import 'package:dailyfairdeal/screens/home/home.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  FocusNode focusNode = FocusNode();

  Future<void> register() async {
    try {
      final response = await http.post(
        Uri.parse("http://api.dailyfairdeal.com/api/signup"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );
      if (response.statusCode == 200) {
        //final data = json.decode(response.body);
          // If register is successful
          Get.snackbar("Success", "Register Successfully", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
          Get.to(() => const Home());  // Navigate to the MerchantSignUp screen
      }else if (response.statusCode == 302) {
        // Unauthorized error (Invalid credentials)
        Get.snackbar("Error", "The email is already used. Please try again.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      } else if (response.statusCode == 401) {
        // Unauthorized error (Invalid credentials)
        Get.snackbar("Error", "Invalid Email or Password. Please try again.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      } else if (response.statusCode == 500) {
        // Server error
        Get.snackbar("Error", "Internal server error. Please try again later.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      } else {
        // Other errors
        Get.snackbar("Error", "Something went wrong. Please try again.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }
    } catch (e) {
      // Handle any exceptions
      Get.snackbar("Error", "Network error. Please check your connection.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

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
                      controller:nameController,
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
                      controller:emailController,
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
                      obscureText: true,
                      controller:passwordController,
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
                        obscureText: true,
                        controller:confirmController,
                        validator: (val){
                        if(val == null || val.isEmpty){
                          return "Please Enter Your Confirm Password";
                        }else if(val != passwordController.text){
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
                            register();
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
