import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/common_widget/common_widget/app_text.dart';
import 'package:flutter_demo/utils/common_widget/common_widget/color_constant.dart';
import 'package:flutter_demo/utils/common_widget/common_widget/helper_widget.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Image.asset("assets/images/no_internet.gif"),
          _buildNoInternetWidget(),
        ],
      ),
    );
  }

  _buildNoInternetWidget() => Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: AppColor.buttonColor,
        //border: Border(top: BorderSide()),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )
      ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                text: "No Internet Connection",
                color: AppColor.white,
                fontWeight: FontWeight.w700,
                textSize: 22
              ),
              WhiteSpace.twentyH(),
              AppText(
                text:
                    "No internet connection found, check your internet connection.",
                color: AppColor.white,
                fontWeight: FontWeight.w500,
                textSize: 16,
                lineHeight: 1.5,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
  );
}
