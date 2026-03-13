import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class DashboardFilterSortButton extends StatelessWidget {
  const DashboardFilterSortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [NeoKelasFilterButton(), NeoKelasSortButton()],
    );
  }
}
