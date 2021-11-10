import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/models/auth.dart';
import 'package:heaven_canceller_hospital/models/response_handler.dart';
import 'package:heaven_canceller_hospital/provider/validation_provider.dart';
import 'package:heaven_canceller_hospital/services/auth_service.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/static/accent_raised_button.dart';
import 'package:heaven_canceller_hospital/ui/static/custom_radio_button.dart';
import 'package:heaven_canceller_hospital/ui/static/custom_text_field.dart';
import 'package:heaven_canceller_hospital/ui/static/validation_flushbar.dart';
import 'package:heaven_canceller_hospital/ui/wrapper.dart';
import 'package:heaven_canceller_hospital/utils/firebase_exception_util.dart';
import 'package:provider/provider.dart';

class UserDataScreen extends StatefulWidget {
  static String routeName = "/user_data_screen";

  @override
  _UserDataScreenState createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController handphoneController = TextEditingController();
  TextEditingController insuranceNumberController = TextEditingController();

  String selectedGender;

  bool isSubmit = false;

  Auth authData = Auth();

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
                Consumer<ValidationProvider>(
                  builder: (_, validation, __) => ListView(
                    padding: EdgeInsets.fromLTRB(32.r, 32.r, 32.r, 48.r),
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 28.r,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Masukan data diri ",
                          style: boldBaseFont.copyWith(
                            fontSize: 18.sp,
                          ),
                          children: [
                            TextSpan(
                              text: "Pasien",
                              style: boldBaseFont.copyWith(
                                fontSize: 18.sp,
                                color: accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        "Lengkapi data diri agar tim dokter kami mudah mengenali anda sebagai pasien.",
                        style: regularBaseFont.copyWith(
                          fontSize: 12.sp,
                          color: greyColor,
                        ),
                      ),
                      SizedBox(
                        height: 36.h,
                      ),
                      CustomTextField(
                        controller: nameController,
                        labelText: "Nama Lengkap",
                        hintText: "Masukan Nama Lengkap",
                        keyboardType: TextInputType.name,
                        errorValidation: validation.errorName,
                        onChanged: (value) {
                          validation.changeName(value);
                        },
                      ),
                      SizedBox(
                        height: 20.h,
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
                        height: 20.h,
                      ),
                      CustomTextField(
                        controller: handphoneController,
                        labelText: "Nomor HP",
                        hintText: "Masukan Nomor HP",
                        keyboardType: TextInputType.phone,
                        errorValidation: validation.errorPhoneNumber,
                        onChanged: (value) {
                          validation.changePhoneNumber(value);
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextField(
                        controller: insuranceNumberController,
                        labelText: "Nomor Asuransi (Opsional)",
                        hintText: "Masukan Nomor Asuransi",
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 18.r,
                            height: 18.r,
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: greyColor,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: Checkbox(
                                  value: validation.isAcceptTerm,
                                  activeColor: accentColor,
                                  onChanged: (value) {
                                    validation.changeTerm(value);
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Saya telah menyetujui ",
                            style: regularBaseFont.copyWith(
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            "layanan & kebijakan",
                            style: regularBaseFont.copyWith(
                              fontSize: 12.sp,
                              color: accentColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      if (!isSubmit)
                        AccentRaisedButton(
                          color: accentColor,
                          width: defaultWidth(context),
                          text: "Daftar",
                          height: 44.h,
                          fontSize: 14.sp,
                          borderRadius: 8,
                          onPressed: (
                                  validation.errorName == "" &&
                                  validation.errorPhoneNumber == "" &&
                                  selectedGender != null &&
                                  validation.isAcceptTerm)
                              ? () {
                                  setState(() {
                                    isSubmit = true;
                                  });

                                  onDaftarButtonPressed(
                                    context,
                                    validation,
                                    Auth(
                                      email: authData.email,
                                      password: authData.password,
                                    ),
                                  );
                                }
                              : null,
                        )
                      else
                        SpinKitRing(
                          color: accentColor,
                          size: 40.r,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      getAuthData();
    });
  }

  getAuthData() {
    authData = ModalRoute.of(context).settings.arguments as Auth;
  }

  Future<void> onDaftarButtonPressed(
    BuildContext context,
    ValidationProvider validation,
    Auth auth,
  ) async {
    ResponseHandler result = await AuthService.register(
      Auth(
        email: auth.email,
        password: auth.password,
        name: nameController.text,
        phoneNumber: handphoneController.text,
        insuranceNumber: insuranceNumberController.text,
        gender: selectedGender,
      ),
    );

    if (result.user == null) {
      setState(() {
        isSubmit = false;
      });

      showValidationBar(
        context,
        message: generateAuthMessage(result.message),
      );
    } else {
      validation.resetChange();

      Navigator.pushReplacementNamed(
        context,
        Wrapper.routeName,
      );
    }
  }
}
