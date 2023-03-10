import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_chat_app/helper/shared/provider/register_provider.dart';
import 'package:my_chat_app/screens/chat_screen.dart';
import 'package:my_chat_app/widgets/custom_text_form_field.dart';
import '../helper/shared/constans.dart';
import '../helper/shared/show_snack_bar.dart';
import '../helper/shared/firebase_utils.dart';
import '../widgets/custom_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class registerScreen extends StatelessWidget {
  static const String routeName = 'reg';
  String? email, password;
  GlobalKey<FormState> formGlobalKey = GlobalKey();
  registerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<registerProvider>(context);
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
                        'Register',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 28,
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
                    textStyle: const TextStyle(color: Colors.white),
                    onChange: (data) {
                      email = data;
                    },
                    validate: (data) {
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(data!);
                      if (emailValid == false) {
                        return 'The email format is incorrect ';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customTextFormField(
                    hint: 'Password',
                    textStyle: const TextStyle(color: Colors.white),
                    obscure: true,
                    onChange: (data) {
                      password = data;
                    },
                    validate: (data) {
                      if (data!.length < 7) {
                        return 'password is a short';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customButton(
                      text: 'REGISTER',
                      onTap: () async {
                        if (formGlobalKey.currentState!.validate()) {
                          provider.changeLoading(true);
                          try {
                            await registerToFirebase(email, password);
                            showSnackBar(context, 'success register');
                            Navigator.pushNamed(context, chatScreen.routeName,
                                arguments: email);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showSnackBar(context,
                                  'The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              showSnackBar(context, 'email already in use');
                            }
                          } catch (e) {
                            showSnackBar(context, e.toString());
                            print(e);
                          }
                          provider.changeLoading(false);
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have An Account ?',
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
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Log In',
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
