import 'package:ecommerce_app_veevo_tech/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../cubits/login/login_cubit.dart';
import '../../cubits/login/login_state.dart';
import '../../services/login_services.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/custom_text_field.dart';
import '../../core/constants/app_colors.dart';
import '../main_navigation/main_navigation_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(ApiService(),StorageService()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Icon(
                        Icons.shopping_cart_rounded,
                        size: 70,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Welcome Back 👋",
                        style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Login to continue shopping",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustomTextField(
                        label: "Username",
                        icon: Icons.person,
                        controller: _usernameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: "Password",
                        icon: Icons.lock,
                        controller: _passwordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccess) {

                            Fluttertoast.showToast(
                              msg: "Login Successful 🎉",
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MainNavigationScreen(),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return const PouringHourGlassRefined();
                          } else if (state is LoginFailure) {
                            Fluttertoast.showToast(
                              msg: state.message,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                            );
                          }

                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<LoginCubit>().login(
                                    _usernameController.text.trim(),
                                    _passwordController.text.trim(),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "Login",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
