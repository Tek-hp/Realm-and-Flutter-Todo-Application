import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oktoast/oktoast.dart';
import 'package:todorealm/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:todorealm/core/service_locator/service_locator.dart' as service_locator;
import 'package:todorealm/features/authentication/presentation/pages/login_page.dart';
import 'package:todorealm/features/todo/presentation/bloc/todo_bloc.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');

  await service_locator.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      position: ToastPosition.bottom,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => service_locator.locator<AuthenticationBloc>(),
          ),
          BlocProvider(
            create: (context) => TodoBloc(),
          ),
        ],
        child: MaterialApp(
          title: 'Realm Todo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const LoginPage(),
        ),
      ),
    );
  }
}
