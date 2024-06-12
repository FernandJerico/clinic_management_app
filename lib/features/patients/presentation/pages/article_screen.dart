import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/patients/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/variables.dart';
import '../../../../core/themes/colors.dart';
import '../../data/model/response/article_category_response_model.dart';
import '../bloc/article/article_bloc.dart';
import '../bloc/article_category/article_category_bloc.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final TextEditingController searchController = TextEditingController();
  int? _selectedCategory = -1;

  @override
  void initState() {
    super.initState();
    context.read<ArticleBloc>().add(const ArticleEvent.getArticles());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Semua Artikel',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                controller: searchController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    context
                        .read<ArticleBloc>()
                        .add(ArticleEvent.getArticleByTitle(
                          searchController.text,
                        ));
                  } else {
                    context
                        .read<ArticleBloc>()
                        .add(const ArticleEvent.getArticles());
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Cari Artikel',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
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
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: _selectedCategory == category.id
                                    ? Colors.white
                                    : AppColors.primary,
                              ),
                            ),
                            selected: _selectedCategory == category.id,
                            onSelected: (bool selected) {
                              setState(() {
                                _selectedCategory =
                                    selected ? category.id : null;
                              });
                              if (selected) {
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
                              debugPrint(
                                  'Selected Category: $_selectedCategory');
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
            const SizedBox(
              height: 8,
            ),
            BlocBuilder<ArticleBloc, ArticleState>(
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
                    return Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        scrollDirection: Axis.vertical,
                        itemCount: articles.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final article = articles[index];
                          return Container(
                            height: context.deviceHeight * 0.22,
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
                                  height: context.deviceHeight * 0.13,
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
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                      horizontal: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.primary.withOpacity(0.25),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      article.category?.name ?? '',
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
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
                    );
                  },
                );
              },
            )
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
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: 3,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: context.deviceHeight * 0.22,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
      ),
    );
  }
}
