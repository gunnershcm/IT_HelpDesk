// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dich_vu_it/models/response/feedback.model.dart';
import 'package:dich_vu_it/models/response/ticket.solution.model.dart';
import 'package:dich_vu_it/provider/solution.provider.dart';
import 'package:flutter/material.dart';

class Commentslotion extends StatefulWidget {
  final TicketSolutionModel solution;
  const Commentslotion({super.key, required this.solution});

  @override
  State<Commentslotion> createState() => _CommentslotionState();
}

class _CommentslotionState extends State<Commentslotion> {
  final FocusNode chatFocus = FocusNode();
  final TextEditingController controllerChat = TextEditingController();

  List<FeedbackModel> listFeedbackModel = [];

  void getData() async {
    var listData = await SolutionProvider.getAllTicketSolutionModel(widget.solution.id ?? 0);
    setState(() {
      listFeedbackModel = listData;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
                child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 228, 243, 255),
              ),
              child: ListView.separated(
                addAutomaticKeepAlives: true,
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                itemBuilder: (context, index) {
                  var feedbackModel = listFeedbackModel[index];
                  return ChatComponent(feedbackModel: feedbackModel);
                },
                itemCount: listFeedbackModel.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 25,
                  );
                },
              ),
            )),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 5),
                SizedBox(width: 5),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.grey, width: 2)),
                    height: 50,
                    child: TextFormField(
                      onChanged: (value) {},
                      enabled: true,
                      controller: controllerChat,
                      style: TextStyle(),
                      onTap: () {},
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Aa",
                        hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFFBBBBBB)),
                        suffixIconConstraints: const BoxConstraints.expand(width: 30, height: 20),
                        contentPadding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                        isCollapsed: true,
                        border: InputBorder.none,
                      ),
                      focusNode: chatFocus,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 81, 168, 238),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: InkWell(
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      var response = await SolutionProvider.sendFeedback(widget.solution.id ?? 0, controllerChat.text);
                      if (response != null) {
                        setState(() {
                          listFeedbackModel.add(response);
                          controllerChat.text = "";
                        });
                      }
                    },
                    child: Center(
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 5),
              ],
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

class ChatComponent extends StatelessWidget {
  final FeedbackModel feedbackModel;
  const ChatComponent({super.key, required this.feedbackModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: ClipOval(
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: feedbackModel.user?.avatarUrl ?? "",
              progressIndicatorBuilder: (context, url, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              errorWidget: (context, url, error) => Image.asset("assets/noavatar.png"),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${feedbackModel.user?.firstName ?? ""} ${feedbackModel.user?.lastName ?? ""}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Text(feedbackModel.comment ?? ""),
              ),
              Row(
                children: [
                  Text(
                    formatDateTimeConversation(feedbackModel.createdAt ?? ""),
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(width: 15),
                  // InkWell(
                  //   child: Text(
                  //     "Trả lời",
                  //     style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                  //   ),
                  // )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

String formatDateTimeConversation(String date) {
  try {
    DateTime dateTime = DateTime.parse(date).toLocal();
    DateTime currentDate = DateTime.now();
    if (dateTime.year == currentDate.year && dateTime.month == currentDate.month && dateTime.day == currentDate.day) {
      String formattedTime = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
      return formattedTime;
    } else {
      String formattedDate = "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}";
      return formattedDate;
    }
  } catch (e) {}
  return "";
}
