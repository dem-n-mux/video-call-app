

class TicketModel {
  String image;
  String email;
  String message;
  String time;
  void Function() onTap;

  TicketModel({required this.image,required this.email,required this.message,required this.time,required this.onTap});

}
