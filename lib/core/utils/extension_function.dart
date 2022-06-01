// import 'dart:math' as math;

import 'package:byzat_pokemon/core/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension CustomExtension on Widget {
  Color getRandomColor(double opacity, int value) =>
      Color((value * 0xFFFFFF).toInt()).withOpacity(opacity);

  showProgressDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.circular(4),
              ),
              height: 60,
              width: 60,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: ColorConstants.mirage,
              ),
            ),
          ),
          onWillPop: () {
            return Future.value(false);
          },
        );
      },
    );
  }

  showErrorToast({required final String message}) {
    if (message.isEmpty) {
      return;
    }
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorConstants.red,
        textColor: ColorConstants.white,
        fontSize: 16.0);
  }
}

extension MyDioError on DioError {
  getErrorFromDio() {
    if (this.type == DioErrorType.connectTimeout ||
        this.type == DioErrorType.receiveTimeout ||
        this.type == DioErrorType.sendTimeout) {
      return Constants.internetErrorOccurred;
    }
    if (this.response != null && response!.data != null) {
      try {
        final errorMap = response!.data["error"];
        final List<dynamic> errors = errorMap["errors"] as List<dynamic>;
        return "".toErrorMessage(List<String>.from(errors));
      } on Exception {
        return Constants.unknownErrorOccurred;
      }
    }
    return Constants.unknownErrorOccurred;
  }
}

extension MyString on String {
  toErrorMessage(List<String> data) {
    var error = "";
    for (var element in data) {
      error += element + "\n";
    }
    if (error.endsWith("\n")) {
      error = error.substring(0, error.length - 1);
    }
    return error;
  }

  String capitalizeFirstOfEach() {
    if (isEmpty) {
      return "";
    }
    return split(" ")
        .map((str) => "${str[0].toUpperCase()}${str.substring(1)}")
        .join(" ")
        .trim();
  }

  String optimizeString() {
    if (isEmpty) {
      return "";
    }
    return replaceAll("-", " ").trim();
  }
}
