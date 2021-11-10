import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/extensions/date_time_extension.dart';
import 'package:heaven_canceller_hospital/models/booking.dart';
import 'package:heaven_canceller_hospital/models/doctor.dart';
import 'package:heaven_canceller_hospital/models/patient.dart';
import 'package:heaven_canceller_hospital/provider/patient_provider.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/booking/change_patient_screen.dart';
import 'package:heaven_canceller_hospital/ui/booking/components/selectable_date_button.dart';
import 'package:heaven_canceller_hospital/ui/booking/payment_method_screen.dart';
import 'package:heaven_canceller_hospital/ui/static/accent_raised_button.dart';
import 'package:heaven_canceller_hospital/ui/static/custom_radio_button.dart';
import 'package:heaven_canceller_hospital/ui/static/selectable_box_button.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CovidServiceScreen extends StatefulWidget {
  static String routeName = "/covid_service_screen";

  @override
  _CovidServiceScreenState createState() => _CovidServiceScreenState();
}

class _CovidServiceScreenState extends State<CovidServiceScreen> {
  String selectedService;
  String selectedTime;
  DateTime selectedDate;
  List<DateTime> dates;

  bool isSubmit = false;

  @override
  void initState() {
    super.initState();

    dates = List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    final PatientProvider patientProvider = Provider.of<PatientProvider>(context);
    final Box<Patient> patientBox = Hive.box('patients');
    final Patient patient = patientBox.getAt(patientProvider.patientIndex);

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
                    Padding(
                      padding: EdgeInsets.only(
                        top: defaultMargin.r,
                        left: defaultMargin.r,
                        right: defaultMargin.r,
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
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
                          Align(  
                            alignment: Alignment.center,
                            child: Text(
                              "Layanan COVID-19",
                              style: semiBoldBaseFont.copyWith(
                                fontSize: 18.sp,
                                color: darkGreyColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 36.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultMargin.r,
                          ),
                          child: Text(
                            "Informasi Layanan",
                            style: semiBoldBaseFont.copyWith(
                              fontSize: 14.sp,
                              color: accentColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                        
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultMargin.r,
                          ),
                          child: Text(
                            "Pilih Tujuan",
                            style: semiBoldBaseFont.copyWith(
                              color: darkGreyColor,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: (defaultMargin + 4).r,
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedService = "Vaksin Covid-19";
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomRadioButton(
                                      value: "Vaksin Covid-19",
                                      groupValue: selectedService,
                                      onChange: (value) {
                                        setState(() {
                                          selectedService = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Rp. 50.000",
                                      style: semiBoldBaseFont.copyWith(
                                        fontSize: 12.sp,
                                        color: accentColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 13.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedService = "Rapid Test";
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomRadioButton(
                                      value: "Rapid Test",
                                      groupValue: selectedService,
                                      onChange: (value) {
                                        setState(() {
                                          selectedService = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Rp. 200.000",
                                      style: semiBoldBaseFont.copyWith(
                                        fontSize: 12.sp,
                                        color: accentColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 13.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedService = "Swab PCR";
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomRadioButton(
                                      value: "Swab PCR",
                                      groupValue: selectedService,
                                      onChange: (value) {
                                        setState(() {
                                          selectedService = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Rp. 900.000",
                                      style: semiBoldBaseFont.copyWith(
                                        fontSize: 12.sp,
                                        color: accentColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 13.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedService = "Tes Covid-19";
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomRadioButton(
                                      value: "Tes Covid-19",
                                      groupValue: selectedService,
                                      onChange: (value) {
                                        setState(() {
                                          selectedService = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Rp. 900.000",
                                      style: semiBoldBaseFont.copyWith(
                                        fontSize: 12.sp,
                                        color: accentColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 13.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedService = "Genose-19";
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomRadioButton(
                                      value: "Genose-19",
                                      groupValue: selectedService,
                                      onChange: (value) {
                                        setState(() {
                                          selectedService = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Rp. 30.000",
                                      style: semiBoldBaseFont.copyWith(
                                        fontSize: 12.sp,
                                        color: accentColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultMargin,
                          ),
                          child: Text(
                            "Detail Pendaftaran",
                            style: semiBoldBaseFont.copyWith(
                              fontSize: 14.sp,
                              color: accentColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 14.h,
                        ),

                        /// SECTION: SELECTED PATIENT CARD
                        Container(
                          width: deviceWidth(context),
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultMargin.r,
                            vertical: 18.r,
                          ),
                          color: Color(0xFFEEEEEE),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Daftar Untuk",
                                    style: semiBoldBaseFont.copyWith(
                                      color: darkGreyColor,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      "Ganti Pasien",
                                      style: mediumBaseFont.copyWith(
                                        fontSize: 11.sp,
                                        color: accentColor,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context, 
                                        ChangePatientScreen.routeName,
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                "Nama: ${patient.name}",
                                textAlign: TextAlign.start,
                                style: regularBaseFont.copyWith(
                                  color: greyColor,
                                  fontSize: 11.sp,
                                  height: 1.7,
                                ),
                              ),
                              Text(
                                "Jenis Kelamin: ${patient.gender}",
                                textAlign: TextAlign.start,
                                style: regularBaseFont.copyWith(
                                  color: greyColor,
                                  fontSize: 11.sp,
                                  height: 1.7,
                                ),
                              ),
                              Text(
                                "Status: ${patient.status}",
                                textAlign: TextAlign.start,
                                style: regularBaseFont.copyWith(
                                  color: greyColor,
                                  fontSize: 11.sp,
                                  height: 1.7,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: defaultMargin.h,
                        ),

                        /// SECTION: DATE CARD LISTVIEW
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultMargin,
                          ),
                          child: Text(
                            "Booking Waktu",
                            style: semiBoldBaseFont.copyWith(
                              color: darkGreyColor,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 76.r,
                          child: ListView.builder(
                            itemCount: dates.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  right: (index != 6) ? 12.r : 20.r,
                                  left: (index != 0) ? 0.r : 20.r,
                                ),
                                child: SelectableDateButton(
                                  date: dates[index].day.toString(),
                                  dayName: dates[index].shortDayName,
                                  isSelected: selectedDate == dates[index],
                                  onTap: () {
                                    setState(() {
                                      selectedDate = dates[index];
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),

                        /// SECTION: TIME LISTVIEW CARD
                        Padding(
                          padding: EdgeInsets.only(
                            top: 16.r,
                            left: defaultMargin.r,
                          ),
                          child: Row(
                            children: [
                              SelectableBoxButton(
                                borderRadius: 20,
                                thickBorder: 1.5,
                                borderColor: lightGreyColor,
                                fontColor: greyColor,
                                content: "10.00 - 11.00",
                                isSelected: selectedTime == "10.00 - 11.00",
                                onTap: () {
                                  setState(() {
                                    selectedTime = "10.00 - 11.00";
                                  });
                                },
                              ),
                              SelectableBoxButton(
                                borderRadius: 20,
                                thickBorder: 1.5,
                                borderColor: lightGreyColor,
                                fontColor: greyColor,
                                content: "13.00 - 14.00",
                                isSelected: selectedTime == "13.00 - 14.00",
                                onTap: () {
                                  setState(() {
                                    selectedTime = "13.00 - 14.00";
                                  });
                                },
                              ),
                              SelectableBoxButton(
                                borderRadius: 20,
                                thickBorder: 1.5,
                                borderColor: lightGreyColor,
                                fontColor: greyColor,
                                content: "16.00 - 17.00",
                                isSelected: selectedTime == "16.00 - 17.00",
                                onTap: () {
                                  setState(() {
                                    selectedTime = "16.00 - 17.00";
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 90.h,
                        ),
                      ],
                    ),
                  ],
                ),

                /// SECTION: BUTTON NEXT SCREEN
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: deviceWidth(context).r,
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
                    child: (!isSubmit) ? AccentRaisedButton(
                      width: defaultWidth(context).r,
                      height: 44.r,
                      color: accentColor,
                      borderRadius: 8,
                      text: "Pilih Pembayaran",
                      fontSize: 14.sp,
                      onPressed: (
                        selectedService != null &&
                        selectedDate != null &&
                        selectedTime != null
                      ) ? () async {
                        setState(() {
                          isSubmit = true;
                        });

                        onSubmitPressed(
                          context,
                          patient,
                        );
                      } : null,
                    ) : SpinKitRing(
                      color: accentColor,
                      size: 40.r,
                    ),
                  ),
                ),

                SizedBox(),
              ],
            ),
          ),
          SizedBox(),
        ],
      ),
    );
  }

  String dateTimeToString(DateTime date, String time) {
    return "${date.day} ${date.monthName} ${date.year}, $time";
  }

  String splitTimeString() {
    return "${
      selectedTime.replaceAll(' ', '').split('-')[1].split(".")[0]
    }:${
      selectedTime.replaceAll(' ', '').split('-')[1].split(".")[1]
    }";
  }

  DateTime parseSelectedSchedule() {
    return DateTime.parse(
      "${
        selectedDate.year
      }-${
        selectedDate.month.toString().padLeft(2, '0')
      }-${
        selectedDate.day.toString().padLeft(2, '0')
      } ${
        splitTimeString()
      }:00",
    );
  }

  String countTotalPrice(String purpose) {
    switch(purpose) {
      case "Vaksin Covid-19" :
        return "Rp. 50.000";
      case "Rapid Test" :
        return "Rp. 200.000";
      case "Swab PCR" :
        return "Rp. 900.000";
      case "Tes Covid-19" :
        return "Rp. 900.000";
      default :
        return "Rp. 30.000";
    }
  }

  Future<void> onSubmitPressed(
    BuildContext context, Patient patient 
  ) async {
    Uuid uuid = Uuid();

    Booking booking = Booking(
      id: uuid.v4(),
      userID: patient.id,
      doctor: Doctor(),
      message: "-",
      patient: patient,
      schedule: dateTimeToString(selectedDate, selectedTime),
      serviceType: "-",
      purposeType: selectedService,
      totalPrice: countTotalPrice(selectedService),
      reportTime: parseSelectedSchedule(),
    );

    Navigator.pushNamed(
      context,
      PaymentMethodScreen.routeName,
      arguments: booking,
    );

    setState(() {
      isSubmit = false;
    });
  }
}