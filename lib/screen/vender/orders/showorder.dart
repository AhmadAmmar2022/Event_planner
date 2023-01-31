import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_templeate/screen/vender/packageservices/showPackage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowOrder extends StatefulWidget {
  final ID_DOC;
  const ShowOrder({super.key, this.ID_DOC});

  @override
  State<ShowOrder> createState() => _ShowOrderState();
}

class _ShowOrderState extends State<ShowOrder> {
  final Stream<QuerySnapshot> _usersStreamPackage = FirebaseFirestore.instance
      .collection('Orders')
      .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where("service_Id", isEqualTo: "tubT1PGEWJzIE9JCzzpK")
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        title: Text('عرض الطلب '),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ShowPackage()));
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStreamPackage,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int i) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                      margin: EdgeInsets.all(10),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.center,
                        child: Text(
                          "${snapshot.data!.docs[i]["name"]}",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      )),
                );
              });
        },
      ),
    );
  }
}
