import 'dart:convert';

import 'package:dailyfairdeal/screens/home/main_screen.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:dailyfairdeal/widget/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
    final client = http.Client();
    try {
      final response = await client.post(
        Uri.parse(
            "http://api.dailyfairdeal.com/api/signup"), // Use HTTPS if required.
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 302) {
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          final redirectedResponse = await client.get(Uri.parse(redirectUrl));
          print('Redirected Response: ${redirectedResponse.body}');
        } else {
          print("No redirect location provided.");
        }
      } else {
        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        if (response.statusCode == 200) {
          Get.snackbar("Successful", "Register Successfully",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green);
          Get.to(() => MainScreen());
        } else {
          Get.snackbar("Error", "Registration failed. Please try again.",
              snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
        }
      }
    } catch (e) {
      print('Exception: $e');
      Get.snackbar("Error", "Network error. Please check your connection.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: SingleChildScrollView(
          child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, right: 30.0, left: 30.0, bottom: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        controller: nameController,
                        validator: validateName,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "Enter Your Name"),
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
                        controller: emailController,
                        validator: validateEmail,
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
                        controller: passwordController,
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
                          controller: confirmController,
                          validator: validatePassword,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "Enter Confirm Password"),
                        )),
                    const SizedBox(height: 30.0),
                    Container(
                        width: MediaQuery.sizeOf(context).width,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
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
                        const Text("Already have an account?"),
                        GestureDetector(
                          onTap: () {
                            print("Sign In button tapped");
                            Get.toNamed("/login");
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
