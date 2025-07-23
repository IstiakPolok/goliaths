import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:math' as math;

import 'package:awesome_calendart/awesome_calendart.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goliaths/network_caller/endpoints.dart';
import 'package:goliaths/pages/_pages.dart';
import 'package:goliaths/pages/settings/controllers/ProfileController.dart';
import 'package:goliaths/routes.dart';
import 'package:goliaths/services_class/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lunary/lunary.dart';
import 'package:permission_handler/permission_handler.dart';



import '../theme.dart';

part './buttons.dart';
part './utilities.dart';
part './bars.dart';
part './custom_widgets.dart';
part './modals.dart';
part './input.dart';
