import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';
import 'package:get/get.dart';

class JimListView<T> extends StatelessWidget {
  final RxList<T> items;
  final RxBool? isLoading;
  final Widget Function(T item) itemBuilder;
  final String emptyMessage;
  final ScrollController? scrollController;

  const JimListView({
    super.key,
    required this.items,
    this.isLoading,
    required this.itemBuilder,
    this.emptyMessage = "No items found.",
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool loading = isLoading?.value == true;
      final bool empty = items.isEmpty;

      if (loading && empty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (empty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "No workouts available.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "Why not create one to get started?",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      }

      return _buildListView();
    });
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(JimSpacings.m),
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder(items[index]),
      controller: scrollController,
    );
  }
}
