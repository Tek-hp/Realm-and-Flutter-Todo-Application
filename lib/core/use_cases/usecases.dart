import 'package:equatable/equatable.dart';

abstract class UseCase<ResponseType, RequestType> {
  ResponseType call(RequestType params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
