import 'package:flutter/material.dart';
import 'package:my_chat_app/screens/chat_screen.dart';
import 'package:my_chat_app/screens/register_screen.dart';
import 'package:my_chat_app/widgets/custom_button.dart';
import 'package:my_chat_app/widgets/custom_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../helper/shared/constans.dart';
import '../helper/shared/show_snack_bar.dart';
import '../helper/shared/provider/home_provider.dart';
import '../helper/shared/utlis_firebase.dart';

class homeLayout extends StatelessWidget {
  static const String routeName = 'home';
  GlobalKey<FormState> formkey = GlobalKey();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: false);

    return ModalProgressHUD(
      inAsyncCall: provider.isLoading,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .15,
                  ),
                  Image.asset(KImageIcon),
                  Text(
                    'Chat App',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
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
                        style: Theme.of(context).textTheme.headline2!.copyWith(
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
                    onChange: (data) {
                      email = data;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customTextFormField(
                    obscure: true,
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
                      if (formkey.currentState!.validate()) {
                        provider.changeLoading(true);
                        try {

                          await loginToFirebase(email,password);
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
                        } catch (e) {
                          showSnackBar(context, e.toString());
                          print(e);
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
                            .bodyText1!
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
                              .bodyText1
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
