import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_templeate/screen/vender/service/AddService.dart';
import 'package:file_templeate/screen/vender/service/serviceDetails.dart';
import 'package:file_templeate/widget/homeAppBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../widget/services/custom_button.dart';
import '../../vender/packageservices/detailsPackage.dart';
import '../details/detailsServiceForUser.dart';
//import 'AddPackage.dart';
//import 'ShowPackage.dart';
//import 'detailsPackage.dart';

class HomePageService extends StatefulWidget {
  const HomePageService({super.key});

  @override
  State<HomePageService> createState() => _HomePageServiceState();
}

class _HomePageServiceState extends State<HomePageService> {
  final Stream<QuerySnapshot> _usersStreamPackage =
      FirebaseFirestore.instance.collection('Service').where("Publishing",isEqualTo: "1").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' الخدمات  '),
        backgroundColor: Colors.black,
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
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 7 / 8,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                crossAxisCount: 2,
              ),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int i) {
                return InkWell(
                  onTap: () {
                    Get.to(() => DetailsServiceForUser(
                          data: snapshot.data!.docs[i],
                          ID_Doc:snapshot.data!.docs[i].id
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              "${snapshot.data!.docs[i]["imageurl"]}",
                              height: 250,
                              width: 400,
                              fit: BoxFit.cover,
                            )),
                        Container(
                          padding: EdgeInsets.all(15),
                          alignment: Alignment.center,
                          child: Text(
                            "${snapshot.data!.docs[i]["name"]}",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                       
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
