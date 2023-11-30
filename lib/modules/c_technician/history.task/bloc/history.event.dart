part of 'history.bloc.dart';

abstract class HistoryTaskEvent extends Equatable {
  const HistoryTaskEvent();

  @override
  List<Object> get props => [];
}

class GetAllListTaskInactiveEvent extends HistoryTaskEvent {
  final int? idTicket;

  const GetAllListTaskInactiveEvent({this.idTicket});
}