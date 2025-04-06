import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controller/exercise_detail_controller.dart';
import 'package:frontend/models/exercise.dart';
import 'package:frontend/screens/exercise/exercise_detail_body.dart';
import 'package:frontend/theme/theme.dart';
import 'package:get/get.dart';

import '../../widgets/action/jim_icon_button.dart';

class ExerciseDetail extends StatelessWidget {
  final Exercise exercise;
  const ExerciseDetail({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final ExerciseDetailController controller =
        Get.put(ExerciseDetailController(exercise));

    return Scaffold(
      backgroundColor: JimColors.white,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(controller),
          SliverToBoxAdapter(
            child: ExerciseDetailBody(controller: controller),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(ExerciseDetailController controller) {
    return SliverAppBar(
      expandedHeight: 400,
      backgroundColor: JimColors.white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          decoration: BoxDecoration(
            color: JimColors.white,
            shape: BoxShape.circle,
          ),
          child: JimIconButton(
            icon: Icons.arrow_back,
            color: JimColors.black,
            onPressed: () => Get.back(),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: JimColors.white,
          child: Hero(
            tag: 'exercise-${controller.exercise.id}',
            child: CachedNetworkImage(
              imageUrl: controller.exercise.gifUrl,
              fit: BoxFit.contain,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(JimColors.placeholder),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
