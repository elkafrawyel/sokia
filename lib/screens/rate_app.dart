import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';

class RateAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      title: 'rate'.tr,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: 'انقر النجوم للتقييم',
                  fontSize: fontSize18,
                  alignment: AlignmentDirectional.center,
                ),
              ),
              RatingBar(
                onRatingChanged: (rating) {},
                initialRating: 0,
                isHalfAllowed: true,
                size: 40,
                halfFilledColor: Colors.amber,
                maxRating: 5,
                filledColor: Colors.amber,
                halfFilledIcon: Icons.star_half,
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
              ),
              TextFormField(
                obscureText: true,
                style: TextStyle(fontSize: 14, color: Colors.black),
                // controller: passwordController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) => FocusScope.of(context).nextFocus(),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'requiredField'.tr;
                  } else {
                    return null;
                  }
                },
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'note'.tr,
                    hintStyle: TextStyle(fontSize: 14, color: Colors.black),
                    contentPadding: EdgeInsets.all(16),
                    alignLabelWithHint: true,
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                    labelText: 'note'.tr,
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kPrimaryColor),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () {},
                  child: CustomText(
                    text: 'send'.tr,
                    color: Colors.white,
                    alignment: AlignmentDirectional.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
