import 'package:get_it/get_it.dart';
import 'package:mytodo/core/services/dialog_service.dart';
import 'package:mytodo/core/services/local_notification_service.dart';
import 'package:mytodo/data/repo/auth_repository.dart';
import 'package:mytodo/data/repo/task_repository.dart';

import '../../data/datasources/local/locals.dart';
import '../cores.dart';
import '../services/image_services.dart';
import '../services/snackbar_service.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<SnackbarService>(() => SnackbarService());
  locator.registerLazySingleton<BottomSheetService>(() => BottomSheetService());
  locator.registerLazySingleton<ImagePickerService>(() => ImagePickerService());
  locator.registerLazySingleton<DialogService>(() => DialogService());
  locator.registerLazySingleton<LocalNotificationService>(
    () => LocalNotificationService(),
  );

  //STORAGES
  locator.registerLazySingleton(() => AuthLocalStorage());
  locator.registerLazySingleton(() => AppLocalStorage());
  //GLOBALS
  locator.registerLazySingleton(() => AppGlobals.instance);

  //REPOS
  locator.registerLazySingleton(() => AuthRepository());
  locator.registerLazySingleton(() => TaskRepository());
}

//GLOBALS
AppGlobals appGlobals = locator.get<AppGlobals>();

NavigationService navigationService = locator.get<NavigationService>();
SnackbarService snackbarService = locator.get<SnackbarService>();
BottomSheetService bottomSheetService = locator.get<BottomSheetService>();
ImagePickerService imageService = locator.get<ImagePickerService>();
DialogService dialogService = locator.get<DialogService>();
LocalNotificationService localNotificationService = locator
    .get<LocalNotificationService>();

//STORAGES
AuthLocalStorage authLocalStorage = locator.get<AuthLocalStorage>();
AppLocalStorage appLocalStorage = locator.get<AppLocalStorage>();

//REPOS
AuthRepository authRepository = locator.get<AuthRepository>();
TaskRepository taskRepository = locator.get<TaskRepository>();
