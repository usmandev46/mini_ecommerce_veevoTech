import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../cubits/theme/theme_cubit.dart';
import '../../cubits/user/user_cubit.dart';
import '../../cubits/user/user_state.dart';
import '../../services/storage_service.dart';
import '../../services/user_service.dart';
import '../../widgets/custom_loader.dart';
import '../login/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final int userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    void _confirmLogout(BuildContext context) async {
      final shouldLogout = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: const Text('Logout',style: TextStyle(fontWeight: FontWeight.bold),),
          content: const Text('Are you sure you want to logout?',style: TextStyle(fontWeight: FontWeight.w400),),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );

      if (shouldLogout == true) {
        await StorageService().clearToken();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false,
        );
      }
    }


    return BlocProvider(
      create: (_) => UserCubit(ApiService())..fetchUser(userId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: PouringHourGlassRefined());
            } else if (state is UserLoaded) {
              final user = state.user;

              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: const Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      '📧 ${user.email}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      '👤 Username: ${user.username}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      '📱 Phone: ${user.phone}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    const Divider(),

                    const SizedBox(height: 20),

                    Text(
                      '🏠 Address:',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${user.address.number}, ${user.address.street},\n${user.address.city}, ${user.address.zipcode}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    Spacer(),

                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<ThemeCubit>().toggleTheme();
                      },
                      icon: Icon(
                        isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                      ),
                      label: Text(
                        isDarkMode
                            ? 'Switch to Light Mode'
                            : 'Switch to Dark Mode',
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    ElevatedButton.icon(
                      onPressed: () => _confirmLogout(context),
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 24,
                        ),
                        textStyle: GoogleFonts.poppins(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('No user data available'));
            }
          },
        ),
      ),
    );
  }
}
