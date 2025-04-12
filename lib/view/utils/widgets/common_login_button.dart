import 'package:flutter/material.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';

class CommonLoginButton extends StatelessWidget {
  final String icon;
  final String title;
  final double padding;
  final void Function()? onTap;

  const CommonLoginButton(
      {Key? key,
        required this.icon,
        required this.title,
        required this.padding,
        this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          top: 15,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        alignment: Alignment.centerLeft,
        height: height / 11.5,
        width: width / 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: FractionalOffset.centerRight,
            colors: [
              const Color(0xff362B2F).withOpacity(.75),
              const Color(0xff362B2F).withOpacity(.85),
              const Color(0xff363636),
            ],
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(),
              child: Container(
                alignment: Alignment.center,
                height: 48,
                width: 45,
                decoration: BoxDecoration(
                  color: const Color(0xff282828),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xff363636),
                    width: 1.5,
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: 28,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(icon),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                color: AppColors.lightPinkColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
