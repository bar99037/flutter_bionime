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
            return _buildLoadFail(context);
          }
          //加載中
          if(state is DailyLoadInProgress){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          //加載成功
          if(state is DailyLoadSuccess){
            return _buildLoadSuccess(state);
          }
          //Initial
          return Container();
    });
  }

  Widget _buildLoadFail(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
            Icons.error,
            color: Colors.red,
            size: 100.w),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: Text(
            tr('daily_load_fail'),
            style: TextStyle(
                fontSize: 20.sp,
                color: Colors.grey
            ),
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
                fontSize: 18.sp,
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

  Widget _buildLoadSuccess(DailyLoadSuccess state){
    final daily = state.daily;
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        elevation: 10.w,
        child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    tr('daily'),
                    style: TextStyle(
                        fontSize: 40.sp,
                        color: Color(0xFF5B5B5B)
                    )
                ),
                Text(
                    daily.motto,
                    style: TextStyle(
                        fontSize: 24.sp,
                        color: Colors.grey
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
                              color: Color(0xFF5B5B5B),
                              fontWeight: FontWeight.bold
                          )
                      )
                  ),
                )
              ],
            )
        )
    );
  }
}