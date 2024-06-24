import 'package:clinic_management_app/features/master/data/models/response/service_medicine_response_model.dart';
import 'package:flutter/material.dart';

class MedicineDropdown extends StatelessWidget {
  final ServiceMedicine? value;
  final List<ServiceMedicine> items;
  final String label;
  final Function(ServiceMedicine? value)? onChanged;

  const MedicineDropdown({
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
        DropdownButtonFormField<ServiceMedicine>(
          dropdownColor: Colors.white,
          value: value,
          onChanged: onChanged,
          selectedItemBuilder: (context) => items
              .map((ServiceMedicine item) => DropdownMenuItem<ServiceMedicine>(
                    value: item,
                    child: Text(
                      item.name!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ))
              .toList(),
          items: items
              .map((ServiceMedicine item) => DropdownMenuItem<ServiceMedicine>(
                    value: item,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        children: [
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(8.0),
                          //   child: Image.network(
                          //     item.,
                          //     width: 50.0,
                          //     height: 50.0,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          // const SpaceWidth(14.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                item.category!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300),
                              ),
                              Text('${item.price}'),
                            ],
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
            hintText: value?.name ?? label,
          ),
        ),
      ],
    );
  }
}
