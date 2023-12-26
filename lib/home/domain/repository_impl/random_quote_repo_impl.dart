import 'package:dartz/dartz.dart';
import 'package:signify_demo_app/home/domain/entity/random_quote_entity.dart';

import '../../../core/error/failure.dart';

abstract class RandomRepository {
  Future<Either<Failure, RandomQuoteEntity>> getRandomQuote();
}
