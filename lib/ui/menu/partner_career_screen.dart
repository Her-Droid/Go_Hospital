import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/models/partner.dart';
import 'package:heaven_canceller_hospital/provider/vacancy_provider.dart';
import 'package:heaven_canceller_hospital/services/partner_service.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/menu/components/vacancy_job_card.dart';
import 'package:heaven_canceller_hospital/ui/menu/detail_partner_vacancy_screen.dart';
import 'package:heaven_canceller_hospital/ui/static/circular_loading_state.dart';
import 'package:heaven_canceller_hospital/ui/static/search_box_field.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PartnerCareerScreen extends StatelessWidget {
  static String routeName = '/partner_career_screen';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Provider
        .of<VacancyProvider>(context, listen: false)
        .resetKeyword();
        return;
      },
      child: Scaffold(
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
                      /// SECTION: TITLE SEARCH BOX
                      Consumer<VacancyProvider>(
                        builder: (context, vacancies, _) => Padding(
                          padding: EdgeInsets.only(
                            top: 24.r,
                            left: defaultMargin.r,
                            right: defaultMargin.r,
                            bottom: 24.r,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      child: Icon(
                                        Icons.arrow_back,
                                        size: 24.r,
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        vacancies.resetKeyword();
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Partner Kerja",
                                      style: semiBoldBaseFont.copyWith(
                                        fontSize: 24.sp,
                                        color: darkGreyColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),    
                              SizedBox(
                                height: 24.h,
                              ),
                              SearchBoxField(
                                hintText: "Cari lowongan",
                                onChanged: (value) {
                                  vacancies.searchResource(value);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// SECTION: PARTNER SLIDER CARD
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: defaultMargin.r,
                              right: defaultMargin.r,
                              bottom: 16.r,
                            ),
                            child: Text(
                              "Partner Kerja",
                              style: semiBoldBaseFont.copyWith(
                                fontSize: 16.sp,
                                color: darkGreyColor,
                              ),
                            ),
                          ),
                          FutureBuilder(
                            future: PartnerService.getResource(),
                            builder: (_, snapshot) {
                              List<Partner> partners = snapshot.data;

                              if (snapshot.hasData) {
                                return Container(
                                  height: 120.r,
                                  child: ListView.builder(
                                    itemCount: partners.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (_, index) => Padding(
                                      padding: EdgeInsets.only(
                                        left: (index == 0) ? 20.r : 16.r,
                                        right: (index == 2) ? 20.r : 0.r,
                                      ),
                                      child: GestureDetector(
                                        child: Container(
                                          width: 120.r,
                                          height: 120.r,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.r,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                              width: 1.r,
                                              color: lightGreyColor,
                                            ),
                                          ),
                                          child: Center(
                                            child: CachedNetworkImage(
                                              imageUrl: partners[index].imageURL,
                                              placeholder: (_, url) => SpinKitRing(
                                                color: accentColor,
                                                size: 50.r,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context, 
                                            DetailPartnerVacancyScreen.routeName,
                                            arguments: partners[index],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              }
                              
                              /// SECTION: LOADING VIEW STATE
                              return CircularLoadingState(
                                height: 120.r,
                                color: accentColor,
                                state: "Memuat Data Partner",
                              );
                            }
                          ),
                        ],
                      ),

                      /// SECTION: VACANCY JOBS CARD
                      Consumer<VacancyProvider>(
                        builder: (context, vacancyProvider, _) {
                          if (vacancyProvider.vacancies != null) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultMargin.r,
                                vertical: 24.r,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (vacancyProvider.keyword != "") 
                                    ? "Hasil Pencarian Lowongan" 
                                    : "Lowongan" ,
                                    style: semiBoldBaseFont.copyWith(
                                      fontSize: 16.sp,
                                      color: darkGreyColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  if (vacancyProvider.keyword == "") Container(
                                    height: vacancyProvider.vacancies.length * (215 + 16).toDouble().r,
                                    child: ListView.builder(
                                      itemCount: vacancyProvider.vacancies.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (_, index) => Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 16.r,
                                        ),
                                        child: VacancyJobCard(
                                          vacancyProvider.vacancies[index],
                                          onTap: () {
                                            launch(vacancyProvider.vacancies[index].link);
                                          },
                                        ),
                                      ),
                                    ),
                                  ) else Container(
                                    height: (vacancyProvider.searchedVacancies.length != 0) 
                                    ? vacancyProvider.searchedVacancies.length * (214 + 16).toDouble().r 
                                    : 200.r,
                                    child: (vacancyProvider.searchedVacancies.length != 0) ? ListView.builder(
                                      itemCount: vacancyProvider.searchedVacancies.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (_, index) => Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 16.r,
                                        ),
                                        child: VacancyJobCard(
                                          vacancyProvider.searchedVacancies[index],
                                          onTap: () {
                                            launch(vacancyProvider.searchedVacancies[index].link);
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

                          /// WIDGET: LOADING VACANCY LISTVIEW 
                          return CircularLoadingState(
                            height: 262.r,
                            state: "Memuat Lowongan",
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
      ),
    );
  }
}