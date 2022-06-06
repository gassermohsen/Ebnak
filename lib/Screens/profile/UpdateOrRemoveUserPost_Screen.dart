import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Size_config/size_config.dart';
import '../../constants/constants.dart';
import '../../layout/ebnak/cubit/ebnak_cubit.dart';
import '../../layout/ebnak/cubit/ebnak_states.dart';
import '../../models/post_model.dart';
import '../../shared/re_useable_components.dart';
import '../../styles/icon_broken.dart';

class UpdateOrremoveUserPostScreen extends StatelessWidget {
  final PostModel model;
  UpdateOrremoveUserPostScreen(this.model,  {Key? key}) : super(key: key);

  var textController= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EbnakCubit, EbnakStates>(
      listener: (context, state) {
        if (state is EbnakCreatePostSuccessState){
          Navigator.pop(context);
          EbnakCubit.get(context).removePostImage();
        }
      },
      builder: (context, state) {
        var postImage=EbnakCubit.get(context).postImage;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Update Post',
            actions: [
              defaultTextButton(
                  text: 'Remove',
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
              defaultTextButton(
                  text: 'Update',
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
                          '${EbnakCubit.get(context).userModel?.image}'),

                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(15),
                    ),
                    Expanded(
                      child: Text(
                        '${EbnakCubit.get(context).userModel?.name}',
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
                      initialValue: '${model.text}',

                      decoration:   InputDecoration(

                      ),

                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),

                if(model.image!=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: getProportionateScreenHeight(250),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),

                        ),
                        child: CachedNetworkImage(
                          imageUrl: '${model.postImage}',
                          fit: BoxFit.contain,

                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}