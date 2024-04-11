// import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
// import 'package:flutter/material.dart';

// import '../../../../core/components/spaces.dart';
// import '../../../../core/themes/colors.dart';

// class MedicineCard extends StatelessWidget {
//   final ServiceAndMedicine item;
//   final VoidCallback onRemoveTap;

//   const MedicineCard({
//     super.key,
//     required this.item,
//     required this.onRemoveTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final quantityNotifier = ValueNotifier(item.quantity ?? 1);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         children: [
//           Row(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               // ClipRRect(
//               //   borderRadius: BorderRadius.circular(8.0),
//               //   child: Image.network(
//               //     item.imageUrl,
//               //     width: 50.0,
//               //     height: 50.0,
//               //     fit: BoxFit.cover,
//               //   ),
//               // ),
//               // const SpaceWidth(14.0),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: context.deviceWidth - 1080.0,
//                         child: Text(item.name!),
//                       ),
//                       InkWell(
//                         onTap: onRemoveTap,
//                         child: const Text(
//                           'Remove',
//                           style: TextStyle(color: AppColors.red),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     width: context.deviceWidth - 1080.0,
//                     child: Text(item.category!),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: context.deviceWidth - 1140.0,
//                         child: Text(
//                           '${item.price}',
//                           style: const TextStyle(fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () => quantityNotifier.value--,
//                         icon: const Icon(Icons.remove_circle),
//                         color: AppColors.grey,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: ValueListenableBuilder(
//                           valueListenable: quantityNotifier,
//                           builder: (context, value, _) => Text('$value'),
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () => quantityNotifier.value++,
//                         icon: const Icon(Icons.add_circle),
//                         color: AppColors.grey,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SpaceHeight(4.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text('Sub-total'),
//               ValueListenableBuilder(
//                 valueListenable: quantityNotifier,
//                 builder: (context, value, _) => Text(
//                   (item.price! * value).currencyFormatRp,
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }