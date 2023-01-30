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
import '../../../widget/services/custom_button.dart';
import 'AddPackage.dart';
import 'ShowPackage.dart';
import 'detailsPackage.dart';

class ShowPackage extends StatefulWidget {
  const ShowPackage({super.key});

  @override
  State<ShowPackage> createState() => _ShowPackageState();
}

class _ShowPackageState extends State<ShowPackage> {
  final Stream<QuerySnapshot> _usersStreamPackage = FirebaseFirestore.instance
      .collection('PackageServices')
      .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  final Stream<QuerySnapshot> _usersStreamService = FirebaseFirestore.instance
      .collection('Service')
      .where("pack_id")
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: serviceButton(
              text: " اضافة خدمة ",
              onTap: () {
                print("========================");
                print(FirebaseAuth.instance.currentUser!.uid);
                Get.to(() => Addservice(
                      serviec_id: "0",
                    ));
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          serviceButton(
            text: "  اضافة مجموعة من الخدمات  ",
            onTap: () {
              Get.to(() => AddPackage());
            },
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            ' حزمة الخدمات ',
            style: GoogleFonts.getFont('Almarai'),
          ),
          SizedBox(
            height: 200,
            child: StreamBuilder<QuerySnapshot>(
              stream: _usersStreamPackage,
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
      
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
      
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => PackageDetails(
                                data: snapshot.data!.docs[i],
                                ID_doc:snapshot.data!.docs[i].id
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
                                    width: 250,
                                    fit: BoxFit.cover,
                                  )),
                              Container(
                                padding: EdgeInsets.all(15),
                                alignment: Alignment.center,
                                child: Text(
                                  "${snapshot.data!.docs[i]["name"]}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
            
          ),  SizedBox(
            height: 10,
          ),
          
          Text(
            '  خدماتي ',
            style: GoogleFonts.getFont('Almarai'),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 200,
            child: StreamBuilder<QuerySnapshot>(
              stream: _usersStreamService,
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
      
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
      
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => SeviceDetails(
                              data: snapshot.data!.docs[index],
                              ID_Doc: snapshot.data!.docs[index].id
                            ));
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  "${snapshot.data!.docs[index]["imageurl"]}",
                                  height: 250,
                                  width: 250,
                                  fit: BoxFit.cover,
                                )),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${snapshot.data!.docs[index]["name"]}",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 3, 3, 3).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
