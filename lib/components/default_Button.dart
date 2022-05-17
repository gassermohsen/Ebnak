import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key, this.text, this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: Container(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,
            padding:(EdgeInsets.all(15)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed:press as void Function()?,
          child: Text(text!,style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),),

        ),
      ),
    );
  }
}