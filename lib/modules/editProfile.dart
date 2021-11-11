import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/cubits/all_states.dart';
import 'package:todo_app/cubits/homeCubit.dart';
import 'package:todo_app/shared/component.dart';
import 'package:todo_app/shared/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, SocialLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context).usermodel;
        var profileImage = HomeCubit.get(context).profileImage;
        var coverProfile = HomeCubit.get(context).coverImage;
        nameController.text = cubit!.name!;
        bioController.text = cubit.bio!;
        phoneController.text = cubit.phone!;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left_2),
            ),
            title: Text(
              'Edit Profile',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            titleSpacing: 0.0,
            actions: [
              MaterialButton(
                onPressed: ()
                {
                  HomeCubit.get(context).updateUserData(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                },
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Upload,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'update',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if(state is UpdateUserModelLoading)
                LinearProgressIndicator(),
                SizedBox(height: 10,),
                Container(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                clipBehavior: Clip.antiAlias,
                                width: double.infinity,
                                decoration: BoxDecoration(

                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                ),
                                child: coverProfile == null
                                    ? Image(
                                  width: double.infinity,
                                  height: 140,
                                  fit: BoxFit.cover,

                                  image: NetworkImage('${cubit.cover}'),
                                )
                                    : Image(
                                  width: double.infinity,
                                  height: 140,

                                  fit: BoxFit.cover,
                                  image: FileImage(coverProfile),
                                )

                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                    backgroundColor: Colors.purple,
                                    child: IconButton(
                                      onPressed: () {
                                        HomeCubit.get(context).getCoverImage();
                                      },
                                      icon: Icon(
                                        IconBroken.Camera,
                                        size: 17,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              child: ClipOval(
                                child: profileImage == null
                                    ? Image(
                                        fit: BoxFit.cover,
                                        width: 120,
                                        height: 120,
                                        image: NetworkImage('${cubit.image}'),
                                      )
                                    : Image(
                                        fit: BoxFit.cover,
                                        width: 120,
                                        height: 120,
                                        image: FileImage(profileImage)),
                              ),
                            ),
                            CircleAvatar(
                                backgroundColor: Colors.purple,
                                child: IconButton(
                                  onPressed: () {
                                    HomeCubit.get(context).getProfileImage();
                                  },
                                  icon: Icon(
                                    IconBroken.Camera,
                                    size: 17,
                                    color: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                if(HomeCubit.get(context).profileImage!= null || HomeCubit.get(context).coverImage!= null )
                Row(
                  children:
                [
                  if(HomeCubit.get(context).profileImage!= null)
                  Expanded(
                    child: MaterialButton(
                      height: 50,
                      onPressed: ()
                      {
                        HomeCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);

                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'upload profile image',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          if(state is UpdateUserModelLoading)
                          SizedBox(height: 5,),
                          if(state is UpdateUserModelLoading)
                          LinearProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                  if(HomeCubit.get(context).coverImage!= null)
                  Expanded(
                    child: MaterialButton(
                      height: 50,
                      onPressed: ()
                      {
                        HomeCubit.get(context).uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'upload  Cover image',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          if(state is UpdateUserModelLoading)

                          SizedBox(height: 5,),
                          if(state is UpdateUserModelLoading)
                          LinearProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                ],),
                SizedBox(
                  height: 5,
                ),
                defaultFormField(
                    context: context,
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    label: 'Name',
                    prefix: IconBroken.User,
                    validate: (value) {
                      // if (value!.isEmpty) {
                      //   return 'name must not be empty';
                      // }
                    }),
                SizedBox(
                  height: 40,
                ),
                defaultFormField(
                    context: context,
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    label: 'phone',
                    prefix: IconBroken.Call,
                    validate: (value) {
                      // if (value!.isEmpty) {
                      //   return 'phone must not be empty';
                      // }
                    }),
                SizedBox(
                  height: 40,
                ),
                defaultFormField(
                    context: context,
                    keyboardType: TextInputType.name,
                    controller: bioController,
                    label: 'bio',
                    prefix: IconBroken.Info_Circle,
                    validate: (value) {
                      // if (value!.isEmpty) {
                      //   return 'bio must not be empty';
                      // }
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
