import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:todo_app/cubits/all_states.dart';
import 'package:todo_app/cubits/login_cubit.dart';
import 'package:todo_app/modules/homeScreen.dart';
import 'package:todo_app/remoteNetwork/cacheHelper.dart';
import 'package:todo_app/shared/component.dart';
import 'package:todo_app/shared/constants.dart';

import 'package:todo_app/shared/icon_broken.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
        listener: (context, state)
        {
          if(state is SocialCreateUserSuccessState)
          {
            CacheHelper.saveData(key: 'uId', value:state.uId ).then((value)
            {
              navigateAndKill(context, HomeScreen());
            }).catchError((error){});
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(icon: Icon(IconBroken.Arrow___Left_2),onPressed: (){Navigator.pop(context);},),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 30,
                            ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'register to meet a new friend',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                              fontSize: 30,
                            ),
                      ),
                      defaultFormField(
                        context: context,
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        prefix: Icons.person,
                        label: 'enter your name',
                        validate: (value) {
                          if (value!.isEmpty) return 'plz enter your name';
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        context: context,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        prefix: Icons.email,
                        label: 'enter your email',
                        validate: (value) {
                          if (value!.isEmpty) return 'plz enter your email';
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        context: context,
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        prefix: Icons.phone,
                        label: 'enter your phone',
                        validate: (value) {
                          if (value!.isEmpty) return 'plz enter your phone';
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        keyboardType:TextInputType.visiblePassword ,
                        context: context,
                        prefix: Icons.password,
                        suffix: SocialLoginCubit.get(context).isPasswordIcon,
                        label: 'enter your password',
                        isPassword: SocialLoginCubit.get(context).isPassword,
                        suffixPressed: () {
                          SocialLoginCubit.get(context).showPassword();
                        },
                        controller: passwordController,
                        validate: (value) {
                          if (value!.isEmpty) return 'plz enter your password';
                        },
                        onSubmit: (value) {
                           if (formKey.currentState!.validate()) {
                             SocialLoginCubit.get(context).userRegister(
                               email: emailController.text,
                               name: nameController.text,
                               password: passwordController.text,
                               phone: phoneController.text,
                             );
                           }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Conditional.single(context: context, conditionBuilder:(context)=>state is! SocialRegisterLoadingState ,
                          widgetBuilder: (context)=>OutlinedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate())
                              {
                                SocialLoginCubit.get(context).userRegister(
                                  email: emailController.text,
                                  name: nameController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );


                              }
                            },
                            child: Container(
                                width: double.infinity,
                                height: 50,
                                child: Center(child: Text('Sign up'))),
                          ),
                          fallbackBuilder: (context)=>Center(child: CircularProgressIndicator()))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
