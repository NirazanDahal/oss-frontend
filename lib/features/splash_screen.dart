import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/routes/app_routes.dart';
import 'package:oss_frontend/features/auth/blocs/login/login_bloc.dart';
import 'package:oss_frontend/features/auth/blocs/login/login_event.dart';
import 'package:oss_frontend/features/auth/blocs/login/login_state.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _shineController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shineAnimation;

  @override
  void initState() {
    super.initState();

    // Check login status immediately
    context.read<LoginBloc>().add(LoginStatusCheckEvent());

    // Pulse animation for logo
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Scale in animation
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: AnimationController(
          duration: const Duration(milliseconds: 1200),
          vsync: this,
        )..forward(),
        curve: Curves.elasticOut,
      ),
    );

    // Shimmer shine effect
    _shineController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _shineAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _shineController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _shineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A0B2E), // Deep purple-black
                  Color(0xFF2A1B3D),
                  Color(0xFF3D2A50),
                  Color(0xFF4A2C6B),
                  Color(0xFF6B3A9A),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Animated background particles (cosmetic glow effect)
                ...List.generate(8, (index) {
                  return AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Positioned(
                        left:
                            math.Random().nextDouble() *
                            MediaQuery.of(context).size.width,
                        top:
                            math.Random().nextDouble() *
                            MediaQuery.of(context).size.height,
                        child: Transform.scale(
                          scale:
                              0.5 +
                              math
                                  .sin(
                                    _pulseController.value * 2 * math.pi +
                                        index,
                                  )
                                  .abs(),
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.pinkAccent,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.pinkAccent,
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),

                // Main content
                Center(
                  child: AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Logo with shimmer effect
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                // Glowing logo background
                                Container(
                                  width: 180,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        Colors.pink.shade300.withOpacity(0.6),
                                        Colors.transparent,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.pink.shade400.withOpacity(
                                          0.5,
                                        ),
                                        blurRadius: 50,
                                        spreadRadius: 20,
                                      ),
                                    ],
                                  ),
                                ),

                                // Shimmer overlay
                                AnimatedBuilder(
                                  animation: _shineAnimation,
                                  builder: (context, child) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(90),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 180,
                                            height: 180,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Transform.translate(
                                            offset: Offset(
                                              _shineAnimation.value * 300,
                                              -100,
                                            ),
                                            child: Container(
                                              width: 60,
                                              height: 300,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.white.withOpacity(
                                                      0.8,
                                                    ),
                                                    Colors.transparent,
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),

                                // Main Logo (Replace with your actual logo)
                                Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.pink.shade100,
                                      width: 4,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.pink.shade300.withOpacity(
                                          0.6,
                                        ),
                                        blurRadius: 30,
                                        spreadRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/logo.png', // Add your luxury logo here
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.auto_fix_high,
                                              size: 80,
                                              color: Colors.pink,
                                            );
                                          },
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 40),

                            // Brand Name with luxury font style
                            AnimatedBuilder(
                              animation: _pulseAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _pulseAnimation.value,
                                  child: const Text(
                                    'O S S',
                                    style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 12,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          color: Colors.pinkAccent,
                                          offset: Offset(0, 0),
                                          blurRadius: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                            const Text(
                              'COSMETICS',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                                letterSpacing: 18,
                                color: Colors.pinkAccent,
                              ),
                            ),

                            const SizedBox(height: 60),

                            // Loading indicator with beauty touch
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.pink.shade300,
                                ),
                                backgroundColor: Colors.white.withOpacity(0.2),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
        listener: (context, state) async {
          if (state is LoginStatusSuccessState) {
            await Future.delayed(const Duration(seconds: 3));
            if (mounted) {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.dashBoardScreen,
              );
            }
          }
          if (state is LoginStatusFailureState) {
            if (mounted) {
              Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
            }
          }
        },
      ),
    );
  }
}
