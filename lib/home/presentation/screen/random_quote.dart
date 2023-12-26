import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:screenshot/screenshot.dart';
import 'package:signify_demo_app/core/utilities/strings.dart';
import 'package:signify_demo_app/home/presentation/bloc/random_quote_event.dart';
import 'package:signify_demo_app/home/presentation/widget/default_widget.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../bloc/random_quote_bloc.dart';
import '../bloc/random_quote_state.dart';

void main() {
  runApp(const RandomQuoteApp());
}

class RandomQuoteApp extends StatelessWidget {
  const RandomQuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Random Quote Generator',
      home: RandomQuoteScreen(),
    );
  }
}

class RandomQuoteScreen extends StatefulWidget {
  const RandomQuoteScreen({super.key});

  @override
  State<RandomQuoteScreen> createState() => _RandomQuoteScreenState();
}

class _RandomQuoteScreenState extends State<RandomQuoteScreen> {
  final _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    HttpOverrides.global = MyHttpOverrides();
    const CircularProgressIndicator();
    BlocProvider.of<RandomQuoteBloc>(context).add((GetRandomSectionEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RandomQuoteBloc, RandomQuoteState>(
        builder: (context, state) {
          if (state is RandomQuoteInitialState) {
            EasyLoading.show(
              status: 'loading...',
              maskType: EasyLoadingMaskType.black,
            );
            return const DefaultWidget();
          } else if (state is RandomQuoteLoadingState) {
            EasyLoading.show(
              status: 'loading...',
              maskType: EasyLoadingMaskType.black,
            );
            return const DefaultWidget();
          } else if (state is RandomQuoteLoadedState) {
            var quote = state.randomQuoteData.content;
            EasyLoading.dismiss();
            return randomQuoteLayout(context, quote!, _screenshotController);
          } else if (state is RandomQuoteErrorState) {
            if (state.error == AppStrings.noInternetError) {
              EasyLoading.dismiss();
              return noInternetLayout(context, state.quote);
            } else {
              return const DefaultWidget();
            }
          } else {
            return const DefaultWidget();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _takeScreenshot();
        },
        child: const Icon(
          Icons.share_rounded,
          color: Colors.black,
        ),
      ),
    );
  }

  void _takeScreenshot() async {
    final uint8List = await _screenshotController.capture();
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/customerPhotos.png');
    await file.writeAsBytes(uint8List as List<int>);
    final xFile = XFile(file.path);
    await Share.shareXFiles([xFile]);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Widget randomQuoteLayout(
    BuildContext context, String quote, ScreenshotController screenController) {
  return Screenshot(
    controller: screenController,
    child: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppStrings.backgroundImagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55),
            child: Text(
              quote,
              style: const TextStyle(
                  fontSize: 40,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Cookie',
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Trajan Pro')),
                  onPressed: () {
                    BlocProvider.of<RandomQuoteBloc>(context)
                        .add(GetRandomSectionEvent());
                  },
                  child: const Text('Get next Quote'))),
        ],
      ),
    ),
  );
}

Widget noInternetLayout(BuildContext context, String quote) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(AppStrings.backgroundImagePath),
        fit: BoxFit.cover,
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 55),
              child: Text(
                "No Internet Connection",
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Trajan Pro',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                quote,
                style: const TextStyle(
                    fontFamily: 'Cookie',
                    fontSize: 40,
                    fontStyle: FontStyle.italic,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal)),
              onPressed: () {
                 EasyLoading.show(
                  status: 'loading...',
                  maskType: EasyLoadingMaskType.black,
                );
                BlocProvider.of<RandomQuoteBloc>(context)
                    .add(GetRandomSectionEvent());
              },
              child: const Text(
                'Try again',
                style: TextStyle(
                  fontFamily: 'Trajan Pro',
                ),
              )),
        ],
      ),
    ),
  );
}
