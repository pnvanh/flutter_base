// ignore_for_file: depend_on_referenced_packages, unused_import, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class APIBaseInput extends Equatable {
  final String url;
  final Map<String, String>? urlParams;
  final Map<String, String>? body;
  Map<String, String>? headers;

  APIBaseInput({required String url, this.urlParams, this.body, this.headers})
      : assert(url != null),
        this.url = url;

  @override
  List<Object> get props => [url];
}
