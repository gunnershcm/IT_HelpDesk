import 'package:dich_vu_it/app/theme/colors.dart';
import 'package:dich_vu_it/app/theme/text.style.dart';
import 'package:dich_vu_it/app/widgets/will.pop.scope.dart';
import 'package:dich_vu_it/modules/c_technician/history.task/ui/history.technica.page.dart';
import 'package:dich_vu_it/modules/c_technician/home/ui/home.technica.page.dart';
import 'package:dich_vu_it/modules/c_technician/home/ui/list.ticket.assign.dart';
import 'package:dich_vu_it/modules/c_technician/profile/ui/profile.screen.dart';
import 'package:dich_vu_it/modules/c_technician/ticket.solution/ui/ticket.solution.tech.dart';
import 'package:dich_vu_it/modules/chat/chat.screen.list.dart';
import 'package:flutter/material.dart';

class NavigatorMainTechnician extends StatefulWidget {
  const NavigatorMainTechnician({super.key});

  @override
  State<NavigatorMainTechnician> createState() => _NavigatorMainTechnicianState();
}

class _NavigatorMainTechnicianState extends State<NavigatorMainTechnician> {
  int sttPage = 0;
  Widget body = const HomeTechiacaPage();
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
                  body = const HomeTechiacaPage();
                } else if (value == 1) {
                  body = const ListTicketAssign();
                } else if (value == 2) {
                  body = const TicketSolutionPage() ;
                } else if (value == 3) {
                  body = const ListChatScreen() ;
                }else if (value == 4) {
                  body = const ProfileScreen();
                }
              });
            },           
            selectedLabelStyle: MyTextStyle.styleSelectMenu,
            selectedItemColor: MyColors.blue,
            unselectedLabelStyle: MyTextStyle.styleUnSelectMenu,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.task, color: (sttPage == 0) ? MyColors.blue : MyColors.greyUnselect),
                label: 'Task',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.confirmation_number, color: (sttPage == 1) ? MyColors.blue : MyColors.greyUnselect),
                label: 'Ticket',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wb_incandescent_outlined, color: (sttPage == 2) ? MyColors.blue : MyColors.greyUnselect),
                label: 'Solution',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message, color: (sttPage == 3) ? MyColors.blue : MyColors.greyUnselect),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: (sttPage == 4) ? MyColors.blue : MyColors.greyUnselect),
                label: 'Profile',
              ),
            ],
          )),        
    );
  }
}
