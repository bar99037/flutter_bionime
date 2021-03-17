import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bionime/model/Locales.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_bionime/main.dart';

void main() async{
  await EasyLocalization.ensureInitialized();

  testWidgets('change laguage to CN', (WidgetTester tester) async {
    await tester.pumpWidget(EasyLocalization(
      supportedLocales: languages.map<Locale>((e) => e.locale).toList(),
      fallbackLocale: languages.first.locale,
      path: 'resources/langs',
      child: MyApp(),
    ));
    await tester.pump();

    //step1 點選語言Icon
    await tester.tap(find.byKey(Key('languageButton')));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    //檢查是否有找到簡體中文選項
    expect(find.text("簡體中文"), findsOneWidget);

    //step2 點選簡體中文
    await tester.tap(find.text("簡體中文"));
    await tester.pump();

    //檢查是否有找到簡體中文標題 BIONIME 面试题目
    expect(find.text('BIONIME 面试题目'), findsOneWidget);
  });

  testWidgets('change laguage to TW', (WidgetTester tester) async {
    await tester.pumpWidget(EasyLocalization(
      supportedLocales: languages.map<Locale>((e) => e.locale).toList(),
      fallbackLocale: languages.first.locale,
      path: 'resources/langs',
      child: MyApp(),
    ));
    await tester.pump();

    //step1 點選語言Icon
    await tester.tap(find.byKey(Key('languageButton')));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    //檢查是否有找到繁體中文選項
    expect(find.text("繁體中文"), findsOneWidget);

    //step2 點選繁體中文
    await tester.tap(find.text("繁體中文"));
    await tester.pump();

    //檢查是否有找到繁體中文標題 BIONIME 面試題目
    expect(find.text('BIONIME 面試題目'), findsOneWidget);
  });

  testWidgets('change laguage to US', (WidgetTester tester) async {
    await tester.pumpWidget(EasyLocalization(
      supportedLocales: languages.map<Locale>((e) => e.locale).toList(),
      fallbackLocale: languages.first.locale,
      path: 'resources/langs',
      child: MyApp(),
    ));
    await tester.pump();

    //step1 點選語言Icon
    await tester.tap(find.byKey(Key('languageButton')));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    //檢查是否有找到英語選項
    expect(find.text("English"), findsOneWidget);

    //step2 點選English
    await tester.tap(find.text("English"));
    await tester.pump();

    //檢查是否有找到英文標題 BIONIME interview questions
    expect(find.text('BIONIME interview questions'), findsOneWidget);
  });
}
