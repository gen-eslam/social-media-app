import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:todo_app/cubits/all_states.dart';
import 'package:todo_app/cubits/homeCubit.dart';
import 'package:todo_app/shared/constants.dart';
import 'package:todo_app/shared/icon_broken.dart';

import 'editProfile.dart';




class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, SocialLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=HomeCubit.get(context).usermodel;


        return Conditional.single(context: context, conditionBuilder: (context)=>cubit != null, widgetBuilder: (context)=>Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                                '${cubit!.cover}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            '${cubit.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${cubit.name}',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${cubit.phone}',
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                '${cubit.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text('100',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(height: 1.5)),
                            Text(
                              'posts',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text('65',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(height: 1.5)),
                            Text(
                              'photos',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: ()
                        {

                        },
                        child: Column(
                          children: [
                            Text('40',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(height: 1.5)),
                            Text(
                              'Followers',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text('64',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(height: 1.5)),
                            Text(
                              'Following',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                        height: 40,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'Add Photos',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16,),
                          ),
                        ),
                      )),
                  SizedBox(width: 10,),
                  Container(
                    height: 40,

                    child: OutlinedButton(
                      onPressed: ()
                      {
                        navigateTo(context, EditProfileScreen());
                      },
                      child: Icon(
                        IconBroken.Edit,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ), fallbackBuilder:(context)=>Center(child: CircularProgressIndicator(),));
      },
    );
  }
}
