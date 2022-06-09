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



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EbnakCubit, EbnakStates>(
      listener: (context, state) {
        if (state is EbnakDeletePostSuccessState){
          Navigator.pop(context);
        }

        if (state is EbnakUpdatePostSuccessState){
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var postImage=EbnakCubit.get(context).postImage;
        var textController= TextEditingController(text: model.text);

        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: defaultAppBar(
            context: context,
            title: 'Update Post',
            actions: [
              defaultTextButton(
                  text: 'Remove',
                  function: ()=>  showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(

              title: const Text('Delete'),
              content: const Text('Are you sure you want to delete this post ! '),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel',style: TextStyle(color: Colors.grey),),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                    EbnakCubit.get(context).deletePost(postID: model.postID);
                  },
                  child: const Text('OK',style: TextStyle(color:Colors.green)),
                ),
              ],
            ),
          ),
              ),
              defaultTextButton(
                  text: 'Update',
                  function: (){
                  EbnakCubit.get(context).UpdatePost(text: textController.text,postID: model.postID);

                  }
              ),
            ],

          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
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
                  SizedBox(
                    width: double.infinity,
                    height: getProportionateScreenHeight(300),
                    child: Theme(
                      data: ThemeData(
                          inputDecorationTheme: InputDecorationTheme(
                            border: InputBorder.none,


                          )
                      ),
                      child: TextFormField(
                        maxLines: 5,
                        controller: textController,
                        decoration:   InputDecoration(

                        ),

                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),

                  if(model.image!=null)
                    Container(
                      alignment: AlignmentDirectional.topEnd,
                      height: getProportionateScreenHeight(250),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image:  NetworkImage('${model.postImage}') ,
                          fit: BoxFit.contain,
                        ),

                      ),

                    ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                if(model.image==null)
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),


                ],
              ),
            ),
          ),
        );
      },
    );
  }
}