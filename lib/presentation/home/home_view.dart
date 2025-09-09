import 'package:flutter/material.dart';
import 'package:mytodo/core/widgets/task_tile.dart';
import 'package:mytodo/presentation/home/home_viewmodel.dart';
import 'package:mytodo/presentation/home/widgets/carousel.dart';
import 'package:mytodo/presentation/home/widgets/home_header.dart';
import 'package:stacked/stacked.dart';

import '../../core/cores.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewmodel>.reactive(
      viewModelBuilder: () => HomeViewmodel(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
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

                      //Services
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: AppText(
                          "Today's List",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TaskTile(
                        taskName: "Complete Flutter project",
                        dateTime: "Today, 2:30 PM",
                        category: "Work",
                        description:
                            "Finish the task management app with all features.",
                        isCompleted: false,
                        categoryColor: Colors.blue,
                        categoryIcon: Icons.work,
                        onTap: () {},
                        onStatusChanged: (completed) {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
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
