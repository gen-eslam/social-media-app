import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:todo_app/cubits/all_states.dart';
import 'package:todo_app/cubits/homeCubit.dart';
import 'package:todo_app/model/post_Model.dart';
import 'package:todo_app/shared/constants.dart';
import 'package:todo_app/shared/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,SocialLayoutState>(
        listener:(context,state){},
      builder: (context,state)
      {
        return Conditional.single(context: context,
            conditionBuilder:(context)=> HomeCubit().posts.length >=0  ,
            widgetBuilder: (context) =>
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5,
                          margin: EdgeInsets.all(8),
                          child: Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              Image(
                                image: NetworkImage(
                                    'https://image.freepik.com/free-photo/thrilled-cheerful-afro-american-curly-girl-gives-way-awesome-place-points-aside-smiles-broadly-looks-happily-camera-gestures-against-purple-background_273609-32433.jpg'),
                                fit: BoxFit.cover,
                                height: 200,
                                width: double.infinity,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Communicate with friends',
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => buildPostItem(HomeCubit.get(context).posts[index],index,context),
                        separatorBuilder: (context, index) => SizedBox(height: 8,),
                        itemCount: HomeCubit.get(context).posts.length,
                      ),
                      SizedBox(height: 8,),

                    ],
                  ),
                ),
            fallbackBuilder:(context)=> Center(child: CircularProgressIndicator(),)
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, index, BuildContext context ) =>
      Container(
        width: double.infinity,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(

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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${model.name}',
                                style: TextStyle(height: 1.4),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.check_circle,
                                size: 16,
                              ),
                            ],
                          ),
                          Text(
                            '${model.dateTime}',
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        IconBroken.More_Circle,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                myDivider(),
                Text(
                  '${model.text}',
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle1,
                ),

                 // Padding(
                 //   padding: const EdgeInsets.only(top: 5,bottom: 10),
                 //   child: Container(
                 //     width: double.infinity,
                 //     child: Wrap(
                 //       spacing: 6,
                 //
                 //       children:
                 //       [
                 //         Container(
                 //           height: 20,
                 //           child: MaterialButton(
                 //             minWidth: 1,
                 //             height: 25,
                 //
                 //             padding: EdgeInsets.zero,
                 //             onPressed: () {},
                 //             child: Text(
                 //               '#Softwere',
                 //               style: Theme.of(context)
                 //                   .textTheme
                 //                   .bodyText1!
                 //                   .copyWith(fontSize: 12),
                 //             ),
                 //           ),
                 //         ),
                 //
                 //
                 //
                 //
                 //       ],
                 //     ),
                 //   ),
                 // ),
                if(model.postImage !='')
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top:15 ),
                    child: Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: NetworkImage(
                              '${model.postImage}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children:
                    [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children:
                              [
                                Icon(IconBroken.Heart,
                                  size: 16,
                                ),
                                SizedBox(width: 5,),
                                Text( '${HomeCubit.get(context).likes[index]}', style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,),
                              ],
                            ),
                          ),

                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children:
                              [
                                Icon(IconBroken.Chat,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                                SizedBox(width: 5,),
                                Text('${HomeCubit.get(context).comments[index]}', style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,),
                              ],
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Container(
                    color: Colors.grey[300],
                    height: 1,
                    width: double.infinity,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: ()
                        {
                          HomeCubit.get(context).commentPost(HomeCubit.get(context).postsId[index],'fares');
                        },
                        child: Row(
                          children:
                          [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(
                                  '${HomeCubit.get(context).usermodel!.image}'),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              'write a comment...',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: ()
                      {
                        HomeCubit.get(context).likePost(HomeCubit.get(context).postsId[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children:
                          [
                            Icon(IconBroken.Heart,
                              size: 16,
                            ),
                            SizedBox(width: 5,),
                            Text('Like', style: Theme
                                .of(context)
                                .textTheme
                                .caption,),
                          ],
                        ),
                      ),

                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
