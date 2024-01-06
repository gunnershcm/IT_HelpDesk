import 'package:dich_vu_it/app/theme/colors.dart';
import 'package:dich_vu_it/app/widgets/WAColors.dart';
import 'package:dich_vu_it/app/widgets/WAWidgets.dart';
import 'package:dich_vu_it/provider/session.provider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ForgetScreen extends StatefulWidget {
  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  TextEditingController emailController = TextEditingController();

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
          "Forget password",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Forget password",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: " Input your email",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                    counter: Offstage(),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: WAPrimaryColor)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.2)),
                    ),
                    fillColor: WAPrimaryColor.withOpacity(0.04),
                  ),
                ),
              ),
              SizedBox(height: 15),
              AppButton(
                      text: "Send",
                      color: MyColors.blue,
                      textColor: Colors.white,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      width: context.width(),
                      onTap: () async {
                        print("aa");
                        String email = emailController.text;
                        print(email);                     
                        var a = await SessionProvider.reset_password(email);
                        print(a);
                      })
                  .paddingOnly(
                      left: context.width() * 0.3,
                      right: context.width() * 0.3),
            ],
          )),
    );
  }
}
