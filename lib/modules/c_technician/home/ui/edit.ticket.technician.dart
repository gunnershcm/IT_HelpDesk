// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, must_be_immutable

import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/app/widgets/toast.dart';
import 'package:dich_vu_it/models/response/tiket.response.model.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class EditTicketTechnicianScreen extends StatefulWidget {
  Function callBack;
  final TicketResponseModel tiket;
   EditTicketTechnicianScreen({super.key, required this.tiket, required this.callBack});

  @override
  State<EditTicketTechnicianScreen> createState() => _EditTicketTechnicianScreenState();
}

class _EditTicketTechnicianScreenState extends State<EditTicketTechnicianScreen> {
  TextEditingController description = TextEditingController();  
  Map<int, String> listImpact = {
    0: 'Low',
    1: 'Medium',
    2: 'High',
  };
  int? selectedImpact;
  Map<int, String> listUrgency = {
    0: 'Low',
    1: 'Medium',
    2: 'High',
    3: 'Urgent',
  };
  int? selectedUrgency;


  @override
  void initState() {
    super.initState();
    selectedImpact = widget.tiket.impact;
    description.text = widget.tiket.impactDetail ?? "";
    selectedUrgency = widget.tiket.urgency;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Evaluate ticket",
          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: const Color.fromARGB(255, 229, 243, 254), borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Impact",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  items: listImpact.entries.map((item) => DropdownMenuItem<int>(value: item.key, child: Text(item.value))).toList(),
                  value: selectedImpact,
                  onChanged: (value) {
                    setState(() {
                      selectedImpact = value as int;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            const Text(
              "Impact Detail",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: description,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            const Text(
              "Urgency",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  items: listUrgency.entries.map((item) => DropdownMenuItem<int>(value: item.key, child: Text(item.value))).toList(),
                  value: selectedUrgency,
                  onChanged: (value) {
                    setState(() {
                      selectedUrgency = value as int;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
                  child: InkWell(
                    onTap: () async {
                      onLoading(context);
                      var response = await TicketProvider.patchTechnicianTicket(
                        idTicket: widget.tiket.id ?? 0,
                        impact: selectedImpact ?? 0,
                        impactDetail: description.text,
                        urgency: selectedUrgency ?? 0,
                      );
                      if (response) {
                        showToast(
                          context: context,
                          msg: "Update successfully",
                          color: Colors.green,
                          icon: const Icon(Icons.done),
                        );
                        var valueCallBack = widget.tiket;
                        valueCallBack.impact = selectedImpact;
                        valueCallBack.urgency = selectedUrgency;
                        valueCallBack.impactDetail = description.text;
                        widget.callBack(valueCallBack);
                      } else {
                        showToast(
                          context: context,
                          msg: "Error updating",
                          color: Colors.orange,
                          icon: const Icon(Icons.warning),
                        );
                      }
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
