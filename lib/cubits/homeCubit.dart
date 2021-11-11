import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/model/ChatsModel.dart';
import 'package:todo_app/model/UserCreate.dart';
import 'package:todo_app/model/post_Model.dart';

import 'package:todo_app/modules/chats.dart';
import 'package:todo_app/modules/feeds.dart';
import 'package:todo_app/modules/settings.dart';
import 'package:todo_app/modules/users.dart';
import 'package:todo_app/shared/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'all_states.dart';

class HomeCubit extends Cubit<SocialLayoutState> {
  HomeCubit() : super(SocialLayoutInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  UserCreate? usermodel;
  PostModel? postModel;
  List<String> appBarTitle = [
    'New Feeds',
    'Chat',
    'User',
    'Settings',
  ];
  List<Widget> screen = [
    FeedsScreen(),
    ChatsScreen(),
    UserScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(SocialLayoutBottomNavBarChange());
    if (index == 1)
      getUsers();
  }

  void getUserData() {
    emit(UserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      usermodel = UserCreate.fromJson(value.data()!);
      print('**********************');
      print(uId);
      print(usermodel!.uId);
      emit(UserSuccessState());
    }).catchError((error) {
      print('**********************');
      print(uId);
      print(usermodel!.uId);
      emit(UserErrorState());
    });
  }

  File? profileImage;
  final picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(GetProfileImageSuccessState());
    } else {
      print('No image selected');
      emit(GetProfileImageErrorState());
    }
  }

  File? coverImage;
  final coverPicker = ImagePicker();

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(GetProfileCoverImageSuccessState());
    } else {
      print('No image selected');
      emit(GetProfileCoverImageErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UpdateUserModelLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(name: name, phone: phone, bio: bio, image: value);

        // emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UpdateUserModelLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(UploadProfileCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileCoverImageErrorState());
    });
  }

  /*void updateUserImages({
    required String name,
    required String phone,
    required String bio
}) {
    emit(UpdateUserModelLoading());
    if (coverImage != null) {
      uploadCoverImage();
    } else if (profileImage != null) {
      uploadProfileImage();
    }else if(coverImage != null && profileImage != null )
    {
      uploadProfileImage();
      uploadCoverImage();

    }else
      {
        updateUserData(name:name,phone: phone,bio: bio);
      }

  }*/
  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    UserCreate model = UserCreate(
      name: name,
      phone: phone,
      bio: bio,
      email: usermodel!.email,
      image: image ?? usermodel!.image,
      cover: cover ?? usermodel!.cover,
      uId: usermodel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      print('***************************');
      print(model.name);
      print(model.cover);
      print(model.image);
      print(model.email);
      print(model.phone);
      print(model.uId);
      emit(UpdateUserModelError());
    });
  }

  File? postImage;
  final postImagePicker = ImagePicker();

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(GetPostImageSuccessState());
    } else {
      print('No image selected');
      emit(GetPostImageErrorState());
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri
        .file(postImage!.path)
        .pathSegments
        .last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel model = PostModel(
      name: usermodel!.name,
      image: usermodel!.image,
      uId: usermodel!.uId,
      dateTime: dateTime,
      postImage: postImage ?? '',
      text: text,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      print('***************************');
      print(model.name);

      print(model.uId);
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comment').get().then((value) {
          comments.add(value.docs.length);
          element.reference.collection('likes').get().then((value) {
            likes.add(value.docs.length);

            print(value.docs.length);
            posts.add(PostModel.fromJson(element.data()));
            postsId.add(element.id);
            emit(GetPostsSuccessState());
          }).catchError((error) {});
        }).catchError((error) {});
      });
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId,) {
    FirebaseFirestore.instance.collection('posts').doc(postId).collection(
        'likes').doc(usermodel!.uId).set({
      'like': true,
    }).then((value) {
      emit(LikePostsSuccessState());
    }).catchError((error) {
      emit(LikePostsErrorState(error.toString()));
    });
  }

  List<int> comments = [];

  void commentPost(String postId, String text) {
    FirebaseFirestore.instance.collection('posts').doc(postId).collection(
        'comment').doc(usermodel!.uId).set({
      'comment': text,
    }).then((value) {
      emit(CommentPostsSuccessState());
    }).catchError((error) {
      emit(CommentPostsErrorState(error.toString()));
    });
  }

  List<UserCreate> users = [];

  void getUsers() {
    emit(GetUsersLoadingState());
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != usermodel!.uId)
            users.add(UserCreate.fromJson(element.data()));
        });

        emit(GetUsersSuccessState());
      }).catchError((error) {
        emit(GetUsersErrorState(error));
      });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      senderId: usermodel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,

    );
    FirebaseFirestore.instance.collection('users').doc(usermodel!.uId)
        .collection('chats').doc(receiverId).collection('messages')
        .add((model.toMap())).then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance.collection('users').doc(receiverId)
        .collection('chats').doc(usermodel!.uId).collection('messages')
        .add((model.toMap())).then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessage({required String receiverId}) {
    FirebaseFirestore.instance.collection('users').doc(usermodel!.uId)
        .collection('chats').doc(receiverId)
        .collection('messages').orderBy('dateTime').snapshots().listen((event)
    {
      messages = [];

      event.docs.forEach((element)
      {
        messages.add(MessageModel.fromJson(element.data()));

      });
      emit(GetMessageSuccessState());
    });
  }

}
