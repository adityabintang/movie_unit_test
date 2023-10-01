import 'package:equatable/equatable.dart';

class ServerException implements Exception {}

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}