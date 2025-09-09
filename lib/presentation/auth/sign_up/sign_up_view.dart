import 'package:flutter/material.dart';
import 'package:mytodo/core/cores.dart';
import 'package:mytodo/presentation/auth/sign_in/sign_in_view.dart';
import 'package:stacked/stacked.dart';
import 'sign_up_viewmodel.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
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
                        'Sign up to your new',
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
                        'Enjoy creating and managing your tasks',
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

                            AppCustomTextField(
                              textEditingController:
                                  viewModel.userNameController,
                              hintText: 'kxSplash',
                              textInputType: TextInputType.name,
                              borderRadius: 16,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              fontSize: 16,
                            ),
                            SizedBox(height: 20),

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

                            SizedBox(height: 32),

                            // Sign Up button
                            AppButton(
                              title: 'Sign Up',
                              onPressed: viewModel.signUp,
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
                                  "Already have an account? ",
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                                AppText(
                                  'Sign In',
                                  fontSize: 14,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  onPress: () {
                                    navigationService.push(SignInView());
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
