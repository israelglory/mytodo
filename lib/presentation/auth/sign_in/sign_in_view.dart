import 'package:flutter/material.dart';
import 'package:mytodo/core/cores.dart';
import 'package:mytodo/presentation/auth/sign_up/sign_up_view.dart';
import 'package:stacked/stacked.dart';
import 'sign_in_viewmodel.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Top section with logo and title
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      ClipOval(
                        child: Image.asset(
                          AppAssets.appIconPNG,
                          fit: BoxFit.cover,
                          width: 70,
                          height: 70,
                        ),
                      ),
                      SizedBox(height: 16),

                      // Title
                      AppText(
                        'Sign in to your',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        alignment: TextAlign.center,
                      ),
                      AppText(
                        'Account',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        alignment: TextAlign.center,
                      ),
                      SizedBox(height: 16),

                      // Subtitle
                      AppText(
                        'Enter your email and password to log in',
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                        alignment: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Bottom section with form
                Expanded(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 24),

                            // Email field
                            AppCustomTextField(
                              textEditingController: viewModel.emailController,
                              hintText: 'Loisbecket@gmail.com',
                              textInputType: TextInputType.emailAddress,
                              borderRadius: 16,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              fontSize: 16,
                            ),
                            SizedBox(height: 20),

                            // Password field
                            AppCustomTextField(
                              textEditingController:
                                  viewModel.passwordController,
                              hintText: '•••••••',
                              obscureText: !viewModel.isPasswordVisible,
                              borderRadius: 16,
                              maxLines: 1,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              fontSize: 16,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  viewModel.isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: viewModel.togglePasswordVisibility,
                              ),
                            ),
                            SizedBox(height: 16),

                            // Remember me and forgot password row
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: viewModel.rememberMe,
                                      onChanged: viewModel.toggleRememberMe,
                                      activeColor: AppColors.primaryColor,
                                    ),
                                    AppText(
                                      'Remember me',
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                AppText(
                                  'Forgot Password ?',
                                  fontSize: 14,
                                  color: AppColors.primaryColor,
                                  onPress: () {
                                    // Handle forgot password
                                  },
                                  isTextButton: true,
                                ),
                              ],
                            ),
                            SizedBox(height: 32),

                            // Login button
                            AppButton(
                              title: 'Log In',
                              onPressed: viewModel.signIn,
                              color: AppColors.primaryColor,
                              textColor: Colors.white,
                              radius: 16,
                              height: 56,
                              width: double.infinity,
                              fontSize: 18,
                              textFontWeight: FontWeight.w600,
                              loading: viewModel.isBusy,
                            ),
                            SizedBox(height: 24),

                            // Sign up text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  "Don't have an account? ",
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                                AppText(
                                  'Sign Up',
                                  fontSize: 14,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  onPress: () {
                                    navigationService.pushReplacement(
                                      SignUpView(),
                                    );
                                  },
                                  isTextButton: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
