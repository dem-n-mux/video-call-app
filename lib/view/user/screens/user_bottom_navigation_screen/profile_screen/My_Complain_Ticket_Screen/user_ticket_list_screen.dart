import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/profile_screen/My_Complain_Ticket_Screen/user_ticket_details.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import '../../../../../../Api_Service/Complain/user_complain/get_user_complain/get_user_complain_model.dart';


class UserTicketList extends StatefulWidget {

  final List<Data> complainData;
  final int index;

  const UserTicketList(
      {Key? key, required this.complainData, required this.index})
      : super(key: key);

  @override
  State<UserTicketList> createState() => _UserTicketListState();
}

class _UserTicketListState extends State<UserTicketList> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        right: 15,
        left: 15,
      ),
      child: InkWell(
        onTap: () {
          Get.to(
            () => UserTicketDetails(
              complainData: widget.complainData,
              index: widget.index,
            ),
          );
        },
        child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            alignment: Alignment.center,
            height: height / 9.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff434343),
                    Color(0xff252525),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: height / 30,
                      backgroundImage: NetworkImage(userImage),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 18,
                        left: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.complainData[widget.index].contact
                                        .toString()
                                        .length >
                                    15
                                ? '${widget.complainData[widget.index].contact.toString().substring(0, 15)}...'
                                : widget.complainData[widget.index].contact
                                    .toString(),
                            style: const TextStyle(
                              color: AppColors.pinkColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // const SizedBox(height: 3,),
                          Text(
                            widget.complainData[widget.index].message
                                        .toString()
                                        .length >
                                    17
                                ? '${widget.complainData[widget.index].message.toString().substring(0, 17)}...'
                                : widget.complainData[widget.index].message
                                    .toString(),
                            style: TextStyle(
                              color: AppColors.lightPinkColor.withOpacity(0.82),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 55,
                      ),
                      child: Text(
                        widget.complainData[widget.index].date.toString(),
                        style: TextStyle(
                          color: AppColors.lightPinkColor.withOpacity(0.6),
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
