import 'package:flutter/material.dart';

import '../../../core/cores.dart';
import '../../../data/model/user_model.dart';

class UserSwitchBottomSheet extends StatelessWidget {
  final List<User> users;
  final User? currentUser;
  final Function(User) onUserSelected;
  final Function() addAccount;

  const UserSwitchBottomSheet({
    super.key,
    required this.users,
    required this.currentUser,
    required this.onUserSelected,
    required this.addAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                AppText(
                  'Switch Account',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),

          // Users list
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: users.length,
              separatorBuilder: (context, index) => Divider(height: 1),
              itemBuilder: (context, index) {
                final user = users[index];
                final isCurrentUser = user.email == currentUser?.email;
                final displayName = _getUserDisplayName(user);

                return ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                    child: AppText(
                      _getUserInitials(user),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  title: AppText(
                    displayName,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  subtitle: AppText(
                    user.email,
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                  trailing: isCurrentUser
                      ? Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.primaryColor.withOpacity(0.3),
                            ),
                          ),
                          child: AppText(
                            'Current',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        )
                      : Icon(
                          Icons.chevron_right,
                          color: Colors.grey.shade400,
                        ),
                  onTap: isCurrentUser ? null : () => onUserSelected(user),
                );
              },
            ),
          ),

          SizedBox(height: 20),
          InkWell(
            onTap: addAccount,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.black),
                SizedBox(width: 20),
                AppText(
                  'Add Account',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  String _getUserDisplayName(User user) {
    return user.username.isNotEmpty ? user.username : user.email.split('@')[0];
  }

  String _getUserInitials(User user) {
    String name = _getUserDisplayName(user);
    if (name.length >= 2) {
      return name.substring(0, 2).toUpperCase();
    } else if (name.length == 1) {
      return name.toUpperCase();
    }
    return 'U';
  }
}
