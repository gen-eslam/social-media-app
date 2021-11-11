import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:todo_app/cubits/all_states.dart';
import 'package:todo_app/cubits/homeCubit.dart';
import 'package:todo_app/model/UserCreate.dart';
import 'package:todo_app/modules/chatDetails.dart';
import 'package:todo_app/shared/constants.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, SocialLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context)=>HomeCubit.get(context).users.length >0,
          fallbackBuilder: (context)=>Center(child: CircularProgressIndicator(),),
          widgetBuilder:(context)=> ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(context,HomeCubit.get(context).users[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: HomeCubit.get(context).users.length,),
        );
      },
    );
  }

  Widget buildChatItem(context,UserCreate model) => InkWell(
    onTap: ()
    {
      navigateTo(context, ChatDetailsScreen(userCreate: model));

    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    '${model.image}'),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                '${model.name}',
                style: TextStyle(height: 1.4),
              ),
            ],
          ),
    ),
  );
}
