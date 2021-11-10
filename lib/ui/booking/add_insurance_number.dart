import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/models/user.dart';
import 'package:heaven_canceller_hospital/provider/user_provider.dart';
import 'package:heaven_canceller_hospital/services/user_service.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/static/accent_raised_button.dart';
import 'package:heaven_canceller_hospital/ui/static/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddInsuranceScreen extends StatefulWidget {
  static String routeName = "/add_insurance_screen";

  @override
  _AddInsuranceScreenState createState() => _AddInsuranceScreenState();
}

class _AddInsuranceScreenState extends State<AddInsuranceScreen> {
  TextEditingController insuranceController = TextEditingController();

  bool isFilled = false;
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
                ListView(
                  children: [
                    SizedBox(
                      height: 24.r,
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
                            "Data Asuransi",
                            style: semiBoldBaseFont.copyWith(
                              fontSize: 18.sp,
                              color: darkGreyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin.r,
                      ),
                      child: Text(
                        "Silahkan masukan nomor asuransi jiwasraya milik anda, agar pembayaran bisa dilanjutkan.",
                        maxLines: 3,
                        style: mediumBaseFont.copyWith(
                          fontSize: 12.sp,
                          color: greyColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin.r,
                      ),
                      child: CustomTextField(
                        controller: insuranceController,
                        labelText: "Nomor Asuransi",
                        hintText: "Contoh: 00000xxxxxx",
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.length != 0) {
                            setState(() {
                              isFilled = true;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 350.h,
                    ),
                    if (!isSubmit) Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin.r,
                      ),
                      child: AccentRaisedButton(
                        color: accentColor,
                        width: 1.sw,
                        text: "Tambahkan",
                        height: 44.r,
                        fontSize: 14.sp,
                        borderRadius: 8,
                        onPressed: (insuranceController.text.trim().length != 0)
                        ? () async {
                          setState(() {
                            isSubmit = true;
                          });

                          User user = Provider.of<UserProvider>(
                            context, 
                            listen: false,
                          ).user;

                          await UserService.updateUser(
                            User(
                              id: user.id,
                              name: user.name,
                              email: user.email,
                              gender: user.gender,
                              phoneNumber: user.phoneNumber,
                              insuranceNumber: insuranceController.text,
                            ),
                          );

                          Provider.of<UserProvider>(
                            context,
                            listen: false,
                          ).loadResource(
                            user.id,
                          );
                          
                          Navigator.pop(context);
                        } : null,
                      ),
                    ) else SpinKitRing(
                      color: accentColor,
                      size: 40.r,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}