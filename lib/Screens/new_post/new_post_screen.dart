import 'package:ebnak1/Screens/community/community_Screen_test.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:ebnak1/shared/re_useable_components.dart';
import 'package:ebnak1/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Size_config/size_config.dart';
import '../../constants/constants.dart';
import '../../layout/ebnak/ebnak_layout.dart';

class NewPostScreen extends StatelessWidget {

  var textController= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EbnakCubit, EbnakStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var postImage=EbnakCubit.get(context).postImage;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextButton(
                text: 'Post',
                function: (){
                  var nowTime= DateTime.now();
                if(EbnakCubit.get(context).postImage==null){
                  EbnakCubit.get(context).createPost(dateTime: nowTime.toString(), text: textController.text);
                } else{
                  EbnakCubit.get(context).UploadPostImage
                    (
                      dateTime: nowTime.toString(),
                      text: textController.text);
                }

                }
              ),
            ],

          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if(state is EbnakCreatePostLoadingState)
                LinearProgressIndicator(
                  color: kPrimaryColor,
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                      NetworkImage(
                          'https://img.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg?t=st=1649854254~exp=1649854854~hmac=362731baa7ebc16247ded4c09be827bb5ce5f961e9942f08a2dbd16813195731&w=1060'),

                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(15),
                    ),
                    Expanded(
                      child: Text(
                        'Gasser Mohsen',
                        style: TextStyle(
                            height: 1.35,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
               SizedBox(
                 height: getProportionateScreenHeight(10),
               ),
               Expanded(
                  child: Theme(
                    data: ThemeData(
                      inputDecorationTheme: InputDecorationTheme(
                        border: InputBorder.none,


                      )
                    ),
                    child: TextFormField(
                      controller: textController,

                      decoration:   InputDecoration(
                        hintText: 'What\'s on your mind...',

                      ),

                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),

                if(EbnakCubit.get(context).postImage!=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image:  FileImage(postImage!) ,
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
                        EbnakCubit.get(context).removePostImage();
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
                          onPressed: (){
                            EbnakCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image_2,color: kPrimaryColor,),
                              SizedBox(
                                width: getProportionateScreenWidth(5)
                              ),
                              Text(
                                'Add photo',
                                style: TextStyle(
                                  color:kPrimaryColor,
                                  fontWeight: FontWeight.w700
                                ),
                              )
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: (){},
                          child: Text(
                            '# tags',
                            style: TextStyle(
                                color:kPrimaryColor,
                                fontWeight: FontWeight.w700
                            ),
                          ),),
                    ),

                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
