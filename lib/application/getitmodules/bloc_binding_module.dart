import '../../main.dart';
import '../../pages/home/home_bloc.dart';

class BlocBindingModule {
  static provideModules() {
    getIt.registerFactory(() => HomeCubit(getIt.get()));
  }
}
