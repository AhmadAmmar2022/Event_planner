import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_templeate/Auth/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../functions/function.dart';
import '../screen/vender/service/showservices.dart';
import '../style/app_colors.dart';
import '../screen/homePage/HomePage.dart';
import '../widget/Auth/custom_button.dart';
import '../widget/Auth/custom_formfield.dart';
import '../widget/Auth/custom_header.dart';
import '../widget/Auth/custom_richtext.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _userName = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get userName => _userName.text.trim();
  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  late UserCredential credential;
  String typeuser = "";
  @override
  Widget build(BuildContext context) {
    bool visiable = true;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: AppColors.blue,
            ),
            CustomHeader(
                text: 'تسجيل حساب',
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Signin()));
                }),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.08,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: AppColors.whiteshade,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32))),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Form(
                        key: formstate,
                        child: Column(children: [
                       
                          Container(
                            height: 125,
                            width: MediaQuery.of(context).size.width * 0.8,
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.09),
                            child: Image.asset("images/login.png"),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          CustomFormField(
                            valu: (val) {
                              return validate(val!, 10, 4);
                            },
                            headingText: "اسم المستخدم",
                            hintText: "اسم المستخدم",
                            obsecureText: false,
                            suffixIcon: const SizedBox(),
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.text,
                            controller: _userName,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomFormField(
                            valu: (val) {
                              return validate(val!, 15, 10);
                            },
                            headingText: "البريد الالكتروني",
                            hintText: "البريد الالكتروني",
                            obsecureText: false,
                            suffixIcon: const SizedBox(),
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.emailAddress,
                            controller: _emailController,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomFormField(
                            valu: (val) {
                              return validate(val!, 15, 8);
                            },
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.text,
                            controller: _passwordController,
                            headingText: "كلمة المرور",
                            hintText: "كلمة المرور لا تقل عن 8 محارف",
                            obsecureText: visiable,
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    visiable = !visiable;
                                  });
                                }),
                          ),
                        ])),
                    const SizedBox(
                      height: 5,
                    ),

                    Text(
                      "  اختر نوع الحساب",
                      style: TextStyle(fontSize: 24),
                    ),
                    RadioListTile(
                      value: "vender",
                      groupValue: typeuser,
                      onChanged: (val) {
                        setState(() {
                          typeuser = val!;
                          print(typeuser);
                        });
                      },
                      title: Text("مزود الخدمة"),
                      subtitle: Text("providing service"),
                    ),
                    RadioListTile(
                        value: "spnser",
                        groupValue: typeuser,
                        onChanged: (val) {
                          setState(() {
                            typeuser = val!;
                            print(typeuser);
                          });
                        },
                        title: Text("ممول الخدمة"),
                        subtitle: Text("Service sponsor")),
                    RadioListTile(
                      value: "planner",
                      groupValue: typeuser,
                      onChanged: (val) {
                        setState(() {
                          typeuser = val!;
                          print(typeuser);
                        });
                      },
                      title: Text("مخطط الخدمة"),
                      subtitle: Text("booking service"),
                    ),
                    AuthButton(
                      onTap: () async {
                        await signUp();
                      },
                      text: 'انشاء الحساب',
                    ),
                    // CustomRichText(
                    //   discription: 'Browsing as a visitor ',
                    //   text: 'click here',
                    //   onTap: () async {
                    //     credential =
                    //         await FirebaseAuth.instance.signInAnonymously();
                    //     print(credential);
                    //     // Navigator.pushReplacement(
                    //     //     context,
                    //     //     MaterialPageRoute(
                    //     //         builder: (context) => const Signin()));
                    //   },
                    // ),
                    // CustomRichText(
                    //   discription: 'Already Have an account? ',
                    //   text: 'Log In here',
                    //   onTap: () {
                    //     Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => const Signin()));
                    //   },
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  signUp() async {
    if (formstate.currentState!.validate()) {
      try {
        credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(credential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }

           
     try {
         if (credential.user?.uid != null){
        await FirebaseFirestore.instance.collection("Users").add({
     "username":userName,
     "id":1,
     "type": typeuser,
     "status":"false",
   });
  }
} on FirebaseException catch (e) {
   print(e);
}
      if (credential.user?.uid != null) {
        Get.snackbar(
          "welcome",
          " Login completed successfully",
          icon: Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromARGB(255, 31, 1, 101),
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
        Get.off(() => ShowServices());
      }
    
  }
}
}

