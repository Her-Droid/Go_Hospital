import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/models/auth.dart';
import 'package:heaven_canceller_hospital/provider/validation_provider.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/auth/login_screen.dart';
import 'package:heaven_canceller_hospital/ui/auth/register_screen_no_hp.dart';
import 'package:heaven_canceller_hospital/ui/auth/register_screen_otp.dart';
import 'package:heaven_canceller_hospital/ui/auth/user_data_otp_screen.dart';
import 'package:heaven_canceller_hospital/ui/auth/user_data_screen.dart';
import 'package:heaven_canceller_hospital/ui/static/accent_raised_button.dart';
import 'package:heaven_canceller_hospital/ui/static/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = "/register_screen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                        height: 20.h,
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
                        height: 20.h,
                      ),
                      CustomTextField(
                        controller: confirmPasswordController,
                        labelText: "Konfirmasi Password",
                        hintText: "Masukan Konfirmasi",
                        obscureText: true,
                        errorValidation: validation.errorPasswordConfirmation,
                        onChanged: (value) {
                          validation.changePasswordConfirmation(
                            value, 
                            passwordController.text,
                          );
                        },
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      AccentRaisedButton(
                        color: accentColor,
                        width: defaultWidth(context),
                        text: "Berikutnya",
                        height: 44.h,
                        fontSize: 14.sp,
                        borderRadius: 8,
                        onPressed: (
                          validation.errorEmail == "" &&
                          validation.errorPassword == "" &&
                          validation.errorPasswordConfirmation == ""
                        ) ? () {
                          Navigator.pushNamed(
                            context, 
                            UserDataScreen.routeName,
                            arguments: Auth(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        } : null,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          validation.resetChange();
                          
                          Navigator.pushReplacementNamed(
                            context, 
                            RegisterNoHpScreen.routeName,
                          );
                        },
                        child: Text(
                          "Saya tidak punya email",
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
                            LoginScreen.routeName,
                          );
                        },
                        child: Text(
                          "Saya sudah memiliki akun",
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
}