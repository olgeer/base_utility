import 'package:base_utility/base_utility.dart';
import 'package:cron/cron.dart';

typedef eventCall = Function(dynamic value);
typedef actionCall = Function();
typedef voidProc = Function();

enum RequestMethod { get, post }

extension MatchExtension on Schedule {
  bool match(DateTime now) {
    if (seconds?.contains(now.second) == false) return false;
    if (minutes?.contains(now.minute) == false) return false;
    if (hours?.contains(now.hour) == false) return false;
    if (days?.contains(now.day) == false) return false;
    if (months?.contains(now.month) == false) return false;
    if (weekdays?.contains(now.weekday) == false) return false;
    return true;
  }
}

extension TranslateExtension on String {
  String tl({List<String>? args}) {
    String tmp = this;
    while (tmp.contains("{}") && !(args?.isEmpty ?? true)) {
      tmp = tmp.replaceFirst("{}", args!.removeAt(0));
    }
    return tmp;
  }
}

///按一定时间间隔重复执行processer方法，方法调用后立即执行processer方法，如millisecondInterval不为null则按此间隔继续执行
void intervalAction(actionCall? processer, {List<int>? millisecondInterval}) {
  if (processer != null) {
    processer();
    if ((millisecondInterval?.isNotEmpty ?? false) == true) {
      for (int i in millisecondInterval!) {
        Future.delayed(Duration(milliseconds: i), processer);
      }
    }
  }
}

/// Do nothing function
void DNT() {}

class Cache {
  static GetStorage _cache = GetStorage();

  Cache();

  Future<void> init() async {
    try {
      if (!(await _cache.initStorage)) {
        await GetStorage.init();
      }
    } catch (err) {
      throw err;
    }
  }

  T? read<T>(String key) {
    return _cache.read(key);
  }

  Future<void> write(String key, dynamic value) async {
    _cache.write(key, value);
  }

  Future<void> remove(String key) async {
    _cache.remove(key);
  }
}