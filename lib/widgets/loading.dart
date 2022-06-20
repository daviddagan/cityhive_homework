import 'package:cityhive_homework/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget circularProgress() {
  return Center(
    child: SizedBox(height: SizeConfig.screenHeight / 5, width: SizeConfig.screenHeight / 5, child: const CircularProgressIndicator()),
  );
}
