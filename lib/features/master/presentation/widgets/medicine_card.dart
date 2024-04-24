import 'package:clinic_management_app/core/extensions/int_ext.dart';
import 'package:clinic_management_app/features/master/data/models/response/service_medicine_response_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';

class MedicineCard extends StatefulWidget {
  final ServiceMedicine item;
  final ValueNotifier<int> quantityNotifier;
  final void Function(int) onQuantityChanged;
  final VoidCallback onRemoveTap;

  const MedicineCard({
    super.key,
    required this.item,
    required this.quantityNotifier,
    required this.onQuantityChanged,
    required this.onRemoveTap,
  });

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  @override
  Widget build(BuildContext context) {
    //final quantityNotifier = ValueNotifier(0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(8.0),
              //   child: Image.network(
              //     widget.item.photo,
              //     width: 50.0,
              //     height: 50.0,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              // const SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.item.name!),
                        InkWell(
                          onTap: widget.onRemoveTap,
                          child: const Text(
                            'Remove',
                            style: TextStyle(color: AppColors.red),
                          ),
                        ),
                      ],
                    ),
                    Text(widget.item.category!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.item.price?.currencyFormatRp}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (widget.quantityNotifier.value > 0) {
                                  widget.onQuantityChanged(
                                      widget.quantityNotifier.value - 1);
                                  setState(() {});
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Quantity cannot be less than 0'),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.remove_circle),
                              color: AppColors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ValueListenableBuilder(
                                valueListenable: widget.quantityNotifier,
                                builder: (context, value, _) => Text('$value'),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                widget.onQuantityChanged(
                                    widget.quantityNotifier.value + 1);
                                setState(() {});
                              },
                              icon: const Icon(Icons.add_circle),
                              color: AppColors.grey,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Sub-total'),
              ValueListenableBuilder(
                valueListenable: widget.quantityNotifier,
                builder: (context, value, _) => Text(
                  '${(widget.item.price! * value)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
