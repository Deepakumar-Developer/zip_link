import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zip_link/functions/app_function.dart';

import '../widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController urlInputController = TextEditingController();
  bool onLoad = false;

  @override
  Widget build(BuildContext context) {
    customStatusBar(
      Colors.black,
      Colors.black,
      Brightness.light,
      Brightness.light,
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment(0, 0),
          children: [
            Container(
              padding: EdgeInsets.all(18),
              height: height(context),
              width: width(context),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/appLogo.png',
                      width: width(context) * 0.3,
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 1.5,
                      children: [
                        ZipText(
                          str: 'Zip',
                          size: 36,
                          weight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        GradientText('Link', size: 36, underline: false),
                      ],
                    ),
                    SizedBox(height: 8),
                    ZipText(
                      str: 'Your Instant URL Shortener',
                      size: 16,
                      weight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 32),
                    UrlInput(controller: urlInputController),
                    SizedBox(height: 24),
                    MyButton(
                      name: 'Zip It!',
                      onPressed: () async {
                        print("the button is pressed");
                        if (urlInputController.text.isEmpty) {
                          showToast(context, 'Nothing to Zip!');
                          return;
                        }
                        if (urlInputController.text.startsWith('http://') ||
                            urlInputController.text.startsWith('https://')) {
                          setState(() {
                            onLoad = true;
                          });
                          String data = await generateShortLink(
                            urlInputController.text,
                            context,
                          );
                          setState(() {
                            code = data;
                            onLoad = false;
                          });
                        } else {
                          showToast(context, 'Please enter a valid URL!');
                        }
                      },
                    ),
                    SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ZipText(str: 'Your Zipped Link:', size: 16),
                    ),
                    SizedBox(height: 12),
                    ZippedLinkField(),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: onLoad,
              child: Container(
                height: height(context),
                width: width(context),
                color: Colors.black54,
                child: Center(
                  child: SpinKitDancingSquare(
                    color: Theme.of(context).colorScheme.primary,
                    size: 80.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
