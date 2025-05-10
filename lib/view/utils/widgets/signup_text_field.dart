import 'package:flutter/material.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';

class SignupTextField extends StatelessWidget {
  final String title;
  final void Function()? onEditingComplete;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const SignupTextField(
      {Key? key,
      required this.title, this.onEditingComplete, this.obscureText, this.suffixIcon, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.blockSizeVertical * 6.7,
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
      padding: EdgeInsets.only(
        left: SizeConfig.blockSizeHorizontal * 4,
      ),
      decoration: BoxDecoration(
         color: AppColors.grey,
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: TextFormField(
          controller: controller,
          obscureText: obscureText ?? false,
          onEditingComplete: onEditingComplete,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.black,
          decoration:  InputDecoration(
            suffixIcon: suffixIcon,
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            hintText: title,
            hintStyle: const TextStyle(color: Colors.white)
          ),
        ),
      ),
    );
  }
}
