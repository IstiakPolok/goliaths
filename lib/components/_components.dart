import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:Goliaths/network_caller/endpoints.dart';
import 'package:Goliaths/pages/_pages.dart';
import 'package:Goliaths/pages/settings/controllers/ProfileController.dart';
import 'package:Goliaths/routes.dart';
import 'package:Goliaths/services_class/shared_preferences_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';

part './buttons.dart';
part './utilities.dart';
part './bars.dart';
part './custom_widgets.dart';
part './modals.dart';
part './input.dart';
