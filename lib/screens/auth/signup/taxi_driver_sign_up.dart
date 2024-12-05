import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
    
class TaxiDriverSignUp extends StatefulWidget {
  const TaxiDriverSignUp({super.key});

  @override
  State<TaxiDriverSignUp> createState() => _TaxiDriverSignUpState();
}

class _TaxiDriverSignUpState extends State<TaxiDriverSignUp> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();

  Widget buildTextFormField(String label, TextEditingController controller, {String? Function(String?)? validator, TextInputType? keyboardType, int? maxLines}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: label,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget buildPhoneField() {
    return buildTextFormField(
      'Phone Number',
      phoneController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the phone number';
        } else if (!RegExp(r'^\d{10,}$').hasMatch(value)) {
          return 'Enter a valid phone number';
        }
        return null;
      },
      keyboardType: TextInputType.phone,  // Use phone keyboard
    );
  }

  Widget buildDateOfBirthTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Date of Birth",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: dobController,
          readOnly: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'yyyy-MM-dd',
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                await selectDateOfBirth(context);
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your date of birth';
            }
            return null;
          },
        ),
      ],
    );
  }

  Future<void> selectDateOfBirth(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        dobController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  Widget buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            Get.snackbar("Successful", "Form submitted successfully!");
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFC740),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: const Text(
          "Submit",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildLoginRedirectButton() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Already have an account? "),
          GestureDetector(
            onTap: () {
             // Get.to(()=> const MerchantLogin());
            },
            child: const Text(
              "Sign In",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ready to hit the road?',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Fill out the form below',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 20),
                buildTextFormField('Name', nameController, keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                buildTextFormField('Email', emailController, keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 10),
                buildPhoneField(),
                const SizedBox(height: 10),
                buildDateOfBirthTextFormField(),
                const SizedBox(height: 10),
                buildTextFormField('Address', addressController, keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                buildTextFormField('Referral Code', referralCodeController, keyboardType: TextInputType.text),
                const SizedBox(height: 20),
                buildSubmitButton(),
                const SizedBox(height: 15),
                buildLoginRedirectButton(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}