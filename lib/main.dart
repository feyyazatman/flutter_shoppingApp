import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping/core/constants/color_constant.dart';
import 'package:shopping/pages/home/home_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: ColorConstant.instance.appBarColor,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark)),
      home:  const HomeView()
    );
  }
}