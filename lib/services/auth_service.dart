import 'package:firebase_auth/firebase_auth.dart';
import 'package:heaven_canceller_hospital/extensions/firebase_user_extension.dart';
import 'package:heaven_canceller_hospital/models/auth.dart';
import 'package:heaven_canceller_hospital/models/patient.dart';
import 'package:heaven_canceller_hospital/models/user.dart' as model;
import 'package:heaven_canceller_hospital/models/response_handler.dart';
import 'package:heaven_canceller_hospital/services/patient_service.dart';
import 'package:heaven_canceller_hospital/services/user_service.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<User> get userStream => _auth.authStateChanges();

  static Future<ResponseHandler> register(Auth authData) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: authData.email,
        password: authData.password,
      );

      model.User user = result.user.convertToUser(
        name: authData.name,
        gender: authData.gender,
        phoneNumber: authData.phoneNumber,
        insuranceNumber: authData.insuranceNumber,
      );

      Patient patient = Patient(
        id: Uuid().v4(),
        name: authData.name,
        email: authData.email,
        gender: authData.gender,
        phoneNumber: authData.phoneNumber,
        status: "Saya Sendiri",
      );

      await UserService.updateUser(user);

      Patient.register(patient);

      await PatientService.storeResource(patient);

      return ResponseHandler(
        user: user,
      );
    } on FirebaseAuthException catch (error) {
      return ResponseHandler(
        message: error.code,
      );
    }
  }

  static Future<ResponseHandler> registerFromOtp(
      Auth authData, PhoneAuthCredential phoneAuthCredential) async {
    try {
      model.User user = model.User(
        id: FirebaseAuth.instance.currentUser.uid,
        name: authData.name,
        gender: authData.gender,
        phoneNumber: authData.phoneNumber,
        insuranceNumber: authData.insuranceNumber,
      );

      Patient patient = Patient(
        id: Uuid().v4(),
        name: authData.name,
        email: authData.email,
        gender: authData.gender,
        phoneNumber: authData.phoneNumber,
        status: "Saya Sendiri",
      );

      await UserService.updateUser(user);

      Patient.register(patient);

      await PatientService.storeResource(patient);

      return ResponseHandler(
        user: user,
      );
    } on FirebaseAuthException catch (error) {
      return ResponseHandler(
        message: error.code,
      );
    }
  }

  static Future<ResponseHandler> login(Auth authData) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: authData.email,
        password: authData.password,
      );

      model.User user = await result.user.fromFireStore();

      Patient patient = await PatientService.getSingle(
        user.email,
      );

      Patient.register(patient);

      return ResponseHandler(
        user: user,
      );
    } on FirebaseAuthException catch (error) {
      return ResponseHandler(
        message: error.code,
      );
    }
  }

  static Future<ResponseHandler> loginFromOtp() async {
    try {
      model.User user =
          await UserService.getUser(FirebaseAuth.instance.currentUser.uid);

      Patient patient = await PatientService.getSingle(
        user.email,
      );

      Patient.register(patient);

      return ResponseHandler(
        user: user,
      );
    } on FirebaseAuthException catch (error) {
      return ResponseHandler(
        message: error.code,
      );
    } catch (e) {
      return ResponseHandler(
        message: "user-not-found-otp",
      );
    }
  }

  static Future<void> logOut() async {
    await _auth.signOut();
  }
}
