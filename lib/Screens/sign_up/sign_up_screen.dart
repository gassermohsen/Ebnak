
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ebnak1/Screens/Home/home_Screen.dart';
import 'package:ebnak1/Screens/sign_up/components/body.dart';
import 'package:ebnak1/layout/ebnak/ebnak_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Size_config/size_config.dart';
import '../../components/default_Button.dart';
import '../../constants/constants.dart';
import '../../layout/ebnak/cubit/ebnak_cubit.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/re_useable_components.dart';
import '../sign_in/components/form_error.dart';
import '../sign_in/components/sign_form.dart';
import '../sign_in/components/social_card.dart';
import 'Cubit/_cubit.dart';
import 'Cubit/_state.dart';
import 'components/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "/sign_up";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String? email;

  String? password;

  String? confirm_password;

  bool remember = false;

  final List<String> errors = [];

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();

  late String fullName;

  late String phoneNumber;

  late String address;


  var addressController = TextEditingController();

  var dateCtl = TextEditingController();

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
    return BlocProvider(
      create: (context) => EbnakRegisterCubit(),
      child: BlocConsumer<EbnakRegisterCubit, EbnakRegisterStates>(
          listener: (context, state) {
            if (state is EbnakCreateUserSuccessState) {

              print(state.uId);
              uId=state.uId;
              EbnakCubit.get(context).getUserData();

              CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
              ).then((value)
              {
                navigateAndFinish(
                  context,
                  EbnakLayout(),
                );
              });
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("Sign Up",
                ),
              ),
              body: SizedBox(

                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,),

                        Text(
                          "Register Account",
                          style: headingStyle,
                        ),
                        Text(
                          "Complete your details or continue\nwith social media ",
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(
                          height: SizeConfig.screenHeight * 0.07,
                        ),


                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              buildNameFormField(),
                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),
                              buildEmailFormField(),
                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),
                              buildPasswordFormField(),
                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),


                              buildConfirmPasswordFormField(),
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


                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),
                              FormError(errors: errors),
                              SizedBox(
                                height: getProportionateScreenHeight(40),
                              ),
                              ConditionalBuilder(
                                condition: state is! EbnakRegisterLoadingState,
                                builder: (context) =>
                                    DefaultButton(
                                      text: "Continue",
                                      press: () {
                                        if (_formKey.currentState!
                                            .validate()) {
                                          EbnakRegisterCubit.get(context)
                                              .userRegister(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            DateOfBirth: dateCtl.text,
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            address: addressController.text,
                                          );
                                        }
                                      },
                                    ),
                                fallback: (context) =>
                                    Center(
                                        child: CircularProgressIndicator()),
                              ),


                            ],
                          ),
                        ),


                        SizedBox(
                          height: SizeConfig.screenHeight * 0.07,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialCard(icon: "assets/icons/facebook-2.svg",
                              press: () {},),
                            SocialCard(icon: "assets/icons/google-icon.svg",
                              press: () {},),
                            SocialCard(icon: "assets/icons/twitter.svg",
                              press: () {},),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(20),),
                        Text(
                          "By continuing you confirm that you agree\n with our Terms And Conditions",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(

        obscureText: true,
        onSaved: (newValue) => confirm_password = newValue,
        onChanged: (value) {
          if (password == confirm_password) {
            removeError(error: kMatchPassError);
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "";
          } else if (password != value) {
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
            suffixIcon: Icon(
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
        onSaved: (newValue) => password = newValue,
        onChanged: (value) {
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
            suffixIcon: Icon(
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
        onSaved: (newValue) => email = newValue,
        onChanged: (value) {
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
            suffixIcon: CustomSuffixicon()
        )
    );
  }


  TextFormField buildAddressFormField() {
    return TextFormField(
        controller: addressController,
        onSaved: (newValue) => address = newValue!,
        onChanged: (value) {
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
            suffixIcon: Icon(
              Icons.location_on_outlined,
              color: kPrimaryColor,
            )
        )
    );
  }


  TextFormField buildPhoneNumberFormField() {
    return TextFormField(

        controller: phoneController,
        keyboardType: TextInputType.phone,
        onSaved: (newValue) => phoneNumber = newValue!,
        onChanged: (value) {
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
            suffixIcon: Icon(
              Icons.phone_android_outlined,
              color: kPrimaryColor,
            )
        )
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
        controller: nameController,
        onSaved: (newValue) => fullName = newValue!,
        onChanged: (value) {
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
            suffixIcon: Icon(
              Icons.account_circle,
              color: kPrimaryColor,
            )
        )
    );
  }
}



