import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_templeate/screen/vender/service/AddService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../widget/services/custom_button.dart';
import 'Editservice.dart';

class ShowServices extends StatefulWidget {
  const ShowServices({super.key});

  @override
  State<ShowServices> createState() => _ShowServicesState();
}

class _ShowServicesState extends State<ShowServices> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('PackageServices')
      .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        serviceButton(
          text: " اضافة خدمة ",
          onTap: () {
            print("========================");
            print(FirebaseAuth.instance.currentUser!.uid);
            Get.to(() => AddService());
          },
        ),
        SizedBox(
          height: 10,
        ),
        serviceButton(
          text: "  اضافة مجموعة من الخدمات  ",
          onTap: () {},
        ),
        SizedBox(
          height: 25,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading"));
            }

            return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 100, 100, 98),
                        border: Border.all(color: Colors.black, width: 4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "${snapshot.data!.docs[i]['name']}",
                            ),
                          ),
                          SizedBox(
                            height: 92,
                          ),
                          Container(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: IconButton(
                                      onPressed: () {
                                        Get.to(()=>EditService(ID_doc:snapshot.data!.docs[i].id,
                                        data:snapshot.data!.docs[i]));
                                        
                                      }, icon: Icon(Icons.edit)),
                                ),
                                SizedBox(
                                  width: 68,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.delete)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ));
                });
          },
        ),
      ]),
    );
  }
}
