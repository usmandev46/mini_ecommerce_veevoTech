import 'package:ecommerce_app_veevo_tech/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cubits/theme/theme_cubit.dart';
import 'core/constants/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: AppColors.lightBackground,
              primaryColor: AppColors.primary,
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData.light().textTheme,
              ).apply(
                bodyColor: AppColors.textDark,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: AppColors.darkBackground,
              primaryColor: AppColors.primary,
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData.dark().textTheme,
              ).apply(
                bodyColor: AppColors.textLight,
              )
            ),
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
