import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/models/patient.dart';
import 'package:heaven_canceller_hospital/provider/patient_provider.dart';
import 'package:heaven_canceller_hospital/provider/validation_provider.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/booking/add_patient_screen.dart';
import 'package:heaven_canceller_hospital/ui/booking/components/patient_radio_option.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePatientScreen extends StatefulWidget {
  static String routeName = '/change_patient_screen';
  
  @override
  _ChangePatientScreenState createState() => _ChangePatientScreenState();
}

class _ChangePatientScreenState extends State<ChangePatientScreen> {
  String selectedPatient;

  @override
  Widget build(BuildContext context) {
    final PatientProvider patientProvider = Provider.of<PatientProvider>(context, listen: false);
    final Box<Patient> patientBox = Hive.box('patients');
    final Patient selfUser = patientBox.getAt(patientProvider.patientIndex);
    
    setState(() {
      selectedPatient = selfUser.name;
    });

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
                              "Ganti Pasien",
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
                      height: 18.h,
                    ),

                    /// SECTION: PATIENT RADIO OPTION
                    Container(
                      height: (patientBox.length.toDouble() * 100).r,
                      child: Consumer<PatientProvider>(
                        builder: (context, patientProvider, _) => ValueListenableBuilder(
                          valueListenable: Hive.box<Patient>('patients').listenable(),
                          builder: (context, patient, _) => ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: patientBox.length,
                            itemBuilder: (_, index) {
                              final Patient patient = patientBox.getAt(index);
                              return PatientRadioOption(
                                name: patient.name,
                                gender: patient.gender,
                                status: patient.status,
                                value: patient.name,
                                groupValue: selectedPatient,
                                onChange: (value) {
                                  setState(() {
                                    selectedPatient = value;
                                    patientProvider.changeIndex(index);
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Center(
                      child: GestureDetector(
                        child: Text(
                          "Tambah Pasien",
                          style: mediumBaseFont.copyWith(
                            color: accentColor,
                            fontSize: 12.sp,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context, 
                            AddPatientScreen.routeName,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
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