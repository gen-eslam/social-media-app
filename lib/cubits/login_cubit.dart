import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/model/UserCreate.dart';

import 'all_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginState> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData isPasswordIcon = Icons.remove_red_eye;


  void userLogin({required String email, required String password}) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  void showPassword() {
    isPassword = !isPassword;
    if (isPassword == true) {
      isPasswordIcon = Icons.remove_red_eye;
    } else {
      isPasswordIcon = Icons.remove_red_eye_outlined;
    }
    emit(SocialLoginShowPassword());
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(FirebaseAuth.instance.currentUser!.uid);
      userCreate(
          phone: phone,
          name: name,
          email: email,
          cover:'https://image.freepik.com/free-photo/thrilled-cheerful-afro-american-curly-girl-gives-way-awesome-place-points-aside-smiles-broadly-looks-happily-camera-gestures-against-purple-background_273609-32433.jpg' ,
          bio: 'write your bio..',
          image:
              'https://image.freepik.com/free-photo/young-beautiful-woman-casual-outfit-isolated-studio_1303-20526.jpg',
          uId: FirebaseAuth.instance.currentUser!.uid,
      );
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required String image,
    required String cover,
    required String bio,
  }) {
    UserCreate model = UserCreate(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        cover:cover,
        bio: bio,
        image:image,
            );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState(uId));
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error));
    });
  }
}
