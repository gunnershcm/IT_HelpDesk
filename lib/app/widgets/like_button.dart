import 'package:dich_vu_it/provider/solution.provider.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeButtonWidget extends StatefulWidget {
  final bool like;
  final int countLike;
  final int solutionId;
  final VoidCallback callback;
  const LikeButtonWidget(
    this.like,
    this.countLike,
    this.solutionId, {
    Key? key,
    required this.callback,
  }) : super(key: key);
  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButtonWidget> {
  late bool issLiked;
  late int likeCount;
  late int solutionId;
  late bool like;
  late VoidCallback callback;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    issLiked = widget.like;
    likeCount = widget.countLike;
    solutionId = widget.solutionId;
    like = widget.like;
    callback = widget.callback;
  }

    @override
  void didUpdateWidget(covariant LikeButtonWidget oldWidget) {
    if (oldWidget.countLike != widget.countLike) {
      // Thực hiện cập nhật khi tham số b thay đổi
      setState(() {
        likeCount = widget.countLike;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {  
    return LikeButton(
      isLiked: issLiked,
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
         bool result = await SolutionProvider.likeSolution(solutionId, issLiked);
        setState(() {
          issLiked = !issLiked;
          if (issLiked) {
            likeCount++;
          } else {
            likeCount--;
          }
        });       
        callback();
        return !isLiked;
      },
    );
  }
}
