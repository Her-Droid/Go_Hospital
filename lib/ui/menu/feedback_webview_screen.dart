import 'dart:io';

import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/shared/value.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedbackWebviewScreen extends StatefulWidget {
  static String routeName = '/feedback_webview_screen';

  @override
  _FeedbackWebviewScreenState createState() => _FeedbackWebviewScreenState();
}

class _FeedbackWebviewScreenState extends State<FeedbackWebviewScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: accentColor,
          ),
          SafeArea(
            child: Stack(
              children: [
                Container(
                  color: baseColor,
                ),
                Column(
                  children: [
                    /// SECTION: TITLE BACK BUTTON
                    SizedBox(
                      height: 24.h,
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20.r,
                            ),
                            child: GestureDetector(
                              child: Icon(
                                Icons.arrow_back,
                                color: darkGreyColor,
                                size: 28.r,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Align(  
                          alignment: Alignment.center,
                          child: Text(
                            "Feedback",
                            style: semiBoldBaseFont.copyWith(
                              color: darkGreyColor,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),

                    /// SECTION: WEBVIEW FORM CONTENT
                    Expanded(
                      child: Container(
                        width: deviceWidth(context),
                        height: double.infinity,
                        child: WebView(
                          initialUrl: googleFormURL,
                          gestureNavigationEnabled: true,
                          javascriptMode: JavascriptMode.unrestricted,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}