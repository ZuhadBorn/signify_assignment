import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:signify_demo_app/home/data/data_source/remote/random_quote_data_source.dart';
import 'package:signify_demo_app/home/data/repository/random_quote_repo.dart';
import 'package:signify_demo_app/home/domain/repository_impl/random_quote_repo_impl.dart';
import 'package:signify_demo_app/home/domain/use_cases/random_quote_use_case.dart';
import 'package:signify_demo_app/home/presentation/bloc/random_quote_bloc.dart';

import 'core/network/api_provider.dart';
import 'core/network/api_provider_impl.dart';
import 'core/network/network_info.dart';

GetIt injector = GetIt.instance;

Future<void> init() async {
  injector.registerFactory(() => RandomQuoteBloc(injector(), injector()));

  injector.registerLazySingleton(() => GetRandomQuoteUseCase(injector()));

  injector.registerLazySingleton<RandomRepository>(
      () => RandomQuoteRepositoryImpl(injector(), injector()));

  injector.registerLazySingleton<RandomQuoteDataSource>(
      () => RandomQuoteDataSourceImpl(injector()));

  //API Provider
  injector.registerLazySingleton<APIProvider>(() => APIProviderImpl());

  //Network Info
  injector
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(injector()));
  //InternetConnectionChecker
  injector.registerLazySingleton(() => InternetConnectionChecker());
}
