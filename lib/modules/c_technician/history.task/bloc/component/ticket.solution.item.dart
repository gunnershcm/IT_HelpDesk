import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/app/widgets/dislike_button.dart';
import 'package:dich_vu_it/app/widgets/like_button.dart';
import 'package:dich_vu_it/models/response/ticket.solution.model.dart';
import 'package:flutter/material.dart';

class TicketSolutionItem extends StatelessWidget {
  final TicketSolutionModel solution;
  final Function(TicketSolutionModel) onTap;

  const TicketSolutionItem({
    Key? key,
    required this.solution,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  solution.title ?? "",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  solution.category?.name ?? "",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Status: ",
                        style: DefaultTextStyle.of(context).style,
                      ),
                      TextSpan(
                        text: "${getApproveStatus(solution.isApproved)}",
                        style: solution.isApproved == true
                            ? TextStyle(color: Colors.green)
                            : TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Visibility: ",
                        style: DefaultTextStyle.of(context).style,
                      ),
                      TextSpan(
                        text: "${getPublicStatus(solution.isPublic)}",
                        style: solution.isPublic == true
                            ? TextStyle(color: Colors.green)
                            : TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LikeButtonWidget(
                      isLike(solution.currentReactionUser),
                      solution.countLike!,
                      solution.id!,
                    ),
                    SizedBox(width: 20.0),
                    DisLikeButtonWidget(isDislike(solution.currentReactionUser),
                        solution.countDislike!, solution.id!),
                    // DisLikeButton(
                    //   size: size,
                    //   isLiked: isLiked,
                    //   likeCount: likeCount,
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
