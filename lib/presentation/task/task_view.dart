import 'package:flutter/material.dart';
import 'package:mytodo/core/cores.dart';
import 'package:mytodo/core/widgets/task_tile.dart';
import 'package:mytodo/presentation/task/create_task/create_task_view.dart';
import 'package:stacked/stacked.dart';
import 'task_viewmodel.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskViewModel>.reactive(
      viewModelBuilder: () => TaskViewModel(),
      onViewModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppText(
                  "My Tasks",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 24,
                ),
                AppRectangle(
                  width: double.infinity,
                  color: AppColors.primaryColor.withOpacity(0.2),
                  padding: EdgeInsets.all(8),
                  radius: 8,
                  child: Row(
                    children: [
                      Expanded(
                        child: AppRectangle(
                          onTap: () {
                            model.setSelectedIndex(0);
                          },
                          radius: 8,
                          padding: EdgeInsets.all(16),
                          color: model.selectedIndex == 0
                              ? AppColors.primaryColor
                              : null,
                          child: Center(
                            child: AppText(
                              "Ongoing",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: model.selectedIndex == 0
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: AppRectangle(
                          onTap: () {
                            model.setSelectedIndex(1);
                          },
                          radius: 8,
                          padding: EdgeInsets.all(16),
                          color: model.selectedIndex == 1
                              ? AppColors.primaryColor
                              : null,
                          child: Center(
                            child: AppText(
                              "Completed",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: model.selectedIndex == 1
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //List of tasks
                SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (model
                          .getTasksByStatus(
                            model.selectedIndex == 0 ? 'ongoing' : "completed",
                          )
                          .isEmpty) {
                        return Center(
                          child: AppText(
                            "No tasks available, Create New Task",
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        );
                      }
                      return ListView.separated(
                        itemCount: model
                            .getTasksByStatus(
                              model.selectedIndex == 0
                                  ? 'ongoing'
                                  : "completed",
                            )
                            .length,
                        itemBuilder: (context, index) {
                          final task = model.getTasksByStatus(
                            model.selectedIndex == 0 ? 'ongoing' : "completed",
                          )[index];
                          return TaskTile(
                            taskName: task.title,
                            dateTime: task.formattedDueDate.toString(),
                            category: task.category,
                            description: task.description,
                            isCompleted: task.isCompleted,
                            categoryColor: Colors.blue,
                            categoryIcon: Icons.work,
                            onTap: () {},
                            onStatusChanged: (completed) {
                              model.toggleTaskStatus(
                                task.id,
                                completed ?? false,
                              );
                            },
                            onEdit: () => model.editTask(task),
                            onDelete: () =>
                                model.deleteTaskWithConfirmation(task),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 16,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: "task_fab",
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
        );
      },
    );
  }
}
