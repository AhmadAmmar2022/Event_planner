import 'package:comment_box/comment/comment.dart';
import 'package:file_templeate/const/imageassets.dart';
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
  final Stream<QuerySnapshot> _usersStreamPackage = FirebaseFirestore.instance
      .collection('comment') as Stream<QuerySnapshot<Object?>>;
  final CollectionReference<Map<String, dynamic>> userStream =
      FirebaseFirestore.instance.collection('comment');
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

  Widget commentChild(data) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStreamPackage,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return ListView(
          children: [
            for (var i = 0; i < snapshot.data!.docs.length; i++)
              Padding(
                padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                child: ListTile(
                  leading: GestureDetector(
                    onTap: () async {
                      // Display the image in large form.
                      print("Comment Clicked");
                    },
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: new BoxDecoration(
                          color: Colors.black87,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(50))),
                      child: CircleAvatar(
                          radius: 50,
                          backgroundImage: CommentBox.commentImageParser(
                              imageURLorPath:
                                  'https://cdn.onlinewebfonts.com/svg/img_322817.png')),
                    ),
                  ),
                  title: Text(
                    "${snapshot.data!.docs[i]['user_name']}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "${snapshot.data!.docs[i]["text"]}",
                  ),
                  trailing: Text("${snapshot.data!.docs[i]["date"]}",
                      style: TextStyle(fontSize: 10)),
                ),
              )
          ],
        );
      },
//this is the end of stream builder
    );

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
                  "https://cdn.onlinewebfonts.com/svg/img_322817.png"),
          child: commentChild(filedata), //هون بدنا نحط ال Query
          labelText: 'اكتب تعليقك هنا...',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              setState(() {
                var value = {
                  'name': '${snapshot.data!.docs[i]["user_name"]}',
                  'pic': 'https://cdn.onlinewebfonts.com/svg/img_322817.png',
                  'message': commentController.text,
                  'date': '2021-01-01 12:00:00'
                };
                filedata.insert(0, value);
              });
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
}
