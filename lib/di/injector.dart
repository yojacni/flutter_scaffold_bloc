import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_scaffold_bloc/feature/account_management/domain/entity/user_profile.dart';
import 'package:get_it/get_it.dart';

import '../core/global/endpoints.dart';
import '../core/global/entities/enums/flavor_enum.dart';
import '../core/navigator/router.dart';
import '../core/network/connectivity.dart';
import '../core/network/dio/dio_client.dart';
import '../core/network/network_handler.dart';
import '../core/platform/shared_prefs.dart';
import '../core/utils/logger.dart';
import '../feature/account_management/data/datasources/remote/account_management_remote_datasource.dart';
import '../feature/account_management/data/repositories/account_management_repository_impl.dart';
import '../feature/account_management/domain/repository/account_management_repository.dart';
import '../feature/account_management/domain/usecase/login_usecase.dart';
import '../feature/account_management/domain/usecase/sign_up_usecase.dart';
import '../feature/account_management/presentation/bloc/log_in/log_in_bloc.dart';
import '../feature/account_management/presentation/bloc/sign_up/sign_up_bloc.dart';

class Injector {
  ///Init
  Injector._init() {
    _registerCommonImpl();
    _registerApiLayer();
    _registerBloCs();
    _registerUserCaseLayer();
    //repositories
    _registerRepositoryLayer();
  }

  static Injector? instance;

  final sl = GetIt.instance;

  ///API base url
  static late String apiBaseUrl;

  ///Azure Storage
  static late String azureStorage;

  ///HubConnection
  static late String hubConnection;

  ///Environment
  static late FlavorEnum environment;

  ///Init the injector with Prod configurations
  static void initProd() {
    apiBaseUrl = Endpoint.apiBaseUrlProd;
    azureStorage = Endpoint.azureStorageProd;
    hubConnection = Endpoint.hubConnectionProd;
    environment = FlavorEnum.production;

    instance ??= Injector._init();
  }

  static void initStaging() {
    apiBaseUrl = Endpoint.apiBaseUrlStg;
    azureStorage = Endpoint.azureStorageStg;
    hubConnection = Endpoint.hubConnectionStg;
    environment = FlavorEnum.staging;

    instance ??= Injector._init();
  }

  static void initDev() {
    apiBaseUrl = Endpoint.apiBaseUrlDev;
    azureStorage = Endpoint.azureStorageDev;
    hubConnection = Endpoint.hubConnectionDev;
    environment = FlavorEnum.development;

    instance ??= Injector._init();
  }

  void _registerApiLayer() {
    sl.registerLazySingleton<AccountManagementRemoteApi>(
      () => AccountManagementRemoteApiImpl(
        sl(),
      ),
    );
  }

  void _registerUserCaseLayer() {
    sl
      ..registerFactory(() => LoginUsecase(sl.get()))
      ..registerFactory(() => SignUpUseCase(sl.get()));
  }

  void _registerRepositoryLayer() {
    sl.registerLazySingleton<AccountManagementRepository>(
      () => AccountManagementRepositoryImpl(
        sl.get(),
        sl.get(),
        sl.get(),
      ),
    );
  }

  void _registerBloCs() {
    sl
      ..registerFactory(
        () => LogInBloc(
          sl.get(),
          sl.get(),
        ),
      )
      ..registerFactory(
        () => SignUpBloc(
          sl.get(),
          sl.get(),
        ),
      );
  }

  void _registerCommonImpl() {
    sl
      ..registerSingleton<Logger>(LoggerImpl())
      ..registerSingleton<RouterManager>(BeamerRouter(sl.get()))
      ..registerSingleton(Dio())
      ..registerSingleton(DioClient(sl.get(), sl.get()))
      ..registerSingleton<UserPreferencesManager>(SharedPreferencesImpl())
      ..registerSingleton(NetworkHandler(sl.get(), sl.get(), sl.get()))
      ..registerSingleton(ConnectivityService());
  }

  T getNewBloCLibrary<T extends Bloc<dynamic, dynamic>>() => sl.get();

  Logger getLogger() => sl.get();

  NetworkHandler get networkHandler => sl.get();

  UserPreferencesManager get sharedPreferences => sl.get();

  RouterManager get routerManager => sl.get();

  ConnectivityService get connectivityService => sl.get();

  T getDependency<T extends Object>() => sl.get();

  UserProfile get userProfile => sl.get();
}
