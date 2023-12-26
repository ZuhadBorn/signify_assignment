import 'package:dartz/dartz.dart';
import 'package:signify_demo_app/core/utilities/strings.dart';
import 'package:signify_demo_app/home/data/data_source/remote/random_quote_data_source.dart';
import 'package:signify_demo_app/home/domain/entity/random_quote_entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../core/error/error_handler.dart';
import '../../domain/repository_impl/random_quote_repo_impl.dart';

class RandomQuoteRepositoryImpl implements RandomRepository {
  final RandomQuoteDataSource randomQuoteDataSource;
  final NetworkInfo networkInfo;

  RandomQuoteRepositoryImpl(this.randomQuoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, RandomQuoteEntity>> getRandomQuote() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await randomQuoteDataSource.getRandomQuote();
        return right(data);
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left(const OfflineFailure(AppStrings.noInternetError));
    }
  }
}
