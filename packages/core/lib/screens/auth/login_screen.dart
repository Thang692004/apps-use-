import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_config.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  final AppConfig config;

  final Widget nextScreen;

  const LoginScreen({
    super.key,
    required this.config,
    required this.nextScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              config.primaryColor,
              config.secondaryColor,
            ],
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [
                Image.asset(
                  config.logoPath,
                  width: 140,
                ),

                const SizedBox(height: 24),

                Text(
                  config.appName,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  config.slogan,

                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 60),

                Consumer<AuthProvider>(
                  builder: (
                      context,
                      authProvider,
                      child,
                      ) {
                    return CustomButton(
                      title:
                      authProvider
                          .isLoading
                          ? 'Loading...'
                          : 'Continue with Google',

                      icon: Icons.login,

                      color: Colors.black87,

                      onTap: () async {
                        await authProvider
                            .loginWithGoogle();

                        if (context.mounted &&
                            authProvider
                                .isLoggedIn) {
                          Navigator
                              .pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              nextScreen,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}