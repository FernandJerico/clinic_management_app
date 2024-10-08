part of 'article_bloc.dart';

@freezed
class ArticleEvent with _$ArticleEvent {
  const factory ArticleEvent.started() = _Started;
  const factory ArticleEvent.getArticles() = _GetArticles;
  const factory ArticleEvent.getArticleDetail(String id) = _GetArticleDetail;
  const factory ArticleEvent.getArticleByTitle(String title) =
      _GetArticleByTitle;
  const factory ArticleEvent.getArticleByCategoryId(int categoryId) =
      _GetArticleByCategoryId;
}
