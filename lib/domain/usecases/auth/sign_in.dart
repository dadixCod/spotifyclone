import 'package:dartz/dartz.dart';
import 'package:spotifyclone/core/usecase/usecase.dart';
import 'package:spotifyclone/data/models/auth/signin_user_req.dart';
import 'package:spotifyclone/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

class SignInUseCase extends Usecase<Either, SigninUserReq> {
  @override
  Future<Either> call({SigninUserReq? params}) async {
    return sl<AuthRepository>().signIn(params!);
  }
}
