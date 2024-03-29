library auth;

// =================== Necessary Imports =================
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whisper/configs/config.dart';
import 'package:whisper/packages/database/database.dart';
import 'package:whisper/packages/network_engine/network_engine.dart';
import 'dart:convert';

// =================== Parts ==================
part "controllers/authenticator.dart";
part 'models/auth_result.dart';
