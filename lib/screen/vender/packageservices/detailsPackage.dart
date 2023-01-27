import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class PackageDetails extends StatefulWidget {
  final String pack_id;
  const PackageDetails({super.key, required this.pack_id});

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
    var Pack_Id;
    @override
  void initState() {
 //Pack_Id =widget.pack_id;
    super.initState();
  }
   final Stream<QuerySnapshot> _usersStreamPackage = FirebaseFirestore.instance
      .collection('PackageServices').where("pack_id",isEqualTo:50)
      .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
      '  تفاصيل الحزمة   ',
      style: GoogleFonts.getFont('Almarai'),
    ),),
    body: Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: _usersStreamPackage,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading...");
            }

             return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 80, 80, 80),
                              border: Border.all(color: Colors.black, width: 4),
                              borderRadius: BorderRadius.circular(8),
                              
                            ),
                            child: Text(
                              "${snapshot.data!.docs[i]['name']}",
                            ),
                          );
                        });
          },
        ),
    ]));
  }
}