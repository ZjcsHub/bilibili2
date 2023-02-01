import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class HiDefend {
  run(Widget app) {
    // 框架异常
    FlutterError.onError = (FlutterErrorDetails details) async {
      // 线上环境，走上报逻辑
      if (kReleaseMode) {
        Zone.current.handleUncaughtError(
            details.exception, details.stack ?? StackTrace.current);
      } else {
        FlutterError.dumpErrorToConsole(details);
      }
    };

    runZonedGuarded(
        () => runApp(app), (error, stack) => _reportError(error, stack));
  }

  _reportError(Object e, StackTrace s) {
    print("kreleaseMode:$kReleaseMode , catch error : $e");
  }
}
