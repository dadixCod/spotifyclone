import 'package:dartz/dartz.dart';
import 'package:spotifyclone/core/usecase/usecase.dart';
import 'package:spotifyclone/data/models/auth/create_user_req.dart';
import 'package:spotifyclone/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

class SignUpUseCase implements Usecase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) {
    return sl<AuthRepository>().signUp(params!);
  }
}
