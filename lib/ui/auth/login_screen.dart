import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/models/auth.dart';
import 'package:heaven_canceller_hospital/models/response_handler.dart';
import 'package:heaven_canceller_hospital/provider/validation_provider.dart';
import 'package:heaven_canceller_hospital/services/auth_service.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/auth/login_screen_otp.dart';
import 'package:heaven_canceller_hospital/ui/auth/register_screen.dart';
import 'package:heaven_canceller_hospital/ui/static/accent_raised_button.dart';
import 'package:heaven_canceller_hospital/ui/static/custom_text_field.dart';
import 'package:heaven_canceller_hospital/ui/static/validation_flushbar.dart';
import 'package:heaven_canceller_hospital/ui/wrapper.dart';
import 'package:heaven_canceller_hospital/utils/firebase_exception_util.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isSubmit = false;

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
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.r,
                      vertical: 48.r,
                    ),
                    children: [
                      SizedBox(
                        height: 52.h,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Selamat Datang Di ",
                          style: boldBaseFont.copyWith(
                            fontSize: 18.sp,
                          ),
                          children: [
                            TextSpan(
                              text: "Go Hospital",
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
                        "Silahkan lakukan login dengan akun anda terlebih dahulu untuk masuk.",
                        style: regularBaseFont.copyWith(
                          fontSize: 12.sp,
                          color: greyColor,
                        ),
                      ),
                      SizedBox(
                        height: 54.h,
                      ),
                      CustomTextField(
                        controller: emailController,
                        labelText: "Email",
                        hintText: "Masukan Akun Email",
                        keyboardType: TextInputType.emailAddress,
                        errorValidation: validation.errorEmail,
                        onChanged: (value) {
                          validation.changeEmail(value);
                        },
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        labelText: "Password",
                        hintText: "Masukan Password",
                        obscureText: true,
                        errorValidation: validation.errorPassword,
                        onChanged: (value) {
                          validation.changePassword(value);
                        },
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      if (!isSubmit) AccentRaisedButton(
                        color: accentColor,
                        width: defaultWidth(context),
                        text: "Masuk",
                        height: 44.r,
                        fontSize: 14.sp,
                        borderRadius: 8,
                        onPressed: (
                          validation.errorEmail== "" && 
                          validation.errorPassword == ""
                        ) ? () {
                          setState(() {
                            isSubmit = true;
                          });

                          onMasukButtonPressed(
                            context,
                            validation,
                          );
                        } : null,
                      ) else SpinKitRing(
                        color: accentColor,
                        size: 40.r,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          validation.resetChange();
                          
                          Navigator.pushReplacementNamed(
                            context, 
                            LoginOtpScreen.routeName,
                          );
                        },
                        child: Text(
                          "Masuk menggunakan Nomor Hp",
                          textAlign: TextAlign.center,
                          style: regularBaseFont.copyWith(
                            fontSize: 12.sp,
                            color: accentColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          validation.resetChange();
                          
                          Navigator.pushReplacementNamed(
                            context, 
                            RegisterScreen.routeName,
                          );
                        },
                        child: Text(
                          "Saya belum punya akun",
                          textAlign: TextAlign.center,
                          style: regularBaseFont.copyWith(
                            fontSize: 12.sp,
                            color: accentColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
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

  Future<void> onMasukButtonPressed(
    BuildContext context,
    ValidationProvider validation,
  ) async {
    ResponseHandler result = await AuthService.login(
      Auth(
        email: emailController.text,
        password: passwordController.text,
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