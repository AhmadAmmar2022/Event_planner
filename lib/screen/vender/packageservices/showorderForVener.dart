import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_templeate/screen/vender/packageservices/showPackage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowOrderForVender extends StatefulWidget {
  final ID_DOC;
  const ShowOrderForVender({super.key, this.ID_DOC});

  @override
  State<ShowOrderForVender> createState() => _ShowOrderForVenderState();
}

class _ShowOrderForVenderState extends State<ShowOrderForVender> {
  late final Stream<QuerySnapshot> _usersStreamPackage;

   var options = [
    'معلقة',
    'قيد الانجاز',
    'تم الموافقة والحجز'
  ];
   var _currentItemSelected = "معلقة";
    var newpros="معلقة";
  @override
  void initState() {
    fetchData(widget.ID_DOC);
    super.initState();
  }
     _displayDialog(BuildContext context) async {  
    return showDialog(  
        context: context,  
        builder: (context) {  
          return AlertDialog(  
            title: Text('TextField AlertDemo'),  
            content:   DropdownButton<String>(
                              dropdownColor: Color.fromARGB(255, 55, 102, 173),
                              isDense: true,
                              isExpanded: false,
                              iconEnabledColor: Color.fromARGB(255, 20, 1, 1),
                              focusColor: Color.fromARGB(255, 17, 1, 1),
                              items: options.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 124, 121, 121),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValueSelected) {
                                setState(() {
                                  _currentItemSelected = newValueSelected!;
                                  newpros = newValueSelected;
                                });
                              },
                              value: _currentItemSelected,
                            ),
            actions: <Widget>[  
               MaterialButton(  
                child: new Text('SUBMIT'),  
                onPressed: () {  
                  Navigator.of(context).pop();  
                },  
              )  
            ],  
          );  
        });  
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        title: Text('عرض الطلبات التي تخص هذه الخدمة  '),
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
                  onTap: () {
                    _displayDialog(context);
                  },
                  child: Card(
                      elevation: 10,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          "${snapshot.data!.docs[i]["name"]}",
                          style: TextStyle(
                              color: Color.fromARGB(255, 10, 10, 10),
                              fontSize: 25),
                        ),
                        trailing: Text(
                          "${snapshot.data!.docs[i]["status"]}",
                          style: TextStyle(
                              color: Color.fromARGB(255, 12, 0, 0),
                              fontSize: 25),
                        ),
                      )),
                );
              });
        },
      ),
    );
  }

  fetchData(String searchFild) async {
    _usersStreamPackage = FirebaseFirestore.instance
        .collection('Orders')
        .where("service_Id", isEqualTo: searchFild)
        .snapshots();
  }
}
