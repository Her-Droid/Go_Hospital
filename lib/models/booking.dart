import 'package:equatable/equatable.dart';
import 'package:heaven_canceller_hospital/models/doctor.dart';
import 'package:heaven_canceller_hospital/models/patient.dart';

///* Class Model AboutUs
/// Model untuk mengelola data booking pengguna

class Booking extends Equatable {
  final String id;
  final String userID;
  final Doctor doctor;
  final Patient patient;
  final String schedule;
  final String message;
  final int time;
  final String serviceType;
  final String purposeType;
  final String totalPrice;
  final String paymentMethod;
  final String report;
  final DateTime reportTime;

  Booking({
    this.id,
    this.userID,
    this.doctor,
    this.patient,
    this.schedule,
    this.message,
    this.time,
    this.serviceType,
    this.purposeType,
    this.totalPrice,
    this.paymentMethod,
    this.report,
    this.reportTime,
  });

  @override
  List<Object> get props => [
    id,
    userID,
    doctor,
    patient,
    schedule,
    message,
    time,
    serviceType,
    purposeType,
    totalPrice,
    paymentMethod,
    report,
    reportTime,
  ];
}