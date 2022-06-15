import 'package:ebnak1/Screens/user_Children/add_userChildren_Screen.dart';
import 'package:ebnak1/Screens/user_Children/viewAllMembers_Screen.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Size_config/size_config.dart';
import '../../components/default_Button.dart';
import '../../constants/constants.dart';
import '../../shared/re_useable_components.dart';
import '../../styles/icon_broken.dart';

class AddmemberScreen extends StatefulWidget {
  @override
  State<AddmemberScreen> createState() => _AddmemberScreenState();
}

class _AddmemberScreenState extends State<AddmemberScreen> {
  var nameController = TextEditingController();

  var heightController = TextEditingController();

  var weightController = TextEditingController();

  var informationController = TextEditingController();

  late String fullName;

  var dateCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EbnakCubit, EbnakStates>(
      listener: (context, state) async {
        if(state is EbnakCreateMemberSuccessState){
          EbnakCubit.get(context).getuserMembers();
          showToast(text: "Member Added Successfully", state: ToastStates.SUCCESS);
          EbnakCubit.get(context).memberImage=null;
          nameController.clear();
          heightController.clear();
          weightController.clear();
          informationController.clear();
          dateCtl.clear();
        }
      },
      builder: (context, state) {
        var memberImage=EbnakCubit.get(context).memberImage;

        return Scaffold(
          appBar: AppBar(),
            body: SingleChildScrollView(
              child: Column(

                children: [

                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),

                  Center(child: Text('Add Member',style: headingStyle,)),
                  SizedBox(height: getProportionateScreenHeight(40),),

                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,

                                    radius: 75,
                                    backgroundImage: memberImage == null ? NetworkImage(
                                        'https://st2.depositphotos.com/4111759/12123/v/950/depositphotos_121231642-stock-illustration-baby-default-placeholder-children-avatar.jpg'
                                    ) : FileImage(memberImage) as ImageProvider,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      EbnakCubit.get(context).getMemberImage();
                                    },
                                    icon: CircleAvatar(
                                      backgroundColor: kPrimaryColor,
                                      radius: 20,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 23,
                                        color: Colors.white,
                                      ),
                                    ))
                              ]
                          ),
                        ),

                        SizedBox(height: getProportionateScreenHeight(30),),
                        if(state is EbnakCreateMemberLoadingState)
                          LinearProgressIndicator(
                            color: kPrimaryColor,
                            backgroundColor: Colors.white,
                          ),
                        SizedBox(height: getProportionateScreenHeight(20),),


                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: buildNameFormField(),
                        ),

                        SizedBox(height: getProportionateScreenHeight(20),),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              controller: dateCtl,
                              decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,

                                  labelText: "Date of birth",
                                  labelStyle: TextStyle(
                                    color: kPrimaryColor,
                                  ),
                                  hintText: "Ex. Insert Member dob",
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
                        ),
                        SizedBox(height: getProportionateScreenHeight(20),),


                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  width: getProportionateScreenWidth(170),
                                  child: buildWeightFormField()),
                            ),
                            SizedBox(width: getProportionateScreenHeight(4),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  width:getProportionateScreenWidth(170),
                                  child: buildHeightFormField()),
                            ),



                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(20),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              height: getProportionateScreenHeight(100),
                              child: buildInformationFormField()),
                        ),
                        SizedBox(height: getProportionateScreenHeight(20),),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 10,bottom: 10,right: 10),
                              child: Align(
                                alignment: AlignmentDirectional.bottomStart,
                                child: Container(
                                  width: getProportionateScreenWidth(160),
                                  height: getProportionateScreenHeight(60),

                                  child: OutlinedButton(onPressed: (){

                                    PushReplacment(context, viewAllmembers());

                                  },
                                    clipBehavior: Clip.hardEdge,
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        width: 2.0,
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                      ),

                                      shape:  RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10),

                                        ),
                                      ),


                                    ),

                                    child: Text('Done',style: TextStyle(color: Colors.black87),),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10,bottom: 10,left: 15),
                              child: Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: Container(
                                  width: getProportionateScreenWidth(160),
                                  height: getProportionateScreenHeight(60),
                                  child: ElevatedButton(onPressed: () async {
                                    if(EbnakCubit.get(context).memberImage==null){
                                      showToast(
                                        text: "Please Select an Image",
                                        state: ToastStates.ERROR,
                                      );

                                    } else  {

                                      await EbnakCubit.get(context).UploadMemberImage
                                        (
                                        fullName: nameController.text,
                                        Info: informationController.text,
                                        Age: dateCtl.text,
                                        weight: weightController.text,
                                        height: heightController.text,

                                      );


                                    }
                                  },
                                    child: Text('Add New Member',style: TextStyle(color: Colors.white),),
                                    clipBehavior: Clip.hardEdge,

                                    style: ElevatedButton.styleFrom(
                                      shape:RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10),

                                        ),

                                      ),
                                      primary: kPrimaryColor,


                                    ),

                                  ),
                                ),
                              ),
                            ),


                          ],
                        ),







                      ],
                    ),
                  ),
                ],
              ),
            ),
        );
      },
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
            hintText: "Enter Member Full Name",
            floatingLabelBehavior: FloatingLabelBehavior.always,

        )
    );
  }

  TextFormField buildHeightFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
        controller: heightController,
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
          labelText: "Height",
          labelStyle: TextStyle(
            color: kPrimaryColor,
          ),
          hintText: "Enter Height",
          floatingLabelBehavior: FloatingLabelBehavior.always,

        )
    );
  }

  TextFormField buildWeightFormField() {
    return TextFormField(
        keyboardType: TextInputType.number,

        controller: weightController,
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
          labelText: "Weight",
          labelStyle: TextStyle(
            color: kPrimaryColor,
          ),
          hintText: "Enter Weight",
          floatingLabelBehavior: FloatingLabelBehavior.always,

        )
    );
  }

  TextFormField buildInformationFormField() {
    return TextFormField(
        expands: true,
        keyboardType: TextInputType.text,
        maxLines: null,
        minLines: null,
        controller: informationController,
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
          labelText: "Additional Information",
          labelStyle: TextStyle(
            color: kPrimaryColor,
          ),
          hintText: "More Information... ",
          floatingLabelBehavior: FloatingLabelBehavior.always,

        )
    );
  }
}
