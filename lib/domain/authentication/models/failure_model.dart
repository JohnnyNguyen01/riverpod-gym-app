import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

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
