import 'package:flutter/material.dart';
import 'package:flutter_bionime/model/Locales.dart';
import 'package:flutter_bionime/pages/home_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: languages.map<Locale>((e) => e.locale).toList(),
    fallbackLocale: languages.first.locale,
    path: 'resources/langs',
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(600, 800),
      allowFontScaling: false,
      builder: () => MaterialApp(
        title: 'Flutter BIONIME TEST',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      )
    );
  }
}