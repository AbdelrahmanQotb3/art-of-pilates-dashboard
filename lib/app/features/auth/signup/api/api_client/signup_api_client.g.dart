// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _SignupApiClient implements SignupApiClient {
  _SignupApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://localhost:3000/'; // Taken from EndPoints.baseUrl
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<SignupResponse> signup(Map<String, dynamic> body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);

    final _result = await _dio.fetch<Map<String, dynamic>>(
      _setStreamType<SignupResponse>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(
              _dio.options,
              'auth/signup', // This comes from EndPoints.signup
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
      ),
    );

    // This part maps the JSON response to your SignupResponse class
    final value = SignupResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? clientBaseUrl) {
    if (clientBaseUrl == null || clientBaseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(clientBaseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
