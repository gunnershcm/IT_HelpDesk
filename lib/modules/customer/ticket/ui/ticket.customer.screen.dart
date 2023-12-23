import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/app/widgets/scroll.item.dart';
import 'package:dich_vu_it/models/request/request.create.ticket.model.dart';
import 'package:dich_vu_it/models/response/ticket.response.model.dart';
import 'package:dich_vu_it/modules/customer/notification/notification.page.dart';
import 'package:dich_vu_it/modules/customer/ticket/bloc/ticket.bloc.dart';
import 'package:dich_vu_it/modules/customer/ticket/compoment/ticket.item.dart';
import 'package:dich_vu_it/modules/customer/ticket/ui/edit.ticket.dart';
import 'package:dich_vu_it/modules/customer/ticket/ui/view.ticket.dart';
import 'package:dich_vu_it/provider/noti.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketCustomerScreen extends StatefulWidget {
  const TicketCustomerScreen({Key? key}) : super(key: key);

  @override
  State<TicketCustomerScreen> createState() => _TicketCustomerScreenState();
}

class _TicketCustomerScreenState extends State<TicketCustomerScreen> {
  final _bloc = TicketBloc();
  List<TicketResponseModel> listTicket = [];
  List<TicketResponseModel> filteredList = [];
  int? selectedStatus;
  int countNoti = 0;
  late String query = '';
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void getNoti() async {
    var noti = await NotiProvider.getCountNoti();
    setState(() {
      countNoti = noti;
    });
  }

  @override
  void initState() {
    super.initState();
    getNoti();
    _bloc.add(GetAllListTicket());
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
      key: _scaffoldKey, // Add the key to the Scaffold
      backgroundColor: const Color.fromARGB(255, 229, 243, 254),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {
            // Open the Drawer when the menu button is pressed
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: const Text(
          "IT_HelpDesk",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              await Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const NotificationPage(),
                ),
              );
              getNoti();
            },
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                const Icon(
                  Icons.notifications,
                  size: 30,
                  color: Colors.white,
                ),
                if (countNoti > 0)
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 248, 88, 77),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    // Close the Drawer when the close button is pressed
                    _scaffoldKey.currentState!.openEndDrawer();
                  });
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text(
                  'Menu Item 1',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  // Handle the action for Menu Item 1
                  // For example, navigate to a different screen
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text(
                  'Menu Item 2',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  // Handle the action for Menu Item 2
                  // For example, navigate to a different screen
                },
              ),
              // Add more menu items as needed
            ],
          ),
        ),
      ),
      body: BlocConsumer<TicketBloc, TicketState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is TicketLoading) {
            onLoading(context);
            return;
          } else if (state is TicketSuccessState) {
            Navigator.pop(context);
            listTicket = state.list;
            filterList();
          } else if (state is TicketError) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 8, left: 16, right: 16), // Updated padding
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
                            builder: (BuildContext context) => ViewTicketScreen(
                              ticket: element,
                            ),
                          ),
                        );
                      },
                      child: TicketItem(
                        ticket: element,
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
