import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/models/news.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LatestNewsScreen extends StatelessWidget {
  static String routeName = '/latest_news_screen';

  @override
  Widget build(BuildContext context) {
    final News news = ModalRoute.of(context).settings.arguments;

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
                ListView(
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
                              left: 24.h,
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
                            "Berita Terbaru",
                            style: semiBoldBaseFont.copyWith(
                              fontSize: 18.sp,
                              color: darkGreyColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// SECTION: TITLE IMAGE CONTENT
                    SizedBox(
                      height: 24.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.r,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: CachedNetworkImage(
                          imageUrl: news.imageURL,
                          width: 1.sw,
                          height: 200.r,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => SpinKitRing(
                            size: 50.r,
                            color: accentColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      "Foto Berita - Go Hospital",
                      textAlign: TextAlign.center,
                      style: regularBaseFont.copyWith(
                        fontSize: 11.sp,
                        color: greyColor,
                      ),
                    ),

                    /// SECTION: DESCTION TEXT CONTENT
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.r,
                        horizontal: defaultMargin.r,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ 
                          Text(
                            "Berita",
                            textAlign: TextAlign.start,
                            style: mediumBaseFont.copyWith(
                              color: accentColor,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            news.title,
                            textAlign: TextAlign.start,
                            style: semiBoldBaseFont.copyWith(
                              color: darkGreyColor,
                              fontSize: 20.sp,
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            news.date,
                            textAlign: TextAlign.start,
                            style: regularBaseFont.copyWith(
                              color: lightGreyColor,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          RichText(
                            textAlign:TextAlign.start,
                            text: TextSpan(
                              children: news.content.map((text) {
                                return WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 20.r,
                                    ),
                                    child: Text(
                                      text,
                                      style: regularBaseFont.copyWith(
                                        fontSize: 12.sp,
                                        height: 1.7,
                                        color: darkGreyColor,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
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