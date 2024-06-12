part of 'article_bloc.dart';

@freezed
class ArticleState with _$ArticleState {
  const factory ArticleState.initial() = _Initial;
  const factory ArticleState.loading() = _Loading;
  const factory ArticleState.loaded(List<Article> articles) = _Loaded;
  const factory ArticleState.detail(Article article) = _Detail;
  const factory ArticleState.error(String message) = _Error;
}
