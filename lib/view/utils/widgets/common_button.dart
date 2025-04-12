import 'package:flutter/material.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';



class CommonButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final double? height;

  const CommonButton(
      {Key? key, required this.text, this.onTap, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(
          horizontal: 35,
        ),
        height: height / 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.pinkColor,
        ),
        // child: (isUpdate)
        //     ?
      child:  Text(
                text,
                style: const TextStyle(
                  color: AppColors.lightPinkColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )
            // : const SizedBox(
            //     height: 15,
            //     width: 15,
            //     child: CircularProgressIndicator(
            //       color: Colors.white,
            //     )),
      ),
    );
  }
}
