import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/models/patient.dart';
import 'package:heaven_canceller_hospital/provider/validation_provider.dart';
import 'package:heaven_canceller_hospital/services/patient_service.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/shared/value.dart';
import 'package:heaven_canceller_hospital/ui/booking/change_patient_screen.dart';
import 'package:heaven_canceller_hospital/ui/static/accent_raised_button.dart';
import 'package:heaven_canceller_hospital/ui/static/custom_dropdown_field.dart';
import 'package:heaven_canceller_hospital/ui/static/custom_radio_button.dart';
import 'package:heaven_canceller_hospital/ui/static/custom_text_field.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPatientScreen extends StatefulWidget {
  static String routeName = '/add_patient_screen';

  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  String selectedGender;
  String selectedStatus;
  bool isSubmit = false;

  @override
  Widget build(BuildContext context) {
    final Box<Patient> patientBox = Hive.box('patients');
    final Patient patient = patientBox.getAt(0);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(
          context, 
          ChangePatientScreen.routeName,
        );
        return;
      },
      child: Scaffold(
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
                                      Navigator.pushReplacementNamed(
                                        context, 
                                        ChangePatientScreen.routeName,
                                      );
                                      validation.resetChange();
                                    },
                                  ),
                                ),
                                Align(  
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Tambah Pasien",
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

                            /// SECTION: INPUT FIELD FORM
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
                            CustomDropdownField(
                              labelName: "Status",
                              hintText: "Pilih Salah Satu",
                              options: status,
                              onChanged: (value) {
                                setState(() {
                                  selectedStatus = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 220.h,
                            ),

                            /// SECTION: BUTTON REGISTER DATA
                            if (!isSubmit) AccentRaisedButton(
                              color: accentColor,
                              width: defaultWidth(context),
                              text: "Daftar",
                              height: 44.r,
                              fontSize: 14.sp,
                              borderRadius: 8,
                              onPressed: (
                                validation.errorName == "" 
                                && selectedGender != null 
                                && selectedStatus != null
                              ) ? () {
                                setState(() {
                                  isSubmit = true;
                                });
                                onSubmitPressed(
                                  context,
                                  validation, 
                                  patient: Patient(
                                    id: patient.id,
                                    name: nameController.text,
                                    gender: selectedGender,
                                    status: selectedStatus,
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
      ),
    );
  }
  
  /// Method ketika tombol "daftar" ditekan
  void onSubmitPressed(BuildContext context, ValidationProvider validation, {Patient patient}) {
    Patient.register(patient);
    PatientService.storeResource(patient);

    Navigator.pushReplacementNamed(context, ChangePatientScreen.routeName);
    validation.resetChange();
  }
}