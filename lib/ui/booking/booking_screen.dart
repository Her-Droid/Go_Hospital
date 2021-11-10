import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/provider/doctor_provider.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/booking/components/doctor_view_card.dart';
import 'package:heaven_canceller_hospital/ui/booking/detail_doctor_screen.dart';
import 'package:heaven_canceller_hospital/ui/static/empty_view_state.dart';
import 'package:heaven_canceller_hospital/ui/static/search_box_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin.r,
            vertical: 24.r,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// SECTION: TITLE SEARCH FILTER BOX
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/image/ic_booking_black.png",
                    width: 28.r,
                    height: 28.r,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    "Booking",
                    style: semiBoldBaseFont.copyWith(
                      color: darkGreyColor,
                      fontSize: 24.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<DoctorProvider>(
                    builder: (context, provider, _) => Flexible(
                      flex: 5,
                      child: SearchBoxField(
                        hintText: "Cari dokter pilihan anda",
                        onChanged: (value) {
                          provider.searchResource(value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),

              /// SECTION: DOCTOR GRIDVIEW
              Consumer<DoctorProvider>(
                builder: (context, provider, _) {
                  int doctorsLength = provider.doctors.length;

                  if (provider.keyword == "") {
                    return SizedBox(
                      height: (getOrientation(context) == Orientation.portrait) ? 870.h : 480.h,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: (getOrientation(context) == Orientation.portrait) ? 2 : 4,
                          mainAxisSpacing: 12.r,
                          crossAxisSpacing: 12.r,
                          childAspectRatio: (getOrientation(context) == Orientation.portrait) ? 3 / 4 : 2.75 / 4,
                        ),
                        itemCount: doctorsLength,
                        itemBuilder: (_, index) {
                          return DoctorViewCard(
                            provider.doctors[index],
                            onTap: () {
                              Navigator.pushNamed(context, DetailDoctorScreen.routeName,
                                arguments: provider.doctors[index],
                              );
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    if (provider.searchedDoctors.length != 0) {
                      return SizedBox(
                        height: (getOrientation(context) == Orientation.portrait) 
                        ? (provider.searchedDoctors.length >= 2) 
                        ? 870.h : 250.h : (provider.searchedDoctors.length >= 2) 
                        ? 480.h : 260.h,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: (getOrientation(context) == Orientation.portrait) ? 2 : 4,
                            mainAxisSpacing: 12.r,
                            crossAxisSpacing: 12.r,
                            childAspectRatio: (getOrientation(context) == Orientation.portrait) 
                            ? 3 / 4 
                            : 2.75 / 4,
                          ),
                          itemCount: provider.searchedDoctors.length ,
                          itemBuilder: (_, index) {
                            return DoctorViewCard(
                              provider.searchedDoctors[index],
                              onTap: () {
                                Navigator.pushNamed(context, DetailDoctorScreen.routeName,
                                  arguments: provider.searchedDoctors[index],
                                );
                              },
                            );
                          },
                        ),
                      );
                    }
                    
                    /// SECTION: EMPTY VIEW STATE
                    return Container(
                      height: 360.r,
                      child: EmptyViewState(),
                    );
                  }
                },
              ), 
            ],
          ),
        ),
      ),
    );
  }
}