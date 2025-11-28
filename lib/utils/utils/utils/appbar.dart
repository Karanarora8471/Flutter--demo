import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/common_widget/common_widget/color_constant.dart';

class CommonAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  String? heading;
  final VoidCallback? onBackPress;
  IconData? iconData;
  TextStyle? textStyle;
  Widget? leading;
  double? preferredheight;
  Widget? action;
  final Color? backgroundColor;

  CommonAppbarWidget(
      {this.heading,
      this.iconData,
      this.textStyle,
      this.leading,
      this.onBackPress,
      this.action,
      this.preferredheight,
        this.backgroundColor,
      });

  @override
  Widget build(BuildContext context) {
    return AppBar(
     // centerTitle: true,
      backgroundColor: backgroundColor ?? Colors.white,
      elevation: 0,
      title: Text(
        heading ?? "",
        style: textStyle ??
            const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),
      ),
      leading: leading ??
          GestureDetector(
            onTap: onBackPress ??
                () {
                 // Get.back();
                },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                  color: AppColor.buttonColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Icon(Icons.arrow_back_ios,
              color: AppColor.buttonColor,
              ),
            ),
          ),
      actions: [action ?? SizedBox()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
