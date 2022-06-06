import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/reportMissing_model.dart';

class ViewAllReports extends StatelessWidget {
  const ViewAllReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Reports'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0,left: 20,right: 20,bottom: 20),
        child: ListView.separated


          (itemBuilder: (context,index)=>buildReportItem(EbnakCubit.get(context).Reports[index],context,index),
            separatorBuilder:(context,index)=> Divider(
              thickness:2,
              height: 40,
              color: Colors.grey[300],
            ), itemCount: 10,shrinkWrap: true,),
      ),

    );
  }

  ClipRRect buildReportItem(reportMissingModel model,context,index) {
    return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            child: Column(
              children: [
                Container(
                width: double.infinity,
                color: Colors.redAccent.shade200,
                height: getProportionateScreenHeight(250),
                child: CachedNetworkImage(imageUrl: '${model.reportMissingImage}',),
              ),
                Container(
                  color: Colors.redAccent.shade200,
                  width: double.infinity,
                  height: getProportionateScreenHeight(150),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(children: [
                            Text('Name : ',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                            Text('${model.fullName}',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),
                          ],),
                          Row(children: [
                            Text('Age : ',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                            Text('${model.Age}',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                          ],),
                          Row(children: [
                            Text('Reporter Name : ',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                            Text('${model.name}',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),


                          ],),
                          Row(children: [
                            Text('Date : ',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                            Text('${model.dateTime}',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),


                          ],),
                          Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
                            Text('Information : ',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                            Expanded(child: Text('${model.Information}',style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold),)),


                          ],),



                        ],
                      ),
                    ),
                  ),
                )
            ],
            ),
          ),
        );
  }
}
