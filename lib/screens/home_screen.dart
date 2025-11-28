import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/controller/home_controller.dart';
import 'package:flutter_demo/utils/common_widget/common_widget/app_text.dart';
import 'package:flutter_demo/utils/common_widget/common_widget/app_textfield.dart';
import 'package:flutter_demo/utils/common_widget/common_widget/color_constant.dart';
import 'package:flutter_demo/utils/common_widget/common_widget/common_button.dart';
import 'package:flutter_demo/utils/common_widget/common_widget/helper_widget.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppText(text: "Data")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            AppText(text: "Login Here", textSize: 20),
            WhiteSpace.tenH(),
            AppTextField(title: "Email"),
            WhiteSpace.tenH(),
            Obx(
              () => AppTextField(
                textInputType: TextInputType.text,
                controller: controller.password,
                title: "Password",
                isObscure: true,
                maxLines: 1,
                suffix: GestureDetector(
                  onTap: () {
                    controller.check.toggle();
                  },
                  child: Icon(
                    controller.check.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            SizedBox(
              child: ListView(),
            ),

            WhiteSpace.tenH(),
            CommonButton(text: " Login page", color: AppColor.buttonColor),
          ],
        ),
      ),
    );
  }
}
