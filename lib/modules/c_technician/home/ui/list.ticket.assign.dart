// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/app/widgets/scroll.item.dart';
import 'package:dich_vu_it/models/response/ticket.response.model.dart';
import 'package:dich_vu_it/modules/c_technician/home/bloc/home.bloc.dart';
import 'package:dich_vu_it/modules/c_technician/home/ui/view.ticket.dart';
import 'package:dich_vu_it/modules/c_technician/history.task/bloc/component/ticket.item.tech.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ListTicketAssign extends StatefulWidget {
  final List<TicketResponseModel> listTiket;
  const ListTicketAssign({super.key, required this.listTiket});

  @override
  State<ListTicketAssign> createState() => _ListTicketAssignState();
}


class _ListTicketAssignState extends State<ListTicketAssign> {
  final _bloc = HomeBloc();
  List<TicketResponseModel> listTicket = [];
  List<TicketResponseModel> filteredList = [];
  int? selectedStatus;
  late String query = '';
  bool updateList = false;

  @override
  void initState() {
    super.initState();
    //getNoti();
    _bloc.add(GetListTicketAssignEvent());
  }

  void updateTicketList(){
   // _bloc.add(ClearDataEvent());
    setState(() {
      //updateList = !updateList;
      _bloc.add(GetListTicketAssignEvent());
    });
  }

  void onStatusSelected(int? status) {
    setState(() {
      selectedStatus = status;
      filterList();
    });
  }

  // Add this function to filter the list based on the search query
  void filterList() {
    setState(() {
      filteredList = listTicket
          .where((ticket) =>
              (ticket.title!.toLowerCase().contains(query.toLowerCase()) ||
                  ticket.category!.name!
                      .toLowerCase()
                      .contains(query.toLowerCase())) &&
              (ticket.ticketStatus == selectedStatus || selectedStatus == null))
          .toList();
    });
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 229, 243, 254),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          title: const Center(
            child: Text(
              "List of assigned tickets",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is HomeLoading) {
              onLoading(context);
              return;
            } else if (state is GetListTicketAssignSuccessState) {
              Navigator.pop(context);
              listTicket = state.list;
              filterList();
            } else if (state is HomeError) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 8,
                      left: 16,
                      right: 16), // Updated padding
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          query = value;
                          filterList();
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                          gapPadding: 5.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(8.0), // Updated padding
                  child: Row(
                    children: [
                      ScrollItem(
                        text: 'All',
                        onTap: () => onStatusSelected(null),
                        isSelected: selectedStatus == null,
                      ),
                      ScrollItem(
                        text: 'Open',
                        onTap: () => onStatusSelected(0),
                        isSelected: selectedStatus == 0,
                      ),
                      ScrollItem(
                        text: 'Assigned',
                        onTap: () => onStatusSelected(1),
                        isSelected: selectedStatus == 1,
                      ),
                      ScrollItem(
                        text: 'In Progress',
                        onTap: () => onStatusSelected(2),
                        isSelected: selectedStatus == 2,
                      ),
                      ScrollItem(
                        text: 'Resolved',
                        onTap: () => onStatusSelected(3),
                        isSelected: selectedStatus == 3,
                      ),
                      ScrollItem(
                        text: 'Closed',
                        onTap: () => onStatusSelected(4),
                        isSelected: selectedStatus == 4,
                      ),
                      ScrollItem(
                        text: 'Cancelled',
                        onTap: () => onStatusSelected(5),
                        isSelected: selectedStatus == 5,
                      ),
                      // Add more ScrollItem widgets as needed
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final element = filteredList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  ViewTicketAssigScreen(
                                tiket: element,
                              ),
                            ),
                          );
                        },
                        child: TicketItem(
                          listTicket: listTicket,
                          ticket: element,
                          callback:  updateTicketList,
                          onTap: (ticket) {
                            // onTap logic specific to the TicketItem
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      );
    }
  }

