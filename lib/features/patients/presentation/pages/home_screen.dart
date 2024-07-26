import 'package:carousel_slider/carousel_slider.dart';
import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/core/themes/colors.dart';
import 'package:clinic_management_app/features/master/presentation/bloc/data_doctor/data_doctor_bloc.dart';
import 'package:clinic_management_app/features/patients/presentation/bloc/article/article_bloc.dart';
import 'package:clinic_management_app/features/patients/presentation/pages/article_screen.dart';
import 'package:clinic_management_app/features/patients/presentation/pages/detail_article_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/variables.dart';
import '../../../auth/data/datasources/auth_local_datasources.dart';
import '../../data/model/response/article_category_response_model.dart';
import '../bloc/article_category/article_category_bloc.dart';
import 'detail_doctor_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;
  int? _selectedCategory = -1;
  String? _username;

  Future<void> _loadUsername() async {
    final user = await AuthLocalDatasources().getAuthData();
    setState(() {
      _username = user!.user!.name;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUsername();
    context
        .read<ArticleCategoryBloc>()
        .add(const ArticleCategoryEvent.getArticleCategory());
    context.read<ArticleBloc>().add(const ArticleEvent.getArticles());
    context.read<DataDoctorBloc>().add(const DataDoctorEvent.getDoctors());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
                      height: ResponsiveWidget.isLargeScreen(context)
                          ? context.deviceHeight * 0.26
                          : context.deviceHeight * 0.19,
                      color: AppColors.primary,
                    ),
                    Container(
                      height: ResponsiveWidget.isLargeScreen(context)
                          ? context.deviceHeight * 0.27
                          : context.deviceHeight * 0.15,
                      color: AppColors.white,
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
                          _username ?? '!',
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
                                // carouselController: _carouselController,
                                options: CarouselOptions(
                                  enlargeCenterPage: false,
                                  enableInfiniteScroll: true,
                                  height:
                                      ResponsiveWidget.isLargeScreen(context)
                                          ? 310
                                          : 155,
                                  aspectRatio: 16 / 8,
                                  scrollDirection: Axis.horizontal,
                                  viewportFraction:
                                      ResponsiveWidget.isLargeScreen(context)
                                          ? 0.8
                                          : 1,
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
                      backgroundColor: WidgetStateProperty.all(AppColors.white),
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
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const ArticleScreen();
                        },
                      ));
                    },
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
                child: BlocBuilder<ArticleCategoryBloc, ArticleCategoryState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => const CategoryShimmerLoading(),
                      loaded: (articleCategory) {
                        final allCategories = [
                          ArticleCategory(id: -1, name: 'Semua'),
                          ...articleCategory
                        ];
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: allCategories.length,
                          itemBuilder: (context, index) {
                            final category = allCategories[index];
                            return ChoiceChip(
                              showCheckmark: false,
                              selectedColor: AppColors.primary,
                              backgroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: AppColors.primary,
                                ),
                              ),
                              label: Text(
                                category.name ?? '',
                                style: GoogleFonts.poppins(
                                  fontSize:
                                      ResponsiveWidget.isLargeScreen(context)
                                          ? 14
                                          : 12,
                                  fontWeight: FontWeight.normal,
                                  color: _selectedCategory == category.id
                                      ? Colors.white
                                      : AppColors.primary,
                                ),
                              ),
                              selected: _selectedCategory == category.id,
                              onSelected: (bool selected) {
                                setState(() {
                                  // Hanya memperbarui _selectedCategory jika pilihan berbeda
                                  if (_selectedCategory != category.id) {
                                    _selectedCategory = category.id;
                                  }
                                });
                                if (_selectedCategory == category.id) {
                                  if (category.id == -1) {
                                    context
                                        .read<ArticleBloc>()
                                        .add(const ArticleEvent.getArticles());
                                  } else {
                                    context.read<ArticleBloc>().add(
                                        ArticleEvent.getArticleByCategoryId(
                                            category.id!));
                                  }
                                }
                              },
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 8),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                height: ResponsiveWidget.isLargeScreen(context)
                    ? context.deviceHeight * 0.23
                    : context.deviceHeight * 0.22,
                child: BlocBuilder<ArticleBloc, ArticleState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const CardArticleShimmerLoading();
                      },
                      loaded: (articles) {
                        if (articles.isEmpty) {
                          return Center(
                            child: Text(
                              'Tidak Ada Artikel',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          );
                        }
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          scrollDirection: Axis.horizontal,
                          itemCount: articles.length > 5 ? 5 : articles.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final article = articles[index];
                            return InkWell(
                              onTap: () => context
                                  .push(DetailArticleScreen(article: article)),
                              child: Container(
                                width: ResponsiveWidget.isLargeScreen(context)
                                    ? context.deviceWidth * 0.25
                                    : context.deviceWidth * 0.6,
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
                                        child: Image.network(
                                          '${Variables.imageBaseUrl}/${article.image?.replaceAll('public/', '')}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        article.title ?? '',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              ResponsiveWidget.isLargeScreen(
                                                      context)
                                                  ? 13
                                                  : 10,
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
                                          color: AppColors.primary
                                              .withOpacity(0.25),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          article.category?.name ?? '',
                                          style: GoogleFonts.poppins(
                                            fontSize:
                                                ResponsiveWidget.isLargeScreen(
                                                        context)
                                                    ? 10
                                                    : 8,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
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
                height: ResponsiveWidget.isLargeScreen(context)
                    ? context.deviceHeight * 0.4
                    : context.deviceHeight * 0.37,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: BlocBuilder<DataDoctorBloc, DataDoctorState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const CardDoctorShimmerLoading();
                        },
                        loaded: (doctors) {
                          return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 12,
                            ),
                            itemCount: doctors.length,
                            itemBuilder: (context, index) {
                              final doctor = doctors[index];
                              return InkWell(
                                onTap: () => context
                                    .push(DetailDoctorScreen(doctor: doctor)),
                                child: Container(
                                  height:
                                      ResponsiveWidget.isLargeScreen(context)
                                          ? context.deviceHeight * 0.12
                                          : context.deviceHeight * 0.11,
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
                                        height: double.infinity,
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
                                      Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            '${Variables.imageBaseUrl}/${doctor.photo?.replaceAll('public/', '')}',
                                            fit: BoxFit.cover,
                                            width: ResponsiveWidget
                                                    .isLargeScreen(context)
                                                ? context.deviceWidth * 0.075
                                                : context.deviceWidth * 0.2,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${doctor.doctorName}',
                                            style: GoogleFonts.poppins(
                                                fontSize: ResponsiveWidget
                                                        .isLargeScreen(context)
                                                    ? 14
                                                    : 12,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.darkGrey),
                                          ),
                                          Text(
                                            doctor.doctorSpecialist ?? '',
                                            style: GoogleFonts.poppins(
                                                fontSize: ResponsiveWidget
                                                        .isLargeScreen(context)
                                                    ? 14
                                                    : 12,
                                                color: AppColors.darkGrey),
                                          ),
                                          Text(
                                            'Poli ${doctor.polyclinic}',
                                            style: GoogleFonts.poppins(
                                                fontSize: ResponsiveWidget
                                                        .isLargeScreen(context)
                                                    ? 14
                                                    : 10,
                                                color: AppColors.darkGrey),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
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

class CardArticleShimmerLoading extends StatelessWidget {
  const CardArticleShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(width: 8),
      itemCount: 3,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: ResponsiveWidget.isLargeScreen(context)
                ? context.deviceWidth * 0.25
                : context.deviceWidth * 0.6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CategoryShimmerLoading extends StatelessWidget {
  const CategoryShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: ResponsiveWidget.isLargeScreen(context)
                ? context.deviceWidth * 0.15
                : context.deviceWidth * 0.25,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 8,
      ),
      itemCount: ResponsiveWidget.isLargeScreen(context) ? 9 : 5,
    );
  }
}

class CardDoctorShimmerLoading extends StatelessWidget {
  const CardDoctorShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(
        height: 12,
      ),
      itemCount: 3,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
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
