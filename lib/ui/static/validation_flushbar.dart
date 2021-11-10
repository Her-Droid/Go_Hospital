import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';

Future<dynamic> showValidationBar(
  BuildContext context, {String message = "", Color color = maroonColor}) {
  return Flushbar(
    duration: Duration(seconds: 4),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: color,
    message: message,
  ).show(context);
}