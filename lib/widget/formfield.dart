import 'package:flutter/material.dart';

class FormFieldMethods{
  
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

  Widget buildDropdownField(String label, String? value, List<Map<String, String>> items, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Select Value',
            ),
            items: items.isEmpty ?
              [
                const DropdownMenuItem(
                  enabled: false,
                  value: "No option availabel",
                  child: Text('No option available'),
                ),
              ]:
            items.map((type) {
              return DropdownMenuItem<String>(
                value: type['name'],
                child: Text(
                  type['name']!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 14),
                ),
              );
            }).toList(),
            onChanged:  (value) {
              if(value != null){
                onChanged(value);
              }
            },
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

  Widget buildPhoneField(TextEditingController phoneController) {
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

  
}