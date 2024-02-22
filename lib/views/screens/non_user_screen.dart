import 'package:deenae/views/screens/auth/login_screen.dart';
import 'package:deenae/views/shared/widgets/export.dart';
import 'package:deenae/views/shared/widgets/export_packages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class NonUserScreen extends StatelessWidget {
  const NonUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE2E2E2),
        elevation: 0,
        leading: const Icon(
          MaterialCommunityIcons.qrcode_scan,
          size: 18.0,
          color: Colors.black,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/usa.svg',
                    width: 15.w,
                    height: 25.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Container(
                    height: 15.h,
                    width: 1.w,
                    color: Colors.grey,
                  ),
                  ReusableText(
                    text: ' USA',
                    style: appstyle(
                      16,
                      Colors.black,
                      FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Icon(
                      SimpleLineIcons.settings,
                      color: Colors.black,
                      size: 15.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 750.h,
              decoration: const BoxDecoration(color: Color(0xFFE2E2E2)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 10, 16, 16),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40.h,
                          width: 40.w,
                          child: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/user.jpeg'),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: 'Hello, please login to your account',
                              style: appstyle(
                                12,
                                Colors.grey.shade600,
                                FontWeight.normal,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: ReusableText(
                                text: 'Login',
                                style: appstyle(
                                  12,
                                  Colors.lightBlue,
                                  FontWeight.normal,
                                ).copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationStyle:
                                        TextDecorationStyle.dotted),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
