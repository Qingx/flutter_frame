class HttpConfig {
  static const Get = "get";
  static const Post = "post";
  static const EmptySign = "EMPTY_SIGN";
  static const EmptyToken = "EMPTY_TOKEN";

  static final globalEnv = DevEnv();

  static String fullUrl(String url) {
    if (url == null || url.isEmpty) {
      return "";
    }

    if (url.startsWith(r'http')) {
      return url;
    } else if (url.startsWith(r'/')) {
      return "${globalEnv.baseUrl}$url";
    } else {
      return "${globalEnv.baseUrl}/$url";
    }
  }
}

abstract class IEnv {
  /// 判断是否为开发模式
  bool get isDebug;

  /// 网络接口
  String get baseUrl;

  /// 文件上传
  String get fileUrl;

  /// 文件下载
  String get downUrl;
}

class DevEnv extends IEnv {
  @override
  String get baseUrl {
    return "http://api.tianjiemedia.com"; //阿里云
    return "http://192.168.1.142:8087"; //叶
    return "http://192.168.1.125:8088"; //李
  }

  @override
  bool get isDebug => true;

  @override
  String get fileUrl => "http://file-tr.hii-m.net";

  @override
  String get downUrl => "http://download-tr.hii-m.net";
}
