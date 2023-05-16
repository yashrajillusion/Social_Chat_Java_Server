import 'package:chat_app/ui/common/common_app_text/common_app_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

//loader when some method or function calling or processing
class CustomLoading {
  String title = "";
  static progressDialog(
      {required bool isLoading, required BuildContext context, title, noNeedOfLoading = false, double bgOpacity = 0}) {
    if (noNeedOfLoading) return;
    if (!isLoading) {
      Navigator.of(context, rootNavigator: true).pop();
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        useSafeArea: true,
        // barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Container(
                color: Colors.black.withOpacity(bgOpacity),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 64,
                      child: OverflowBox(
                        minHeight: 200,
                        maxHeight: 200,
                        child: Lottie.asset(
                          'assets/animation/bubleChatlotie.json',
                          // 'assets/animation/chatbotfinallotiie.json',
                          repeat: true,
                        ),
                      ),
                    ),
                    CommonAppText(
                      lineHeight: 1.5,
                      fontSize: 12,
                      title: title ?? "",
                      titleColor: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ));
        },
        useRootNavigator: true,
      );
    }
  }
}
