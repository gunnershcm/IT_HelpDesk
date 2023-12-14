import 'package:dich_vu_it/app/widgets/dislike_button_setting.dart';
import 'package:flutter/material.dart';

class DisLikeButtonWidget extends StatefulWidget {
  @override
  _DisLikeButtonState createState() => _DisLikeButtonState();
}

class _DisLikeButtonState extends State<DisLikeButtonWidget> {
  bool isLiked = false;
  int likeCount = 17;
  double size = 20;
  @override
  Widget build(BuildContext context) {
    return DisLikeButton(
      size: size,
      isLiked: isLiked,
      likeCount: likeCount,
      likeCountPadding: EdgeInsets.only(left: 10),
      likeBuilder: (isLiked) {
        final image = isLiked ? (Image.asset('assets/images/unliked.png', width: 30, height: 30)) : (Image.asset('assets/images/unlike.png', width: 30, height: 30));
        return image;
      },
      countBuilder: (count, isLiked, text) {
        final color = isLiked ? Colors.black : Colors.grey;
        return Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        );
      },
      onTap: (isLiked) async {
        this.isLiked = !isLiked;
        likeCount += this.isLiked ? 1 : -1;
        return !isLiked;
      },
    );
  }
}
