import 'package:bloc/bloc.dart';

class CollapsedCubit extends Cubit<bool> {
  CollapsedCubit() : super(false);

  void collapse() => emit(true);
  void expand() => emit(false);
}
