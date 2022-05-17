import 'package:ebnak1/shared/re_useable_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Size_config/size_config.dart';
import '../../../components/default_Button.dart';
import '../../../constants/constants.dart';
import '../../sign_in/components/form_error.dart';
import '../../sign_in/components/sign_form.dart';
import '../complete_profile/complete_profile_screen.dart';

class SignUpForm extends StatefulWidget {

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey= GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirm_password;
  bool remember = false;
  final List<String> errors = [];
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildPasswordFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),


          buildConfirmPasswordFormField(),
          FormError(errors:errors),
          SizedBox(
            height: getProportionateScreenHeight(40),
          ),
          DefaultButton(
            text: "Continue",
            press: (){

              if(_formKey.currentState!.validate()){
                navigateTo(context, CompleteProfileScreen(emailController: emailController.text, passwordController: emailController.text));
              }
            },
          )




        ],
      ),
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(

        obscureText: true,
        onSaved: (newValue)=>confirm_password=newValue,
        onChanged: (value){
          if (password==confirm_password) {
            removeError(error: kMatchPassError);
          }

        },
        validator: (value) {
          if (value!.isEmpty) {
            return "";
          } else if (password!=value) {
            addError(error: kMatchPassError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: " Confirm Password",
            labelStyle: TextStyle(
              color: kPrimaryColor,
            ),
            hintText: "Re-enter your password",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon:  Icon(
              Icons.lock,
              color: kPrimaryColor,
            )
        )
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
        obscureText: true,
        onSaved: (newValue)=>password=newValue,
        onChanged: (value){
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          } else if (value.length >= 8) {
            removeError(error: kShortPassError);
          }
          password = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPassNullError);
            return "";
          } else if (value.length < 8) {
            addError(error: kShortPassError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(
              color: kPrimaryColor,
            ),
            hintText: "Enter your password",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon:  Icon(
              Icons.lock,
              color: kPrimaryColor,
            )
        )
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailController,
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue)=>email=newValue,
        onChanged: (value){
          if (value.isNotEmpty) {
            removeError(error: kEmailNullError);
          } else if (emailValidatorRegExp.hasMatch(value)) {
            removeError(error: kInvalidEmailError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kEmailNullError);
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            addError(error: kInvalidEmailError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Email",
            labelStyle: TextStyle(
              color: kPrimaryColor,
            ),
            hintText: "Enter your email",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon:  CustomSuffixicon()
        )
    );
  }
}

