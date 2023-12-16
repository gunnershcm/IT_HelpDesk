import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeButtonWidget extends StatefulWidget {
  final bool like;
  final int countLike;
  const LikeButtonWidget(this.like,this.countLike, {super.key});
  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButtonWidget> {
  late bool isLiked;
  late int likeCount;
  double size = 20;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked = widget.like;
    likeCount = widget.countLike;
  }

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
        
      },
    );
  }
}
