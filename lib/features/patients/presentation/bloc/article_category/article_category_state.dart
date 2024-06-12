part of 'article_category_bloc.dart';

@freezed
class ArticleCategoryState with _$ArticleCategoryState {
  const factory ArticleCategoryState.initial() = _Initial;
  const factory ArticleCategoryState.loading() = _Loading;
  const factory ArticleCategoryState.loaded(
      List<ArticleCategory> articleCategory) = _Loaded;
  const factory ArticleCategoryState.error(String message) = _Error;
}
