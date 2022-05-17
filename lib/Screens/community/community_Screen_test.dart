import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:ebnak1/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/post_model.dart';
import '../../shared/re_useable_components.dart';
import '../new_post/new_post_screen.dart';

class communityScreentest extends StatelessWidget {
  const communityScreentest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);


        return BlocConsumer<EbnakCubit, EbnakStates>(
          listener: (context, state) {
          },
          builder: (context, state) {
            return Scaffold(
              floatingActionButton: SizedBox(
                width: getProportionateScreenWidth(55),
                height: getProportionateScreenHeight(60),
                child: FloatingActionButton(
                  elevation: 10,
                  enableFeedback: true,
                  onPressed: (){
                    navigateTo(
                      context,
                      NewPostScreen(),
                    );
                  },
                  backgroundColor: kPrimaryColor,
                  child:  Icon(IconBroken.Edit_Square,size: 27,),


                ),
              ),
              body: ConditionalBuilder(
                    condition:EbnakCubit.get(context).posts.length>=0&&EbnakCubit.get(context).userModel!=null,
                    builder: (context) =>SingleChildScrollView(

                      physics: BouncingScrollPhysics(),
                      child: Column(


                          children: [


                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 10.0,
                              margin: EdgeInsets.all(8.0),
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children:[

                                  Image(
                                    width: double.infinity,
                                    image: NetworkImage(
                                        'https://img.freepik.com/free-photo/diverse-hands-touching-white-paper_53876-98411.jpg?t=st=1649852964~exp=1649853564~hmac=bb082dc5ec8330732421c84e5dc2c7048874a02424686f62c3008f5e55eee81b&w=1380'
                                    ),
                                    fit: BoxFit.cover,
                                    height: getProportionateScreenHeight(200),
                                  ),
                                  Text(
                                    'Share your thoughts and advice ',

                                  )
                                ],
                              ),
                            ),


                          ),
                          StreamBuilder<QuerySnapshot>(
                              stream: EbnakCubit.get(context).getallposts2(),
                              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                print(snapshot.connectionState);

                                return ListView.separated(
                                  itemBuilder: (context,index)=> buildPostItem(EbnakCubit.get(context).posts[index],context,index),
                                itemCount: EbnakCubit.get(context).posts.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap:  true,
                                separatorBuilder: (context,index)=>SizedBox(
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
                    fallback: (context)=>
                        Center(child:

                    CircularProgressIndicator(
                      color: kPrimaryColor,
                    )),

                  ),

              );

          },
        );
      }
  }



Widget buildPostItem(PostModel model,context,index)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: EdgeInsets.symmetric(horizontal: 8),
    child:Padding(
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
                width:getProportionateScreenWidth(15),
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
                      style: Theme.of(context).textTheme.caption?.copyWith(
                        height: 1.35,

                      ),)
                  ],
                ),
              ),
              SizedBox(
                width:getProportionateScreenWidth(15),
              ),
              IconButton(onPressed: (){}, icon: Icon(
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
              style: Theme.of(context).textTheme.subtitle1
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Container(
                    height: getProportionateScreenHeight(20),
                    child: MaterialButton(onPressed: (){},
                      minWidth: 1.0,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#mom',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            color: kPrimaryColor
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: getProportionateScreenHeight(20),
                    child: MaterialButton(onPressed: (){},
                      minWidth: 1.0,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#mom',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            color: kPrimaryColor
                        ),
                      ),
                    ),
                  ),


                ],

              ),
            ),
          ),
          if(model.postImage!='')
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  top: 15.0
              ),
              child: Container(
                height: getProportionateScreenHeight(140),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image : NetworkImage(
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
                          Text(
                            '${EbnakCubit.get(context).Likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          )

                        ],
                      ),
                      onTap: (){

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
                          Text(
                            '0 Comments',
                            style: Theme.of(context).textTheme.caption,
                          ),


                        ],
                      ),
                    ),
                    onTap: (){},
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
                          NetworkImage('${EbnakCubit.get(context).userModel?.image}')

                      ),
                      SizedBox(
                        width:getProportionateScreenWidth(15),
                      ),
                      Text(
                        'Write a comment...',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                          height: 1.35,

                        ),),

                    ],
                  ),
                  onTap: (){} ,
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
                      style: Theme.of(context).textTheme.caption,
                    )

                  ],
                ),
                onTap: (){
                  print(EbnakCubit.get(context).posts.length);

                  print(index);
                  EbnakCubit.get(context).likePost(EbnakCubit.get(context).PostsIds[index]);

                },
              ),
            ],
          )
        ],

      ),
    )
);



