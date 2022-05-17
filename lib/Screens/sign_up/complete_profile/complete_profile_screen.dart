import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Size_config/size_config.dart';
import '../../../components/default_Button.dart';
import '../../../constants/constants.dart';
import '../../../shared/re_useable_components.dart';
import '../../Home/home_Screen.dart';
import '../../sign_in/components/form_error.dart';
import '../Cubit/_cubit.dart';
import '../Cubit/_state.dart';

class CompleteProfileScreen extends StatefulWidget {

  final String emailController;
  final String passwordController;

  static String routeName = "/complete_profile";
   CompleteProfileScreen(
      {Key? key, required this.emailController, required this.passwordController, })
      : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  var _formKey = GlobalKey<FormState>();

  late String fullName;

  late String phoneNumber;

  late String address;

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var addressController = TextEditingController();

  TextEditingController dateCtl = TextEditingController();

  final List<String> errors = [];

  void addError  ({String? error})   {
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
    return BlocProvider(
        create: (context) => EbnakRegisterCubit(),
        child: BlocConsumer<EbnakRegisterCubit, EbnakRegisterStates>(
            listener: (context, state) {
              if (state is EbnakCreateUserSuccessState) {
                navigateAndFinish(
                  context,
                  HomeScreen(),
                );
              }
            },
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                      "Sign Up"
                  ),
                ),
                body: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.screenHeight*0.02,
                          ),
                          Text(
                            "Complete Profile",
                            style: headingStyle,

                          ),
                          Text(
                            "Complete your details or continue \nwith social media",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight*0.05,
                          ),

                        Form(
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

                            ConditionalBuilder(
                              condition: state is! EbnakRegisterLoadingState,
                              builder: (context) =>
                                  DefaultButton(
                                  text: "Continue",
                                   press: (){
                                     if (_formKey.currentState!.validate()) {
                              //   EbnakRegisterCubit.get(context).userRegister(
                              //   // name: nameController.text,
                              //   email: widget.emailController,
                              //   password: widget.passwordController,
                              // // phone: phoneController.text,
                              // );
                                     }
                                  },
                                  ),
                                  fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                                  ),



                              ],
                            )
                        ),
                          SizedBox(
                            height: getProportionateScreenHeight(30),),

                          Text("By continuing you confirm that you agree \nwith our Terms and Conditions",textAlign: TextAlign.center,),



                        ],
                      ),
                    ),
                  ),
                ),);
              }
              )
                );
            }

TextFormField buildAddressFormField() {
  return TextFormField(
      controller: addressController,
      onSaved: (newValue)=>address=newValue!,
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
      onSaved: (newValue)=>phoneNumber=newValue!,
      onChanged: (value){
        if (value.isNotEmpty) {
          // removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          // addError(error: kPhoneNumberNullError);
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
      onSaved: (newValue)=>fullName=newValue!,
      onChanged: (value){
        if (value.isNotEmpty) {
          // removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          // addError(error: kNamelNullError);
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




















