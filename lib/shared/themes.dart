import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



ThemeData lightMode() => ThemeData(
    fontFamily: 'fares',
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      actionsIconTheme: IconThemeData(color: Colors.purple),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 23,
      ),
      iconTheme: IconThemeData(color: Colors.purple),


      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.purple),
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: EdgeInsetsDirectional.only(top: 5, start: 20),
      hintStyle: TextStyle(color: Colors.black),
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontFamily: 'fares',
            color: Colors.purple,
            fontWeight: FontWeight.w400,
            fontSize: 18),
        subtitle1: TextStyle(
            fontFamily: 'fares',
            color: Colors.black,
            height: 1.3,

            fontSize: 14),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed));

ThemeData darkMode() => ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 23,
        ),
        iconTheme: IconThemeData(color: Colors.white),

        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      primarySwatch: Colors.red,
      scaffoldBackgroundColor: Colors.black,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: EdgeInsetsDirectional.only(top: 5, start: 30),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
          bodyText1: TextStyle(
              fontFamily: 'fares',
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 18),
        subtitle1: TextStyle(
            fontFamily: 'fares',
            color: Colors.white70,
            height: 1.3,

            fontSize: 14),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed),
      iconTheme: IconThemeData(color: Colors.white),
      primaryIconTheme: IconThemeData(color: Colors.white),
    );
