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
import 'package:heaven_canceller_hospital/ui/auth/user_data_screen.dart';
import 'package:heaven_canceller_hospital/ui/static/accent_raised_button.dart';
import 'package:heaven_canceller_hospital/ui/static/custom_text_field.dart';
import 'package:heaven_canceller_hospital/ui/static/validation_flushbar.dart';
import 'package:heaven_canceller_hospital/ui/wrapper.dart';
import 'package:heaven_canceller_hospital/utils/firebase_exception_util.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_receiver/sms_receiver.dart';

class RegisterOtpScreen extends StatefulWidget {
  static String routeName = "/register_screen_otp";

  @override
  _RegisterOtpScreenState createState() => _RegisterOtpScreenState();
}

class _RegisterOtpScreenState extends State<RegisterOtpScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool isOTPSent = false;
  bool isLoading = false;
  String verificationID;
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey();

  Auth authData = Auth();
  SmsReceiver smsReceiver;

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
                          enabled: false,
                          keyboardType: TextInputType.phone),
                      isOTPSent
                          ? SizedBox(
                              height: 20.h,
                            )
                          : Container(),
                      isOTPSent
                          ? CustomTextField(
                              controller: otpController,
                              labelText: "Kode OTP",
                              hintText: "******",
                              keyboardType: TextInputType.number)
                          : Container(),
                      SizedBox(
                        height: 20.h,
                      ),
                      isOTPSent && !isLoading
                          ? AccentRaisedButton(
                              color: accentColor,
                              width: defaultWidth(context),
                              text: "Verifikasi",
                              height: 44.h,
                              fontSize: 14.sp,
                              borderRadius: 8,
                              onPressed: (true)
                                  ? () {
                                      verifyOTP();
                                    }
                                  : null,
                            )
                          : !isOTPSent && !isLoading
                              ? AccentRaisedButton(
                                  color: accentColor,
                                  width: defaultWidth(context),
                                  text: "Kirim OTP",
                                  height: 44.h,
                                  fontSize: 14.sp,
                                  borderRadius: 8,
                                  onPressed: (true)
                                      ? () {
                                          verifyPhoneNumber();
                                        }
                                      : null,
                                )
                              : Container(),
                      isLoading
                          ? SpinKitRing(
                              color: accentColor,
                              size: 40.r,
                            )
                          : Container(),
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
        authData = ModalRoute.of(context).settings.arguments as Auth;
        phoneController.text = authData.phoneNumber;
      });
      verifyPhoneNumber();
      listenToSMS();
    });
  }

  listenToSMS() async {
    smsReceiver = SmsReceiver(onSmsReceived, onTimeout: onTimeout);
    _startListening();
  }

  onSmsReceived(String message) {
    List<String> sms = message.split("\n");
    String otp = sms[0].replaceAll("Enter: ", "");
    setState(() {
      print("ON OTP RECEIVED");
      otpController.text = otp;
      verifyOTP();
    });
  }

  onTimeout() {
    print("ON OTP TIMEOUT");
    listenToSMS();
  }

  _startListening() {
    smsReceiver.startListening();
  }

  verifyPhoneNumber() async {
    setState(() {
      isLoading = true;
    });
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (phoneAuthCredential) async {
        setState(() {
          isLoading = false;
        });
      },
      verificationFailed: (verificationFailed) async {
        setState(() {
          isLoading = false;
        });
        showValidationBar(
          context,
          message: generateAuthMessage("Nomor telepon tidak valid."),
        );
      },
      codeSent: (verificationID, resendingToken) async {
        setState(() {
          isLoading = false;
          isOTPSent = true;
          this.verificationID = verificationID;
        });
      },
      codeAutoRetrievalTimeout: (verificationID) async {},
    );
  }

  verifyOTP() async {
    setState(() {
      isLoading = true;
    });
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential?.user != null) {
        // SUCCESS
        print("LOGIN SUCCCESS OTP");
        print(phoneAuthCredential.toString());
        print(FirebaseAuth.instance.currentUser.uid);
        createDataFirebase(phoneAuthCredential);
      }
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      if(e.message.contains("invalid")){
        showValidationBar(
          context,
          message: generateAuthMessage("Kode OTP salah, silahkan cek SMS"),
        );
      }
      else if(e.message.contains("expired")){
        showValidationBar(
          context,
          message: generateAuthMessage("Kode OTP kadaluarsa."),
        );
      }
      else {
        showValidationBar(
          context,
          message: generateAuthMessage("Terjadi kesalahan saat verifikasi OTP."),
        );
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  createDataFirebase(PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      isLoading = true;
    });
    ResponseHandler result =
        await AuthService.registerFromOtp(authData, phoneAuthCredential);

    if (result.user == null) {
      setState(() {
        isLoading = false;
      });

      showValidationBar(
        context,
        message: generateAuthMessage(result.message),
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        Wrapper.routeName,
      );
    }
  }
}
