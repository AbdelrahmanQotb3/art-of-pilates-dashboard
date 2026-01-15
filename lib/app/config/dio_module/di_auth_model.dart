import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/core/utils/end_points.dart';

@module
abstract class DiAuthModel {
  @singleton
  Dio get dio => Dio(BaseOptions(baseUrl: EndPoints.baseUrl));
}
