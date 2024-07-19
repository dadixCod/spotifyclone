import 'package:dartz/dartz.dart';
import 'package:spotifyclone/data/models/auth/create_user_req.dart';
import 'package:spotifyclone/data/models/auth/signin_user_req.dart';
import 'package:spotifyclone/data/sources/auth/auth_firebase_service.dart';
import 'package:spotifyclone/domain/repository/auth/auth.dart';
import 'package:spotifyclone/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signIn(SigninUserReq signinUserReq) async {
    return await sl<AuthFirebaseService>().signIn(signinUserReq);
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    return await sl<AuthFirebaseService>().signUp(createUserReq);
  }
}
