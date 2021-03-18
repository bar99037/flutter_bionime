import 'package:daily_repository/daily_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bionime/pages/daily/bloc/daily_bloc.dart';
import 'package:flutter_bionime/pages/daily/bloc/daily_event.dart';
import 'package:flutter_bionime/pages/daily/bloc/daily_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyBloc, DailyState>(
        builder: (context, state){
          //加載失敗
          if(state is DailyLoadFail){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                    Icons.error,
                    color: Colors.grey,
                    size: 40.w),
                Text(
                  tr('daily_load_fail'),
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.w),
                              side: BorderSide(color: Colors.grey)
                          )
                      )
                  ),
                  child:Text(
                    tr('reload'),
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black45
                    ),
                  ),
                  onPressed: (){
                    BlocProvider.of<DailyBloc>(context).add(DailyRequested());
                  },
                )
              ],
            );
          }
          //加載中
          if(state is DailyLoadInProgress){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          //加載成功
          if(state is DailyLoadSuccess){
            final daily = state.daily;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  daily.motto,
                  style: TextStyle(
                    fontSize: 24.sp
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.w),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          daily.provenance,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold
                          )
                      )
                  ),
                )
              ],
            );
          }
          //Initial
          return Container();
    });
  }

}