import 'package:flutter/material.dart';
import 'package:flutter_bionime/model/Locales.dart';
import 'package:flutter_bionime/pages/home_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pharmacies_repository/pharmacies_repository.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PharmacyAdapter());

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
        title: tr('title'),
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