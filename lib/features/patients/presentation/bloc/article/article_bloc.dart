import 'package:bloc/bloc.dart';
import 'package:clinic_management_app/features/patients/data/datasource/article_remote_datasource.dart';
import 'package:clinic_management_app/features/patients/data/model/response/article_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_event.dart';
part 'article_state.dart';
part 'article_bloc.freezed.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRemoteDatasource articleRemoteDatasource;
  ArticleBloc(this.articleRemoteDatasource) : super(const _Initial()) {
    on<_GetArticles>((event, emit) async {
      emit(const _Loading());
      final result = await articleRemoteDatasource.getArticles();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });

    on<_GetArticleByTitle>((event, emit) async {
      emit(const _Loading());
      final result =
          await articleRemoteDatasource.getArticleByTitle(event.title);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });

    on<_GetArticleByCategoryId>((event, emit) async {
      emit(const _Loading());
      final result = await articleRemoteDatasource
          .getArticleByCategoryId(event.categoryId);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });
  }
}
