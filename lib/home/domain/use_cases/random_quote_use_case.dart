
import 'package:dartz/dartz.dart';
import 'package:signify_demo_app/home/domain/entity/random_quote_entity.dart';
import 'package:signify_demo_app/home/domain/repository_impl/random_quote_repo_impl.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';


class GetRandomQuoteUseCase implements BaseUsecase<RandomQuoteEntity, NoParams> {
  final RandomRepository randomRepository;

  GetRandomQuoteUseCase(this.randomRepository);
  @override
  Future<Either<Failure, RandomQuoteEntity>> call(NoParams params) async {
    return await randomRepository.getRandomQuote();
  }
}
