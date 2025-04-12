import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import '../../../../Api_Service/Complain/host_complain/get_host_complain/get_host_complain_model.dart';
import 'host_ticket_details.dart';

class HostTicketList extends StatefulWidget {
  final List<Data> complainData;
  final int index;

  const HostTicketList(
      {Key? key, required this.complainData, required this.index})
      : super(key: key);

  @override
  State<HostTicketList> createState() => _HostTicketListState();
}

class _HostTicketListState extends State<HostTicketList> {
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
            () => HostTicketDetails(
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
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 55),
                      child: Text(
                        widget.complainData[widget.index].date.toString(),
                        style: TextStyle(
                          color: AppColors.lightPinkColor.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
