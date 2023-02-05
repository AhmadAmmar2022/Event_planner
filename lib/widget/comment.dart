import 'package:comment_box/comment/comment.dart';
import 'package:file_templeate/const/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// late User signedInUser; //this will give us the email
final _firestore = FirebaseFirestore.instance;

class comment extends StatefulWidget {
  final ID_doc;
  const comment({super.key, this.ID_doc});
  @override
  _commentState createState() => _commentState();
}

class _commentState extends State<comment> {
  final _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  late CollectionReference userref ;
 late final Stream<QuerySnapshot> _usersStreamPackage;
  String? messageText;
  void initState() {
    super.initState();
   fetchData(widget.ID_doc);
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // signedInUser = user;
        // print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // var email = signedInUser.email;
  Widget commentChild() {
    return StreamBuilder<QuerySnapshot>(
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
                       
                      )),
                );
              });
        },
      );;

    //this is the end of commentchild
  } //for comment  child

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
                  "https://cdn.onlinewebfonts.com/svg/img_418803.png"),
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

 fetchData(String searchFild) async {
    _usersStreamPackage = FirebaseFirestore.instance.collection('comment').where("service_Id", isEqualTo: searchFild).snapshots();
  }

  Add() async {
    userref.add({
      //"user": email,
      // "service_Id": widget.ID_doc,
      "text": commentController.text,
    }).then((value) {
      print(widget.ID_doc);
      Get.snackbar("تمت العملية بنجاح  ", " ",
          colorText: Colors.white,
          backgroundColor: Colors.lightBlue,
          icon: const Icon(Icons.add_alert),
          snackPosition: SnackPosition.BOTTOM);
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