import 'package:bloc/bloc.dart';
import 'package:clinic_management_app/features/patients/data/datasource/article_remote_datasource.dart';
import 'package:clinic_management_app/features/patients/data/model/response/article_category_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_category_event.dart';
part 'article_category_state.dart';
part 'article_category_bloc.freezed.dart';

class ArticleCategoryBloc
    extends Bloc<ArticleCategoryEvent, ArticleCategoryState> {
  final ArticleRemoteDatasource articleRemoteDatasource;
  ArticleCategoryBloc(this.articleRemoteDatasource) : super(const _Initial()) {
    on<_GetArticleCategory>((event, emit) async {
      emit(const _Loading());
      final result = await articleRemoteDatasource.getArticleCategory();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });
  }
}
