import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Failure extends Equatable {
  final String error;
  final String message;
  Failure({
    @required this.error,
    @required this.message,
  });

  @override
  // TODO: implement stringify
  bool get stringify => true;

  @override
  List<Object> get props => [error, message];
}
