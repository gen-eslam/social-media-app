import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:todo_app/cubits/all_states.dart';
import 'package:todo_app/cubits/homeCubit.dart';
import 'package:todo_app/model/ChatsModel.dart';
import 'package:todo_app/model/UserCreate.dart';
import 'package:todo_app/shared/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserCreate userCreate;

  ChatDetailsScreen({required this.userCreate});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      HomeCubit.get(context).getMessage(receiverId: userCreate.uId!);
      return BlocConsumer<HomeCubit, SocialLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(IconBroken.Arrow___Left_2),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('${userCreate.image}'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '${userCreate.name}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              body: Conditional.single(
                  context: context,
                  conditionBuilder: (context) =>
                      HomeCubit.get(context).messages.length >= 0,
                  widgetBuilder: (context) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Expanded(

                              child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index)
                                  {
                                    var message =HomeCubit.get(context).messages[index];
                                    if(HomeCubit.get(context).usermodel!.uId == message.senderId )
                                      return buildMyMessage(message);
                                    return buildMessage(message);
                                  },
                                  separatorBuilder: (context, index) => SizedBox(
                                        height: 15,
                                      ),
                                  itemCount: HomeCubit.get(context).messages.length),
                            ),
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: messageController,
                                      decoration: InputDecoration(
                                          hintText:
                                              'Type Your Message Here....',
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                      color: Colors.purple,
                                      child: MaterialButton(
                                        onPressed: () {
                                          print(messageController.text);

                                          if (messageController.text.isNotEmpty)
                                            HomeCubit.get(context).sendMessage(
                                                receiverId: userCreate.uId!,
                                                dateTime:
                                                    DateTime.now().toString(),
                                                text: messageController.text);
                                          if (messageController.text.isNotEmpty)
                                            messageController.clear();
                                        },
                                        minWidth: 1,
                                        child: Icon(
                                          IconBroken.Send,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  fallbackBuilder: (context) => Center(
                        child: CircularProgressIndicator(),
                      )));
        },
      );
    });
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                )),
            child: Text('${model.text}')),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.3),
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(10),
                  bottomStart: Radius.circular(10),
                  topStart: Radius.circular(10),
                )),
            child: Text('${model.text}')),
      );
}
