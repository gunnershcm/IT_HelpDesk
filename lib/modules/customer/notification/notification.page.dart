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
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
        actions: [
          InkWell(
            onTap: () async {
              await NotiProvider.readAllNoti();
              getData();
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(
                Icons.mark_email_read,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: (statusData)
          ? ListView.builder(
              itemCount: listNoti.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    listNoti[index].title ?? "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  formatDateTimeConversation(
                                    listNoti[index].createdAt ?? "",
                                  ),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              listNoti[index].body ?? "",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            if (!(listNoti[index].isRead ?? false))
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: MyColors.blue,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(
              color: MyColors.blue,
            )),
    );
  }
}
