import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

late User signedInUser; //this will give us the email
final _firestore = FirebaseFirestore.instance;

class comment extends StatefulWidget {
  @override
  _commentState createState() => _commentState();
}

class _commentState extends State<comment> {
  final _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  
    CollectionReference userref =
      FirebaseFirestore.instance.collection("comment");
  String? messageText;
  void initState() {
    super.initState();
    fetchData();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void messagestream() async {
  //   await for (var snapshot in _firestore.collection('comment').snapshots()) {
  //     snapshot.docs;
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //     ;
  //   }
  // }

  List filedata = [
    {
      'name': 'Chuks Okwuenu',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to code',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://www.adeleyeayodeji.com/img/IMG_20200522_121756_834_2.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Tunde Martins',
      'pic': 'assets/img/userpic.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
  ];

  Widget commentChild() {
    return 
     FutureBuilder(
          future: fetchData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                 scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int i) {
                    return 
                    Container(
                      height: 200,
                      color: Color.fromARGB(255, 88, 83, 83),
                      child: ListTile(
                                    leading: const Icon(Icons.comment),
                                    trailing:  Text(
                                      "",
                                      style: TextStyle(color: Colors.green, fontSize: 15),
                                    ),
                                    title: Text("${snapshot.data[i]['text']}")),
                    );
                  });
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return Text("  لا يوجد اي عقود ");
          });

    //this is the end of commentchild
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("صفحة التعليقات "),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        child: CommentBox(
          userImage: CommentBox.commentImageParser(
              imageURLorPath:
                  "https://cdn.onlinewebfonts.com/svg/img_322817.png"),
          child: commentChild(), //هون بدنا نحط ال Query
          labelText: 'اكتب تعليقك هنا...',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
             Add();
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
  fetchData() async{
   
  QuerySnapshot snapshot = await userref.get();
  List<QueryDocumentSnapshot> listdocs = snapshot.docs;
  return listdocs;
}
 Add() async {
      userref.add({
        "text": commentController.text,
      }).then((value) {
         Get.snackbar(
        "تمت العملية بنجاح  ",
        " ",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      snackPosition:SnackPosition.BOTTOM
      );
      }).catchError((e) {
        print(e);
      });
    }
  
}






        //   ListView(
        //   children: [
        //     for (var i = 0; i < snapshot.data!.docs.length; i++)
        //       Padding(
        //         padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
        //         child: ListTile(
        //           leading: GestureDetector(
        //             onTap: () async {
        //               // Display the image in large form.
        //               print("Comment Clicked");
        //             },
        //             child: Container(
        //               height: 50.0,
        //               width: 50.0,
        //               decoration: new BoxDecoration(
        //                   color: Colors.black87,
        //                   borderRadius:
        //                       new BorderRadius.all(Radius.circular(50))),
        //               child: CircleAvatar(
        //                   radius: 50,
        //                   backgroundImage: CommentBox.commentImageParser(
        //                       imageURLorPath:
        //                           'https://cdn.onlinewebfonts.com/svg/img_322817.png')),
        //             ),
        //           ),
        //           title: Text(
        //             "${snapshot.data!.docs[i]['user_name']}",
        //             style: TextStyle(fontWeight: FontWeight.bold),
        //           ),
        //           subtitle: Text(
        //             "${snapshot.data!.docs[i]["text"]}",
        //           ),
        //           trailing: Text("${snapshot.data!.docs[i]["date"]}",
        //               style: TextStyle(fontSize: 10)),
        //         ),
        //       )
        //   ],
        // );
        //${snapshot.data[i]['text']}