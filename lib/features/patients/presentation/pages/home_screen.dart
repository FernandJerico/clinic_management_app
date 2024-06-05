import 'package:carousel_slider/carousel_slider.dart';
import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/assets/assets.gen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;
  int _selectedCategory = 0;
  final List<String> _categories = [
    'Semua',
    'Kista Baker',
    'Kesehatan Mental',
    'Migrain',
    'Sakit Tenggorokan',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: context.deviceHeight * 0.19,
                      color: AppColors.primary,
                    ),
                    Container(
                      height: context.deviceHeight * 0.14,
                      color: Colors.white,
                    ),
                  ],
                ),
                Positioned.fill(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello!,',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          'Fernand Jerico',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(
                            children: [
                              CarouselSlider(
                                carouselController: _carouselController,
                                options: CarouselOptions(
                                  enlargeCenterPage: false,
                                  enableInfiniteScroll: true,
                                  height: 155,
                                  aspectRatio: 16 / 8,
                                  scrollDirection: Axis.horizontal,
                                  viewportFraction: 1,
                                  pauseAutoPlayOnTouch: true,
                                  autoPlay: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentIndex = index;
                                    });
                                  },
                                ),
                                items: [
                                  HeroImageCarousel(
                                    imagePath: Assets.images.hero1.path,
                                  ),
                                  HeroImageCarousel(
                                    imagePath: Assets.images.hero2.path,
                                  ),
                                  HeroImageCarousel(
                                    imagePath: Assets.images.hero3.path,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(3, (index) {
                                  return Container(
                                    width: 10,
                                    height: 10,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentIndex == index
                                          ? AppColors.primary700
                                          : AppColors.grey,
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Text(
                    'Baca Artikel Baru',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: AppColors.primary),
                        ),
                      ),
                      minimumSize: WidgetStateProperty.all(const Size(0, 0)),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Lihat Semua',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return ChoiceChip(
                      showCheckmark: false,
                      selectedColor: AppColors.primary,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: AppColors.primary,
                        ),
                      ),
                      label: Text(
                        _categories[index],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: _selectedCategory == index
                              ? Colors.white
                              : AppColors.primary,
                        ),
                      ),
                      selected: _selectedCategory == index,
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedCategory = selected ? index : 0;
                        });
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 8,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                height: context.deviceHeight * 0.22,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return Container(
                      width: context.deviceWidth * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.grey.withOpacity(0.25),
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: context.deviceHeight * 0.12,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              child: Image.asset(
                                Assets.images.hero1.path,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Ini Cara Mengatasi Tenggorokan Gatal dengan Bahan Herbal',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 6),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Sakit Tenggorokan',
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Daftar Dokter',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGrey,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
                height: context.deviceHeight * 0.375,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        height: context.deviceHeight * 0.11,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grey.withOpacity(0.25),
                              blurRadius: 4,
                              offset: const Offset(2, 4),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: context.deviceHeight * 0.11,
                              width: 10,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  bottomLeft: Radius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                Assets.images.menu.doctorIcon.path,
                                fit: BoxFit.cover,
                                width: context.deviceWidth * 0.2,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'dr. Hafidz SR, Sp. THT-KL',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkGrey),
                                ),
                                Text(
                                  'Spesialis Kulit dan Kelamin',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: AppColors.darkGrey),
                                ),
                                Text(
                                  'Poli Kulit dan Kelamin',
                                  style: GoogleFonts.poppins(
                                      fontSize: 10, color: AppColors.darkGrey),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class HeroImageCarousel extends StatelessWidget {
  final String imagePath;
  const HeroImageCarousel({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: SizedBox(
        width: double.infinity,
        height: 155,
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}
