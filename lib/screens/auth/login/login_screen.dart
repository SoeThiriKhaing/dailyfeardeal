import 'package:dailyfairdeal/screens/home/main_screen.dart';
import 'package:dailyfairdeal/service/api_method.dart';
import 'package:dailyfairdeal/widget/formfield.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:dailyfairdeal/widget/validation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  Future<void> login() async {
    int? statusCode = await APIMethods()
        .login(emailController.text.trim(), passwordController.text.trim());

    if (statusCode == 200) {
          // If login is successful
          Get.snackbar("Success", "Login Successfully", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
          Get.to(() => MainScreen());  // Navigate to the MerchantSignUp screen
      } else if (statusCode == 401) {
        // Unauthorized error (Invalid credentials)
        Get.snackbar("Error", "Invalid Email or Password. Please try again.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      } else if (statusCode == 500) {
        // Server error
        Get.snackbar("Error", "Internal server error. Please try again later.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }else if(statusCode == 0) {
        //Network Error
        Get.snackbar("Error", "Network error. Please check your connection.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      } else {
        // Other errors
        Get.snackbar("Error", "Something went wrong. Please try again.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text('Email', style: AppWidget.FormFieldLabelTextStyle()),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  maxLength: 255,
                  maxLengthEnforcement: MaxLengthEnforcement.none,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: "Enter Email",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
                const SizedBox(height: 10),
                Text('Password', style: AppWidget.FormFieldLabelTextStyle()),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  decoration:passwordInputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),),
                  obscureText: !isPasswordVisible,
                  validator: validatePassword,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      APIMethods().login(emailController.text.trim(), passwordController.text.trim());
                    } 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC740),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    "Login",
                    style:AppWidget.buttonTextStyle(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/register");
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "or",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.facebook, color: Colors.white),
                  label: const Text("Continue with Facebook",
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.g_mobiledata_outlined,
                      color: Colors.redAccent),
                  label: const Text("Continue with Google",
                      style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    side: const BorderSide(color: Colors.black, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
