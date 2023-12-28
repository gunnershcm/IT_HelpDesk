import 'package:dich_vu_it/app/theme/colors.dart';
import 'package:dich_vu_it/app/theme/text.style.dart';
import 'package:dich_vu_it/app/widgets/will.pop.scope.dart';
import 'package:dich_vu_it/modules/c_technician/profile/ui/profile.screen.dart';
import 'package:dich_vu_it/modules/chat/chat.screen.list.dart';
import 'package:dich_vu_it/modules/customer/history_customer/ui/history.customer.page.dart';
import 'package:dich_vu_it/modules/customer/ticket.solution/ui/ticket.solution.tech.dart';
import 'package:flutter/material.dart';

import 'ticket/ui/ticket.customer.screen.dart';

class NavigatorMainCustomer extends StatefulWidget {
  const NavigatorMainCustomer({super.key});

  @override
  State<NavigatorMainCustomer> createState() => _NavigatorMainCustomerState();
}

class _NavigatorMainCustomerState extends State<NavigatorMainCustomer> {
  int sttPage = 0;
  Widget body = const TicketCustomerScreen();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPS(
      child: Scaffold(
          body: body,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: sttPage,
            onTap: (value) async {
              setState(() {
                sttPage = value;
                if (value == 0) {
                  body = const TicketCustomerScreen();
                } else if (value == 1) {
                  body = const TicketSolutionPage();
                } else if (value == 2) {
                  body = const HistoryCustomerScreen();
                } else if (value == 3) {
                  body = const ListChatScreen();
                } else if (value == 4) {
                  body = const ProfileScreen();
                }
              });
            },
            selectedLabelStyle: MyTextStyle.styleSelectMenu,
            selectedItemColor: MyColors.blue,
            unselectedLabelStyle: MyTextStyle.styleUnSelectMenu,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.confirmation_number,
                    color:
                        (sttPage == 0) ? MyColors.blue : MyColors.greyUnselect),
                label: 'Ticket',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wb_incandescent_outlined,
                    color:
                        (sttPage == 1) ? MyColors.blue : MyColors.greyUnselect),
                label: 'Solution',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history,
                    color:
                        (sttPage == 2) ? MyColors.blue : MyColors.greyUnselect),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message,
                    color:
                        (sttPage == 2) ? MyColors.blue : MyColors.greyUnselect),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person,
                    color:
                        (sttPage == 2) ? MyColors.blue : MyColors.greyUnselect),
                label: 'Profile',
              ),
            ],
          )),
    );
  }
}
