library auth;

// =================== Necessary Imports =================
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whisper/configs/config.dart';

// =================== Parts ==================
part "controllers/authenticator.dart";
part 'models/auth_result.dart';
part "notifiers/auth_state_notifier.dart";
part "states/auth_state.dart";
