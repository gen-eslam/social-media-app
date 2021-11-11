import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/all_states.dart';
import 'package:todo_app/cubits/homeCubit.dart';
import 'package:todo_app/shared/component.dart';

import 'package:todo_app/shared/icon_broken.dart';

class NewPostScreen extends StatelessWidget {

  TextEditingController textController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, SocialLayoutState>(
      listener: (context, state)
      {
        if(state is CreatePostSuccessState)
        {
        textController.clear();
        HomeCubit.get(context).removePostImage();
        ScaffoldMessenger.of(context).showSnackBar(snakBar(text: 'Uploaded success', state: SnackState.SUCCESS));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left_2),
            ),
            title: Text(
              'Create Post',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            actions: [
              TextButton(onPressed: ()
              {
                var now = DateTime.now();
                if(HomeCubit.get(context).postImage == null)
                {
                  HomeCubit.get(context).createPost(dateTime:now.toString() , text: textController.text);
                }else
                {
                  HomeCubit.get(context).uploadPostImage(dateTime: now.toString(), text: textController.text);
                }
                print('**********************************************');
                print(HomeCubit.get(context).postModel!.image);


              }, child: Text('Post')),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is CreatePostLoadingState)
                LinearProgressIndicator(),
                SizedBox(height: 10,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/young-beautiful-woman-casual-outfit-isolated-studio_1303-20526.jpg'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'fares',
                                style: TextStyle(height: 1.4),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    //maxLines: ,
                    decoration: InputDecoration(
                        hintText: 'what is on your mind ... ',
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(height: 20,),
                if(HomeCubit.get(context).postImage !=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                        height: 200,
                        clipBehavior: Clip.antiAlias,
                        width: double.infinity,
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Image(
                          width: double.infinity,
                          height: 100,
                          fit: BoxFit.cover,

                          image: FileImage(HomeCubit.get(context).postImage!),
                        )


                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundColor: Colors.purple,
                          child: IconButton(
                            onPressed: () {
                              HomeCubit.get(context).removePostImage();

                            },
                            icon: Icon(
                              Icons.clear,
                              size: 17,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: ()
                        {
                          HomeCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Icon(IconBroken.Image_2),
                            SizedBox(width: 5,),
                            Text('add photo'),

                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        child: TextButton(

                          onPressed: () {},
                          child: Text('# Tags '),
                        ),
                      ),
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
