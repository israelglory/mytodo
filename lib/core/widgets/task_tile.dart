import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cores.dart';

class TaskTile extends StatelessWidget {
  final String taskName;
  final String dateTime;
  final String category;
  final String description;
  final bool isCompleted;
  final VoidCallback? onTap;
  final ValueChanged<bool?>? onStatusChanged;
  final Color? categoryColor;
  final IconData? categoryIcon;

  const TaskTile({
    super.key,
    required this.taskName,
    required this.dateTime,
    required this.category,
    required this.description,
    required this.isCompleted,
    this.onTap,
    this.onStatusChanged,
    this.categoryColor,
    this.categoryIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: isCompleted
              ? Colors.green.withOpacity(0.3)
              : Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Radio button
              Container(
                margin: EdgeInsets.only(top: 2.h, right: 12.w),
                child: GestureDetector(
                  onTap: () => onStatusChanged?.call(!isCompleted),
                  child: Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isCompleted
                            ? Colors.green
                            : Colors.grey.shade400,
                        width: 2,
                      ),
                      color: isCompleted ? Colors.green : Colors.transparent,
                    ),
                    child: isCompleted
                        ? Icon(
                            Icons.check,
                            size: 16.sp,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              ),

              // Task content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Task name and category row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Task name
                        Expanded(
                          child: Text(
                            taskName,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: isCompleted
                                  ? Colors.grey.shade500
                                  : Colors.black87,
                              decoration: isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        SizedBox(width: 8.w),

                        // Category tag
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: (categoryColor ?? Colors.blue).withOpacity(
                              0.1,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: (categoryColor ?? Colors.blue).withOpacity(
                                0.3,
                              ),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (categoryIcon != null) ...[
                                Icon(
                                  categoryIcon,
                                  size: 12.sp,
                                  color: categoryColor ?? Colors.blue,
                                ),
                                SizedBox(width: 4.w),
                              ],
                              Text(
                                category,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: categoryColor ?? Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 6.h),

                    // Date and time
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 14.sp,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(width: 4.w),
                        AppText(
                          dateTime,
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),

                    // Description
                    if (description.isNotEmpty) ...[
                      SizedBox(height: 8.h),
                      AppText(
                        description,

                        fontSize: 12.sp,
                        color: isCompleted
                            ? Colors.grey.shade400
                            : Colors.grey.shade700,
                        height: 1.4,
                        textDecoration: isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
