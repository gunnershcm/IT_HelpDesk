
import 'package:dich_vu_it/app/widgets/dislike_button_setting.dart';
import 'package:flutter/material.dart';
import 'package:dich_vu_it/provider/solution.provider.dart';


class DisLikeButtonWidget extends StatefulWidget {
  final bool dislike;
  final int countDisLike;
  final int solutionId;
  final VoidCallback callback;
   const DisLikeButtonWidget(
    this.dislike,
    this.countDisLike,
    this.solutionId, {
    Key? key,
    required this.callback,
  }) : super(key: key);
  @override
  _DisLikeButtonState createState() => _DisLikeButtonState();
}

class _DisLikeButtonState extends State<DisLikeButtonWidget> {
  late bool isDisliked;
  late int dislikeCount;
  late int solutionId;
  late VoidCallback callback;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDisliked = widget.dislike;
    dislikeCount = widget.countDisLike;
    solutionId = widget.solutionId;
    callback = widget.callback;
  }

  @override
  void didUpdateWidget(covariant DisLikeButtonWidget oldWidget) {
    if (oldWidget.countDisLike != widget.countDisLike) {
      // Thực hiện cập nhật khi tham số b thay đổi
      setState(() {
        dislikeCount = widget.countDisLike;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return DisLikeButton(

      isLiked: isDisliked,
      likeCount: dislikeCount,
      likeCountPadding: EdgeInsets.only(left: 10),
      likeBuilder: (isLiked) {
        final image = isLiked
            ? (Image.asset('assets/images/unliked.png', width: 30, height: 30))
            : (Image.asset('assets/images/unlike.png', width: 30, height: 30));
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
        bool result = await SolutionProvider.dislikeSolution(solutionId, isDisliked);
        setState(() {
          isDisliked = !isDisliked;
          if (isDisliked) {
            dislikeCount++;
          } else {
            dislikeCount--;
          }
        });
        callback();
        return !isLiked;
      },
    );
  }
  
}
