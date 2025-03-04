import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/theme.dart';
import 'package:frontend/controller/exercise_detail_controller.dart';
import 'package:frontend/models/exercise.dart';
import 'package:frontend/screens/exercise/exercise_detail_body.dart';
import 'package:get/get.dart';

class ExerciseDetail extends StatelessWidget {
  final Exercise exercise;
  const ExerciseDetail({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final ExerciseDetailController controller =
        Get.put(ExerciseDetailController(exercise));

    return Scaffold(
      backgroundColor: AppColor.white,
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
      pinned: true,
      backgroundColor: AppColor.white,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColor.white.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.black),
          onPressed: () => Get.back(),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: AppColor.white,
          child: Hero(
            tag: 'exercise-${controller.exercise.id}',
            child: CachedNetworkImage(
              imageUrl: controller.exercise.gifUrl,
              fit: BoxFit.contain,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColor.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
