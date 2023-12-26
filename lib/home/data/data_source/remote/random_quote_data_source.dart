import 'package:signify_demo_app/core/network/api_provider.dart';
import 'package:signify_demo_app/home/data/models/random_quote_model.dart';

import '../../../../core/utilities/endpoints.dart';

abstract class RandomQuoteDataSource {
  Future<RandomQuoteModel> getRandomQuote();
}

class RandomQuoteDataSourceImpl implements RandomQuoteDataSource{
  final APIProvider apiProvider;

  RandomQuoteDataSourceImpl(this.apiProvider);

  @override
  Future<RandomQuoteModel> getRandomQuote() async {
    final response = await apiProvider.get(
      endPoint: getRandomQuoteURL,
    );
    return RandomQuoteModel.fromJson(response.data);
  }

}