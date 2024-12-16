import 'package:dailyfairdeal/service/api_method.dart';
import 'package:dailyfairdeal/widget/dropdown_field_widget.dart';
import 'package:dailyfairdeal/widget/phone_text_field_widget.dart';
import 'package:dailyfairdeal/widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  List<Map<String, String>> countryList = [];
  List<Map<String, String>> divisionList = [];
  List<Map<String, String>> cityList = [];
  List<Map<String, String>> townshipList = [];
  List<Map<String, String>> wardList = [];
  List<Map<String, String>> streetList = [];

  int? selectedCountryId, selectedDivisionId, selectedCityId, selectedTownshipId, selectedWardId;

  List<Map<String, String>> businessTypeList = [
    {
      'id': '1', 
      'name': 'Shop'
    },
    {
      'id': '2',
      'name':'Restaurant',
    }
  ];

  @override
  void initState() {
    super.initState();
    fetchAddress();
  }

  // Fetch the countries and update the state
  Future<void> fetchAddress() async {
    try {
      List<Map<String, String>> countries = await APIMethods().getCountries();
      setState(() {
        countryList = countries;
      });
    } catch (e) {
      // ignore: avoid_print
      print("Error fetching country: $e");
      
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
                buildDropdownField('Select Business Type', businessType, businessTypeList, (value) {
                  setState(() { businessType = value; });
                }),
                const SizedBox(height: 10),
                buildTextFormField('Owner Name', ownerNameController, keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                buildPhoneField(phoneController),
                const SizedBox(height: 10),
                const Text("Restaurant/Shop Address", style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                buildAddressFields(),
                const SizedBox(height: 10),
                buildTextFormField('Description', descriptionController, keyboardType: TextInputType.text, maxLines: 3),
                const SizedBox(height: 20),
                buildSubmitButton(),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget buildAddressFields() {
    return Column(
      children: [
        // First row: Country and Division
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 1,
              child: buildDropdownField(
                'Country',
                country,
                countryList,
                (value) async {
                  setState(() {
                    country = value;
                    division = city = township = ward = street = null;
                    selectedCountryId = int.tryParse(countryList.firstWhere(
                      (item) => item['name'] == value)['id']!) ?? 0;
                  });
                  if (selectedCountryId != null && selectedCountryId != 0) {
                    divisionList = await APIMethods().getDivisions(selectedCountryId!);
                    setState(() {}); // Refresh dropdown
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: buildDropdownField(
                'Division',
                division,
                divisionList,
                (value) async {
                  setState(() {
                    division = value;
                    city = township = ward = street = null;
                    selectedDivisionId = int.tryParse(
                        divisionList.firstWhere((item) => item['name'] == value)['id']!);
                  });
                  if (selectedDivisionId != null) {
                    cityList = await APIMethods().getCities(selectedDivisionId!);
                    setState(() {});
                  }
                } 
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
    
        // Second row: City and Township
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 1,
              child: buildDropdownField(
                'City',
                city,
                cityList,
                (value) async {
                  setState(() {
                    city = value;
                    township = ward = street = null;
                    selectedCityId = int.tryParse(
                        cityList.firstWhere((item) => item['name'] == value)['id']!);
                  });
                  if (selectedCityId != null) {
                    townshipList = await APIMethods().getTownships(selectedCityId!);
                    setState(() {});
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: buildDropdownField(
                'Township',
                township,
                townshipList,
                (value) async {
                  setState(() {
                    township = value;
                    ward = street = null;
                    selectedTownshipId = int.tryParse(
                        townshipList.firstWhere((item) => item['name'] == value)['id']!);
                  });
                  if (selectedTownshipId != null) {
                    wardList = await APIMethods().getWards(selectedTownshipId!);
                    setState(() {});
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
    
        // Third row: Ward and Street
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 1,
              child: buildDropdownField(
                'Ward',
                ward,
                wardList,
                (value) async {
                  setState(() {
                    ward = value;
                    street = null;
                    selectedWardId = int.tryParse(
                        wardList.firstWhere((item) => item['name'] == value)['id']!);
                  });
                  if (selectedWardId != null) {
                    streetList = await APIMethods().getStreets(selectedWardId!);
                    setState(() {});
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: buildDropdownField(
                'Street',
                street,
                streetList,
                (value) async{
                  setState(() {
                    street = value;
                  });
                },
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

  @override
  void dispose() {
    shopNameController.dispose();
    ownerNameController.dispose();
    phoneController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
