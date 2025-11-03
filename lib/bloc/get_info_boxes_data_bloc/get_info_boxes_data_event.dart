part of 'get_info_boxes_data_bloc.dart';

sealed class GetInfoBoxesDataEvent extends Equatable {
  const GetInfoBoxesDataEvent();

  @override
  List<Object> get props => [];
}

class OnGetInfroBoxesDateEvent extends GetInfoBoxesDataEvent {}
