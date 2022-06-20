  import 'package:flutter/material.dart';

Widget errorState(String? message) {
    return Text(
      message ?? "Failed load messages",
      style: const TextStyle(color: Colors.red),
    );
  }