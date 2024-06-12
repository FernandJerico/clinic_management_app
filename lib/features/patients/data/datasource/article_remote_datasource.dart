import 'package:clinic_management_app/features/patients/data/model/response/article_category_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/variables.dart';
import '../../../auth/data/datasources/auth_local_datasources.dart';

class ArticleRemoteDatasource {
  Future<Either<String, ArticleCategoryResponseModel>>
      getArticleCategory() async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-article-categories');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(ArticleCategoryResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get article category');
    }
  }
}
