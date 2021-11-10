import 'dart:io';

import 'package:flutter/material.dart' as material;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:open_file/open_file.dart';

Future<void> reportPDF(
  material.BuildContext context, {
  String idBooking,
  String purposeType,
  String patientName,
  String patientGender,
  String message,
  String serviceType,
  String paymentMethod,
  String totalPrice,
}) async {
  final Document pdf = Document();

  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a4.copyWith(
        marginBottom: 1.5 * PdfPageFormat.cm,
      ),
      
      build: (Context context) { 
        return Expanded(
          child: Column(
            children: [
              Text(
                "Rumah Sakit Columbia Asia",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  "Jl. Listrik No.2A, Petisah Tengah, Kec. Medan Petisah, Kota Medan, Sumatera Utara 20112",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                height: 2.5,
                color: PdfColor.fromHex("000"),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "NO REGISTRASI: $idBooking",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "$purposeType",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DATA PASIEN",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(
                          "1. Nama Lengkap"
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        ":",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 140,
                        child: Text(
                          "$patientName",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(
                          "2. Jenis Kelamin"
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        ":",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 140,
                        child: Text(
                          "$patientGender",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(
                          "3. Keluhan / Pesan"
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        ":",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 140,
                        child: Text(
                          "$message",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DATA LAYANAN",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(
                          "1. Jenis Layanan"
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        ":",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 140,
                        child: Text(
                          "$serviceType",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(
                          "2. Tujuan Layanan"
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        ":",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 140,
                        child: Text(
                          "$purposeType",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(
                          "3. Metode Pembayaran",
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        ":",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 140,
                        child: Text(
                          "$paymentMethod",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(
                          "4. Total Biaya",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        ":",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 140,
                        child: Text(
                          "$totalPrice",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/${purposeType.toLowerCase().replaceAll(" ", "-")}-${patientName.toLowerCase().replaceAll(" ", "-")}.pdf");

  await file.writeAsBytes(await pdf.save());
  OpenFile.open(file.path);
}