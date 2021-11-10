///* Class Model AboutUs
/// Model untuk mengelola data autentikasi pengguna

class Auth {
  final String name;
  final String phoneNumber;
  final String gender;
  final String email;
  final String password;
  final String insuranceNumber;

  Auth({
    this.name, 
    this.phoneNumber, 
    this.gender, 
    this.email, 
    this.password,
    this.insuranceNumber,
  });
}