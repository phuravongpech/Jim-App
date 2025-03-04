import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JimListView<T> extends StatelessWidget {
  final RxList<T> items;
  final RxBool? isLoading;
  final Widget Function(T item) itemBuilder;
  final String emptyMessage;

  const JimListView({
    super.key,
    required this.items,
    this.isLoading,
    required this.itemBuilder,
    this.emptyMessage = "No items found.",
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isLoading?.value == true) {
        return const Center(child: CircularProgressIndicator());
      }

      if (items.isEmpty) {
        return Center(child: Text(emptyMessage));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: items.length,
        itemBuilder: (context, index) => itemBuilder(items[index]),
      );
    });
  }
}
