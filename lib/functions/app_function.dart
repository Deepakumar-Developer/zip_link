
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:zip_link/widget.dart';

double width(BuildContext context) => MediaQuery.of(context).size.width;
double height(BuildContext context) => MediaQuery.of(context).size.height;

void customStatusBar(var statusBarColor, systemNavigationBarColor,
    statusBarIconBrightness, systemNavigationBarIconBrightness) {
  print('Custom Status Bar Applied');
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: statusBarColor,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: statusBarIconBrightness,
    systemNavigationBarColor: systemNavigationBarColor,
    systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
  ));
}

void showToast(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: ZipText(str: message, size: 14),
      duration: Duration(seconds: 1),
      backgroundColor: Colors.black87,
      behavior: SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      // margin: EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),
    ),
  );
}

String code = '';
final String baseUrl = 'zip-link-api-iiphpp1-deepakumar-developer.globeapp.dev';


Future<void> copyToClipboard(BuildContext context, String code) async {
  if(code.isNotEmpty) {
    await Clipboard.setData(ClipboardData(text: '$baseUrl/$code'));
    showToast(context, 'Copied to Clipboard');
  } else {
    showToast(context, 'Nothing in Zip!');
  }
}

Future<bool> pasteFromClipboard(
    BuildContext context, TextEditingController controller) async {
  final clipboardData = await Clipboard.getData('text/plain');
  if (clipboardData != null && clipboardData.text != null) {
    controller.text = clipboardData.text!;
    return true;
  } else {
    showToast(context, 'Clipboard is empty');
  }
  return false;
}

Future<String> generateShortLink(String longUrl, BuildContext context) async {
  String data = '';
  try {
    final url = Uri.https(baseUrl, '/zip', {'long_url': longUrl});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      data = jsonDecode(response.body)['short_url'];
      print('Short link generated: $data');
      // return data;
    } else {
      showToast(context, 'Failed to generate short link');
      // return '';
    }
  } catch (e) {
    print(e);
    showToast(context, e.toString());
    // return '';
  }
  return data;
}

Future<void> launchURL(String url,BuildContext context) async {
  Uri uri = Uri.parse(url);
  try {
    await launchUrl(uri);
  } on Exception catch (e) {
    showToast(context, 'Unable to Launch');
  }

}