import 'dart:ui';

import 'package:daily_repository/daily_repository.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bionime/pages/daily/bloc/daily_bloc.dart';
import 'package:flutter_bionime/pages/daily/daily_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bionime/model/Language.dart';
import 'package:flutter_bionime/model/Locales.dart';

import 'daily/bloc/daily_event.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('title').tr(),
          actions: [
            Padding(padding: EdgeInsets.all(8.w),
              child: PopupMenuButton<Language>(
                key: Key('languageButton'),
                icon: Icon(
                    Icons.language,
                    color: Colors.white
                ),
                onSelected: (Language language){
                  context.setLocale(language.locale);
                },
                itemBuilder: (context){
                  return languages.map<PopupMenuItem<Language>>(
                          (e) => PopupMenuItem<Language>(
                        value: e,
                        child: Text(
                            e.name,
                            style: TextStyle(fontSize: 20.sp)
                        ),
                      )
                  ).toList();
                },
              ),
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Flexible(
                  child: Container(
                      width: 0.7.sw,
                      child: BlocProvider(
                          create: (_) => DailyBloc(dailyRepository: DailyRepository())..add(DailyRequested()),
                          child: DailyView()
                      )
                  )
              ),
              Divider(color: Colors.black45,thickness: 2.w),
              Flexible(
                flex: 3,
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }

}