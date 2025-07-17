import 'dart:math';

import 'package:awesome_calendart/awesome_calendart.dart';
import 'package:country_list/country_list.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goliaths/components/_components.dart';
import 'package:goliaths/model/_models.dart';
import 'package:goliaths/pages/authentication/controllers/register_controller.dart';
import 'package:goliaths/routes.dart';
import 'package:goliaths/theme.dart';
import 'package:lunary/lunary.dart';
import '../data/_data.dart';

/* authentication - screens ============================================================*/
part './authentication/screen_auth_entry.dart';
part './authentication/screen_login.dart';
part './authentication/screen_register.dart';
part './authentication/screen_create_password.dart';
part './authentication/screen_verify_email.dart';
part './authentication/screen_verify_otp.dart';
part './authentication/screen_password_change_success.dart';

/* home - screens ============================================================*/
part './home/screen_home.dart';
part './home/screen_chat.dart';
part './home/screen_donation_home.dart';
part './home/screen_donation_detail.dart';
part './home/screen_donation_amount.dart';
part './home/screen_donation_complete.dart';
part './home/screen_history.dart';
part './home/controller_home.dart';
part './home/controller_donation.dart';
part './home/controller_history.dart';

/* onboard ===================================================================*/
part './onboard/controller_onboard.dart';
part './onboard/screen_avatar_detail.dart';
part './onboard/screen_avatar_list.dart';
part './onboard/screen_country.dart';
part './onboard/screen_dob.dart';
part './onboard/screen_splash.dart';
part './onboard/screen_ai_type.dart';

/* settings - screens =========================================================*/

part './settings/screen_birthdate.dart';
part './settings/screen_birthday_wish.dart';
part './settings/screen_faq.dart';
part './settings/screen_friends_birth.dart';
part './settings/screen_privacy.dart';
part './settings/screen_profile.dart';
part './settings/screen_settings.dart';
part './settings/screen_subscription.dart';
part './settings/screen_terms.dart';
part './settings/controller_privacy.dart';
part './settings/controller_terms.dart';
part './settings/controller_birth_day.dart';
part './settings/controller_subscription.dart';
