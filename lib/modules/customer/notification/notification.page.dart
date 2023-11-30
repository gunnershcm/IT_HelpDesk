import 'package:dich_vu_it/app/constant/my_date_util.dart';
import 'package:dich_vu_it/app/theme/colors.dart';
import 'package:dich_vu_it/models/response/noti.model.dart';
import 'package:dich_vu_it/modules/customer/notification/view.noti.screen.dart';
import 'package:dich_vu_it/provider/noti.provider.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotiModel> listNoti = [];
  bool statusData = false;
  getData() async {
    setState(() {
      statusData = false;
    });
    var listData = await NotiProvider.getAllListNoti();
    setState(() {
      listNoti = listData;
      statusData = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
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
          "Notification",
          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
        actions: [
          InkWell(
            onTap: () async {
              await NotiProvider.readAllNoti();
              getData();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              width: 100,
              height: 35,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17)),
              child: const Center(
                child: Text(
                  "See all",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      ),
      body: (statusData)
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(20),
              child: ListView.separated(
                itemCount: listNoti.length,
                separatorBuilder: (BuildContext context, int index) => Container(
                  margin: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Color.fromARGB(255, 122, 122, 122)))),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: (listNoti[index].isRead == false) ? const Color.fromARGB(255, 229, 243, 254) : Colors.white,
                    ),
                    child: InkWell(
                      onTap: () async {
                        NotiProvider.readNoti(listNoti[index].id ?? -1);
                        await Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => ViewNotiScreen(
                              notiModel: listNoti[index],
                            ),
                          ),
                        );
                        setState(() {
                          listNoti[index].isRead = true;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    listNoti[index].title ?? "",
                                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Text(formatDateTimeConversation(listNoti[index].createdAt ?? ""))
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  listNoti[index].body ?? "",
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17),
                                  overflow: TextOverflow.ellipsis,
                                ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
              color: MyColors.blue,
            )),
    );
  }
}
