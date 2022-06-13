import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:ebnak1/models/articles_model.dart';
import 'package:ebnak1/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class  HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var color;
  var color2;



  Future<void> launchURL({
  required String modelUrl
} ) async {
    final String  url = modelUrl;
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    List <Color>Colorsx = [
      const Color(0xFFC5FFC2),
      const Color(0xFFB6CFFF),
      const Color(0xFFDDB6FF),
      const Color(0xFFFFC9C9),
      const Color(0xFFC9FFF8),
      const Color(0xFFF8FFB2),
    ];

    List <Color>Colorsx2 = [
      const Color(0xFFDDB6FF),
      const Color(0xFFFFC9C9),
      const Color(0xFFC9FFF8),
      const Color(0xFFC5FFC2),
      const Color(0xFFB6CFFF),
      const Color(0xFFF8FFB2),
    ];
     int index=0;
     int index2=0;

    return BlocConsumer<EbnakCubit, EbnakStates>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return  Scaffold(
        backgroundColor: Colors.grey[100],

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,top: 10),
                  child: Container(
                    width: getProportionateScreenWidth(175),
                    height: getProportionateScreenHeight(150),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red[300],
                    ),
                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Missing ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                        Text('21',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),


                      ],
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,top: 10),
                  child: Container(
                    width: getProportionateScreenWidth(175),
                    height: getProportionateScreenHeight(150),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kPrimaryColor.withOpacity(0.4),
                    ),
                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Adopted ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                        Text('21',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),


                      ],
                    )),
                  ),
                ),
              ],
            ),
            

            
            

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Popular Articles',style: TextStyle(color: Colors.grey[600],fontSize: 25,fontWeight: FontWeight.bold),),
            ),

            Container(
            height: getProportionateScreenHeight(380),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,

                itemBuilder: (BuildContext context, int index) {
                  return  buildArticleCard(EbnakCubit.get(context).articleModel[index],context,index);},

                separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: getProportionateScreenWidth(0),)

              , itemCount: EbnakCubit.get(context).articleModel.length,

              ),
            ),









          ],
        ),
      );
    },
    );
  }



  InkWell buildArticleCard(articlesModel model,context,index) {
    return InkWell(
      onTap: (){
        launchURL(modelUrl: '${model.articleUrl}');
      },
      child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                width: getProportionateScreenWidth(250),

                child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                children: [
                ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                height: getProportionateScreenHeight(180),
                child: Padding(
                padding:  EdgeInsets.all(10.0),
                                child: CachedNetworkImage(
                                alignment: Alignment.topRight,

                                imageUrl:'${model.articleImage}',
                                fit: BoxFit.contain,
                                ),
                                ),
                                ),
                                ),
                                Padding(
                                padding: const EdgeInsets.only(left: 10.0,right: 8),
                                child: Text('${model.articleFeed}',style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,

                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                ),
                                ),
                                SizedBox(height: getProportionateScreenHeight(25),),
                                Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(

                                children: [
                                Column(
                                children: [
                                Text('Source : ${model.sourceName}',textAlign: TextAlign.start,style: TextStyle(color: Colors.grey[400],fontSize: 14),),
                                Text(' ${model.articleDate}',textAlign: TextAlign.start,style: TextStyle(color: Colors.grey[400],fontSize: 14,)),
                                ],
                                ),
                                SizedBox(
                                width: getProportionateScreenWidth(35),
                                ),
                                Ink(
                                decoration: ShapeDecoration(
                                color: kPrimaryColor.withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                                ),
                                ),
                                child: IconButton(onPressed: (){
                                  launchURL(modelUrl: '${model.articleUrl}');

                                },
                                highlightColor: Colors.grey,
                                focusColor: Colors.grey,
                                iconSize: 25,
                                icon: Icon(Icons.open_in_new),color: kPrimaryColor,),
                                ),

                                ],
                                ),
                                ),
                                SizedBox(height: getProportionateScreenHeight(10),),

                                ],
                                ),
                                ),
                                ),),
    );
  }
}
