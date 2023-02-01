import 'package:bilibili_test/db/hi_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 单元测试

void main() {
  test("测试本地存储", () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await HiCache.preInit();
    var key = "hichace_test", value = "hello";
    HiCache.getInstance().saveString(key, value);
    expect(HiCache.getInstance().getString(key), value);
  });
}
