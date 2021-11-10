import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/models/booking.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/utils/date_time_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryPersonalCard extends StatelessWidget {
  final Booking historyBooking;
  final Function onTap;
  final bool isFinish;
  final Function() onOpenReport;

  HistoryPersonalCard(
    this.historyBooking, {
    this.onTap,
    this.isFinish = false,
    this.onOpenReport,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 1.sw,
        height: (historyBooking.doctor.name != null) ? 106.r : 96.r,
        padding: EdgeInsets.symmetric(
          vertical: 12.r,
          horizontal: 20.r,
        ),
        color: (isFinish) ? baseColor : Color(0xFFF2F2F2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (historyBooking.doctor.photo != null) CachedNetworkImage(
              imageUrl: historyBooking.doctor.photo,
              width: 48.r,
              height: 48.r,
              fit: BoxFit.cover,
              errorWidget: (context, url, _) => Icon(
                Icons.medication,
              ),
              placeholder: (_, url) => SpinKitRing(
                color: accentColor,
                size: 40.r,
              ),
              imageBuilder: (_, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageProvider,
                  ),
                ),
              ),
            ) else Icon(
              Icons.medication,
              size: 48.r,
            ),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (historyBooking.doctor.name != null) Text(
                        historyBooking.doctor.name,
                        textAlign: TextAlign.start,
                        style: semiBoldBaseFont.copyWith(
                          color: darkGreyColor,
                          fontSize: 12.sp,
                        ),
                      ),
                      if (historyBooking.doctor.name != null) SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        historyBooking.purposeType,
                        textAlign: TextAlign.start,
                        style: mediumBaseFont.copyWith(
                          color: darkGreyColor,
                          fontSize: (historyBooking.doctor.name != null) 
                          ? 11.sp : 12.sp,
                          fontWeight: (historyBooking.doctor.name != null) 
                          ? FontWeight.w500 
                          : FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Text(
                        historyBooking.schedule,
                        style: mediumBaseFont.copyWith(
                          color: greyColor,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateTimeUtil.generateDiffHuman(historyBooking.time),
                        style: regularBaseFont.copyWith(
                          fontSize: 11.sp,
                          color: greyColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: onOpenReport,
                        child: Container(
                          height: 20.r,
                          padding: EdgeInsets.symmetric(
                            horizontal: 11.r,
                          ),
                          decoration: BoxDecoration(
                            color: finishColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Lihat Laporan",
                              style: semiBoldBaseFont.copyWith(
                                fontSize: 10.sp,
                                color: baseColor,
                              ),
                            ),
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
      ),
      onTap: onTap,
    );
  }
}