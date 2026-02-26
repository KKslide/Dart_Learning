import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_application/models/resp_blog_page.dart';
import 'package:flutter_application/utils/http_manager/http_manager.dart';
import 'package:flutter_application/utils/http_manager/result_data.dart';
import 'package:flutter_application/utils/logger.dart';

class ApiTrial {
  static Future<BlogResponse> list() async {
    final ResultData(result: result, err: err) = await httpManager.get(
      '/api/user/getpage'
    );
    if (err != null) {
      throw err;
    }
    return BlogResponse.fromJson(result);
  }
}

@RoutePage()
class BlogListTrialPage extends StatelessWidget {
  const BlogListTrialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dio Trial'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            var response = await ApiTrial.list();
            logger.info('分类列表:');
            for (var cat in response.catList) {
              logger.info('${cat.id}: ${cat.name}|||展示方式: ${cat.show_type}');
            }

            logger.info('\n博客列表:');
  
            // 获取置顶博客
            final topBlogs = response.blogList['TOP'] ?? [];
            logger.info('置顶博客: ${topBlogs.length} 篇');
            
            // 获取 Code 分类的博客
            final codeBlogs = response.blogList['Code'] ?? [];
            logger.info('Code 分类: ${codeBlogs.length} 篇');
            for (var blog in codeBlogs) {
              logger.info('  - ${blog.title}');
            }

            // 遍历所有分类的博客
            response.blogList.forEach((category, blogs) {
              logger.info('$category: ${blogs.length} 篇');
            });
          }, 
          child: Text('Dio request')
        ),
      ),
    );
  }
}