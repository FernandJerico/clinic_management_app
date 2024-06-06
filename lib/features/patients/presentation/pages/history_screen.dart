import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/themes/colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Cari Riwayat',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.135,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: double.infinity,
                          width: 10,
                          decoration: const BoxDecoration(
                            color: AppColors.orderIsWaiting,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Fajar Gema Ramadhan',
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 0),
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: AppColors.orderIsWaiting
                                            .withOpacity(0.25),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: AppColors.orderIsWaiting),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Pending',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: AppColors.orderIsWaiting),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Laki-Laki',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      '10 April 2002',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12, color: AppColors.black),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0817330982122',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: AppColors.black),
                                ),
                                Text(
                                  'Poli Kulit dan Kelamin',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: AppColors.black),
                                ),
                                Text(
                                  'Senin Jam 10.00 WIB',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: AppColors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
