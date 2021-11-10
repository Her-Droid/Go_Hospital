import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/models/doctor.dart';
import 'package:heaven_canceller_hospital/models/patient.dart';
import 'package:heaven_canceller_hospital/provider/navigation_provider.dart';
import 'package:heaven_canceller_hospital/provider/validation_provider.dart';
import 'package:heaven_canceller_hospital/services/patient_service.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/booking/booking_confirmation_screen.dart';
import 'package:heaven_canceller_hospital/ui/home/main_screen.dart';
import 'package:heaven_canceller_hospital/ui/static/accent_raised_button.dart';
import 'package:heaven_canceller_hospital/ui/static/custom_radio_button.dart';
import 'package:heaven_canceller_hospital/ui/static/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterAccountScreen extends StatefulWidget {
  static String routeName = '/register_account_screen';

  @override
  _RegisterAccountScreenState createState() => _RegisterAccountScreenState();
}

class _RegisterAccountScreenState extends State<RegisterAccountScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController handphoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String selectedGender;
  bool isSubmit = false;

  @override
  Widget build(BuildContext context) {
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
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultMargin.r,
                      vertical: 24.r,
                    ),
                    child: Consumer<ValidationProvider>(
                      builder: (context, validation, _) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// SECTION: TITLE BACK BUTTON
                          Stack(
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
                                    validation.resetChange();
                                  },
                                ),
                              ),
                              Align(  
                                alignment: Alignment.center,
                                child: Text(
                                  "Daftar Pasien",
                                  style: semiBoldBaseFont.copyWith(
                                    fontSize: 18.sp,
                                    color: darkGreyColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          /// SECTION: FORGIVE MESSAGE TEXT
                          SizedBox(
                            height: 24.h,
                          ),
                          Text(
                            "Maaf, anda belum terdaftar dalam aplikasi. Harap daftar terlebih dahulu untuk dapat membooking jadwal dengan dokter yang bersangkutan.",
                            maxLines: 3,
                            style: mediumBaseFont.copyWith(
                              fontSize: 12.sp,
                              color: greyColor,
                            ),
                          ),

                          /// SECTION: INPUT FIELD FORM
                          SizedBox(
                            height: 24.h,
                          ),
                          CustomTextField(
                            controller: nameController,
                            labelText: "Nama Pasien",
                            hintText: "Masukan Nama Pasien",
                            errorValidation: validation.errorName,
                            onChanged: (value) {
                              validation.changeName(value);
                            },
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Jenis Kelamin",
                                style: mediumBaseFont.copyWith(
                                  fontSize: 12.sp,
                                  color: darkGreyColor,
                                ),
                              ),
                              SizedBox(
                                height: 14.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomRadioButton(
                                    value: "Pria",
                                    groupValue: selectedGender,
                                    onChange: (value) {
                                      setState(() {
                                        selectedGender = value;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 32.w,
                                  ),
                                  CustomRadioButton(
                                    value: "Wanita",
                                    groupValue: selectedGender,
                                    onChange: (value) {
                                      setState(() {
                                        selectedGender = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          CustomTextField(
                            controller: handphoneController,
                            labelText: "No Handphone",
                            hintText: "Masukan No Handphone",
                            keyboardType: TextInputType.phone,
                            errorValidation: validation.errorPhoneNumber,
                            onChanged: (value) {
                              validation.changePhoneNumber(value);
                            },
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          CustomTextField(
                            controller: emailController,
                            labelText: "Email",
                            hintText: "Masukan Email",
                            keyboardType: TextInputType.emailAddress,
                            errorValidation: validation.errorEmail,
                            onChanged: (value) {
                              validation.changeEmail(value);
                            },
                          ),
                          SizedBox(
                            height: 64.h,
                          ),

                          /// SECTION: BUTTON NEXT NAVIGATION
                          if (!isSubmit) AccentRaisedButton(
                            color: accentColor,
                            width: 1.sw,
                            text: "Daftar",
                            height: 44.r,
                            fontSize: 14.sp,
                            borderRadius: 8,
                            onPressed: validation.isAllValidate() ? () {
                              setState(() {
                                isSubmit = true;
                              });

                              Uuid uuid = Uuid();

                              onSubmitPressed(
                                validation: validation,
                                doctor: doctor,
                                patient: Patient(
                                  id: uuid.v4(),
                                  name: nameController.text,
                                  gender: selectedGender,
                                  email: emailController.text,
                                  phoneNumber: handphoneController.text,
                                  status: "Saya Sendiri"
                                ),
                              );
                            } : null,
                          ) else SpinKitRing(
                            color: accentColor,
                            size: 40.r,
                          ),
                        ],
                      ),
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

  /// Method ketika tombol "daftar akun ditekan"
  Future<void> onSubmitPressed({
    ValidationProvider validation, 
    Patient patient, 
    Doctor doctor,
  }) async {
    if (selectedGender == null) {
      Flushbar(
        duration: Duration(milliseconds: 1500),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xFFFF5C83),
        message: "Jenis Kelamin Harus Diisikan",
      )..show(context);
    }
    
    Patient.register(patient);

    await PatientService.storeResource(patient);

    if (doctor != null) {
      Navigator.pushReplacementNamed(
        context, 
        BookingConfirmationScreen.routeName,
        arguments: doctor,
      );
    } else {
      Provider
      .of<NavigationProvider>(context, listen: false)
      .changeIndex(3, initialPage: 3);
      
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainScreen.routeName,
        (Route<dynamic> route) => false,
      );
    }
    
    validation.resetChange();
  }
}