import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/models/hospital_contact.dart';
import 'package:heaven_canceller_hospital/services/about_us_service.dart';
import 'package:heaven_canceller_hospital/services/hospital_contact_service.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/menu/components/about_us_card.dart';
import 'package:heaven_canceller_hospital/ui/static/circular_loading_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUsScreen extends StatelessWidget {
  static String routeName = '/about_us_screen';

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
                            "Tentang Kami",
                            style: semiBoldBaseFont.copyWith(
                              fontSize: 18.sp,
                              color: darkGreyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    StreamBuilder(
                      stream: AboutUsService.getSingle(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.r,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                snapshot.data['image_path'],
                                width: defaultWidth(context),
                                height: 200.r,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }

                        /// WIDGET: LOADING DESCRIPTION
                        return CircularLoadingState(
                          height: 240.r,
                          state: "Memuat Gambar",
                        );
                      }
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.r,
                        horizontal: defaultMargin.r,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Seputar Tentang RS Columbia Asia",
                            textAlign: TextAlign.start,
                            style: semiBoldBaseFont.copyWith(
                              color: accentColor,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          StreamBuilder(
                            stream: AboutUsService.getSingle(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                List<String> content = (snapshot.data['content'] as List).map(
                                  (e) => e.toString(),
                                ).toList();

                                return RichText(
                                  textAlign:TextAlign.start,
                                  text: TextSpan(
                                    children: content.map((text) {
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
                                );
                              }

                              /// WIDGET: LOADING DESCRIPTION
                              return CircularLoadingState(
                                height: 240.r,
                                state: "Memuat Deskripsi",
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.r,
                      ),
                      child: FutureBuilder(
                        future: HospitalContactService.getResource(),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              height: 520.r,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (_, index) {
                                  HospitalContact hospitalContacts = snapshot.data[index];
                                  return AboutUsCard(
                                    hospitalContacts,
                                  );
                                },
                              ),
                            );
                          }

                          /// WIDGET: LOADING CONTACT DATA
                          return CircularLoadingState(
                            height: 240.r,
                            state: "Memuat Data Info",
                          );
                        },
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