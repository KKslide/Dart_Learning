import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter_application/routes/routes.gr.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

@RoutePage()
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  static const String _aboutText = '''
I'm a front-end engineer with 5 years of professional experience, having started my career in 2013.
What first sparked my passion was a college course on HTML & CSS Web Design, which I found incredibly cool and amazing.
That experience was a revelation, it turns out I've always been a visual enthusiast.
This realization motivated me to diligently teach myself HTML and CSS, and to quickly get up to speed with JavaScript.
My ultimate goal is to combine UI design with front-end engineering, and this aspiration continues to be the driving force in my career.
''';

  static const String _hobbiesText = '''
Besides coding, basketball and roller skating fill my spare time.
I dreamed of being a Pro basketball player when I was a kid, but I stopped growing any taller after 18.
So, I started to try something else to see if I could get a little bit taller.
And then my mom bought me a pair of roller skates and I tried to learn roller skating.
That experience changed my whole life.
''';

  static const String _nextMovementText = '''
Keep trying and learing new things Keep challenge my limits and striving for excellence
''';

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.w, 15.w, 15.w, 60.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Front End Engineer
                SizedBox(
                  width: 1.sw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Front End Engineer',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        _aboutText,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                // Hobbies
                SizedBox(
                  width: 1.sw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hobbies',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        _hobbiesText,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                // Next Movement
                SizedBox(
                  width: 1.sw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Next Movement',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        _nextMovementText,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                // My Skills
                SizedBox(
                  width: 1.sw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Skills',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSkillItem('JS', 0.9, '😎'),
                                SizedBox(height: 15.h),
                                _buildSkillItem('CSS', 0.85, '😎'),
                                SizedBox(height: 15.h),
                                _buildSkillItem('TS', 0.7, '🤓'),
                                SizedBox(height: 15.h),
                                _buildSkillItem('NodeJs', 0.55, '🤓'),
                                SizedBox(height: 15.h),
                                _buildSkillItem('Vue', 0.65, '🤓'),
                                SizedBox(height: 15.h),
                                _buildSkillItem('MySQL', 0.45, '😜'),
                                SizedBox(height: 15.h),
                                _buildSkillItem('PHP', 0.3, '😮'),
                                SizedBox(height: 15.h),
                                _buildSkillItem('Java', 0.2, '😅'),
                                SizedBox(height: 15.h),
                                _buildSkillItem('Linux', 0.4, '😉'),
                              ],
                            ),
                          ),
                          SizedBox(width: 20.w),
                          // Right Column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSkillItem('Adobe Ps', 0.8, '😎'),
                                SizedBox(height: 15.h),
                                _buildSkillItem('Adobe Pr', 0.75, '😎'),
                                SizedBox(height: 15.h),
                                _buildSkillItem('Adobe AE', 0.6, '🤓'),
                                SizedBox(height: 15.h),
                                _buildSkillItem('Adobe Al', 0.4, '😉'),
                                SizedBox(height: 15.h),
                                _buildSkillItem('Adobe Au', 0.35, '🤓'),
                                SizedBox(height: 15.h),
                                _buildSkillItem('Basketball', 0.6, '👽'),
                                SizedBox(height: 15.h),
                                _buildSkillItem('Skate', 0.5, '💀'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                // Resume download
                Container(
                  width: 40.sw,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // todo 预览简历
                      // context.router.push(
                      //   ResumePreviewRoute(
                      //     pdfUrl: 'https://video.kangyouknowwho.space/Resume.pdf',
                      //   ),
                      // );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.preview_rounded, color: Colors.white),
                        SizedBox(width: 10.w),
                        Text('Preview My Resume', style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // My Image
                SizedBox(
                  width: 1.sw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Me in 50 years',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () {
                          final imageProvider = AssetImage('assets/images/profil.young.jpg');

                          showImageViewer(
                            context,
                            imageProvider,
                            swipeDismissible: true,    // 向下滑动关闭
                            doubleTapZoomable: true,   // 双击缩放
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.w),
                          child: Image.asset(
                            'assets/images/profil.old.jpg',
                            fit: BoxFit.cover,
                            width: 1.sw,
                          ),
                        ),
                      )
                    ]
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkillItem(String skillName, double progress, String emoji) {
    return Row(
      children: [
        Text(
          skillName,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black87,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Container(
            height: 8.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
                minHeight: 8.h,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          emoji,
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }
}
