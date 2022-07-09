import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

const String title = "App điều khiển gấu từ xa (J4F)";

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    const initialSize = Size(960, 540);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.title = title;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 30,
              child: Row(
                children: [
                  Expanded(
                    child: WindowTitleBarBox(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                            child: Text(
                              title,
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                              ),
                            ),
                          )),
                    ),
                  ),
                  MinimizeWindowButton(),
                  MaximizeWindowButton(),
                  CloseWindowButton(),
                ],
              ),
            ),
            const MyHomePage(),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double volume = 0.0;
  double angryLevel = 0.0;
  final headerTextStyle = GoogleFonts.notoSans(fontSize: 24);

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.all(
      MediaQuery.of(context).size.height / 48,
    );
    final buttonWidth =
        MediaQuery.of(context).size.width / 4; // 1/4 of the window
    final buttonHeight =
        MediaQuery.of(context).size.height / 10; // 1/10 of the window

    return Expanded(
      child: Material(
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hành động",
                    style: headerTextStyle,
                  ),
                  Padding(
                    padding: padding,
                    child: Row(
                      children: [
                        Padding(
                          padding: padding,
                          child: Column(
                            children: [
                              button(
                                "Cười lên",
                                buttonWidth,
                                buttonHeight,
                                null,
                                null,
                                padding,
                                () {},
                              ),
                              button(
                                "Nói \"Em iu anh\"",
                                buttonWidth,
                                buttonHeight,
                                null,
                                null,
                                padding,
                                () {},
                              ),
                              button(
                                "Chọc giận",
                                buttonWidth,
                                buttonHeight,
                                Colors.red,
                                Colors.white,
                                padding,
                                () {
                                  setState(() {
                                    angryLevel =
                                        (Random().nextInt(30) + 70) / 100;
                                  });
                                },
                              ),
                              button(
                                "Giặt đồ",
                                buttonWidth,
                                buttonHeight,
                                null,
                                null,
                                padding,
                                () {},
                              ),
                              button(
                                "Cho con ăn",
                                buttonWidth,
                                buttonHeight,
                                null,
                                null,
                                padding,
                                () {},
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: padding,
                          child: Column(
                            children: [
                              button(
                                "Hát 1 bài",
                                buttonWidth,
                                buttonHeight,
                                null,
                                null,
                                padding,
                                () {},
                              ),
                              button(
                                "Khen đẹp trai",
                                buttonWidth,
                                buttonHeight,
                                null,
                                null,
                                padding,
                                () {},
                              ),
                              button(
                                "Hết giận",
                                buttonWidth,
                                buttonHeight,
                                Colors.green,
                                Colors.white,
                                padding,
                                () {
                                  setState(() {
                                    angryLevel = (Random().nextInt(30)) / 100;
                                  });
                                },
                              ),
                              button(
                                "Lau nhà",
                                buttonWidth,
                                buttonHeight,
                                null,
                                null,
                                padding,
                                () {},
                              ),
                              button(
                                "Cho chồng ăn",
                                buttonWidth,
                                buttonHeight,
                                null,
                                null,
                                padding,
                                () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Âm thanh",
                      style: headerTextStyle,
                    ),
                  ),
                  SizedBox(
                    width: buttonWidth,
                    child: Slider(
                      value: volume,
                      label: volume.round().toString(),
                      max: 100,
                      divisions: 100,
                      onChanged: (newVolume) {
                        setState(() {
                          volume = newVolume;
                        });
                      },
                    ),
                  ),
                  button(
                    "Im!",
                    48,
                    48,
                    Colors.red,
                    Colors.white,
                    padding,
                    () {
                      setState(() {
                        volume = 0;
                      });
                    },
                  ),
                  Padding(
                    padding: padding,
                    child: Text(
                      "Độ tức giận",
                      style: headerTextStyle,
                    ),
                  ),
                  SizedBox(
                    width: buttonWidth,
                    height: buttonHeight / 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: LinearProgressIndicator(
                        value: angryLevel,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: angryLevel >= 0.6
                            ? const AlwaysStoppedAnimation<Color>(Colors.red)
                            : const AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget button(
  String text,
  double? buttonWidth,
  double? buttonHeight,
  Color? buttonColor,
  Color? textColor,
  EdgeInsets? padding,
  Function() onPressed,
) {
  final buttonStyle = ButtonStyle(
    side: MaterialStateProperty.all(
      const BorderSide(width: 0.5, color: Colors.black),
    ),
    backgroundColor: MaterialStateProperty.all(
      buttonColor ?? Colors.transparent,
    ),
  );

  return Padding(
    padding: padding!,
    child: TextButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: SizedBox(
        width: buttonWidth,
        height: buttonHeight,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.notoSans(
                fontSize: 18, color: textColor ?? Colors.black),
          ),
        ),
      ),
    ),
  );
}
