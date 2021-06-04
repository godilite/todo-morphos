import 'package:crud_firebase/constants/api_constant.dart';
import 'package:dio/dio.dart';

Future getResquest({
  required String url,
  required Map<String, dynamic> queryParam,
}) async {
  try {
    Dio dio = Dio();
    String route = API_BASE_URL + url;
    // dio.options.contentType = Headers.formUrlEncodedContentType;
    Response response = await dio.get(route, queryParameters: queryParam);
    return response;
  } catch (e) {
    print(e.toString());
  }
}

Future postResquest({
  required String url,
  required Map<String, dynamic> headers,
  required dynamic body,
  required Map queryParam,
}) async {
  try {
    Dio dio = Dio();
    String route = API_BASE_URL + url;
    dio.options.contentType = Headers.formUrlEncodedContentType;
    Response response = await dio.post(
      route,
      data: body,
      options: Options(
        headers: headers,
      ),
    );
    return response;
  } catch (e) {
    print(e.toString());
  }
}
