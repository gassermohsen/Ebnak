import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ebnak1/Screens/sign_in/components/form_error.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/components/default_Button.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/ebnak/cubit/ebnak_cubit.dart';
import '../../../layout/ebnak/ebnak_layout.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/re_useable_components.dart';
import '../../Home/home_Screen.dart';
import '../../sign_up/Cubit/_state.dart';
import '../Cubit/cubit.dart';
import '../Cubit/states.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formkey=GlobalKey<FormState>();
  String? email;
  String? password;
  var emailController=TextEditingController();
  var PasswordController=TextEditingController();

  bool? remember = false;
  final List<String>errors=[];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EbnakLoginCubit(),
        child: BlocConsumer<EbnakLoginCubit,EbnakLoginStates>(
            listener: (context,state){
              if (state is EbnakLoginErrorState) {
                showToast(
                  text: state.error,
                  state: ToastStates.ERROR,
                );
              }
              if(state is EbnakLoginSuccessState)
              {
                print(state.uId);
                uId=state.uId;
                EbnakCubit.get(context).getUserData();
                EbnakCubit.get(context).getUserReports();



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
            builder: (context,state) {
              return Form(
                key: _formkey,
                child: Column(
                  children: [
                    buildEmailFormField(),
                    SizedBox(height: getProportionateScreenHeight(30),),
                    buildpassowordFormField(),
                    SizedBox(height: getProportionateScreenHeight(30),),
                    Row(
                      children: [
                        Checkbox(
                          value: remember,
                          activeColor: kPrimaryColor,
                          onChanged: (value) {
                            setState(() {
                              remember = value;
                            });
                          },

                        ),
                        Text("Remember me "),
                        Spacer(),
                        Text("Forgot Password?", style: TextStyle(
                            decoration: TextDecoration.underline),)
                      ],
                    ),

                    SizedBox(height: getProportionateScreenHeight(30),),
                    FormError(errors: errors),

                    ConditionalBuilder(
                      condition: state is! EbnakLoginLoadingState,
                      builder: (context) => DefaultButton(
                        press: () {
                          if (_formkey.currentState!.validate()) {
                            EbnakLoginCubit.get(context).UserLogin(
                              email: emailController.text,
                              password: PasswordController.text,
                            );
                          }
                        },
                        text: 'login',
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),




                  ],
                ),
              );
            }
    ),

    );
            }




  TextFormField buildpassowordFormField() {
    return TextFormField(
        controller:PasswordController,
        obscureText: true,
        onSaved: (newValue)=>password=newValue,
        onChanged: (value){
          if(value.isNotEmpty&&errors.contains(kPassNullError)){
            setState(() {
              errors.remove(kPassNullError);
            });

          }else if (value.length>=8 && errors.contains(kShortPassError)){
            setState(() {
              errors.remove(kShortPassError);
            });
          }
          return null;
        },
        validator: (value){
          if(value!.isEmpty&&!errors.contains(kPassNullError)){
            setState(() {
              errors.add(kPassNullError);
            });

          }else if (value.length<8&&!errors.contains(kShortPassError)){
            setState(() {
              errors.add(kShortPassError);
            });
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
          if(value.isNotEmpty&&errors.contains(kEmailNullError)){
            setState(() {
              errors.remove(kEmailNullError);
            });

          }else if (emailValidatorRegExp.hasMatch(value)&&errors.contains(kInvalidEmailError)){
            setState(() {
              errors.remove(kInvalidEmailError);
            });
          }
          return null;
        },
        validator: (value){
          if(value!.isEmpty&&!errors.contains(kEmailNullError)){
            setState(() {
              errors.add(kEmailNullError);
            });

          }else if (!emailValidatorRegExp.hasMatch(value)&&!errors.contains(kInvalidEmailError)){
            setState(() {
              errors.add(kInvalidEmailError);
            });
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



class CustomSuffixicon extends StatelessWidget {
  const CustomSuffixicon({
    Key? key, this.SvgIcon,

  }) : super(key: key);
  final String? SvgIcon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.email_outlined,
      color: kPrimaryColor,
    );
  }
}

