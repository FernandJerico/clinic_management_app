import 'package:flutter/material.dart';

import '../../../../core/components/spaces.dart';
import '../../../../core/constants/variables.dart';
import '../../data/models/response/master_doctor_response_model.dart';

class DoctorDropdown extends StatelessWidget {
  final MasterDoctor? value;
  final List<MasterDoctor> items;
  final String label;
  final Function(MasterDoctor? value)? onChanged;

  const DoctorDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.label,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<MasterDoctor>(
          value: value,
          onChanged: onChanged,
          isExpanded: true,
          dropdownColor: Colors.white,
          selectedItemBuilder: (context) => items
              .map((MasterDoctor item) => DropdownMenuItem<MasterDoctor>(
                    value: item,
                    child: Text(
                      '${item.doctorName} (${item.doctorSpecialist})',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ))
              .toList(),
          items: items
              .map((MasterDoctor item) => DropdownMenuItem<MasterDoctor>(
                    value: item,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(
                                    '${Variables.imageBaseUrl}/${item.photo?.replaceAll('public/', '')}'),
                              ),
                            ),
                          ),
                          const SpaceWidth(14.0),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Nama Dokter'),
                                Text(
                                  '${item.doctorName} (${item.doctorSpecialist})',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            hintText: value?.doctorName ?? label,
          ),
          validator: (value) {
            if (value == null) {
              return 'This field is required.';
            }
            return null;
          },
        ),
      ],
    );
  }
}
