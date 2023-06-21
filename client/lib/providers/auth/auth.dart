library auth;

// =================== Necessary Imports =================
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whisper/configs/config.dart';

// =================== Parts ==================
part "controllers/authenticator.dart";
part 'models/auth_exception.dart';
part "models/auth_exception_handler.dart";
part "notifiers/auth_state_notifier.dart";
part "states/auth_state.dart";
