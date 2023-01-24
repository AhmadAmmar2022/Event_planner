import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar homeAppBar() {
  return AppBar(
    elevation: 0,
    title: Text(
      ' إضافة خدمة',
      style: GoogleFonts.getFont('Almarai'),
    ),
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {},
    ),
    centerTitle: true,
    actions: [
      IconButton(
        icon: Icon(Icons.home),
        onPressed: () {},
      ),
    ],
  );
}
