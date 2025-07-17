import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goliaths/routes.dart';


/* TODO: todos
* image_picker ios setup
* figma: https://www.figma.com/design/0a34jry4cWjBEm7pSV1J5W/GFLEXX99?node-id=0-1&p=f&t=gLGFAjS8ZjMy4eHd-0
* */
void main() async{
  await ScreenUtil.ensureScreenSize();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // FULLY transparent
      statusBarIconBrightness: Brightness.dark, // or Brightness.light
    ),
  );
  runApp(const AppRoutes());
}

