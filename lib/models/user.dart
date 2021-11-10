///* Class Model Vacancy
/// Model untuk mengelola data collection user (pengguna)

class User {
  final String id;
  final String name;
  final String phoneNumber;
  final String gender;
  final String email;
  final String insuranceNumber;

  User({
    this.id,
    this.name, 
    this.phoneNumber, 
    this.gender, 
    this.email, 
    this.insuranceNumber,
  });
}