import 'package:flutter/material.dart';
import 'package:mytodo/core/widgets/task_tile.dart';
import 'package:mytodo/presentation/home/home_viewmodel.dart';
import 'package:mytodo/presentation/home/widgets/carousel.dart';
import 'package:mytodo/presentation/home/widgets/home_header.dart';
import 'package:stacked/stacked.dart';

import '../../core/cores.dart';
import '../task/create_task/create_task_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // Helper method to get category color
  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'work':
        return Colors.blue;
      case 'personal':
        return Colors.green;
      case 'health':
        return Colors.red;
      case 'learning':
        return Colors.purple;
      case 'career':
        return Colors.orange;
      case 'home':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  // Helper method to get category icon
  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'work':
        return Icons.work;
      case 'personal':
        return Icons.person;
      case 'health':
        return Icons.favorite;
      case 'learning':
        return Icons.school;
      case 'career':
        return Icons.trending_up;
      case 'home':
        return Icons.home;
      default:
        return Icons.task;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewmodel>.reactive(
      viewModelBuilder: () => HomeViewmodel(),
      onViewModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              spacing: 16.0,
              children: [
                HomeHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 16,
                      children: [
                        ///Carosel
                        CarouselWidget(
                          quotes: model.quotes,
                          onPageChanged: (index, reason) {
                            model.setCarouselIndex(index);
                          },
                        ),

                        //Today's Tasks
                        AppText(
                          "Today's List",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),

                        // Dynamic task list
                        if (model.todaysTasks.isEmpty)
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 12),
                                AppText(
                                  "No tasks today, Comeback tomorrow",
                                  fontSize: 16,
                                  color: Colors.grey,
                                  alignment: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        else
                          ...model.todaysTasks.map(
                            (task) => TaskTile(
                              taskName: task.title,
                              dateTime: task.formattedDueDate,
                              category: task.category,
                              description: task.description,
                              isCompleted: task.isCompleted,
                              categoryColor: _getCategoryColor(task.category),
                              categoryIcon: _getCategoryIcon(task.category),
                              onTap: () {},
                              onStatusChanged: (completed) {
                                model.toggleTaskStatus(
                                  task.id,
                                  completed ?? false,
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "home_fab",
          onPressed: () {
            navigationService
                .push(
                  CreateTaskView(),
                )
                .then((_) => model.initialise());
          },
          backgroundColor: AppColors.primaryColor,
          elevation: 2,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
