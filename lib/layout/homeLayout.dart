import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_chat_app/screens/chat_screen.dart';
import 'package:my_chat_app/screens/register_screen.dart';
import 'package:my_chat_app/widgets/custom_button.dart';
import 'package:my_chat_app/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

import '../helper/shared/constans.dart';
import '../helper/shared/firebase_utils.dart';
import '../helper/shared/provider/home_provider.dart';
import '../helper/shared/show_snack_bar.dart';

class HomeLayout extends StatelessWidget {
  static const String routeName = 'home';
 final GlobalKey<FormState> formGlobalKey = GlobalKey();
  String? email, password;

  HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: false);

    return ModalProgressHUD(
      inAsyncCall: provider.isLoading,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: formGlobalKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .15,
                  ),
                  Image.asset(KImageIcon),
                  Text(
                    'Chat App',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontFamily: KFontPacifico,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Log In',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextFormField(
                    hint: 'Email',
                    validate: (data) {
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(data!);
                      if (emailValid == false) {
                        return 'The email format is incorrect ';
                      }
                      return null;
                    },
                    onChange: (data) {
                      email = data;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customTextFormField(
                    obscure: true,
                    validate: (data) {
                      if (data!.length < 7) {
                        return 'password is a short';
                      }
                      return null;
                    },
                    hint: 'Password',
                    onChange: (data) {
                      password = data;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customButton(
                    text: 'LOGIN',
                    onTap: () async {
                      if (formGlobalKey.currentState!.validate()) {
                        provider.changeLoading(true);
                        try {
                          await loginToFirebase(email, password);
                          showSnackBar(context, 'success Log In');
                          Navigator.pushNamed(context, chatScreen.routeName,
                              arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(
                                context, 'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(context,
                                'Wrong password provided for that user.');
                          }
                        } catch (ex) {
                          showSnackBar(context, ex.toString());
                          print(ex);
                        }
                        provider.changeLoading(false);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t Have An Account ?',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            registerScreen.routeName,
                          );
                        },
                        child: Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.red, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
