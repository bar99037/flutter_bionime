import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacies_repository/pharmacies_repository.dart';

import 'bloc/Pharmacies_state.dart';
import 'bloc/pharmacies_bloc.dart';
import 'bloc/pharmacies_event.dart';

class PharmaicesView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PharmaciesBloc, PharmaciesState>(
        builder: (context, state){
          if(state is PharmaciesLoadInProgress){
            return Center(
              child: CircularProgressIndicator()
            );
          }
          if(state is PharmaciesLoadFail){
            return _buildLoadFail(context);
          }
          if(state is PharmaciesLoadSuccess){
            return _buildLoadSuccess(state);
          }
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
            )
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
            BlocProvider.of<PharmaciesBloc>(context).add(PharmaciesRequested());
          },
        )
      ],
    );
  }

  Widget _buildLoadSuccess(PharmaciesLoadSuccess state){
    return ListView.builder(
        itemBuilder: (context, index){
          final item = state.pharmacies[index];
          return Dismissible(
              key: Key(item.id),
              onDismissed: (direction){
                  BlocProvider.of<PharmaciesBloc>(context).add(PharmaciesDeleted(item));
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${item.name} 已刪除"),
                        duration: Duration(milliseconds: 500),
                      )
                  );
                },
              child: _buildPharmacyItem(item)
          );
          return _buildPharmacyItem(state.pharmacies[index]);
        }
    );
  }

  Widget _buildPharmacyItem(Pharmacy pharmacy){
    return Card(
        margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
        elevation: 10.w,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.w))
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 14.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 7,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    pharmacy.name,
                                    style: TextStyle(
                                        fontSize: 30.sp,
                                        color: Color(0xff4F4F4F)
                                    )
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 16.w),
                                    child: Row(
                                      children: [
                                        Icon(Icons.phone, size: 24.w, color: Colors.green),
                                        Padding(
                                            padding: EdgeInsets.only(left: 10.w),
                                            child: Text(
                                                pharmacy.phone,
                                                style: TextStyle(
                                                    fontSize: 20.sp,
                                                    color: Colors.grey
                                                )
                                            )
                                        )
                                      ],
                                    )
                                )
                              ])
                      ),
                      Expanded(
                        flex: 3,
                          child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Text(
                                  tr('adult'),
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      color: Colors.lightBlue
                                  )
                              ),
                              Text(
                                  "${pharmacy.maskAdult}",
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      color: Color(0xff4F4F4F)
                                  )
                              ),
                            ],
                          )
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              Text(
                                  tr('child'),
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      color: Colors.orangeAccent
                                  )
                              ),
                              Text(
                                  "${pharmacy.maskChild}",
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      color: Color(0xff4F4F4F)
                                  )
                              ),
                            ],
                          )
                          )
                        ],
                      )
                      )
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 8.w),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, size: 24.w, color: Colors.red),
                          Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Text(
                                  pharmacy.address,
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      color: Colors.grey
                                  )
                              )
                          )
                        ],
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.w),
                    child: Row(
                      children: [
                        Icon(Icons.update_outlined, size: 24.w, color: Colors.orangeAccent),
                        Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Text(
                                "${DateFormat("yyyy/MM/dd HH:mm:ss").format(pharmacy.updated)} 更新",
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    color: Colors.grey
                                )
                            )
                        )
                      ],
                    ),
                  )
                ]
            )
        )
    );
  }
}