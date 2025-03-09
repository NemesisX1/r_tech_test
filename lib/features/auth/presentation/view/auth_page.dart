import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:repat_event/core/themes/app_colors.dart';
import 'package:repat_event/core/widgets/loader_widget.dart';
import 'package:repat_event/features/auth/presentation/cubit/auth_cubit.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: const AuthView(),
    );
  }
}

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthProcessingState) {
            return const Loader();
          }

          return Center(
            child: ElevatedButton.icon(
              onPressed: () async {
                await context.read<AuthCubit>().signInWithGoogle(
                  onError: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Une erreur est survenue'),
                      ),
                    );
                  },
                ).then((_) {
                  if (context.mounted) context.go('/events');
                });
              },
              icon: Brand(Brands.google),
              label: const Text('Connect with Google'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary, // Use your theme color
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
