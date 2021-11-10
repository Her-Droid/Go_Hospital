import 'package:equatable/equatable.dart';

///* Class Model DoctorSchedule
/// Model untuk mengelola data collection jadwal setiap dokter

class DoctorSchedule extends Equatable {
  final String dayName;
  final String time;
  final String place;

  DoctorSchedule({
    this.dayName,
    this.time,
    this.place,
  });

  @override
  List<Object> get props => [
    dayName,
    time,
    place,
  ];

  factory DoctorSchedule.fromJson(Map<String, dynamic> json) => DoctorSchedule(
    dayName: json['day_name'],
    time: json['time'],
    place: json['place'],
  );
}