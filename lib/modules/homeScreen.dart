import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/all_states.dart';
import 'package:todo_app/cubits/homeCubit.dart';
import 'package:todo_app/modules/LoginScreen.dart';
import 'package:todo_app/modules/newPost.dart';
import 'package:todo_app/shared/component.dart';
import 'package:todo_app/shared/constants.dart';
import 'package:todo_app/shared/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, SocialLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${HomeCubit.get(context).appBarTitle[HomeCubit.get(context).currentIndex]}',
            style: TextStyle(fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor),
            ),
            actions: 
            [
              if(HomeCubit.get(context).currentIndex==0)
              MaterialButton(onPressed: ()
              {
                navigateTo(context,NewPostScreen());
              },child: Row(children:
              [
                Icon(IconBroken.Paper_Upload,color: Colors.purple,),
                Text('AddPost',style: TextStyle(color: Colors.purple,fontSize:12),)
              ],),),
              IconButton(onPressed: ()
              {
                print('***************************************************');
                print(HomeCubit.get(context).usermodel!.image);
                print(HomeCubit.get(context).postModel!.image);
                print(HomeCubit.get(context).posts[1].image);
              }, icon: Icon(IconBroken.Notification),),
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Search),),
              if(HomeCubit.get(context).currentIndex==3)
                IconButton(onPressed: (){signOut(context, LoginScreen());},icon: Icon(IconBroken.Delete),)

            ],

          ),
          body:HomeCubit.get(context).screen[HomeCubit.get(context).currentIndex] ,

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: HomeCubit.get(context).currentIndex,
            onTap: (index)
            {
              HomeCubit.get(context).changeBottomNavBar(index);

            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Home,
                  ),
                  label: 'feeds'),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Chat,
                  ),
                  label: 'chat'),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Location,
                  ),
                  label: 'user'),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Setting,
                  ),
                  label: 'Setting'),
            ],
          ),
        );
      },
    );
  }
}
