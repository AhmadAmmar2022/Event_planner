import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../details/detailsForUser.dart';

class SearchData extends StatefulWidget {
  const SearchData({super.key});

  @override
  State<SearchData> createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  // List searchResult = [];

  // void searchFromFirebase(String query) async {
  //   final result = await FirebaseFirestore.instance
  //       .collection('PackageServices')
  //       .where('salary', isEqualTo: query)
  //       .get();

  //   setState(() {
  //     searchResult = result.docs.map((e) => e.data()).toList();
  //   });
  // }
  String name = "";
  final Stream<QuerySnapshot> _usersStreamPackage =
      FirebaseFirestore.instance.collection('PackageServices').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                        width: 3, color: Color.fromARGB(255, 249, 249, 249))),
                filled: true,
                fillColor: Color(0xff838C96),
                isDense: true,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(
                      width: 5,
                    )),
              ),
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
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
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var data =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  if (name.isEmpty) {
                    return InkWell(
                      child: ListTile(
                        title: Text(data['name']),
                        leading: CircleAvatar(),
                      ),
                      onTap: () {
                        Get.to(() => DetailsForUser(
                              ID_Doc: snapshot.data!.docs[index].id,
                              data: snapshot.data!.docs[index],
                            ));
                      },
                    );
                  }

                  if (data['name']
                      .toString()
                      .toLowerCase()
                      .startsWith(name.toLowerCase())) {
                    return InkWell(
                      child: ListTile(
                        title: Text(data['name']),
                        leading: CircleAvatar(),
                      ),
                      onTap: () {
                        Get.to(() => DetailsForUser(
                              ID_Doc: snapshot.data!.docs[index].id,
                              data: snapshot.data!.docs[index],
                            ));
                      },
                    );
                  }
                  return Container();
                });
          },
        ));
  }
}
