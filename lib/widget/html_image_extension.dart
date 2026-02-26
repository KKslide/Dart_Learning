import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/src/builtins/image_builtin.dart';
import 'package:flutter_html/src/extension/html_extension.dart';
import 'package:flutter_html/src/tree/image_element.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

/// 自定义图片扩展, 提供更好的加载状态和错误处理, 确保网络图片能正常显示
/// 支持: 边距、最大宽度40%、换行、点击预览、长按保存
class CustomImageExtension extends ImageBuiltIn {
  const CustomImageExtension({
    super.networkHeaders,
    super.networkDomains,
    super.networkSchemas = const {"http", "https"},
    super.fileExtensions,
    super.assetSchema = "asset:",
    super.assetBundle,
    super.assetPackage,
    super.mimeTypes,
    super.dataEncoding,
    super.handleNetworkImages = true,
    super.handleAssetImages = true,
    super.handleDataImages = true,
  });

  @override
  InlineSpan build(ExtensionContext context) {
    final element = context.styledElement as ImageElement;
    final src = element.src;

    // 判断图片类型
    final isNetworkImage = Uri.tryParse(src) != null && 
                          (src.startsWith('http://') || src.startsWith('https://'));
    final isBase64Image = src.startsWith('data:image');
    final isAssetImage = src.startsWith(assetSchema);

    if (!isNetworkImage && !isBase64Image && !isAssetImage) {
      return TextSpan(text: element.alt ?? '');
    }

    // 使用 Builder 获取屏幕宽度, 计算最大宽度 (40%)
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      baseline: TextBaseline.alphabetic,
      child: Builder(
        builder: (context) {
          final screenWidth = MediaQuery.of(context).size.width;
          final maxWidth = screenWidth * 0.40; // 最大宽度为屏幕的 40%
          
          // 图片容器, 带边距和最大宽度限制
          return Container(
            margin: EdgeInsets.all(8.w), // 上下左右都有边距
            constraints: BoxConstraints(
              maxWidth: maxWidth,
            ),
            child: _buildImageWidget(
              context: context,
              element: element,
              src: src,
              isNetworkImage: isNetworkImage,
              isBase64Image: isBase64Image,
              isAssetImage: isAssetImage,
              maxWidth: maxWidth,
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageWidget({
    required BuildContext context,
    required ImageElement element,
    required String src,
    required bool isNetworkImage,
    required bool isBase64Image,
    required bool isAssetImage,
    required double maxWidth,
  }) {
    Widget imageWidget;

    if (isNetworkImage) {
      imageWidget = _buildNetworkImage(context, src, maxWidth);
    } else if (isBase64Image) {
      imageWidget = _buildBase64Image(context, src);
    } else {
      imageWidget = _buildAssetImage(context, src);
    }

    // 包装图片, 添加点击预览和长按保存功能
    return GestureDetector(
      onTap: () => _showImagePreview(context, src, isNetworkImage, isBase64Image, isAssetImage),
      onLongPress: () => _saveImageToGallery(context, src, isNetworkImage, isBase64Image, isAssetImage),
      child: imageWidget,
    );
  }

  Widget _buildNetworkImage(BuildContext context, String imageUrl, double maxWidth) {
    return Image.network(
      imageUrl,
      width: maxWidth,
      fit: BoxFit.contain,
      headers: networkHeaders,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Container(
          width: maxWidth,
          height: maxWidth * 0.75, // 假设宽高比 4:3
          color: Colors.grey[200],
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      errorBuilder: (ctx, error, stackTrace) {
        return Container(
          width: maxWidth,
          height: maxWidth * 0.75,
          color: Colors.grey[200],
          padding: const EdgeInsets.all(8),
          child: const Icon(
            Icons.broken_image,
            color: Colors.grey,
            size: 32,
          ),
        );
      },
    );
  }

  Widget _buildBase64Image(BuildContext context, String src) {
    try {
      final decodedImage = base64.decode(src.split("base64,")[1].trim());
      return Image.memory(
        decodedImage,
        fit: BoxFit.contain,
      );
    } catch (e) {
      return Container(
        padding: const EdgeInsets.all(8),
        child: const Icon(Icons.broken_image, color: Colors.grey),
      );
    }
  }

  Widget _buildAssetImage(BuildContext context, String src) {
    final assetPath = src.replaceFirst('asset:', '');
    return Image.asset(
      assetPath,
      fit: BoxFit.contain,
      bundle: assetBundle,
      package: assetPackage,
      errorBuilder: (ctx, error, stackTrace) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: const Icon(Icons.broken_image, color: Colors.grey),
        );
      },
    );
  }

  /// 显示图片预览
  void _showImagePreview(
    BuildContext context,
    String src,
    bool isNetworkImage,
    bool isBase64Image,
    bool isAssetImage,
  ) {
    ImageProvider imageProvider;

    if (isNetworkImage) {
      imageProvider = NetworkImage(src, headers: networkHeaders);
    } else if (isBase64Image) {
      try {
        final bytes = base64.decode(src.split("base64,")[1].trim());
        imageProvider = MemoryImage(bytes);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('图片预览失败')),
        );
        return;
      }
    } else {
      final assetPath = src.replaceFirst('asset:', '');
      imageProvider = AssetImage(assetPath, bundle: assetBundle, package: assetPackage);
    }

    showImageViewer(
      context,
      imageProvider,
      onViewerDismissed: () {},
      backgroundColor: Colors.black87,
      useSafeArea: true,
    );
  }

  /// 保存图片到相册
  Future<void> _saveImageToGallery(
    BuildContext context,
    String src,
    bool isNetworkImage,
    bool isBase64Image,
    bool isAssetImage,
  ) async {
    try {
      // 请求存储权限
      final status = await Permission.photos.status;
      if (!status.isGranted) {
        final result = await Permission.photos.request();
        if (!result.isGranted) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('需要相册权限才能保存图片')),
            );
          }
          return;
        }
      }

      Uint8List imageBytes;

      if (isNetworkImage) {
        // 下载网络图片
        final dio = Dio();
        final response = await dio.get<Uint8List>(
          src,
          options: Options(
            responseType: ResponseType.bytes,
            headers: networkHeaders,
          ),
        );
        imageBytes = Uint8List.fromList(response.data!);
      } else if (isBase64Image) {
        // 解码 Base64 图片
        imageBytes = base64.decode(src.split("base64,")[1].trim());
      } else {
        // Asset 图片需要先读取
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('暂不支持保存本地资源图片')),
          );
        }
        return;
      }

      // 保存到相册
      final result = await ImageGallerySaver.saveImage(
        imageBytes,
        quality: 100,
        name: 'image_${DateTime.now().millisecondsSinceEpoch}',
      );

      if (context.mounted) {
        if (result['isSuccess'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('图片已保存到相册')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('保存失败: ${result['errorMessage'] ?? '未知错误'}')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('保存失败: $e')),
        );
      }
    }
  }
}
