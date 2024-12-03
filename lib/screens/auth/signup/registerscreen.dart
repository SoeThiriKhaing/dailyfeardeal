import 'package:dailyfairdeal/screens/home/main_screen.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, right: 30.0, left: 30.0, bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text("Name", style: AppWidget.labelTextStyle()),
                  const SizedBox(
                    height: 10.0,
                  ),
                  DecoratedBox(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                        blurRadius: 80.0,
                        color: Colors.black12,
                        offset: Offset(1, 1),
                        blurStyle: BlurStyle.outer,
                      )
                    ]),
                    child: TextFormField(
                      validator: (val){
                        if(val == null || val.isEmpty){
                          return "Please Enter Your Name";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Enter Your Name",
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text("Email", style: AppWidget.labelTextStyle()),
                  const SizedBox(
                    height: 10.0,
                  ),
                  DecoratedBox(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          blurRadius: 80.0,
                          color: Colors.black12,
                          offset: Offset(1, 1),
                          blurStyle: BlurStyle.outer)
                    ]),
                    child: TextFormField(
                      validator: (val){
                        if(val == null || val.isEmpty){
                          return "Please Enter Your Email";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Enter Your Email"),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Password",
                    style: AppWidget.labelTextStyle(),
                  ),
                  const SizedBox(height: 10.0),
                  DecoratedBox(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          blurRadius: 80.0,
                          color: Colors.black12,
                          offset: Offset(1, 1),
                          blurStyle: BlurStyle.outer)
                    ]),
                    child: TextFormField(
                      validator: (val){
                        if(val == null || val.isEmpty){
                          return "Please Enter Your Password";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Enter Your Password"),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text("Confirm Password", style: AppWidget.labelTextStyle()),
                  const SizedBox(
                    height: 10.0,
                  ),
                  DecoratedBox(
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 80.0,
                            color: Colors.black12,
                            offset: Offset(1, 1),
                            blurStyle: BlurStyle.outer)
                      ]),
                      child: TextFormField(
                        validator: (val){
                        if(val == null || val.isEmpty){
                          return "Please Enter Your Confirm Password";
                        }else if(val != confirmController.text){
                          return "Passowrds are not match. Try again";
                        }
                        return null;
                      },
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "Enter Confirm Password"),
                      )),
                  const SizedBox(height: 30.0),
                  SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: ElevatedButton(
                        onPressed: () {
                          if(_formkey.currentState!.validate()){
                            Get.to(() => MainScreen());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          foregroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(),
                        ),
                        child: Text(
                          "Sign Up",
                          style: AppWidget.buttonTextStyle(),
                        ),
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed("/login");
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
