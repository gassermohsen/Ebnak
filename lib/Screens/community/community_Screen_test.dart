import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:ebnak1/models/comment_model.dart';
import 'package:ebnak1/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/post_model.dart';
import '../../shared/re_useable_components.dart';
import '../new_post/new_post_screen.dart';

class communityScreentest extends StatelessWidget {
  TextEditingController commentController = TextEditingController();
  final controller=CarouselController();

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);


    return BlocConsumer<EbnakCubit, EbnakStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          floatingActionButton: SizedBox(
            width: getProportionateScreenWidth(55),
            height: getProportionateScreenHeight(60),
            child: FloatingActionButton(
              elevation: 10,
              enableFeedback: true,
              onPressed: () {
                navigateTo(
                  context,
                  NewPostScreen(),
                );
              },
              backgroundColor: kPrimaryColor,
              child: Icon(IconBroken.Edit_Square, size: 27,),


            ),
          ),
          body: ConditionalBuilder(
            condition: EbnakCubit
                .get(context)
                .posts
                .length >= 0 && EbnakCubit
                .get(context)
                .userModel != null,
            builder: (context) =>
                SingleChildScrollView(

                  physics: BouncingScrollPhysics(),
                  child: Column(


                    children: [


                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10.0,
                        margin: EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [

                            SizedBox(
                              width: double.infinity,

                              child: CarouselSlider(
                                    carouselController: controller,
                                options: CarouselOptions(
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  viewportFraction: 1,



                                ),
                                items :[
                                  Stack(
                                  alignment:Alignment.center,
                                  children:[
                                    Image(
                                    image: NetworkImage(
                                        'https://img.freepik.com/free-photo/diverse-hands-touching-white-paper_53876-98411.jpg?t=st=1649852964~exp=1649853564~hmac=bb082dc5ec8330732421c84e5dc2c7048874a02424686f62c3008f5e55eee81b&w=1380'
                                    ),

                                    fit: BoxFit.contain,
                                    height: getProportionateScreenHeight(200),
                                  ),
                                    Center(
                                      child: Text(
                                        'Share your thoughts and advice ',

                                      ),
                                    ),
                        ]
                                ),
                                  Image(
                                    image: NetworkImage(
                                        'https://img.freepik.com/free-photo/children-enjoying-ice-cream-summer-day_53876-146554.jpg?w=996&t=st=1653487810~exp=1653488410~hmac=9dde4506b4514dec35b81ca8c353bb8cd44ed17baea54cd61249f4ed1eb75891'
                                    ),

                                    fit: BoxFit.cover,
                                    height: getProportionateScreenHeight(200),
                                  ),
                                  Image(
                                    image: NetworkImage(
                                        'https://img.freepik.com/free-photo/diverse-hands-united-business-teamwork-gesture_53876-129428.jpg?w=1060&t=st=1653487779~exp=1653488379~hmac=94e724adc08a9581195cb86bcc5d4ce4637a737869be4ac73eea3c2eaf75ceba'
                                    ),

                                    fit: BoxFit.cover,
                                    height: getProportionateScreenHeight(200),
                                  ),
                                  Image(
                                    image: NetworkImage(
                                        'https://img.freepik.com/free-photo/little-kids-cheering-while-holding-white-board_53876-97648.jpg?t=st=1653489859~exp=1653490459~hmac=af0eeae2a3cb90d4926aad98069eb5b031cb6f06a4f7e9812f43edad666df280&w=1060'
                                    ),

                                    fit: BoxFit.cover,
                                    height: getProportionateScreenHeight(200),
                                  ),


                                ]
                              ),
                            ),


                          ],
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                        child: Theme(
                          data: ThemeData(

                            inputDecorationTheme: InputDecorationTheme(
                              border: InputBorder.none,

                            ),
                          ),
                          child: Container(

                            width: getProportionateScreenWidth(500),
                            height: getProportionateScreenHeight(60),
                            child: TextFormField(
                                onTap: (){
                                  navigateTo(
                                    context,
                                    NewPostScreen(),
                                  );
                                },

                              controller:commentController,

                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2,color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder:  OutlineInputBorder(
                                  borderSide: BorderSide(width: 2,color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(20),

                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2,color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(20),

                                ),
                                focusColor: kPrimaryColor,
                                fillColor: Colors.white,
                                filled: true,

                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 15.0,left: 15),
                                  child: CircleAvatar(

                                    backgroundImage: NetworkImage('${EbnakCubit.get(context).userModel?.image}'),
                                    radius: 20,
                                  ),
                                ),

                                hintText: 'Any advice to share.. ?!',
                                hintStyle: TextStyle(color: Colors.black87),

                              ),

                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: getProportionateScreenHeight(20),),
                      StreamBuilder<QuerySnapshot>(
                          stream: EbnakCubit.get(context).trytogetPosts(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              // snapshot.data!.docs.forEach((element)  {
                              //   EbnakCubit.get(context).Likes= [];
                              //
                              //   element.reference.collection('likes').snapshots().listen((event)  {
                              //
                              //     EbnakCubit.get(context).Likes.add(event.docs.length);
                              //   });
                              //   EbnakCubit.get(context).PostsIds.add(element.id);
                              // });


                              EbnakCubit
                                  .get(context)
                                  .posts = [];
                              EbnakCubit
                                  .get(context)
                                  .PostsIds = [];

                              for (int i = 0; i <
                                  snapshot.data!.docs.length; i++) {
                                EbnakCubit
                                    .get(context)
                                    .posts
                                    .add(PostModel.fromSnapShot(
                                    snapshot.data!.docs![i]));
                                snapshot.data!.docs.forEach((element) {
                                  EbnakCubit
                                      .get(context)
                                      .PostsIds
                                      .add(element.id);
                                });
                              }
                            }
                            print(snapshot.connectionState);

                            return ListView.separated(
                              itemBuilder: (context, index) =>
                                  buildPostItem(EbnakCubit
                                      .get(context)
                                      .posts[index], EbnakCubit
                                      .get(context)
                                      .PostsIds[index], context, index),
                              itemCount: EbnakCubit
                                  .get(context)
                                  .posts
                                  .length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  SizedBox(
                                    height: getProportionateScreenHeight(8),
                                  ),

                            );
                          }
                      ),
                      SizedBox(
                        height: 55.0,
                      ),


                    ],

                  ),

                ),
            fallback: (context) =>
                Center(child:

                CircularProgressIndicator(
                  color: kPrimaryColor,
                )),

          ),

        );
      },
    );
  }


  Widget buildPostItem(PostModel model, String postId, context, index) =>
      Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5.0,
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage:
                      NetworkImage('${model.image}'),

                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(15),
                    ),
                    Expanded(

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(

                            children: [
                              Text(
                                '${model.name}',
                                style: TextStyle(
                                    height: 1.35,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(5),
                              ),
                              Icon(
                                Icons.check_circle,
                                color: kPrimaryColor,
                                size: 16,
                              )
                            ],
                          ),
                          Text(
                            '${model.dateTime}',
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                              height: 1.35,

                            ),)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(15),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(
                      Icons.more_horiz,
                      size: 16,
                    ))

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(1),
                    color: Colors.grey[300],
                  ),
                ),
                Text("${model.text}",
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle1
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: Container(
                    width: double.infinity,
                    child: Wrap(
                      children: [
                        Container(
                          height: getProportionateScreenHeight(20),
                          child: MaterialButton(onPressed: () {},
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            child: Text(
                              '#mom',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                  color: kPrimaryColor
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: getProportionateScreenHeight(20),
                          child: MaterialButton(onPressed: () {},
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            child: Text(
                              '#mom',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                  color: kPrimaryColor
                              ),
                            ),
                          ),
                        ),


                      ],

                    ),
                  ),
                ),
                if(model.postImage != '')
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        top: 15.0
                    ),
                    child: Container(
                      height: getProportionateScreenHeight(250),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: NetworkImage(
                              '${model.postImage}'
                          ),
                          fit: BoxFit.cover,

                        ),
                      ),

                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: InkWell(
                            child: Row(

                              children: [
                                Icon(
                                  IconBroken.Heart,
                                  size: 17.0,
                                  color: Colors.red[400],
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(5),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('posts')
                                        .doc(EbnakCubit
                                        .get(context)
                                        .PostsIds[index])
                                        .collection('likes')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text('0');
                                      }
                                      return Text(
                                        snapshot.data!.docs.length.toString(),
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .caption,
                                      );
                                    }
                                )

                              ],
                            ),
                            onTap: () {

                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,

                              children: [
                                Icon(
                                  IconBroken.Chat,
                                  size: 17.0,
                                  color: Colors.amber,
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(5),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('posts')
                                        .doc(EbnakCubit
                                        .get(context)
                                        .PostsIds[index])
                                        .collection('comments')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text('0');
                                      }
                                      return Text(
                                          ('${snapshot.data!.docs.length.toString()} Comments'),
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .caption,
                                      );
                                    }
                                )


                              ],
                            ),
                          ),
                          onTap: () {
                            commentController.clear();

                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                                ),
                                backgroundColor: Colors.white,
                                isScrollControlled: true,
                                context: context,
                                builder: (context){
                                  return Container(
                                    height: MediaQuery.of(context).size.height * 0.75,
                                    child: Stack(
                                      children: [
                                        SingleChildScrollView(
                                          child:
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 80),
                                                child: Divider(
                                                  thickness: 3,
                                                  color: kPrimaryColor,
                                                ),
                                              ),
                                              Text('Comments',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey[500],fontStyle: FontStyle.italic),),
                                              SizedBox(
                                                height: getProportionateScreenHeight(30),
                                              ),
                                              StreamBuilder<QuerySnapshot>(
                                                  stream: FirebaseFirestore.instance
                                                      .collection('posts')
                                                      .doc(EbnakCubit
                                                      .get(context)
                                                      .PostsIds[index])
                                                      .collection('comments')
                                                      .orderBy('time')
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if(snapshot.hasData){
                                                      EbnakCubit
                                                          .get(context)
                                                          .commentmodel = [];
                                                      for (int i = 0; i <
                                                          snapshot.data!.docs.length; i++) {
                                                        EbnakCubit
                                                            .get(context)
                                                            .commentmodel
                                                            .add(commentModel.fromSnapShot(
                                                            snapshot.data!.docs![i]));
                                                      }
                                                      print(EbnakCubit.get(context).commentmodel.length);
                                                    }

                                                    return ListView.separated(
                                                      itemBuilder: (context, index) =>
                                                          buildCommentColumn(EbnakCubit
                                                              .get(context)
                                                              .commentmodel[index], EbnakCubit
                                                              .get(context)
                                                              .PostsIds[index], context, index),
                                                      itemCount: EbnakCubit
                                                          .get(context)
                                                          .commentmodel
                                                          .length,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      separatorBuilder: (context, index) =>
                                                          SizedBox(
                                                            height: getProportionateScreenHeight(8),
                                                          ),

                                                    );
                                                  }
                                              ),
                                              SizedBox(height: getProportionateScreenHeight(80),),

                                            ],

                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(top: 20),
                                          child: Container(

                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

                                              child: Theme(
                                                data: ThemeData(
                                                  inputDecorationTheme: InputDecorationTheme(
                                                    border: InputBorder.none,

                                                  ),
                                                ),
                                                child: TextFormField(
                                                  controller:commentController,

                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(width: 1,color: Colors.grey.shade200),
                                                    ),
                                                    focusedBorder:  OutlineInputBorder(
                                                      borderSide: BorderSide(width: 1,color: Colors.grey.shade200),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(width: 1,color: Colors.grey.shade200),
                                                    ),
                                                    focusColor: kPrimaryColor,
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    prefixIcon: Padding(
                                                      padding: const EdgeInsets.only(right: 8.0),
                                                      child: CircleAvatar(

                                                        backgroundImage: NetworkImage('${EbnakCubit.get(context).userModel?.image}'),
                                                        radius: 5,
                                                      ),
                                                    ),
                                                    suffixIcon: IconButton(

                                                      icon:Icon(IconBroken.Send,color:kPrimaryColor,),
                                                      onPressed: () {
                                                        var nowTime= DateTime.now();
                                                        EbnakCubit.get(context).CommentPost(postId:EbnakCubit.get(context).PostsIds[index],comment: commentController.text,time:nowTime.toString(),      );
                                                        commentController.clear();
                                                      },
                                                      color: kPrimaryColor,


                                                    ),
                                                    hintText: 'Write a comment...',

                                                  ),

                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  );








                                });
                          },
                        ),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(1),
                    color: Colors.grey[300],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 18.0,
                                backgroundImage:
                                NetworkImage('${EbnakCubit
                                    .get(context)
                                    .userModel
                                    ?.image}')

                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(15),
                            ),
                            Text(
                              'Write a comment...',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                height: 1.35,

                              ),),

                          ],
                        ),
                        onTap: () {
                          commentController.clear();

                          showModalBottomSheet(
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                             ),
                               backgroundColor: Colors.white,
                               isScrollControlled: true,
                               context: context,
                               builder: (context){
                                 return Container(
                                   height: MediaQuery.of(context).size.height * 0.75,
                                   child: Stack(
                                             children: [
                                               SingleChildScrollView(
                                                 child:
                                                     Column(
                                                       children: [
                                                       Padding(
                                                         padding: const EdgeInsets.symmetric(horizontal: 80),
                                                         child: Divider(
                                                           thickness: 3,
                                                           color: kPrimaryColor,
                                                         ),
                                                       ),
                                                       Text('Comments',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey[500],fontStyle: FontStyle.italic),),
                                                        SizedBox(
                                                          height: getProportionateScreenHeight(30),
                                                        ),
                                                       StreamBuilder<QuerySnapshot>(
                                                         stream: FirebaseFirestore.instance
                                                             .collection('posts')
                                                             .doc(EbnakCubit
                                                             .get(context)
                                                             .PostsIds[index])
                                                             .collection('comments')
                                                              .orderBy('time')
                                                             .snapshots(),
                                                         builder: (context, snapshot) {
                                                           EbnakCubit
                                                               .get(context)
                                                               .commentmodel = [];
                                                           if(snapshot.connectionState==ConnectionState.waiting){
                                                             return Center(child: Text('Loading'));
                                                           }
                                                           if(snapshot.hasData){

                                                          for (int i = 0; i <
                                                          snapshot.data!.docs.length; i++) {
                                                            EbnakCubit
                                                                .get(context)
                                                                .commentmodel
                                                                .add(commentModel.fromSnapShot(
                                                                snapshot.data!.docs![i]));
                                                          }
                                                          print(EbnakCubit.get(context).commentmodel.length);
                                                           }

                                                           return ListView.separated(
                                                             itemBuilder: (context, index) =>
                                                                 buildCommentColumn(EbnakCubit
                                                                     .get(context)
                                                                     .commentmodel[index], EbnakCubit
                                                                     .get(context)
                                                                     .PostsIds[index], context, index),
                                                             itemCount: EbnakCubit
                                                                 .get(context)
                                                                 .commentmodel
                                                                 .length,
                                                             physics: NeverScrollableScrollPhysics(),
                                                             shrinkWrap: true,
                                                             separatorBuilder: (context, index) =>
                                                                 SizedBox(
                                                                   height: getProportionateScreenHeight(8),
                                                                 ),

                                                           );
                                                         }
                                                       ),
                                                        SizedBox(height: getProportionateScreenHeight(80),),

                                                     ],

                                                     ),
                                               ),

                                               Padding(
                                                 padding: const EdgeInsets.only(top: 20),
                                                 child: Container(

                                                   alignment: Alignment.bottomCenter,
                                                   child: Padding(
                                                     padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

                                                     child: Theme(
                                                       data: ThemeData(
                                                         inputDecorationTheme: InputDecorationTheme(
                                                           border: InputBorder.none,

                                                         ),
                                                       ),
                                                       child: TextFormField(
                                                         controller:commentController,

                                                         decoration: InputDecoration(
                                                           border: OutlineInputBorder(
                                                             borderSide: BorderSide(width: 1,color: Colors.grey.shade200),
                                                           ),
                                                           focusedBorder:  OutlineInputBorder(
                                                               borderSide: BorderSide(width: 1,color: Colors.grey.shade200),
                                                               ),
                                                           enabledBorder: OutlineInputBorder(
                                                               borderSide: BorderSide(width: 1,color: Colors.grey.shade200),
                                                           ),
                                                           focusColor: kPrimaryColor,
                                                           fillColor: Colors.white,
                                                           filled: true,
                                                           prefixIcon: Padding(
                                                             padding: const EdgeInsets.only(right: 8.0),
                                                             child: CircleAvatar(

                                                               backgroundImage: NetworkImage('${EbnakCubit.get(context).userModel?.image}'),
                                                               radius: 5,
                                                             ),
                                                           ),
                                                           suffixIcon: IconButton(

                                                             icon:Icon(IconBroken.Send,color:kPrimaryColor,),
                                                             onPressed: () {
                                                               var nowTime= DateTime.now();
                                                               EbnakCubit.get(context).CommentPost(postId:EbnakCubit.get(context).PostsIds[index],comment: commentController.text,time:nowTime.toString(),      );
                                                                commentController.clear();
                                                             },
                                                             color: kPrimaryColor,


                                                           ),
                                                           hintText: 'Write a comment...',

                                                         ),

                                                       ),
                                                     ),
                                                   ),
                                                 ),
                                               ),

                                             ],
                                           ),
                                 );








                               });
                        },
                      ),
                    ),
                    InkWell(
                      child: Row(

                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 17.0,
                            color: Colors.red[400],
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(5),
                          ),
                          Text(
                            'Like',
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption,
                          )

                        ],
                      ),
                      onTap: () {
                        print(EbnakCubit
                            .get(context)
                            .posts
                            .length);

                        print(index);
                        EbnakCubit.get(context).likePost(EbnakCubit
                            .get(context)
                            .PostsIds[index]);
                      },
                    ),
                  ],
                )
              ],

            ),
          )
      );

  Column buildCommentColumn(commentModel model, String postId, context, index) {
                                      return Column(
                                         crossAxisAlignment: CrossAxisAlignment.end,
                                         children: [
                                           Row(
                                             children: [
                                               Padding(
                                                 padding: const EdgeInsets.only(left: 10.0),
                                                 child: CircleAvatar(
                                                   backgroundImage: NetworkImage('${model.userImage}'),
                                                   radius: 25,
                                                 ),
                                               ),
                                               SizedBox(width: getProportionateScreenWidth(10),),
                                               Flexible(
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(right: 20),
                                                   child: Container(

                                                     child: Padding(
                                                       padding: const EdgeInsets.all(15.0),
                                                       child: Column(

                                                         children: [
                                                           Text('${model.name}',style: TextStyle(
                                                             fontStyle: FontStyle.normal,
                                                             fontWeight: FontWeight.bold,
                                                             fontSize: 14,
                                                             color: Colors.black
                                                           ),),
                                                           Text('${model.comment}',style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w300,color: Colors.black),),

                                                         ],
                                                         mainAxisAlignment: MainAxisAlignment.start,
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                       ),
                                                     ),
                                                     decoration: BoxDecoration(
                                                       color: Colors.grey[100],

                                                       borderRadius: BorderRadius.circular(20),
                                                     ),
                                                   ),
                                                 ),
                                               ),

                                             ],
                                           ),

                                         ],
                                       );
  }





}

