import 'package:ebnak1/Screens/missing/recognizePerson_Screen.dart';
import 'package:ebnak1/Screens/missing/reportMissing_Screen.dart';
import 'package:ebnak1/Screens/missing/reportMyChildren_Screen.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:ebnak1/shared/re_useable_components.dart';
import 'package:ebnak1/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/ebnak/cubit/ebnak_cubit.dart';
import 'allreportsOnMaps_Screen.dart';

class missingScreen extends StatelessWidget {
  const missingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocConsumer<EbnakCubit, EbnakStates>(
      listener: (context, state) {
        if(state is EbnakGetUserMembersSuccessState){
          navigateTo(context, reportMyChildrenScreen());

        }
        if(state is EbnakGetUserMembersErrorState){
          showToast(text: 'Sorry No Children Information Found', state: ToastStates.ERROR);
        }

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        navigateTo(context, ReportMissingScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),

                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.grey.shade100
                              ),
                              color: Colors.white,
                            ),
                            height: getProportionateScreenHeight(250),
                            width: getProportionateScreenWidth(165),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconBroken.Danger,
                                  color: Colors.red,
                                  size: 60,

                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(3),
                                ),
                                Text('Report Missing',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black54
                                  ),
                                )
                              ],
                            ),

                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, RecognizePersonScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 12),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),

                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.grey.shade100
                              ),
                              color: Colors.white,
                            ),
                            height: getProportionateScreenHeight(250),
                            width: getProportionateScreenWidth(165),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconBroken.Shield_Done,
                                  color: Colors.cyanAccent.shade400,
                                  size: 60,

                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(3),
                                ),
                                Text('Recognize Person',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black54
                                  ),
                                )
                              ],
                            ),

                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(25),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        navigateTo(context, AllReportsOnMapsScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),

                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.grey.shade100
                              ),
                              color: Colors.white,
                            ),
                            height: getProportionateScreenHeight(250),
                            width: getProportionateScreenWidth(165),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconBroken.Document,
                                  color: Colors.green.shade200,
                                  size: 60,

                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(3),
                                ),
                                Text('All Reports',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black54
                                  ),
                                )
                              ],
                            ),

                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        EbnakCubit.get(context).getuserMembersForReport();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 12),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),

                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.grey.shade100
                              ),
                              color: Colors.white,
                            ),
                            height: getProportionateScreenHeight(250),
                            width: getProportionateScreenWidth(165),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconBroken.User,
                                  color: Colors.amber.shade200,
                                  size: 60,

                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(3),
                                ),
                                Text('Report My Children',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54
                                  ),
                                )
                              ],
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

        );
      },
    );
  }
}
