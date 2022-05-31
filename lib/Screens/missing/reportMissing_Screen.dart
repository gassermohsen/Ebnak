

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../constants/constants.dart';
import '../../layout/ebnak/cubit/ebnak_cubit.dart';
import '../../shared/re_useable_components.dart';
import '../../styles/icon_broken.dart';
import 'missing_Screen.dart';

class ReportMissingScreen extends StatefulWidget {

  @override
  State<ReportMissingScreen> createState() => _ReportMissingScreenState();
}

class _ReportMissingScreenState extends State<ReportMissingScreen> {
  var nameController = TextEditingController();

  var ageController = TextEditingController();

  var addressController = TextEditingController();

  var infoController = TextEditingController();

  var  currentPos;
  var currentLat;
  var currentLong;


  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }


  void getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position pos) async {
      setState(() {
        currentPos = pos;
        currentLat = pos.latitude;
        currentLong = pos.longitude;
      });

    });
  }

  late String fullName;

  String Unkown = "unKnown";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EbnakCubit, EbnakStates>(
      listener: (context, state) {

        if(state is EbnakCreateReportSuccessState){
          showToast(text: "Report Uploaded Successfully", state: ToastStates.SUCCESS);
          navigateTo(context, missingScreen());
        }


      },
      builder: (context, state) {
        var reportMissingImage=EbnakCubit.get(context).reportMissingImage;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Missing',
            actions: [
              defaultTextButton(
                color: Colors.red,
                  text: 'Report',
                  function: (){
                    var nowTime= DateTime.now();
                    if(EbnakCubit.get(context).reportMissingImage==null){
                        showToast(
                          text: "Please Select an Image",
                          state: ToastStates.ERROR,
                        );

                } else{

                      EbnakCubit.get(context).UploadReportImage
                        (
                          dateTime: nowTime.toString(),
                          fullName: nameController.text,
                          Info: infoController.text,
                          MissingAddress: addressController.text,
                          Age: ageController.text,
                          currentLocation: GeoPoint(currentLat, currentLong));


                    }


                  }
              ),
            ],

          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 15, right: 15),
              child: Column(

                children: [
                  if(state is EbnakCreateReportLoadingState)
                    LinearProgressIndicator(
                      color: kPrimaryColor,
                      backgroundColor: Colors.white,
                    ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 10, bottom: 30),
                    child: Text(
                      "Hint ! The most important thing in this process will be the photo so please make sure to take a clear image with high quality / prefer to be the missing person only in the photo."
                      , textAlign: TextAlign.start,
                    ),
                  ),
                  Column(
                    children: [
                      buildNameFormField(),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      buildageFormField(),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      buildAddressFormField(),

                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      buildInfoFormField(),
                    ],
                  ),


                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),

                  if(EbnakCubit.get(context).reportMissingImage!=null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 300.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              image:  FileImage(reportMissingImage!) ,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          color: Colors.white,
                          icon: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20.0,
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                              color: kPrimaryColor,
                            ),
                          ),
                          onPressed: () {
                            EbnakCubit.get(context).removeReportImage();
                          },
                        ),
                      ],
                    ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),


                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              EbnakCubit.get(context).getreportMissingImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(IconBroken.Image_2, color: Colors.red,),
                                SizedBox(
                                    width: getProportionateScreenWidth(5)
                                ),
                                Text(
                                  'Add photo',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700
                                  ),
                                )
                              ],
                            )),
                      ),


                    ],
                  )

                ],
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
          if (value!.isEmpty) {
            return 'Name Can not be empty type unKnown';
          }
          return null;
        },
        decoration: InputDecoration(

            labelText: "Full Name",
            labelStyle: TextStyle(
              color: Colors.red,
            ),

            hintText: "Enter full name if exist",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(
              IconBroken.Profile,
              color: Colors.red,
            )
        )
    );
  }

  TextFormField buildageFormField() {
    return TextFormField(
        controller: ageController,
        keyboardType: TextInputType.number,
        onSaved: (newValue) => fullName = newValue!,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Age Can not be empty';
          }
          return null;
        },
        decoration: InputDecoration(

            labelText: "Age",
            labelStyle: TextStyle(
              color: Colors.red,
            ),

            hintText: "Age is about",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(
              IconBroken.Calendar,
              color: Colors.red,
            )
        )
    );
  }

  SizedBox buildInfoFormField() {
    return SizedBox(
      height: 100,
      child: TextFormField(
          expands: true,
          keyboardType: TextInputType.text,
          maxLines: null,
          minLines: null,

          controller: infoController,

          validator: (String? value) {
            if (value!.isEmpty) {
              return 'Info can not be empty';
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: "Information",
              labelStyle: TextStyle(
                color: Colors.red,
              ),
              hintText: "Additional Information",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(
                IconBroken.More_Circle,
                color: Colors.red,
              )
          )
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
        controller: addressController,
        keyboardType: TextInputType.text,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Address Can not be empty';
          }
          return null;
        },
        decoration: InputDecoration(

            labelText: "Address",
            labelStyle: TextStyle(
              color: Colors.red,
            ),

            hintText: "Enter last seen address",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(
              IconBroken.Location,
              color: Colors.red,
            )
        )
    );
  }
}