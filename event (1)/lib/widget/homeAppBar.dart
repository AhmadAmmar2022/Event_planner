import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar homeAppBar() {
  return AppBar(
    backgroundColor: Colors.blueAccent,
    elevation: 0,
    title: Text(
      '  خدمات',
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
