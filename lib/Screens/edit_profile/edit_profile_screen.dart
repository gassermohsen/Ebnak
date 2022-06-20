
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/components/default_Button.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:ebnak1/shared/re_useable_components.dart';
import 'package:ebnak1/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../layout/ebnak/ebnak_layout.dart';
import '../user_Children/add_Member_Screen.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();


  late String fullName;



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EbnakCubit, EbnakStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = EbnakCubit
            .get(context)
            .userModel;
        var profileImage=EbnakCubit.get(context).profileImage;
        nameController.text=userModel!.name;
        phoneController.text=userModel!.phone;
        addressController.text=userModel!.address;
        bioController.text=userModel!.bio!;



        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                defaultTextButton(
                  text: 'Update',
                  function: () {
                    EbnakCubit.get(context).updateUser
                      (name: nameController.text,
                        address: addressController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                ),
                SizedBox(
                  width: getProportionateScreenWidth(15),
                ),
              ]
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    if(state is EbnakUserUpdateLoadingState)
                    LinearProgressIndicator(
                      color: kPrimaryColor,
                      backgroundColor: Colors.white,
                    ),
                    if(state is EbnakUserUpdateLoadingState)
                      SizedBox(height: getProportionateScreenHeight(10),),
                    Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,

                                radius: 75,
                                backgroundImage: profileImage ==null ? NetworkImage(
                                    '${userModel?.image}'
                                ) : FileImage(profileImage) as ImageProvider,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                EbnakCubit.get(context).getProfileImage();
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

                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    if(EbnakCubit.get(context).profileImage!=null)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: getProportionateScreenWidth(170),
                          height: getProportionateScreenHeight(50),
                          child: OutlinedButton(

                            onPressed: () {
                              EbnakCubit.get(context).uploadProfileImage(
                                  name: nameController.text,
                                  address: addressController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text);
                            },
                            clipBehavior: Clip.hardEdge,
                            child: Text(
                              'Upload Profile',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold
                              ),
                            ),

                          ),

                        ),
                        // SizedBox(
                        //   height: getProportionateScreenHeight(4),
                        // ),
                        // LinearProgressIndicator(
                        //   color: kPrimaryColor,
                        //   backgroundColor: Colors.white,
                        //
                        // ),


                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),



                    buildNameFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    buildAddressFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    buildPhoneFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    buildBioFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),

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

                                navigateAndFinish(context, EbnakLayout());

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

                                child: Text('Update Family ',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
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
                                PushReplacment(context, AddmemberScreen());

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
            ),
          ),
        );
      },
    );
  }


  TextFormField buildNameFormField() {
    return TextFormField(
        controller: nameController,
        keyboardType: TextInputType.name,
        onSaved: (newValue) => fullName = newValue!,
        validator: (String? value) {
          if(value!.isEmpty){
            return'Name Can not be empty';
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
              IconBroken.Profile,
              color: kPrimaryColor,
            )
        )
    );
  }
  TextFormField buildBioFormField() {

    return TextFormField(
        keyboardType: TextInputType.text,

        controller: bioController,

        validator: (String? value) {
          if(value!.isEmpty){
            return'Bio can not be empty';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Bio",
            labelStyle: TextStyle(
              color: kPrimaryColor,
            ),
            hintText: "Enter your Bio",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(
              IconBroken.Info_Circle,
              color: kPrimaryColor,
            )
        )
    );
  }

  TextFormField buildPhoneFormField() {

    return TextFormField(
        keyboardType: TextInputType.phone,

        controller: phoneController,

        validator: (String? value) {
          if(value!.isEmpty){
            return'Phone Number can not be empty';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Phone Number",
            labelStyle: TextStyle(
              color: kPrimaryColor,
            ),
            hintText: "Enter your Phone",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(
              IconBroken.Call,
              color: kPrimaryColor,
            )
        )
    );
  }

  TextFormField buildAddressFormField() {

    return TextFormField(
        keyboardType: TextInputType.text,

        controller: addressController,

        validator: (String? value) {
          if(value!.isEmpty){
            return'Address can not be empty';
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
              IconBroken.Location,
              color: kPrimaryColor,
            )
        )
    );
  }


}