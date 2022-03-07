import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:qinghe_ios/config/user_config.dart';
import 'package:qinghe_ios/data/config/base_data.dart';
import 'package:qinghe_ios/data/config/base_page.dart';
import 'package:qinghe_ios/data/config/http_config.dart';
import 'package:qinghe_ios/data/config/page_data.dart';
import 'package:qinghe_ios/data/config/page_param.dart';
import 'package:rxdart/rxdart.dart';

class BaseApi {
  static Dio? _dio;
  static Dio? _fileDio;
  static BaseApi? mIns;

  static BaseApi get ins {
    if (mIns == null) {
      mIns = BaseApi();
    }
    return mIns!;
  }

  /// 获取通用接口dio
  static Dio _getDio() {
    if (_dio == null) {
      _dio = _createDio(false);
    }
    return _dio!;
  }

  /// 获取文件上传dio
  static Dio _getFileDio() {
    if (_fileDio == null) {
      _fileDio = _createDio(true);
    }
    return _fileDio!;
  }

  /// 创建dio
  static Dio _createDio(bool isFileDio) {
    BaseOptions options = BaseOptions();
    options.baseUrl =
        isFileDio ? HttpConfig.globalEnv.fileUrl : HttpConfig.globalEnv.baseUrl;
    options.connectTimeout = 16000;
    options.receiveTimeout = isFileDio ? 48000 : 16000;
    options.sendTimeout = isFileDio ? 48000 : 16000;

    Dio dio = Dio(options);

    dio.interceptors.add(HttpInterceptor());
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }

  /// 发起Get请求
  Observable<BaseData<T>> get<T>(String pathOrUrl,
          {Map<String, dynamic>? queryParameters}) =>
      Observable.fromFuture(_http<T>(pathOrUrl, HttpConfig.Get,
          queryParameters: queryParameters!));

  /// 发起Post请求
  Observable<BaseData<T>> post<T>(
    String pathOrUrl, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? requestBody,
  }) =>
      Observable.fromFuture(_http<T>(pathOrUrl, HttpConfig.Post,
          queryParameters: queryParameters, requestBody: requestBody));

  /// 发起网络请求
  Future<BaseData<T>> _http<T>(String pathOrUrl, String method,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? requestBody}) async {
    Response? response;
    try {
      if (HttpConfig.Get == method) {
        response = await _getDio()
            .get(pathOrUrl, queryParameters: queryParameters ?? {});
      } else if (HttpConfig.Post == method) {
        response = await _getDio().post(pathOrUrl,
            queryParameters: queryParameters ?? {}, data: requestBody ?? {});
      }

      final temp = response?.data;
      BaseData<T> data;

      if (temp.runtimeType.toString() == "String") {
        final res = json.decode(temp);
        data = json2WLData<T>(res);
      } else {
        data = json2WLData<T>(temp);
      }

      return data;
    } on DioError catch (error) {
      if (error.message.startsWith("SocketException")) {
        return Future.error(SocketMiss());
      } else {
        return Future.error(BaseMiss());
      }
    }
  }

  /// Page发起Get请求
  Observable<BasePage<T>> getPage<T>(String pathOrUrl,
          {Map<String, dynamic>? queryParameters}) =>
      Observable.fromFuture(_httpPage(pathOrUrl, HttpConfig.Get,
          queryParameters: queryParameters));

  /// Page发起Post请求
  Observable<BasePage<T>> postPage<T>(String pathOrUrl,
          {Map<String, dynamic>? queryParameters,
          Map<String, dynamic>? requestBody}) =>
      Observable.fromFuture(_httpPage(pathOrUrl, HttpConfig.Post,
          queryParameters: queryParameters, requestBody: requestBody));

  /// Page发起网络请求
  Future<BasePage<T>> _httpPage<T>(String pathOrUrl, String method,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? requestBody}) async {
    Response? response;
    try {
      if (HttpConfig.Get == method) {
        response = await _getDio()
            .get(pathOrUrl, queryParameters: queryParameters ?? {});
      } else if (HttpConfig.Post == method) {
        response = await _getDio().post(pathOrUrl,
            queryParameters: queryParameters ?? {}, data: requestBody ?? {});
      }

      final temp = response?.data;

      BasePage<T> data = json2WLPage(temp);
      return data;
    } on DioError catch (error) {
      print(error);
      if (error.message.startsWith("SocketException")) {
        return Future.error(SocketMiss());
      } else {
        return Future.error(BaseMiss());
      }
    }
  }

  /// 创建参数
  Map<String, dynamic> createParam(void doCreate(Map<String, dynamic> param)) {
    final param = <String, dynamic>{};
    doCreate(param);

    return param;
  }

  static var fileTime = 0;

  /// 获取全局唯一ID
  String getUID() =>
      "flutter_${DateTime.now().microsecondsSinceEpoch}_${fileTime++}_${Random().nextInt(10000000)}";

  /// 请求上传文件
  Future<BaseData<String>> actualUpload(String path) async {
    final index = path.lastIndexOf(".");
    String? postX;

    if (index > 0) {
      postX = path.substring(index);
      if (postX.length > 8) {
        postX = null;
      }
    }

    try {
      Map<String, dynamic> map = Map();
      map["file"] = await MultipartFile.fromFile(path);

      ///通过FormData
      FormData formData = FormData.fromMap(map);

      ///发送post
      Response response = await _getFileDio().post(
        "/api/check-file/upload-file/${getUID()}${postX ?? ".png"}",
        data: formData,
        onSendProgress: (int progress, int total) {
          ///这里是发送请求回调函数
          print("当前进度是 $progress 总进度是 $total");
        },
      );

      final temp = response.data;

      return json2WLData(temp);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  /// 上传文件
  Observable<String> uploadFile(String path) {
    return Observable.fromFuture(actualUpload(path)).rebase().refreshSign();
  }

  ///上传多个文件
  Observable<List<String>> uploadFiles(List<String> paths) {
    return Observable.fromIterable(paths)
        .concatMap((value) => uploadFile(value))
        .toList()
        .asObservable();
  }

  /// 全局获取文件签名
  static Observable<String> globalSign =
      ins.refreshSign().shareReplay(maxSize: 1);

  static var tokenTime = 0;
  static Observable<String>? globalToken;


  // Observable<T> autoToken<T>(Observable<T> call()) {
  //   var count = 0;
  //   return Observable.retryWhen(() => call(), (e, s) {
  //     if (e.runtimeType == TempUserMiss && count++ < 2) {
  //       return BaseApi.getGlobalToken().doOnData((event) {
  //         UserConfig.getIns().token = event;
  //       });
  //     } else if (e.runtimeType == UserMiss && count++ < 2) {
  //       return BaseApi.getGlobalRefresh().doOnData((event) {
  //         UserConfig.getIns().token = event;
  //       });
  //     } else {
  //       return Observable.error(e);
  //     }
  //   });
  // }

  // static Observable<String>? getGlobalToken() {
  //   final nowTime = DateTime.now().millisecondsSinceEpoch;
  //
  //   if ((nowTime - tokenTime).abs() > 10000) {
  //     tokenTime = nowTime;
  //     globalToken = null;
  //   }
  //
  //   return globalToken ??= Observable.defer(() {
  //     var tempId = UserConfig.getIns().tempId;
  //
  //     return UserApi.ins().obtainTempLogin(tempId).map((event) {
  //       UserConfig.getIns().setTempId = tempId;
  //       UserConfig.getIns().token = event.token;
  //       Global.user.setUser(event.userInfo);
  //
  //       return event.token;
  //     });
  //   }).shareReplay(maxSize: 1) as Observable<String>?;
  // }

  // static var refreshTime = 0;
  // static Observable<String>? globalRefresh;
  //
  // static Observable<String>? getGlobalRefresh() {
  //   final nowTime = DateTime.now().millisecondsSinceEpoch;
  //
  //   if ((nowTime - refreshTime).abs() > 10000) {
  //     refreshTime = nowTime;
  //     globalRefresh = null;
  //   }
  //
  //   return globalRefresh ??= Observable.defer(() {
  //     return UserApi.ins().obtainRefreshUser().map((event) {
  //       UserConfig.getIns().token = event.token;
  //       Global.user.setUser(event.userInfo);
  //
  //       return event.token;
  //     });
  //   }).shareReplay(maxSize: 1) as Observable<String>?;
  // }

  /// 刷新文件签名
  Observable<String> refreshSign() => post<String>("/api/file/sign").rebase();
}

/// 请求拦截器
class HttpInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options,RequestInterceptorHandler handler) async {
    options.headers['sign'] = UserConfig.getIns().sign;

    var token = UserConfig.getIns().token;

    if (token == null || token.isEmpty || token.length < 25) {
      token = "DEFAULT_TOKEN";
    }

    options.headers['Authorization'] = token;
    return super.onRequest(options,handler);
  }
}

class BaseMiss extends Error {
  int code;
  String msg;

  BaseMiss({this.code = -1, this.msg = "服务异常, 请稍后再试"});
}

class SocketMiss extends BaseMiss {
  SocketMiss() : super(code: -100, msg: "网络异常，请检查网络设置");
}

class TempUserMiss extends BaseMiss {
  TempUserMiss() : super(code: -10, msg: "用户登录失效, 请重新登录");
}

class UserMiss extends BaseMiss {
  UserMiss() : super(code: -6, msg: "用户未登录或身份异常");
}

class SignMiss extends BaseMiss {
  SignMiss() : super(code: -2, msg: "文件签名异常, 请稍后再试");
}

class EmptyMiss extends BaseMiss {
  EmptyMiss() : super(code: -1, msg: "暂无数据, 请稍后再试");
}

extension ObservableData<T> on Observable<BaseData<T>> {
  /// 转换接口调用成功后的数据
  Observable<T> rebase() {
    return this.map((event) {
      if (event.success) {
        return event.data;
      }

      throw _resolveError(event);
    }).delay(Duration(milliseconds: 100));
  }

  /// 判断接口是否调用成功, 成功这返回true, 否则抛出异常
  Observable<bool> success() {
    return this.map((event) {
      if (event.success) {
        return true;
      }

      throw _resolveError(event);
    }).delay(Duration(milliseconds: 100));
  }
}

extension ObservablePage<T> on Observable<BasePage<T>> {
  /// 转换接口调用成功后的数据
  Observable<Page<T>> rebase({PageParam? pageParam}) {
    return this.map((event) {
      if (event.success) {
        if (pageParam != null) {
          if (event.data is Page) {
            final page = event.data;

            /// 自动驱动到下一页
            pageParam.next(page!.current);
          }
        }
        return event.data;
      }

      throw _resolveError(event);
    }).delay(Duration(milliseconds: 100));
  }
}

extension ObservableEx<T> on Observable<T> {
  /// 刷新sign
  Observable<T> refreshSign() {
    int errorCount = 0;
    return Observable.retryWhen(() => this, (e, s) {
      if (e.runtimeType != SignMiss || errorCount++ > 2) {
        return Observable.error(e);
      }
      return BaseApi.globalSign.doOnData((event) {
        UserConfig.getIns().sign = event;
      });
    });
  }

  /// 自动刷新token
  // Observable<T> autoToken() {
  //   Observable<T> source = this;
  //
  //   return Observable.retryWhen(() => source, (e, s) {
  //     if (e.runtimeType == TempUserMiss) {
  //       return BaseApi.getGlobalToken().doOnData((event) {
  //         UserConfig.getIns().token = event;
  //       });
  //     } else {
  //       return Observable.error(e);
  //     }
  //   });
  // }
}

/// 确定业务异常
Error _resolveError(DataSource event) {
  if (event.code == -10) {
    return TempUserMiss();
  }

  if (event.code == -6) {
    return UserMiss();
  }

  if (event.code == -2) {
    return SignMiss();
  }

  var msg = event.msg;
  if (msg == null || msg == "") {
    return BaseMiss(code: event.code);
  }

  return BaseMiss(code: event.code, msg: msg);
}
