import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeButtonWidget extends StatefulWidget {
  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButtonWidget> {
  bool isLiked = false;
  int likeCount = 17;
  double size = 20;
  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: size,
      isLiked: isLiked,
      likeCount: likeCount,
      likeCountPadding: EdgeInsets.only(left: 10),
      likeBuilder: (isLiked) {
        final image = isLiked ? (Image.asset('assets/images/liked.png', width: 30, height: 30)) : (Image.asset('assets/images/like.png', width: 30, height: 30));
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
