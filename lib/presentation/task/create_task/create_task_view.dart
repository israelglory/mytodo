import 'package:flutter/material.dart';
import 'package:mytodo/core/widgets/widgets.dart';
import 'package:mytodo/data/model/params/tasks/tasks_param.dart';
import 'package:stacked/stacked.dart';
import 'create_task_viewmodel.dart';

class CreateTaskView extends StatelessWidget {
  final Task? task;
  const CreateTaskView({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateTaskViewModel>.reactive(
      viewModelBuilder: () => CreateTaskViewModel(),
      onViewModelReady: (model) => model.initializeWithTask(task),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: AppText(
              task != null ? "Edit Task" : "Create Task",
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const AppText(
                    "Task Details",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 24),

                  // Task Title
                  AppCustomTextField(
                    textEditingController: model.taskTitleController,
                    hintText: "Task Title",
                  ),
                  const SizedBox(height: 16),

                  AppCustomTextField(
                    textEditingController: model.taskDescriptionController,
                    hintText: "Task Description",

                    maxLines: 5,
                  ),
                  const SizedBox(height: 16),

                  // Category Field
                  AppCustomTextField(
                    textEditingController: model.categoryController,
                    hintText: "Task Category",
                  ),
                  const SizedBox(height: 16),

                  // Due Date & Time Section
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => model.selectDate(context),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 8),
                                AppText(
                                  model.selectedDate != null
                                      ? "${model.selectedDate!.day}/${model.selectedDate!.month}/${model.selectedDate!.year}"
                                      : "Select Date",
                                  color: model.selectedDate != null
                                      ? Colors.black
                                      : Colors.grey.shade600,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => model.selectTime(context),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 8),
                                AppText(
                                  model.selectedTime != null
                                      ? model.selectedTime!.format(context)
                                      : "Select Time",
                                  color: model.selectedTime != null
                                      ? Colors.black
                                      : Colors.grey.shade600,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Priority Selection
                  const AppText(
                    "Priority",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ...Priority.values.map(
                        (priority) => Expanded(
                          child: GestureDetector(
                            onTap: () => model.setPriority(priority),
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: model.selectedPriority == priority
                                    ? Color(
                                        priority.colorValue,
                                      ).withOpacity(0.2)
                                    : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: model.selectedPriority == priority
                                      ? Color(priority.colorValue)
                                      : Colors.grey.shade300,
                                ),
                              ),
                              child: Center(
                                child: AppText(
                                  priority.displayName,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: model.selectedPriority == priority
                                      ? Color(priority.colorValue)
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Create Button
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      onPressed: model.canCreateTask
                          ? () => task != null
                                ? model.updateTask(task!)
                                : model.createTask()
                          : null,
                      child: AppText(
                        task != null ? "Update Task" : "Create Task",
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
