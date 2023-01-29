import 'package:file_templeate/Auth/signin.dart';
import 'package:file_templeate/screen/chat_screen.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageSponsor extends StatefulWidget {
  const HomePageSponsor({super.key});

  @override
  State<HomePageSponsor> createState() => _HomePageSponsorState();
}

class _HomePageSponsorState extends State<HomePageSponsor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: Text(
          'صفحة ممول الخدمة  ',
        ),
        leading: IconButton(
          icon: Icon(Icons.chat),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ChatScreen()));
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Signin()));
            },
          ),
        ],
      ),
    );
  }
}
