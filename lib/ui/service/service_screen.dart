import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/provider/event_promo_provider.dart';
import 'package:heaven_canceller_hospital/provider/service_facility_provider.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/service/components/event_promo_card.dart';
import 'package:heaven_canceller_hospital/ui/service/components/hospital_facility_card.dart';
import 'package:heaven_canceller_hospital/ui/service/covid_service_screen.dart';
import 'package:heaven_canceller_hospital/ui/service/detail_service_screen.dart';
import 'package:heaven_canceller_hospital/ui/service/event_promo_screen.dart';
import 'package:heaven_canceller_hospital/ui/static/circular_loading_state.dart';
import 'package:heaven_canceller_hospital/ui/static/empty_view_state.dart';
import 'package:heaven_canceller_hospital/ui/static/search_box_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          /// SECTION: TITLE SEARCH BOX
          Consumer<EventPromoProvider>(
            builder: (context, eventPromos, _) => Consumer<ServiceFacilityProvider>(
              builder: (context, serviceFacilities, _) => Padding(
                padding: EdgeInsets.only(
                  top: 24.r,
                  left: defaultMargin.r,
                  right: defaultMargin.r,
                  bottom: 24.r,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/image/ic_layanan_black.png",
                          width: 28.r,
                          height: 28.r,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Text(
                          "Layanan",
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
                    SearchBoxField(
                      hintText: "Cari event, promo, fasilitas, layanan",
                      onChanged: (value) {
                        serviceFacilities.searchResource(value);
                        eventPromos.searchResource(value);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              left: defaultMargin.r,
              right: defaultMargin.r,
              bottom: 24.r,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Layanan Covid - 19",
                  style: semiBoldBaseFont.copyWith(
                    fontSize: 16.sp,
                    color: darkGreyColor,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                GestureDetector(
                  child: Container(
                    width: 360.r,
                    height: 90.r,
                    padding: EdgeInsets.only(
                      left: 24.r,
                      right: 24.r,
                      top: 16.r,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/image/bg_covid.png",
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tes COVID-19 & Vaksinasi",
                          style: boldBaseFont.copyWith(
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(
                          height: 6.h
                        ),
                        Text(
                          "Tersedia untuk SWAB, Rapid Test, Antigen dan Suntik Vaksin.",
                          style: regularBaseFont.copyWith(
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context, 
                      CovidServiceScreen.routeName,
                    );
                  },
                ),
              ],
            ),
          ),

          /// SECTION: FACILITY & SERVICE SLIDER CARD
          Consumer<ServiceFacilityProvider>(
            builder: (context, provider, _) {
              if ((provider.serviceFacilities != null)) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: defaultMargin.r,
                        right: defaultMargin.r,
                        bottom: 16.r,
                      ),
                      child: Text(
                        (provider.keyword != "") 
                        ? "Hasil Pencarian Fasilitas & Layanan" 
                        : "Fasilitas & Layanan Terkini",
                        style: semiBoldBaseFont.copyWith(
                          fontSize: 16.sp,
                          color: darkGreyColor,
                        ),
                      ),
                    ),
                    if (provider.keyword == "") Container(
                      height: 180.r,
                      child: ListView.builder(
                        itemCount: provider.serviceFacilities.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) => Padding(
                          padding: EdgeInsets.only(
                            left: (index == 0) ? 20.r : 16.r,
                            right: (index == provider.serviceFacilities.length - 1) 
                            ? 20.r : 0.r,
                          ),
                          child: HospitalFacilityCard(
                            title: provider.serviceFacilities[index].name,
                            imagePath: provider.serviceFacilities[index].imagePath,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                DetailServiceScreen.routeName,
                                arguments: provider.serviceFacilities[index],
                              );
                            },
                          ),
                        ),
                      ) 
                    ) else Container(
                      height: 180.r,
                      child: (provider.searchedServiceFacilities.length != 0) ? ListView.builder(
                        itemCount: provider.searchedServiceFacilities.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) => Padding(
                          padding: EdgeInsets.only(
                            left: (index == 0) ? 20.r : 16.r,
                            right: (index == provider.searchedServiceFacilities.length - 1) 
                            ? 20.r : 0.r,
                          ),
                          child: HospitalFacilityCard(
                            title: provider.searchedServiceFacilities[index].name,
                            imagePath: provider.searchedServiceFacilities[index].imagePath,
                            onTap: () {
                              Navigator.pushNamed(context, DetailServiceScreen.routeName,
                                arguments: provider.searchedServiceFacilities[index],
                              );
                            },
                          ),
                        ),
                      ) : EmptyViewState(),
                    ),
                  ],
                );
              }

              /// WIDGET: LOADING MAPS RESOURCE
              return CircularLoadingState(
                height: 180.r,
                state: "Memuat Data Fasilitas",
              );
            },
          ),

          /// SECTION: EVENT PROMO CARD
          Consumer<EventPromoProvider>(
            builder: (context, eventPromoProvider, _) {
              if (eventPromoProvider.eventPromos != null) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(24.r, 24.r, 24.r, 48.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (eventPromoProvider.keyword != "") 
                        ? "Hasil Pencarian Event & Promo" 
                        : "Event & Promo" ,
                        style: semiBoldBaseFont.copyWith(
                          fontSize: 16.sp,
                          color: darkGreyColor,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      if (eventPromoProvider.keyword == "") Container(
                        height: (eventPromoProvider.eventPromos.length * (220 + 16).toDouble()).r,
                        child: ListView.builder(
                          itemCount: eventPromoProvider.eventPromos.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) => Padding(
                            padding: EdgeInsets.only(
                              bottom: 16.r,
                            ),
                            child: EventPromoCard(
                              eventPromoProvider.eventPromos[index],
                              onTap: () {
                                Navigator.pushNamed(
                                  context, 
                                  EventPromoScreen.routeName,
                                  arguments: eventPromoProvider.eventPromos[index],
                                );
                              },
                            ),
                          ),
                        ),
                      ) else Container(
                        height: (eventPromoProvider.searchedEventPromos.length != 0) 
                        ? eventPromoProvider.searchedEventPromos.length * (214 + 16).toDouble().r 
                        : 200.r,
                        child: (eventPromoProvider.searchedEventPromos.length != 0) ? ListView.builder(
                          itemCount: eventPromoProvider.searchedEventPromos.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) => Padding(
                            padding: EdgeInsets.only(
                              bottom: 16.r,
                            ),
                            child: EventPromoCard(
                              eventPromoProvider.searchedEventPromos[index],
                              onTap: () {
                                Navigator.pushNamed(
                                  context, 
                                  EventPromoScreen.routeName,
                                  arguments: eventPromoProvider.searchedEventPromos[index],
                                );
                              },
                            ),
                          ),
                        ) : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/image/empty_state.png",
                                width: 120.r,
                                height: 120.r,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                "Tidak Ada Hasil",
                                style: mediumBaseFont.copyWith(
                                  color: darkGreyColor,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              /// WIDGET: LOADING NEWS LISTVIEW 
              return CircularLoadingState(
                height: 262.r,
                state: "Memuat Event Promo",
              );
            },
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}