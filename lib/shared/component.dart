import 'package:flutter/material.dart';
import 'package:todo_app/remoteNetwork/cacheHelper.dart';

import 'constants.dart';
import 'icon_broken.dart';

Widget defaultFormField({
  required context,
  TextEditingController? controller,
  dynamic label,
  IconData? prefix,
  String? initialValue,
  TextInputType? keyboardType,
  Function(String)? onSubmit,
  onChange,
  onTap,
  required String? Function(String?) validate,
  bool isPassword = false,
  bool enabled = true,
  IconData? suffix,
  suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      textAlign: TextAlign.start,
      onFieldSubmitted: onSubmit,
      enabled: enabled,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      textCapitalization: TextCapitalization.words,
      textAlignVertical: TextAlignVertical.center,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.blueGrey),

      initialValue: initialValue,

      //textCapitalization: TextCapitalization.words,

      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        border: UnderlineInputBorder(),
        prefixIcon: Icon(
          prefix,
          color: Theme.of(context).iconTheme.color,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                  color: Theme.of(context).iconTheme.color,
                ))
            : null,
      ),
    );


Widget defaultButton({
  required Function() onTap,
  required IconData icon,
  double? width = double.infinity,
}) =>
    IconButton(
      onPressed: onTap,
      icon: Icon(icon),
    );

Widget defaultTextButton(
    {required String text,
    required Function() onPressed,
    bool isUpper = false,
    context}) {
  if (isUpper) text = text.toUpperCase();
  return Container(
    child: TextButton(
      child: Text('${text}',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              )),
      onPressed: onPressed,
    ),
  );
}

SnackBar snakBar({required String text, required SnackState state}) {
  return SnackBar(
    content: Text(text),
    backgroundColor: chooseSnackColor(state),
    duration: Duration(
      seconds: 2,
    ),
  );
}

enum SnackState { SUCCESS, ERROR, WARNING }

Color chooseSnackColor(SnackState state) {
  Color color;
  switch (state) {
    case SnackState.SUCCESS:
      color = Colors.green;
      break;
    case SnackState.ERROR:
      color = Colors.red;
      break;
    case SnackState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void signOut(context, widget) {
  CacheHelper.removeData('token').then((value) {
    if (value) {
      navigateAndKill(context, widget);
    }
  });
}
