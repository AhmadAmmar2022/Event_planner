import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_templeate/screen/vender/service/showservices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widget/services/custom_button.dart';

class serviceDetails extends StatefulWidget {
  const serviceDetails({super.key});

  @override
  State<serviceDetails> createState() => _serviceDetailsState();
}

class _serviceDetailsState extends State<serviceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            hoverColor: Colors.grey,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Text(
          'تفاصيل الخدمة ',
          style: GoogleFonts.getFont('Almarai'),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ShowServices()));
          },
        ),
      ),
    );
  }
}
