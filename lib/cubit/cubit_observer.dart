import 'package:bloc/bloc.dart';

class CubitObserver extends BlocObserver {
  const CubitObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
  }
}
