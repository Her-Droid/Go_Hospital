import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/models/auth.dart';
import 'package:heaven_canceller_hospital/models/response_handler.dart';
import 'package:heaven_canceller_hospital/provider/validation_provider.dart';
import 'package:heaven_canceller_hospital/services/auth_service.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/auth/login_screen.dart';
import 'package:heaven_canceller_hospital/ui/auth/register_screen.dart';
import 'package:heaven_canceller_hospital/ui/auth/user_data_otp_screen.dart';
import 'package:heaven_canceller_hospital/ui/auth/user_data_screen.dart';
import 'package:heaven_canceller_hospital/ui/static/accent_raised_button.dart';
import 'package:heaven_canceller_hospital/ui/static/custom_text_field.dart';
import 'package:heaven_canceller_hospital/ui/static/validation_flushbar.dart';
import 'package:heaven_canceller_hospital/ui/wrapper.dart';
import 'package:heaven_canceller_hospital/utils/firebase_exception_util.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterNoHpScreen extends StatefulWidget {
  static String routeName = "/register_screen_no_hp";

  @override
  _RegisterNoHpScreenState createState() => _RegisterNoHpScreenState();
}

class _RegisterNoHpScreenState extends State<RegisterNoHpScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.r,
                      vertical: 48.r,
                    ),
                    children: [
                      SizedBox(
                        height: 36.h,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Buat Akun Untuk ",
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
                        "Registrasikan diri anda agar bisa berkonsultasi dengan dokter kami.",
                        style: regularBaseFont.copyWith(
                          fontSize: 12.sp,
                          color: greyColor,
                        ),
                      ),
                      SizedBox(
                        height: 36.h,
                      ),
                      CustomTextField(
                          controller: phoneController,
                          labelText: "Nomor Telepon",
                          hintText: "+62XXXXXX",
                          enabled: true,
                          keyboardType: TextInputType.phone),
                      SizedBox(
                        height: 20.h,
                      ),
                      AccentRaisedButton(
                        color: accentColor,
                        width: defaultWidth(context),
                        text: "Berikutnya",
                        height: 44.h,
                        fontSize: 14.sp,
                        borderRadius: 8,
                        onPressed: (true)
                            ? () {
                                goToUserData();
                              }
                            : null,
                      ),
                      SizedBox(
                        height: 30.h,
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
      setState(() {
        phoneController.text = "+62";
      });
      ;
    });
  }

  goToUserData() {
    Navigator.pushNamed(
      context,
      UserDataOtpScreen.routeName,
      arguments: Auth(
        phoneNumber: phoneController.text,
      ),
    );
  }
}
