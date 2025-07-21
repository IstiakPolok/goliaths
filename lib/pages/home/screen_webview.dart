import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import '../_pages.dart';

class ScreenWebview extends StatelessWidget {
  final String url;

  const ScreenWebview({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                print("🔄 Page started loading: $url");
              },
              onPageFinished: (url) {
                print("✅ Page finished loading: $url");
              },
              onNavigationRequest: (request) {
                print("📡 Navigating to: ${request.url}");

                if (request.url.contains('payment-success')) {
                  print(
                    "🎉 Success URL detected! Navigating to ScreenDonationComplete",
                  );
                  Get.offAll(() => ScreenDonationComplete());
                  return NavigationDecision.prevent;
                }

                return NavigationDecision.navigate;
              },

              onWebResourceError: (error) {
                print("❌ Web resource error: ${error.description}");
              },
            ),
          )
          ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: WebViewWidget(controller: controller),
    );
  }
}
