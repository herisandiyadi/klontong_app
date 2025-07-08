import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../domain/usecases/sample_usecase.dart';
import '../domain/usecases/product_usecase.dart';
import '../presentation/bloc/product_bloc.dart';
import '../data/datasources/product_remote_datasource.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/repositories/product_repository.dart';
import '../data/datasources/cart_local_datasource.dart';

final sl = GetIt.instance;

void init() {
  // External
  sl.registerLazySingleton<Dio>(() => Dio());

  // Product feature
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ProductUseCase>(
    () => ProductUseCase(sl<ProductRepository>()),
  );

  // Cart local
  sl.registerLazySingleton(() => CartLocalDataSource());

  sl.registerFactory(() => ProductBloc(sl()));
}
