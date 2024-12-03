import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MerchantSignUp extends StatefulWidget {
  const MerchantSignUp({super.key});

  @override
  State<MerchantSignUp> createState() => _MerchantSignUpState();
}

class _MerchantSignUpState extends State<MerchantSignUp> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? businessType, country, division, city, township, ward, street;
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<String> countryList = [];

  Future<List<String>> getCountries() async {
    try {
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/country"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body into a list of countries
        final data = json.decode(response.body);
        final List<String> countries = [];
        for (var country in data['data']) {
          countries.add(country['name']);
        }
        return countries;
      } else if (response.statusCode == 401) {
        // Handle unauthorized error
        throw Exception("Unauthorized: Invalid credentials");
      } else if (response.statusCode == 500) {
        // Handle internal server error
        throw Exception("Server error. Please try again later.");
      } else {
        throw Exception("Failed to load countries");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAddress(); // Fetch the countries when the widget is initialized
  }

  // Fetch the countries and update the state
  Future<void> fetchAddress() async {
    try {
      List<String> countries = await getCountries();
      setState(() {
        countryList = countries;
      });
    } catch (e) {
      // ignore: avoid_print
      print("Error fetching countries: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ready to expand your business?',
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
          padding: const EdgeInsets.all(10.0),
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
                buildTextFormField('Restaurant/Shop Name', shopNameController, keyboardType: TextInputType.text),
                buildDropdownField('Select Business Type', businessType, ['Shop', 'Restaurant'], (value) {
                  setState(() { businessType = value; });
                }),
                buildTextFormField('Owner Name', ownerNameController, keyboardType: TextInputType.text),
                buildPhoneField(),
                const Text("Restaurant/Shop Address", style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                buildAddressFields(),
                const SizedBox(height: 10),
                buildTextFormField('Description', descriptionController, keyboardType: TextInputType.text, maxLines: 3),
                const SizedBox(height: 20),
                buildSubmitButton(),
                const SizedBox(height: 10),
                buildLoginRedirectButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildDropdownField(String label, String? value, List<String> items, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Select Value',
          ),
          items: items.map((type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(
                type,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select $label';
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

  Widget buildAddressFields() {
    return Column(
      children: [
        // First row: Country and Division
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: buildDropdownField(
                'Country',
                country,
                countryList.isEmpty ? ['No option available'] : countryList,
                (value) => setState(() { country = value; }),
              ),
            ),
            const SizedBox(width: 10), // Add spacing between the dropdowns
            Expanded(
              child: buildDropdownField(
                'Division',
                division,
                ['Yangon', 'Mandalay', 'Mon'],
                (value) => setState(() { division = value; }),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10), // Spacing between rows

        // Second row: City and Township
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: buildDropdownField(
                'City',
                city,
                ['Yangon', 'Mandalay', 'Mawlamyine', 'Pyin Oo Lwin'],
                (value) => setState(() { city = value; }),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: buildDropdownField(
                'Township',
                township,
                ['Pabedan', 'Kamaryut', 'Hlaing', 'Mawlamyine'],
                (value) => setState(() { township = value; }),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Third row: Ward and Street
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: buildDropdownField(
                'Ward',
                ward,
                ['No-3', 'No-4'],
                (value) => setState(() { ward = value; }),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: buildDropdownField(
                'Street',
                street,
                ['Hnin Si', 'Padamyar'],
                (value) => setState(() { street = value; }),
              ),
            ),
          ],
        ),
      ],
    );
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
      child: TextButton(
        onPressed: (){},//=> Get.to(() => const MerchantLoginScreen()),
        child: const Text(
          'Have already an account? Login',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  void dispose() {
    shopNameController.dispose();
    ownerNameController.dispose();
    phoneController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
