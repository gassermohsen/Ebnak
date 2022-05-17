import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebnak1/Screens/adopt/child_details_screen.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:ebnak1/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/re_useable_components.dart';

class adoptionScreen extends StatelessWidget {

  List <Color>Colorsx = [
    const Color(0xFFC5FFC2),
    const Color(0xFFB6CFFF),
    const Color(0xFFDDB6FF),
    const Color(0xFFFFC9C9),
    const Color(0xFFC9FFF8),
    const Color(0xFFF8FFB2),
  ];


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);


    return Scaffold(
      appBar: AppBar(
        title: Center(child: Column(
          children: [
            Text('Location',
              style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 15
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(IconBroken.Location, size: 20, color: Colors.black54,),
                SizedBox(
                  width: getProportionateScreenWidth(3),
                ),
                Text('Shiekh Zayed City',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20
                  ),),
              ],
            ),


          ],
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            child: Container(
              color: Color(0xFFF9F9F9),
              child: Column(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Theme(
                      data: ThemeData(
                        inputDecorationTheme: InputDecorationTheme(
                          border: InputBorder.none,

                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            focusColor: kPrimaryColor,
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(IconBroken.Search,
                              color: kPrimaryColor,),
                            hintText: 'Search for children...',

                          ),

                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),

                  ),

                  InkWell(
                    onTap: (){
                      navigateTo(
                        context,
                        ChildDetailsScreen(),
                      );
                    },
                    child: ListView.separated(

                        itemBuilder: (context, index) =>
                            buildChildItem(context, index),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),


                        separatorBuilder: (context, index) =>
                            SizedBox(
                              height: getProportionateScreenHeight(40),
                            ),

                        itemCount: 5),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  )

                ],
              ),

            ),
          ),
        ),
      ),
    );
  }


  Widget buildChildItem(context, index) =>
       Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: getProportionateScreenHeight(180),
                  width: getProportionateScreenWidth(180),
                  color:Colorsx[index],
                  child:  CachedNetworkImage(
                      imageUrl: 'https://img.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984798.jpg?t=st=1650335074~exp=1650335674~hmac=3add018ebccc190007e113bdbff927e96c6e8cf0356e65288aad1eb3da74945b&w=1380',),
                  
                ),

              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Container(
                    height: getProportionateScreenHeight(150),
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text('Gasser',

                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,


                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 45, top: 5),
                              child: Icon(
                                Icons.male,
                                color: Colors.grey[400],
                                size: 30,

                              ),
                            ),

                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 5),
                          child: Row(
                            children: [
                              Text('Footballer',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(5),),
                        Padding(
                          padding: const EdgeInsets.only(left: 16,),
                          child: Row(
                            children: [
                              Text('4 years old',
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 11
                                ),),
                            ],
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(5),),
                        Padding(
                          padding: const EdgeInsets.only(left: 6, top: 7),
                          child: Row(
                            children: [

                              Icon(
                                IconBroken.Location,
                                size: 17,
                                color: Colors.grey[500],
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(2),

                              ),
                              Text('Orghange : Dar el atfal ',
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 11
                                ),),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ),


            ],
          ),
        );
}