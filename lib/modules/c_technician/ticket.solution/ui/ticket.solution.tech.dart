// ignore_for_file: prefer_const_constructors

import 'package:animation_list/animation_list.dart';
import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/app/widgets/dislike_button.dart';
import 'package:dich_vu_it/app/widgets/dislike_button_setting.dart';
import 'package:dich_vu_it/app/widgets/like_button.dart';
import 'package:dich_vu_it/app/widgets/like_button_setting.dart';
//import 'package:dich_vu_it/app/widgets/like_button.dart';
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/models/response/ticket.solution.model.dart';
import 'package:dich_vu_it/models/response/user.login.response.model.dart';
import 'package:dich_vu_it/models/response/user.profile.response.model.dart';
import 'package:dich_vu_it/modules/c_technician/history.task/bloc/component/ticket.solution.item.dart';
import 'package:dich_vu_it/modules/c_technician/ticket.solution/bloc/solution.bloc.dart';
import 'package:dich_vu_it/modules/c_technician/ticket.solution/ui/create.ticket.solution.dart';
import 'package:dich_vu_it/modules/c_technician/ticket.solution/ui/view.ticket.solution.dart';
import 'package:dich_vu_it/provider/session.provider.dart';
import 'package:dich_vu_it/provider/solution.provider.dart';
import 'package:dich_vu_it/repository/authentication.repository.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../bloc/history.bloc.dart';
// import 'infor.task.screen.dart';

class TicketSolutionPage extends StatefulWidget {
  const TicketSolutionPage({super.key});

  @override
  State<TicketSolutionPage> createState() => _TicketSolutionPageState();
}

class _TicketSolutionPageState extends State<TicketSolutionPage> {
  var bloc = TicketSolutionBloc();
  List<TicketSolutionModel> listSolution = [];
  List<TicketSolutionModel> filteredList = [];
  UserLoginResponseModel? userLoginResponseModel;
  late String query = '';
  TicketSolutionModel? selectedSolution =
      TicketSolutionModel(title: "All solutions");

  @override
  void initState() {
    super.initState();
    bloc.add(GetAllSolutionEvent());

  }


  void filterList() {
    setState(() {
      filteredList = listSolution
          .where((solution) =>
              (solution.title!.toLowerCase().contains(query.toLowerCase()) ||
                  solution.category!.name!
                      .toLowerCase()
                      .contains(query.toLowerCase())))
          .toList();
    });
  }

  String idLogin = "";
  Future<String> getIdLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('idUser');

    if (id != null) {
      print('User Role: $id');
      return idLogin = id;
    } else {
      print('Không tìm thấy thông tin người dùng trong SharedPreferences.');
      return idLogin = "not found id";
    }
  }

  @override
  Widget build(BuildContext context) {
    getIdLogin();
    return BlocConsumer<TicketSolutionBloc, TicketSolutionState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is TicketSolutionLoading) {
          onLoading(context);
          return;
        } else if (state is GetListSolutionState) {
          listSolution = state.list;
          filterList();
          Navigator.pop(context);
        } else if (state is TicketSolutionError) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 229, 243, 254),
          appBar: AppBar(
            backgroundColor: Colors.blue,
            leading: Row(),
            title: Center(
              child: Text(
                "Solution ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => CreateSolutionScreen(
                        callBack: (value) {
                          if (value == true) {
                            bloc.add(GetAllSolutionEvent());
                          }
                        },
                      ),
                    ),
                  );
                },
                child: Center(
                    child: Icon(
                  Icons.add_circle,
                  size: 28,
                  color: Colors.white,
                )),
              ),
              SizedBox(width: 15)
            ],
          ),
          body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
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
                //SizedBox(height: 20),
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
                                  ViewSolutionDetail(
                                solution: element,
                                id: idLogin.toInt(),
                              ),
                            ),
                          );
                        },
                        child: TicketSolutionItem(
                          solution: element,
                          onTap: (ticket) {
                            // onTap logic specific to the TicketItem
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
