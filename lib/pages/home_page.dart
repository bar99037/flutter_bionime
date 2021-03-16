import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bionime/model/Language.dart';
import 'package:flutter_bionime/model/Locales.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(padding: EdgeInsets.all(8.w),
              child: DropdownButton<Language>(
                icon: Icon(
                    Icons.language,
                    color: Colors.white
                ),
                onChanged: (Language language){
                  context.setLocale(language.locale);
                },
                items: languages.map<DropdownMenuItem<Language>>(
                        (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Text(
                          e.name,
                          style: TextStyle(fontSize: 20.sp)
                      ),
                    )
                ).toList(),
              ),
            )
          ],
        ),
        body: Column(
          children: [

          ],
        ),
      ),
    );
  }

}