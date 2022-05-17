import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:ebnak1/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EbnakLayout extends StatelessWidget {
  const EbnakLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EbnakCubit, EbnakStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = EbnakCubit.get(context);
        return Scaffold(
          appBar: AppBar(

            actions: [
              IconButton(
                  onPressed: (){}, icon: Icon(IconBroken.Notification)),
              IconButton(
                  onPressed: (){}, icon: Icon(IconBroken.Search)),
            ],
            title: Text(
              cubit.titles[cubit.currentIndex],

            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark
            ),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(

                    IconBroken.Home,

                  ),
                  label: 'Home'
              ),

              BottomNavigationBarItem(
                  icon: Icon(

                    Icons.child_friendly_outlined,

                  ),
                  label: 'Adopt'
              ),

              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.User1,
                  ),
                  label: 'Community'

              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Danger,
                  ),
                  label: 'Missing'

              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Profile,
                ),
                label: 'Profile'
              ),

            ],
          ),
        );
      },
    );
  }
}

