import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileFullImageScreen extends StatefulWidget {

 final String profileImage;

  const UserProfileFullImageScreen({Key? key,required this.profileImage}) : super(key: key);

  @override
  State<UserProfileFullImageScreen> createState() => _UserProfileFullImageScreenState();
}

class _UserProfileFullImageScreenState extends State<UserProfileFullImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.profileImage),
                )
            ),
          ),
          Positioned(
            top: 35,
            right: 10,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.40),
                ),
                child: const Icon(Icons.close,color: Colors.white,size: 25,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
