part of 'history.customer.bloc.dart';

abstract class HistoryCustomerEvent extends Equatable {
  const HistoryCustomerEvent();

  @override
  List<Object> get props => [];
}

class GetAllListHistoryCustomer extends HistoryCustomerEvent {
  final int page;
  final int pageSize;

  const GetAllListHistoryCustomer({required this.page, required this.pageSize});

  @override
  List<Object> get props => [page, pageSize];
}
