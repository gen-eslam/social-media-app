import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/homeScreen.dart';
import 'package:todo_app/remoteNetwork/cacheHelper.dart';

import 'package:todo_app/shared/bloc_observer.dart';
import 'package:todo_app/shared/constants.dart';
import 'package:todo_app/shared/themes.dart';

import 'cubits/homeCubit.dart';
import 'cubits/login_cubit.dart';
import 'modules/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();
  uId = CacheHelper.getData('uId');
  Widget startWidget;
  if (uId != null) {
    startWidget = HomeScreen();
  } else {
    startWidget = LoginScreen();
  }
  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp(this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit()
              ..getUserData()
              ..getPosts(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: startWidget,
          theme: lightMode(),
          darkTheme: darkMode(),
          themeMode: ThemeMode.light,
        ));
  }
}
