import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotifyclone/common/widgets/app_bar/app_bar.dart';
import 'package:spotifyclone/common/widgets/button/basic_app_button.dart';
import 'package:spotifyclone/core/configs/assets/app_vectors.dart';
import 'package:spotifyclone/data/models/auth/create_user_req.dart';
import 'package:spotifyclone/domain/usecases/auth/sign_up.dart';
import 'package:spotifyclone/presentation/authentication/pages/sign_in.dart';
import 'package:spotifyclone/presentation/root/pages/root.dart';
import 'package:spotifyclone/service_locator.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      bottomNavigationBar: _signInText(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              const SizedBox(height: 50),
              _fullNameField(context, _fullNameController),
              const SizedBox(height: 20),
              _emailField(context, _emailController),
              const SizedBox(height: 20),
              _passwordField(context, _passwordController),
              const SizedBox(height: 40),
              BasicAppButton(
                onPressed: () async {
                  var result = await sl<SignUpUseCase>().call(
                    params: CreateUserReq(
                      fullName: _fullNameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    ),
                  );

                  result.fold(
                    (failed) {
                      var snackBar = SnackBar(
                        content: Text(failed),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    (success) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const RootPage(),
                        ),
                        (route) => false,
                      );
                    },
                  );
                },
                title: 'Create Account',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Register',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _fullNameField(
      BuildContext context, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Full Name',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailField(BuildContext context, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Enter email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(
      BuildContext context, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Password',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Do you have an account? ',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SignInPage(),
                ),
              );
            },
            child: const Text(
              'Sign In',
            ),
          )
        ],
      ),
    );
  }
}
