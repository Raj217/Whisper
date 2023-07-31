library version_control;

// ============================ Necessities ===========================
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ============================ Controllers =============================
part 'controllers/version_controller.dart';

// ============================ Utils =============================
part 'utils/version_utils.dart';

// ============================ Widgets =============================
part 'widgets/update_button.dart';
