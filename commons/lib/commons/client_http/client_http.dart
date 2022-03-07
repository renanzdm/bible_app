import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

class ClientHttp extends DioForNative{
@override
set options(BaseOptions _options) {
    _options = BaseOptions(
      baseUrl: 'http://blabla.com'
    );
    super.options = _options;
  }


}