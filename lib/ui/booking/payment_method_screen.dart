import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/models/booking.dart';
import 'package:heaven_canceller_hospital/provider/user_provider.dart';
import 'package:heaven_canceller_hospital/services/booking_service.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/booking/add_insurance_number.dart';
import 'package:heaven_canceller_hospital/ui/booking/components/selectable_payment_card.dart';
import 'package:heaven_canceller_hospital/ui/booking/success_booking_screen.dart';
import 'package:heaven_canceller_hospital/ui/static/accent_raised_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heaven_canceller_hospital/utils/notification_util.dart';
import 'package:provider/provider.dart';

class PaymentMethodScreen extends StatefulWidget {
  static String routeName = "/payment_method_screen";

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int selectedPaymentMethod;

  bool isSubmit = false;

  @override
  Widget build(BuildContext context) {
    final Booking booking = ModalRoute.of(context).settings.arguments;

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
                            "Metode Pembayaran",
                            style: semiBoldBaseFont.copyWith(
                              fontSize: 18.sp,
                              color: darkGreyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 36.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Informasi Booking",
                            style: semiBoldBaseFont.copyWith(
                              fontSize: 14.sp,
                              color: accentColor,
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          if (booking.serviceType != "-") Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Layanan Untuk",
                                style: regularBaseFont.copyWith(
                                  fontSize: 13.sp,
                                  color: greyColor,
                                ),
                              ),
                              Text(
                                booking.serviceType,
                                style: semiBoldBaseFont.copyWith(
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                          if (booking.serviceType != "-") SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tujuan Kedatangan",
                                style: regularBaseFont.copyWith(
                                  fontSize: 13.sp,
                                  color: greyColor,
                                ),
                              ),
                              Text(
                                booking.purposeType,
                                style: semiBoldBaseFont.copyWith(
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nama Pasien",
                                style: regularBaseFont.copyWith(
                                  fontSize: 13.sp,
                                  color: greyColor,
                                ),
                              ),
                              Text(
                                booking.patient.name,
                                style: semiBoldBaseFont.copyWith(
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Jadwal Booking",
                                style: regularBaseFont.copyWith(
                                  fontSize: 13.sp,
                                  color: greyColor,
                                ),
                              ),
                              Text(
                                booking.schedule,
                                style: semiBoldBaseFont.copyWith(
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Harga",
                                style: regularBaseFont.copyWith(
                                  fontSize: 13.sp,
                                  color: greyColor,
                                ),
                              ),
                              Text(
                                booking.totalPrice,
                                style: semiBoldBaseFont.copyWith(
                                  fontSize: 13.sp,
                                  color: accentColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      child: Text(
                        "Pilih Metode",
                        style: semiBoldBaseFont.copyWith(
                          fontSize: 14.sp,
                          color: accentColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    SelectablePaymentCard(
                      optionName: "Perusahaan BUMN",
                      optionImage: "assets/image/bpjs.png",
                      optionDescription: "BPJS Ketenagakerjaan / BPJS Mandiri",
                      option: 1,
                      selectedOption: selectedPaymentMethod,
                      isSelected: selectedPaymentMethod == 1,
                      onTap: () {
                        setState(() {
                          selectedPaymentMethod = 1;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentMethod = 1;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Consumer<UserProvider>(
                      builder: (_, provider, __) => SelectablePaymentCard(
                        optionName: "Asuransi",
                        optionImage: "assets/image/jiwasraya.png",
                        optionDescription: "Jiwasraya",
                        option: 2,
                        selectedOption: selectedPaymentMethod,
                        isSelected: selectedPaymentMethod == 2,
                        paymentNumber: provider.user.insuranceNumber,
                        onTap: () {
                          setState(() {
                            selectedPaymentMethod = 2;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentMethod = 2;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SelectablePaymentCard(
                      optionName: "Bayar Sendiri",
                      optionImage: "assets/image/bayar_sendiri.png",
                      optionDescription: "Rumah Sakit Tujuan",
                      option: 3,
                      selectedOption: selectedPaymentMethod,
                      isSelected: selectedPaymentMethod == 3,
                      onTap: () {
                        setState(() {
                          selectedPaymentMethod = 3;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentMethod = 3;
                        });
                      },
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 1.sw,
                    height: 76.r,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultMargin.r,
                      vertical: 16.r,
                    ),
                    decoration: BoxDecoration(
                      color: baseColor,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFCCCCCC),
                          blurRadius: 20,
                          offset: Offset(0, 0),
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: (!isSubmit) ? Consumer<UserProvider>(
                      builder: (_, provider, __) => AccentRaisedButton(
                        width: 1.sw,
                        height: 44.r,
                        color: accentColor,
                        borderRadius: 8,
                        text: "Konfirmasikan",
                        fontSize: 14.sp,
                        onPressed: (selectedPaymentMethod != null) ? () async {
                          setState(() {
                            isSubmit = true;
                          });
                    
                          if (provider.user.insuranceNumber == "") {
                            Navigator.pushNamed(
                              context,
                              AddInsuranceScreen.routeName,
                            );

                            setState(() {
                              isSubmit = false;
                            });
                          } else {
                            onConfirmPressed(
                              context,
                              booking,
                            );
                          }
                        } : null,
                      ),
                    ) : SpinKitRing(
                      color: accentColor,
                      size: 40.r,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String generatePaymentMethod(int paymentMethod) {
    switch(paymentMethod) {
      case 1 :
        return "BPJS Kesehatan";
      case 2 :
        return "Asuransi";
      default :
        return "Bayar Ditempat";
    }
  }

  Future<void> onConfirmPressed(BuildContext context, Booking booking) async {
    // Generate Report Here!!

    await BookingService.storeResource(
      Booking(
        id: booking.id,
        userID: booking.userID,
        doctor: booking.doctor,
        message: booking.message,
        time: DateTime.now().millisecondsSinceEpoch,
        patient: booking.patient,
        schedule: booking.schedule,
        serviceType: booking.serviceType,
        purposeType: booking.purposeType,
        totalPrice: booking.totalPrice,
        reportTime: booking.reportTime,
        paymentMethod: generatePaymentMethod(
          selectedPaymentMethod,
        ),
      ),
    );

    await NotificationUtil.pushNotification(
      heading: "Sukses Melakukan Booking",
      content: "Silahkan datang pada jadwal yang telah anda tentukan.",
    );
    
    Navigator.pushReplacementNamed(
      context, 
      SuccessBookingScreen.routeName,
      arguments: booking.id,
    );
  }
}