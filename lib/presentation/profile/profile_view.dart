import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import '../../core/cores.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  AppText(
                    'Profile',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 24,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  // Add more profile-related widgets here
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFFE2EEFF),
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Profile image
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                radius: 36,
                                backgroundImage: AssetImage(
                                  AppAssets.picPNG,
                                ), // Replace with your asset
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 6,
                              child: AppRectangle(
                                radius: 100,
                                padding: EdgeInsets.all(8),
                                color: AppColors.primaryColor,
                                child: SvgPicture.asset(
                                  AppAssets.cameraIconSVG,
                                  height: 12,
                                  width: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 16),
                        // Name and location
                        AppText(
                          'Glory Olaifa',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_circle_down,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  // Account settings
                  AppText(
                    'Account settings',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  SizedBox(height: 12),
                  _ProfileListTile(
                    icon: Icons.person,
                    title: 'Personal Info',
                    onTap: () {},
                  ),

                  Divider(),
                  _ProfileListTile(
                    icon: Icons.fingerprint,
                    title: 'Biometric Signin',
                    trailing: CupertinoSwitch(
                      value: model.isBiometricsEnabled,
                      onChanged: (val) {
                        model.toggleBiometrics(val);
                      },
                    ),
                  ),
                  Divider(),
                  _ProfileListTile(
                    icon: Icons.password,
                    title: 'Change password',
                    onTap: () {},
                  ),
                  SizedBox(height: 32),
                  // More
                  AppText(
                    'More',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),

                  SizedBox(height: 12),
                  _ProfileListTile(
                    icon: Icons.document_scanner,
                    title: 'Terms of use',
                    onTap: () {},
                  ),
                  Divider(),
                  _ProfileListTile(
                    icon: Icons.privacy_tip,
                    title: 'Privacy policy',
                    onTap: () {},
                  ),
                  Divider(),
                  _ProfileListTile(
                    icon: Icons.logout,
                    title: 'Logout',
                    titleColor: Colors.red,
                    onTap: () {
                      //model.logOutPrompt();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProfileListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final Color? titleColor;
  final VoidCallback? onTap;

  const _ProfileListTile({
    required this.icon,
    required this.title,
    this.trailing,
    this.titleColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
      ),
      title: AppText(
        title,
        color: titleColor ?? Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      trailing:
          trailing ??
          Icon(
            Icons.chevron_right,
            color: Colors.black,
          ),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }
}
