
import 'dart:io';

class HostComplain {
  late String? hostClassMessage;
  late String? hostClassContact;
  late File? hostImage;
  late String? hostTime;

  HostComplain({
    this.hostClassMessage,
    this.hostClassContact,
    this.hostImage,
    this.hostTime,
  });
}

List<HostComplain> hostComplainData = [];
