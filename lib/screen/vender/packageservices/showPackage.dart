import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_templeate/screen/vender/service/AddService.dart';
import 'package:file_templeate/screen/vender/service/serviceDetails.dart';
import 'package:file_templeate/widget/homeAppBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../../../widget/services/custom_button.dart';
import 'AddPackage.dart';
import 'ShowPackage.dart';


class ShowPackage extends StatefulWidget {
  const ShowPackage({super.key});

  @override
  State<ShowPackage> createState() => _ShowPackageState();
}

class _ShowPackageState extends State<ShowPackage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('PackageServices')
      .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: serviceButton(
            text: " اضافة خدمة ",
            onTap: () {
              // print("========================");
              // print(FirebaseAuth.instance.currentUser!.uid);
              // // Get.to(() => AddPackage());
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        serviceButton(
          text: "  اضافة مجموعة من الخدمات  ",
          onTap: () {
            Get.to(()=>AddPackage());
          },
        ),
        SizedBox(
          height: 25,
        ),
        SizedBox(
        height: 200,
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
        
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text("Loading"));
              }
        
              return  ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
           padding: EdgeInsets.all(10),
                  itemBuilder: (BuildContext context, int i) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const serviceDetails()));
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
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              child: Text(
                                "${snapshot.data!.docs[i]["name"]}",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 25),
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
        ),  SizedBox(height: 20,),
          SizedBox(
        height: 200,
           child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
         
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text("Loading"));
              }
         
              return ListView.builder(
               padding: EdgeInsets.zero,
              
            scrollDirection: Axis.horizontal,
            itemCount:  snapshot.data!.docs.length,
            
            itemBuilder: (context, index) {
              return   Container(
            
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
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              child: Text(
                                "${snapshot.data!.docs[index]["name"]}",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 25),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            )
                          ],
                        ),
                      );
            },
                 );
            },
                 ),
         )

      ]),
    );
  }
}
