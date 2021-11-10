import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/models/contact_complaint.dart';
import 'package:heaven_canceller_hospital/models/office_location.dart';
import 'package:heaven_canceller_hospital/provider/carousel_provider.dart';
import 'package:heaven_canceller_hospital/provider/doctor_provider.dart';
import 'package:heaven_canceller_hospital/provider/event_promo_provider.dart';
import 'package:heaven_canceller_hospital/provider/navigation_provider.dart';
import 'package:heaven_canceller_hospital/provider/news_provider.dart';
import 'package:heaven_canceller_hospital/services/about_us_service.dart';
import 'package:heaven_canceller_hospital/services/contact_complaint_service.dart';
import 'package:heaven_canceller_hospital/services/office_location_service.dart';
import 'package:heaven_canceller_hospital/services/youtube_servie.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/booking/detail_doctor_screen.dart';
import 'package:heaven_canceller_hospital/ui/home/components/carousel_indicator.dart';
import 'package:heaven_canceller_hospital/ui/home/components/contact_complaint_card.dart';
import 'package:heaven_canceller_hospital/ui/home/components/doctor_profile_card.dart';
import 'package:heaven_canceller_hospital/ui/home/components/hospital_info_card.dart';
import 'package:heaven_canceller_hospital/ui/home/components/latest_news_card.dart';
import 'package:heaven_canceller_hospital/ui/home/components/map_address_card.dart';
import 'package:heaven_canceller_hospital/ui/home/components/map_view_card.dart';
import 'package:heaven_canceller_hospital/ui/menu/about_us_screen.dart';
import 'package:heaven_canceller_hospital/ui/service/event_promo_screen.dart';
import 'package:heaven_canceller_hospital/ui/service/latest_news_screen.dart';
import 'package:heaven_canceller_hospital/ui/static/accent_raised_button.dart';
import 'package:heaven_canceller_hospital/ui/static/circular_loading_state.dart';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CarouselProvider carousel = Provider.of<CarouselProvider>(context);

    return Scaffold(
      body: ListView(
        children: [
          /// SECTION: EVENT PROMO CAROUSEL
          Consumer<EventPromoProvider>(
            builder: (context, eventPromoProvider, _) {
              if (eventPromoProvider.eventPromos != null) {
                return Stack(
                  children: [
                    CarouselSlider.builder(
                      itemCount: eventPromoProvider.eventPromos.length,
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 6),
                        autoPlayAnimationDuration: Duration(seconds: 2),
                        enableInfiniteScroll: true,
                        height: 270.r - statusBarHeight(context),
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          carousel.changeIndex(index);
                        },
                      ),
                      itemBuilder: (_, index) => GestureDetector(
                        child: Stack(
                          children: [
                            Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: eventPromoProvider
                                      .eventPromos[index].imageURL,
                                  fit: BoxFit.cover,
                                  height: 250.r - statusBarHeight(context),
                                  width: deviceWidth(context),
                                  placeholder: (context, url) => SpinKitRing(
                                    color: accentColor,
                                    size: 50.r,
                                  ),
                                ),
                                Container(
                                  height: 250.r - statusBarHeight(context),
                                  decoration: BoxDecoration(
                                    color: blackColor.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 250.r - statusBarHeight(context),
                              width: deviceWidth(context),
                              padding: EdgeInsets.only(
                                top: 36.r,
                                bottom: 16.r,
                                left: defaultMargin.r,
                                right: defaultMargin.r,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    eventPromoProvider.eventPromos[index].title,
                                    style: semiBoldBaseFont.copyWith(
                                      color: baseColor,
                                      fontSize: 24.sp,
                                      height: 1.2,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 3,
                                          color: blackColor.withOpacity(0.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  Text(
                                    eventPromoProvider
                                        .eventPromos[index].content[0],
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: regularBaseFont.copyWith(
                                      color: baseColor,
                                      fontSize: 12.sp,
                                      height: 1.5,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 2,
                                          color: blackColor.withOpacity(0.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 28.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      CarouselIndicator(
                                        eventPromoProvider.eventPromos.map((e) {
                                          return e.imageURL;
                                        }).toList(),
                                      ),
                                      AccentRaisedButton(
                                        height: 20.r,
                                        borderRadius: 12,
                                        color: accentColor,
                                        text: "Read",
                                        fontSize: 12.sp,
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            EventPromoScreen.routeName,
                                            arguments: eventPromoProvider
                                                .eventPromos[index],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            EventPromoScreen.routeName,
                            arguments: eventPromoProvider.eventPromos[index],
                          );
                        },
                      ),
                    ),
                  ],
                );
              }

              /// WIDGET: LOADING CAROUSEL RESOURCE
              return CircularLoadingState(
                height: 270.r - statusBarHeight(context),
                state: "Memuat Event Promo",
              );
            },
          ),

          // YOUTUBE
          StreamBuilder(
            stream: YoutubeService.getSingle(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  width: defaultWidth(context).r,
                  height: 180.r,
                  margin: EdgeInsets.only(
                    top: 10,
                    right: defaultMargin.r,
                    left: defaultMargin.r,
                    bottom: defaultMargin.r,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black,
                  ),
                  child: WebView(
                    initialUrl: Uri.dataFromString(
                            '<html><body style="margin:0px;"><iframe style="border-radius:8px;" frameBorder="0" width="100%" height="100%" src="https://www.youtube.com/embed/'+snapshot.data['youtube_id']+'" allowfullscreen></iframe></body></html>',
                            mimeType: 'text/html')
                        .toString(),
                    javascriptMode: JavascriptMode.unrestricted,
                  ),
                );
              }
              return CircularLoadingState(
                height: 200.r,
                state: "Memuat Video Youtube",
                color: baseColor,
                fontColor: baseColor,
              );
            },
          ),

          /// SECTION: MAPS TEMUKAN KAMI
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin.r,
              vertical: 0.r,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Temukan Kami",
                  style: semiBoldBaseFont.copyWith(
                    fontSize: 18.sp,
                    color: blackColor.withOpacity(0.8),
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                StreamBuilder(
                    stream: OfficeLocationService.getSingle(),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        return GestureDetector(
                          child: Container(
                            width: 1.sw,
                            height: 160.r,
                            margin: EdgeInsets.only(
                              bottom: 24.r,
                            ),
                            decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFCCCCCC),
                                  blurRadius: 20,
                                  offset: Offset(0, 0),
                                  spreadRadius: -5,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: MapViewCard(
                                    latitude: snapshot.data['latitude'],
                                    longitude: snapshot.data['longitude'],
                                  ),
                                ),
                                MapAddressCard(
                                  placeName: snapshot.data['place_name'],
                                  address: snapshot.data['address'],
                                  image: snapshot.data['map_image'],
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            if (await mapLauncher.MapLauncher.isMapAvailable(
                                mapLauncher.MapType.google)) {
                              await mapLauncher.MapLauncher.showMarker(
                                mapType: mapLauncher.MapType.google,
                                coords: mapLauncher.Coords(
                                    snapshot.data['latitude'],
                                    snapshot.data['longitude']),
                                title: snapshot.data['address'],
                              );
                            }
                          },
                        );
                      }

                      /// WIDGET: LOADING MAPS RESOURCE
                      return CircularLoadingState(
                        height: 160.r,
                        state: "Memuat Alamat Peta",
                      );
                    }),
                FutureBuilder(
                  future: OfficeLocationService.getResource(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: 360.r,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, index) {
                              OfficeLocation officeLocation =
                                  snapshot.data[index];
                              return HospitalInfoCard(
                                placeName: officeLocation.placeName,
                                address: officeLocation.address,
                                regularSchedule: officeLocation.regularSchedule,
                                weekendSchedule: officeLocation.weekendSchedule,
                                image: officeLocation.imagePath,
                              );
                            }),
                      );
                    }

                    /// WIDGET: LOADING LOKASI KANTOR
                    return CircularLoadingState(
                      height: 160.r,
                      state: "Memuat Data Alamat",
                    );
                  },
                ),
              ],
            ),
          ),

          /// SECTION: LISTVIEW TENTANG KAMI
          Container(
            color: accentColor,
            padding: EdgeInsets.symmetric(
              vertical: 24.r,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.r,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tentang Kami",
                        style: semiBoldBaseFont.copyWith(
                          fontSize: 18.sp,
                          color: baseColor,
                          letterSpacing: -0.5,
                        ),
                      ),
                      InkWell(
                        child: Text(
                          "Selengkapnya",
                          style: regularBaseFont.copyWith(
                            fontSize: 11.5.sp,
                            color: baseColor,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AboutUsScreen.routeName,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                StreamBuilder(
                  stream: AboutUsService.getSingle(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.r,
                        ),
                        child: GestureDetector(
                          child: Container(
                            width: defaultWidth(context).r,
                            height: 200.r,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  snapshot.data['image_path'],
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: blackColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 120.r,
                                      left: 20.r,
                                      right: 20.r,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tentang Kami",
                                          style: semiBoldBaseFont.copyWith(
                                            fontSize: 16.sp,
                                            color: baseColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          snapshot.data['content'][0],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: regularBaseFont.copyWith(
                                            fontSize: 12.sp,
                                            color: baseColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AboutUsScreen.routeName,
                            );
                          },
                        ),
                      );
                    }

                    /// WIDGET: LOADING ABOUT US
                    return CircularLoadingState(
                      height: 200.r,
                      state: "Memuat Tentang Kami",
                      color: baseColor,
                      fontColor: baseColor,
                    );
                  },
                ),
                SizedBox(
                  height: 24.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.r,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dokter Kami",
                        style: semiBoldBaseFont.copyWith(
                          fontSize: 18.sp,
                          color: baseColor,
                          letterSpacing: -0.5,
                        ),
                      ),
                      InkWell(
                        child: Text(
                          "Lihat Lainya",
                          style: regularBaseFont.copyWith(
                            fontSize: 11.5.sp,
                            color: baseColor,
                          ),
                        ),
                        onTap: () {
                          Provider.of<NavigationProvider>(context,
                                  listen: false)
                              .changeIndex(2);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  height: 196.r,
                  child: Consumer<DoctorProvider>(
                    builder: (context, doctorProvider, _) {
                      if (doctorProvider.doctors != null) {
                        return ListView.builder(
                          itemCount: doctorProvider.doctors.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: 20.r,
                                left: (index == 0) ? 20.r : 0.r,
                              ),
                              child: DoctorProfileCard(
                                doctorProvider.doctors[index],
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    DetailDoctorScreen.routeName,
                                    arguments: doctorProvider.doctors[index],
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }

                      /// WIDGET: LOADING DOCTOR LISTVIEW
                      return CircularLoadingState(
                        height: 196.r,
                        state: "Memuat Data Dokter",
                        color: baseColor,
                        fontColor: baseColor,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
              ],
            ),
          ),

          /// SECTION: BERITA TERBARU LISTVIEW
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.r,
                ),
                child: Text(
                  "Berita Terbaru",
                  style: semiBoldBaseFont.copyWith(
                    fontSize: 18.sp,
                    color: blackColor.withOpacity(0.8),
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              Container(
                height: 262.r,
                child: Consumer<NewsProvider>(
                  builder: (context, newsProvider, _) {
                    if (newsProvider.news != null) {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: newsProvider.news.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              right: (index == newsProvider.news.length - 1)
                                  ? 16.r
                                  : 20.r,
                              left: (index == 0) ? 20.r : 0.r,
                            ),
                            child: LatestNewsCard(
                              newsProvider.news[index],
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  LatestNewsScreen.routeName,
                                  arguments: newsProvider.news[index],
                                );
                              },
                            ),
                          );
                        },
                      );
                    }

                    /// WIDGET: LOADING NEWS LISTVIEW
                    return CircularLoadingState(
                      height: 262.r,
                      state: "Memuat Data Berita",
                    );
                  },
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
            ],
          ),

          /// SECTION: CONTACT US CARD
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.r,
                ),
                child: Text(
                  "Kontak & Pengaduan",
                  style: semiBoldBaseFont.copyWith(
                    fontSize: 18.sp,
                    color: blackColor.withOpacity(0.8),
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.r,
                ),
                child: FutureBuilder(
                  future: ContactComplaintService.getResource(),
                  builder: (_, snapshot) {
                    List<ContactComplaint> contactComplaint = snapshot.data;

                    if (snapshot.hasData) {
                      return Wrap(
                        spacing: 16.r,
                        runSpacing: 16.r,
                        children: contactComplaint.map((data) {
                          return ContactComplaintCard(
                            content: data.contact,
                            icon: data.iconPath,
                            onTap: () {
                              launch(data.launcher);
                            },
                          );
                        }).toList(),
                      );
                    }

                    /// WIDGET: LOADING CONTACT COMPLAINT CARD
                    return CircularLoadingState(
                      height: 262.r,
                      state: "Memuat Data Kontak",
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 80.h,
          ),
        ],
      ),
    );
  }
}
