import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:signify_demo_app/dependency_injection.dart';
import 'package:signify_demo_app/home/presentation/bloc/random_quote_bloc.dart';
import 'package:signify_demo_app/home/presentation/screen/random_quote.dart';

void main() async {
  await init();
  runApp(const RandomQuoteApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}


class RandomQuoteApp extends StatelessWidget {
  const RandomQuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<RandomQuoteBloc>(),
      child: MaterialApp(
        title: 'Random Quote Generator',
        home: const RandomQuoteScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
