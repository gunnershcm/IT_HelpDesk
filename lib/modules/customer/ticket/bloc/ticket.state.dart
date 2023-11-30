// ignore_for_file: prefer_const_constructors_in_immutables

part of 'ticket.bloc.dart';

abstract class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

class TicketInitial extends TicketState {}

class TicketLoading extends TicketState {}


class TicketSuccessState extends TicketState {
  final List<TicketResponseModel> list;
  TicketSuccessState({required this.list});
  @override
  List<Object> get props => [list];
}

class TicketError extends TicketState {
  final String error;

  TicketError({required this.error});

  @override
  List<Object> get props => [error];
}


class CareateTicketSuccessState extends TicketState {}

class UpdateTicketSuccessState extends TicketState {}
