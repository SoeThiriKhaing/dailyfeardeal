import 'package:dailyfairdeal/screens/home/main_screen.dart';
import 'package:dailyfairdeal/service/api_method.dart';
import 'package:dailyfairdeal/service/secure_storage.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/formfield.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:dailyfairdeal/widget/validation.dart';
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
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  FocusNode focusNode = FocusNode();

  Future<void> register() async {
    String? token = await APIMethods().register(nameController.text, emailController.text, passwordController.text);

    if (token != null) {
      saveToken(token);
      // If register is successful
      Get.snackbar("Success", "Register Successfully", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      Get.to(() => MainScreen());  // Navigate to the MerchantSignUp screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0),
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
                    Text("Name", style: AppWidget.formFieldLabelTextStyle()),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: nameController,
                      validator: validateName,
                      decoration: nameInputDecoration(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text("Email", style: AppWidget.formFieldLabelTextStyle()),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: validateEmail,
                      decoration: emailInputDecoration(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Password",
                      style: AppWidget.formFieldLabelTextStyle(),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: passwordController,
                      decoration: passwordInputDecoration(
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
                        ),
                      ),
                      obscureText: !isPasswordVisible,
                      validator: validatePassword,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text("Confirm Password",
                        style: AppWidget.formFieldLabelTextStyle()),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: confirmController,
                      validator: validatePassword,
                      decoration: confirmpasswordInputDecoration(
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
                        ),
                      ),
                      obscureText: !isPasswordVisible,
                    ),
                    const SizedBox(height: 30.0),
                    SizedBox(
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
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () {
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
