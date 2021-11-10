import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/extensions/date_time_extension.dart';
import 'package:heaven_canceller_hospital/models/booking.dart';
import 'package:heaven_canceller_hospital/models/doctor.dart';
import 'package:heaven_canceller_hospital/models/patient.dart';
import 'package:heaven_canceller_hospital/provider/patient_provider.dart';
import 'package:heaven_canceller_hospital/provider/validation_provider.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/booking/change_patient_screen.dart';
import 'package:heaven_canceller_hospital/ui/booking/components/selectable_date_button.dart';
import 'package:heaven_canceller_hospital/ui/booking/payment_method_screen.dart';
import 'package:heaven_canceller_hospital/ui/static/accent_raised_button.dart';
import 'package:heaven_canceller_hospital/ui/static/custom_radio_button.dart';
import 'package:heaven_canceller_hospital/ui/static/custom_text_field.dart';
import 'package:heaven_canceller_hospital/ui/static/selectable_box_button.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingConfirmationScreen extends StatefulWidget {
  static String routeName = '/booking_confirmation_screen';

  @override
  _BookingConfirmationScreenState createState() => _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  String selectedTime;
  List<DateTime> dates;
  DateTime selectedDate;
  String selectedDoctorPurpose;
  String selectedPurpose;

  TextEditingController messageController = TextEditingController();

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
    final Doctor doctor = ModalRoute.of(context).settings.arguments;

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
                              child: Consumer<ValidationProvider>(
                                builder: (context, validation, _) => Icon(
                                  Icons.arrow_back,
                                  color: darkGreyColor,
                                  size: 28.r,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Align(  
                            alignment: Alignment.center,
                            child: Text(
                              "Konfirmasi Booking",
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

                    /// SECTION: DOCTOR BOOKED CARD
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl: doctor.photo,
                            placeholder: (_, url) => SpinKitRing(
                              color: accentColor,
                              size: 40.r,
                            ),
                            imageBuilder: (_, provider) => Container(
                              width: 60.r,
                              height: 60.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 3.w,
                                  color: accentColor,
                                ),
                                image: DecorationImage(
                                  image: provider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 24.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.name,
                                style: semiBoldBaseFont.copyWith(
                                  color: darkGreyColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                doctor.speciality,
                                style: regularBaseFont.copyWith(
                                  color: greyColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 36.h,
                    ),
                    Container(
                      width: 1.sw,
                      height: 12.r,
                      color: Color(0xFFEEEEEE),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultMargin.r,
                          ),
                          child: Text(
                            "Informasi Konsultasi",
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
                            "Layanan Untuk",
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
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDoctorPurpose = "Spesialis";
                                  });
                                },
                                child: CustomRadioButton(
                                  value: "Spesialis",
                                  groupValue: selectedDoctorPurpose,
                                  onChange: (value) {
                                    setState(() {
                                      selectedDoctorPurpose = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 32.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDoctorPurpose = "Konsultasi";
                                  });
                                },
                                child: CustomRadioButton(
                                  value: "Konsultasi",
                                  groupValue: selectedDoctorPurpose,
                                  onChange: (value) {
                                    setState(() {
                                      selectedDoctorPurpose = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
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
                                    selectedPurpose = "Medical Checkup";
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomRadioButton(
                                      value: "Medical Checkup",
                                      groupValue: selectedPurpose,
                                      onChange: (value) {
                                        setState(() {
                                          selectedPurpose = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Rp. 198.369",
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
                                    selectedPurpose = "CT - Scan";
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomRadioButton(
                                      value: "CT - Scan",
                                      groupValue: selectedPurpose,
                                      onChange: (value) {
                                        setState(() {
                                          selectedPurpose = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Rp. 1.624.145",
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
                                    selectedPurpose = "MRI";
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomRadioButton(
                                      value: "MRI",
                                      groupValue: selectedPurpose,
                                      onChange: (value) {
                                        setState(() {
                                          selectedPurpose = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Rp. 4.511.153",
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
                                    selectedPurpose = "Rontgen";
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomRadioButton(
                                      value: "Rontgen",
                                      groupValue: selectedPurpose,
                                      onChange: (value) {
                                        setState(() {
                                          selectedPurpose = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Rp. 1.784.748",
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
                                    selectedPurpose = "Tes Darah";
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomRadioButton(
                                      value: "Tes darah",
                                      groupValue: selectedPurpose,
                                      onChange: (value) {
                                        setState(() {
                                          selectedPurpose = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Rp. 264.411",
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
                                    selectedPurpose = "Periksa Gigi";
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomRadioButton(
                                      value: "Periksa Gigi",
                                      groupValue: selectedPurpose,
                                      onChange: (value) {
                                        setState(() {
                                          selectedPurpose = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Rp. 274.815",
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
                                    selectedPurpose = "Gula Darah";
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomRadioButton(
                                      value: "Gula Darah",
                                      groupValue: selectedPurpose,
                                      onChange: (value) {
                                        setState(() {
                                          selectedPurpose = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Rp. 631.370",
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
                            "Detail Booking",
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
                                    "Booking Untuk",
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
                            children: doctor.doctorSchedule.map((schedule) {
                              return SelectableBoxButton(
                                borderRadius: 20,
                                thickBorder: 1.5,
                                borderColor: lightGreyColor,
                                fontColor: greyColor,
                                content: schedule.time,
                                isSelected: selectedTime == schedule.time,
                                onTap: () {
                                  setState(() {
                                    selectedTime = schedule.time;
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),

                        /// SECTION: PERSONAL MESSAGE INPUT
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultMargin.r,
                          ),
                          child: Text(
                            "Pesan Pribadi",
                            style: semiBoldBaseFont.copyWith(
                              color: darkGreyColor,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultMargin,
                          ),
                          child: CustomTextField(
                            controller: messageController,
                            hintText: "Catatan Untuk Dokter",
                            maxLines: 4,
                            fontSize: 13.sp,
                            onChanged: (value) {
                              
                            },
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
                        selectedDoctorPurpose != null &&
                        selectedPurpose != null &&
                        selectedDate != null &&
                        selectedTime != null
                      ) ? () async {
                        setState(() {
                          isSubmit = true;
                        });

                        onSubmitPressed(
                          context,
                          doctor: doctor,
                          patient: patient,
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
      case "Medical Checkup" :
        return "Rp. 198.369";
      case "CT - Scan" :
        return "Rp. 1.624.145";
      case "MRI" :
        return "Rp. 4.511.153";
      case "Rontgen" :
        return "Rp. 1.784.748";
      case "Tes Darah" :
        return "Rp. 264.411";
      case "Periksa Gigi" :
        return "Rp. 274.815";
      default :
        return "Rp. 631.370";
    }
  }

  Future<void> onSubmitPressed(
    BuildContext context, { Doctor doctor, Patient patient 
  }) async {
    Uuid uuid = Uuid();

    Booking booking = Booking(
      id: uuid.v4(),
      userID: patient.id,
      doctor: doctor,
      message: messageController.text ?? "-",
      patient: patient,
      schedule: dateTimeToString(selectedDate, selectedTime),
      serviceType: selectedDoctorPurpose,
      purposeType: selectedPurpose,
      totalPrice: countTotalPrice(selectedPurpose),
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