import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/app/widgets/dislike_button.dart';
import 'package:dich_vu_it/app/widgets/like_button.dart';
import 'package:dich_vu_it/models/response/ticket.solution.model.dart';
import 'package:dich_vu_it/modules/c_technician/ticket.solution/bloc/solution.bloc.dart';
import 'package:flutter/material.dart';

class TicketSolutionItem extends StatefulWidget {
  final TicketSolutionModel solution;
  final Function(TicketSolutionModel) onTap;
  const TicketSolutionItem({
    Key? key,
    required this.solution,
    required this.onTap,
  }) : super(key: key);

  @override
  State<TicketSolutionItem> createState() => _TicketSolutionItemState();
}

class _TicketSolutionItemState extends State<TicketSolutionItem> {
  bool shouldUpdate = false;
  var bloc = TicketSolutionBloc();
  TicketSolutionModel solution = TicketSolutionModel();
  @override
  void initState() {
    super.initState();
    //bloc.add(GetAllSolutionEvent());
    solution = widget.solution;
  }

  void updateLike() {
    setState(() {
      bloc.add(GetAllSolutionEvent());
      shouldUpdate = !shouldUpdate;
    });
  }

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
                        text: getApproveStatus(solution.isApproved),
                        style: solution.isApproved == true
                            ? const TextStyle(color: Colors.green)
                            : const TextStyle(color: Colors.red),
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
                      callback: updateLike,
                    ),
                    SizedBox(width: 20.0),
                    DisLikeButtonWidget(
                      isDislike(solution.currentReactionUser),
                      solution.countDislike!,
                      solution.id!,
                      callback: updateLike,
                    ),
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
