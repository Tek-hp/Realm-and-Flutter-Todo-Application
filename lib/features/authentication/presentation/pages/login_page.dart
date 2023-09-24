import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:todorealm/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:todorealm/features/todo/presentation/pages/todo_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is GoogleSignInSuccessState) {
          showToast('Welcome : ${state.googleUser!.displayName}');

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const TodoPage(),
              ),
              (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is AuthenticationLoadingState
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 50,
                  ),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Sign in'),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<AuthenticationBloc>(context).add(GoogleSignInEvent());
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(10),
                          height: 45,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.purpleAccent.withOpacity(0.3),
                                offset: const Offset(1, 1),
                                blurRadius: 3.5,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Image.asset('assets/icons/google.png'),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
