
//loginCubit
abstract class SocialLoginState {}

class SocialLoginInitialState extends SocialLoginState {}

class SocialLoginLoadingState extends SocialLoginState {}

class SocialLoginSuccessState extends SocialLoginState {
  final String uId;
  SocialLoginSuccessState(this.uId);

}

class SocialLoginErrorState extends SocialLoginState {
  late final String error;

  SocialLoginErrorState(this.error);
}
class SocialRegisterInitialState extends SocialLoginState {}

class SocialRegisterLoadingState extends SocialLoginState {}

class SocialRegisterSuccessState extends SocialLoginState {

}

class SocialRegisterErrorState extends SocialLoginState {
  late final String error;

  SocialRegisterErrorState(this.error);
}
class SocialCreateUserSuccessState extends SocialLoginState {
  final String uId;
  SocialCreateUserSuccessState(this.uId);

}

class SocialCreateUserErrorState extends SocialLoginState {
  late final String error;

  SocialCreateUserErrorState(this.error);
}
class SocialLoginShowPassword extends SocialLoginState {}
//SocialCubit
abstract class SocialLayoutState{}
class SocialLayoutInitialState extends SocialLayoutState {}

class SocialLayoutLoadingState extends SocialLayoutState {}

class SocialLayoutSuccessState extends SocialLayoutState {
}

class SocialLayoutErrorState extends SocialLayoutState {
  late final String error;

  SocialLayoutErrorState(this.error);
}
class SocialLayoutBottomNavBarChange extends SocialLayoutState{}
class UserLoadingState extends SocialLayoutState{}
class UserSuccessState extends SocialLayoutState{}
class UserErrorState extends SocialLayoutState{}
class GetProfileImageSuccessState extends SocialLayoutState{}
class GetProfileImageErrorState extends SocialLayoutState{}
class GetProfileCoverImageSuccessState extends SocialLayoutState{}
class GetProfileCoverImageErrorState extends SocialLayoutState{}
class UploadProfileImageSuccessState extends SocialLayoutState{}
class UploadProfileImageErrorState extends SocialLayoutState{}
class UploadProfileCoverImageSuccessState extends SocialLayoutState{}
class UploadProfileCoverImageErrorState extends SocialLayoutState{}
class UpdateUserModelError extends SocialLayoutState{}
class UpdateUserModelLoading extends SocialLayoutState{}
//createPost
class CreatePostSuccessState extends SocialLayoutState{}
class CreatePostLoadingState extends SocialLayoutState{}
class CreatePostErrorState extends SocialLayoutState{}
class GetPostImageSuccessState extends SocialLayoutState{}
class GetPostImageErrorState extends SocialLayoutState{}
class RemovePostImageState extends SocialLayoutState{}
class GetPostsLoadingState extends SocialLayoutState{}
class GetPostsSuccessState extends SocialLayoutState{}
class GetPostsErrorState extends SocialLayoutState{
  final String error;
  GetPostsErrorState(this.error);

}

class LikePostsSuccessState extends SocialLayoutState{}
class LikePostsErrorState extends SocialLayoutState{
  final String error;
  LikePostsErrorState(this.error);

}
class CommentPostsSuccessState extends SocialLayoutState{}
class CommentPostsErrorState extends SocialLayoutState{
  final String error;
  CommentPostsErrorState(this.error);

}
class GetUsersLoadingState extends SocialLayoutState{}
class GetUsersSuccessState extends SocialLayoutState{}
class GetUsersErrorState extends SocialLayoutState{
  final String error;
  GetUsersErrorState(this.error);

}
class SendMessageSuccessState extends SocialLayoutState{}
class SendMessageErrorState extends SocialLayoutState{}
class GetMessageSuccessState extends SocialLayoutState{}
class GetMessageErrorState extends SocialLayoutState{}




