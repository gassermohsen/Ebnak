import 'package:flutter/material.dart';

import '../../../../Size_config/size_config.dart';
import '../../../../components/default_Button.dart';
import '../../../../constants/constants.dart';
import '../../../sign_in/components/form_error.dart';



class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  State<CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {

  final _formKey= GlobalKey<FormState>();
  String? fullName;
  String? phoneNumber;
  String? address;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  TextEditingController dateCtl = TextEditingController();

  final List<String> errors = [];

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
        child: Column(
          children: [
            buildNameFormField(),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),

            buildPhoneNumberFormField(),

            SizedBox(
              height: getProportionateScreenHeight(30),
            ),


            buildAddressFormField(),

            SizedBox(
              height: getProportionateScreenHeight(30),
            ),


            TextFormField(
                controller: dateCtl,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,

                    labelText: "Date of birth",
                    labelStyle: TextStyle(
                      color: kPrimaryColor,
                    ),
                    hintText: "Ex. Insert your dob",
                    suffixIcon:  Icon(
                      Icons.date_range_outlined,
                      color: kPrimaryColor,
                    )
                ),
                onTap: () async {
                  DateTime? date = DateTime(1900);
                  FocusScope.of(context).requestFocus(new FocusNode());

                  date = (await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    builder: (context, child){
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: kPrimaryColor, // header background color
                            onPrimary: Colors.white, // header text color
                            onSurface: Colors.green, // body text color
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              primary: kPrimaryColor, // button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },




                  ));
                  dateCtl.text = date.toString().substring(0, 10);
                }
            ),
            FormError(errors: errors),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),


            DefaultButton(
              text: "Continue",
              press: (){
                if(_formKey.currentState!.validate()){

                }
              },
            ),



          ],
        )
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      controller: addressController,
        onSaved: (newValue)=>address=newValue,
        onChanged: (value){
          if (value.isNotEmpty) {
            removeError(error: kAddressNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kAddressNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Address",
            labelStyle: TextStyle(
              color: kPrimaryColor,
            ),
            hintText: "Enter your Address",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon:  Icon(
              Icons.location_on_outlined,
              color: kPrimaryColor,
            )
        )
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: phoneController,
        keyboardType:TextInputType.phone,
        onSaved: (newValue)=>phoneNumber=newValue,
        onChanged: (value){
          if (value.isNotEmpty) {
            removeError(error: kPhoneNumberNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPhoneNumberNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Phone Number",
            labelStyle: TextStyle(
              color: kPrimaryColor,
            ),
            hintText: "Enter your phone number",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon:  Icon(
              Icons.phone_android_outlined,
              color: kPrimaryColor,
            )
        )
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      controller: nameController,
        onSaved: (newValue)=>fullName=newValue,
        onChanged: (value){
          if (value.isNotEmpty) {
            removeError(error: kNamelNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kNamelNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Full Name",
            labelStyle: TextStyle(
              color: kPrimaryColor,
            ),
            hintText: "Enter your full name",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon:  Icon(
              Icons.account_circle,
              color: kPrimaryColor,
            )
        )
    );
  }
}

