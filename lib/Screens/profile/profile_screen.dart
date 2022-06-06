import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ebnak1/Screens/edit_profile/edit_profile_screen.dart';
import 'package:ebnak1/Screens/profile/UpdateOrRemoveUserPost_Screen.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:ebnak1/shared/re_useable_components.dart';
import 'package:ebnak1/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/default_Button.dart';
import '../../models/comment_model.dart';
import '../../models/post_model.dart';

class profileScreen extends StatelessWidget {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<EbnakCubit, EbnakStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = EbnakCubit
            .get(context)
            .userModel;
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.grey[300],
            body: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: getProportionateScreenHeight(350),
                  width: double.infinity,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 75,
                        backgroundImage: NetworkImage(
                            '${userModel?.image}'
                        ),
                      ),
                      Text(
                        '${userModel?.name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 21
                        ),
                      ),
                      Text(
                        '${userModel?.bio}',
                        style: TextStyle(
                            color: Colors.grey[400]
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(

                            style: ElevatedButton.styleFrom(
                              elevation: 5,

                              shape:
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),

                              primary: kPrimaryColor,
                              fixedSize: Size(160, 40),
                            ),
                            onPressed: () {
                              navigateTo(context, EditProfileScreen());
                            },


                            child: Text(
                              'Edit Profile',
                              style: TextStyle(color: Colors.white),),


                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(5),
                          ),
                          TextButton(


                            style: TextButton.styleFrom(
                              elevation: 2,
                              backgroundColor: Colors.grey[200],
                              fixedSize: Size(6, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),

                              ),

                            ),

                            onPressed: () {},
                            child: Icon(IconBroken.Message,
                              color: Colors.grey[400],

                            ),


                          ),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),


                      TabBar(

                        enableFeedback: true,
                        indicatorColor: kPrimaryColor,
                        labelColor: Colors.grey,
                        tabs: [
                          Tab(
                            text: 'Posts',
                            icon: Icon(IconBroken.Category,
                              color: Colors.grey,),
                          ),
                          Tab(
                            text: 'My Reports',
                            icon: Icon(IconBroken.Danger,
                              color: Colors.grey,),
                          ),
                          Tab(
                            text: 'About',
                            icon: Icon(IconBroken.Profile,
                              color: Colors.grey,),
                          ),
                        ],

                      ),
                    ],
                  ),

                ),
                Expanded(
                  child: Container(
                    child: TabBarView(
                        children: [
                          ConditionalBuilder(
                            condition: EbnakCubit
                                .get(context)
                                .posts
                                .length >= 0 && EbnakCubit
                                .get(context)
                                .userModel != null,
                            builder: (context) =>
                                SingleChildScrollView(
                                  child: Column(


                                    children: [

                                      SizedBox(height: getProportionateScreenHeight(20),),
                                      StreamBuilder<QuerySnapshot>(
                                          stream: EbnakCubit.get(context).trytogetUserPosts(),
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
                                                  .Userposts = [];
                                              EbnakCubit
                                                  .get(context)
                                                  .UserPostsIds = [];

                                              for (int i = 0; i <
                                                  snapshot.data!.docs.length; i++) {
                                                EbnakCubit
                                                    .get(context)
                                                    .Userposts
                                                    .add(PostModel.fromSnapShot(
                                                    snapshot.data!.docs![i]));
                                                snapshot.data!.docs.forEach((element) {
                                                  EbnakCubit
                                                      .get(context)
                                                      .UserPostsIds
                                                      .add(element.id);
                                                });
                                              }
                                            }
                                            print(snapshot.connectionState);

                                            return ListView.separated(

                                              itemBuilder: (context, index) =>
                                                  buildPostItem(EbnakCubit
                                                      .get(context)
                                                      .Userposts[index], EbnakCubit
                                                      .get(context)
                                                      .UserPostsIds[index], context, index),
                                              itemCount: EbnakCubit
                                                  .get(context)
                                                  .Userposts
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
                                      SizedBox(height: getProportionateScreenHeight(20),),



                                    ],

                                  ),
                                ),
                            fallback: (context) =>
                                Center(child:

                                CircularProgressIndicator(
                                  color: kPrimaryColor,
                                )),

                          ),
                          Text('Reports'),
                          Text('About'),
                        ]),
                  ),
                )
              ],
            ),

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
                    PopupMenuButton(
                      onSelected: (result) {
                        if (result == 1) {
                          navigateTo(context, UpdateOrremoveUserPostScreen(EbnakCubit.get(context).Userposts[index]));
                        }
                      },
                         icon: Icon(
                      Icons.more_horiz,
                      size: 16,
                    ),
                      itemBuilder: (BuildContext context) => [
                      PopupMenuItem(child: Text('Update/Remove Post'),value: 1,

                        onTap: (){
                        },

                      )
                    ],)

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
                                        .UserPostsIds[index])

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
                                        .UserPostsIds[index])
                                        .collection('comments')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text('0');
                                      }
                                      return Text(
                                        ('${snapshot.data!.docs.length
                                            .toString()} Comments'),
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
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25)),
                                ),
                                backgroundColor: Colors.white,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.75,
                                    child: Stack(
                                      children: [
                                        SingleChildScrollView(
                                          child:
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(horizontal: 80),
                                                child: Divider(
                                                  thickness: 3,
                                                  color: kPrimaryColor,
                                                ),
                                              ),
                                              Text('Comments', style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[500],
                                                  fontStyle: FontStyle
                                                      .italic),),
                                              SizedBox(
                                                height: getProportionateScreenHeight(
                                                    30),
                                              ),
                                              StreamBuilder<QuerySnapshot>(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection('posts')
                                                      .doc(EbnakCubit
                                                      .get(context)
                                                      .UserPostsIds[index])
                                                      .collection('comments')
                                                      .orderBy('time')
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      EbnakCubit
                                                          .get(context)
                                                          .Usercommentmodel = [];
                                                      for (int i = 0; i <
                                                          snapshot.data!.docs
                                                              .length; i++) {
                                                        EbnakCubit
                                                            .get(context)
                                                            .Usercommentmodel
                                                            .add(commentModel
                                                            .fromSnapShot(
                                                            snapshot.data!
                                                                .docs![i]));
                                                      }
                                                      print(EbnakCubit
                                                          .get(context)
                                                          .Usercommentmodel
                                                          .length);
                                                    }

                                                    return ListView.separated(
                                                      itemBuilder: (context,
                                                          index) =>
                                                          buildCommentColumn(
                                                              EbnakCubit
                                                                  .get(context)
                                                                  .Usercommentmodel[index],
                                                              EbnakCubit
                                                                  .get(context)
                                                                  .UserPostsIds[index],
                                                              context, index),
                                                      itemCount: EbnakCubit
                                                          .get(context)
                                                          .Usercommentmodel
                                                          .length,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      separatorBuilder: (
                                                          context, index) =>
                                                          SizedBox(
                                                            height: getProportionateScreenHeight(
                                                                8),
                                                          ),

                                                    );
                                                  }
                                              ),
                                              SizedBox(
                                                height: getProportionateScreenHeight(
                                                    80),),

                                            ],

                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20),
                                          child: Container(

                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery
                                                      .of(context)
                                                      .viewInsets
                                                      .bottom),

                                              child: Theme(
                                                data: ThemeData(
                                                  inputDecorationTheme: InputDecorationTheme(
                                                    border: InputBorder.none,

                                                  ),
                                                ),
                                                child: TextFormField(
                                                  controller: commentController,

                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.grey
                                                              .shade200),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.grey
                                                              .shade200),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.grey
                                                              .shade200),
                                                    ),
                                                    focusColor: kPrimaryColor,
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    prefixIcon: Padding(
                                                      padding: const EdgeInsets
                                                          .only(right: 8.0),
                                                      child: CircleAvatar(

                                                        backgroundImage: NetworkImage(
                                                            '${EbnakCubit
                                                                .get(context)
                                                                .userModel
                                                                ?.image}'),
                                                        radius: 5,
                                                      ),
                                                    ),
                                                    suffixIcon: IconButton(

                                                      icon: Icon(
                                                        IconBroken.Send,
                                                        color: kPrimaryColor,),
                                                      onPressed: () {
                                                        var nowTime = DateTime
                                                            .now();
                                                        EbnakCubit.get(context)
                                                            .CommentPost(
                                                          postId: EbnakCubit
                                                              .get(context)
                                                              .UserPostsIds[index],
                                                          comment: commentController
                                                              .text,
                                                          time: nowTime
                                                              .toString(),);
                                                        commentController
                                                            .clear();
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
                                borderRadius: BorderRadius.vertical(top: Radius
                                    .circular(25)),
                              ),
                              backgroundColor: Colors.white,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.75,
                                  child: Stack(
                                    children: [
                                      SingleChildScrollView(
                                        child:
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(horizontal: 80),
                                              child: Divider(
                                                thickness: 3,
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                            Text('Comments', style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[500],
                                                fontStyle: FontStyle.italic),),
                                            SizedBox(
                                              height: getProportionateScreenHeight(
                                                  30),
                                            ),
                                            StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('posts')
                                                    .doc(EbnakCubit
                                                    .get(context)
                                                    .UserPostsIds[index])
                                                    .collection('comments')
                                                    .orderBy('time')
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  EbnakCubit
                                                      .get(context)
                                                      .Usercommentmodel = [];
                                                  if (snapshot
                                                      .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                        child: Text('Loading'));
                                                  }
                                                  if (snapshot.hasData) {
                                                    for (int i = 0; i <
                                                        snapshot.data!.docs
                                                            .length; i++) {
                                                      EbnakCubit
                                                          .get(context)
                                                          .Usercommentmodel
                                                          .add(commentModel
                                                          .fromSnapShot(
                                                          snapshot.data!
                                                              .docs![i]));
                                                    }
                                                    print(EbnakCubit
                                                        .get(context)
                                                        .Usercommentmodel
                                                        .length);
                                                  }

                                                  return ListView.separated(
                                                    itemBuilder: (context,
                                                        index) =>
                                                        buildCommentColumn(
                                                            EbnakCubit
                                                                .get(context)
                                                                .Usercommentmodel[index],
                                                            EbnakCubit
                                                                .get(context)
                                                                .UserPostsIds[index],
                                                            context, index),
                                                    itemCount: EbnakCubit
                                                        .get(context)
                                                        .Usercommentmodel
                                                        .length,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    separatorBuilder: (context,
                                                        index) =>
                                                        SizedBox(
                                                          height: getProportionateScreenHeight(
                                                              8),
                                                        ),

                                                  );
                                                }
                                            ),
                                            SizedBox(
                                              height: getProportionateScreenHeight(
                                                  80),),

                                          ],

                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Container(

                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery
                                                    .of(context)
                                                    .viewInsets
                                                    .bottom),

                                            child: Theme(
                                              data: ThemeData(
                                                inputDecorationTheme: InputDecorationTheme(
                                                  border: InputBorder.none,

                                                ),
                                              ),
                                              child: TextFormField(
                                                controller: commentController,

                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.grey
                                                            .shade200),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.grey
                                                            .shade200),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.grey
                                                            .shade200),
                                                  ),
                                                  focusColor: kPrimaryColor,
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  prefixIcon: Padding(
                                                    padding: const EdgeInsets
                                                        .only(right: 8.0),
                                                    child: CircleAvatar(

                                                      backgroundImage: NetworkImage(
                                                          '${EbnakCubit
                                                              .get(context)
                                                              .userModel
                                                              ?.image}'),
                                                      radius: 5,
                                                    ),
                                                  ),
                                                  suffixIcon: IconButton(

                                                    icon: Icon(IconBroken.Send,
                                                      color: kPrimaryColor,),
                                                    onPressed: () {
                                                      var nowTime = DateTime
                                                          .now();
                                                      EbnakCubit.get(context)
                                                          .CommentPost(
                                                        postId: EbnakCubit
                                                            .get(context)
                                                            .PostsIds[index],
                                                        comment: commentController
                                                            .text,
                                                        time: nowTime
                                                            .toString(),);
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
                            .UserPostsIds[index]);
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
                        Text('${model.name}', style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black
                        ),),
                        Text('${model.comment}',
                          style: TextStyle(fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300,
                              color: Colors.black),),

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