import 'package:flutter_application/utils/http_manager/error_builder.dart';

class ResultData {
  dynamic result;
  ErrorBuilder? err;

  ResultData(this.result, this.err);
}