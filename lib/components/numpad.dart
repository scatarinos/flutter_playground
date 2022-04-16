import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'keybutton.dart';

class NumPad extends StatelessWidget {
  const NumPad({
    Key? key,
    required this.onTapKeyButton,
  }) : super(key: key);

  final void Function(String code) onTapKeyButton;

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      axisDirection: AxisDirection.down,
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        ...['C', '/', '*', '-'].map(
          (k) => StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: KeyButoon(
              label: k,
              code: k == 'C' ? 'clear' : k,
              onTap: onTapKeyButton,
            ),
          ),
        ),
        /* 789 */
        ...['7', '8', '9'].map(
          (k) => StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: KeyButoon(
              label: k,
              onTap: onTapKeyButton,
            ),
          ),
        ),
        /* + */
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 2,
          child: KeyButoon(
            label: '+',
            onTap: onTapKeyButton,
          ),
        ),
        /* 456 */
        ...['4', '5', '6'].map(
          (k) => StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: KeyButoon(
              label: k,
              onTap: onTapKeyButton,
            ),
          ),
        ),

        /* 123 */
        ...['1', '2', '3'].map(
          (k) => StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: KeyButoon(
              label: k,
              onTap: onTapKeyButton,
            ),
          ),
        ),
        /* + */
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 2,
          child: KeyButoon(
            label: 'Enter',
            code: 'enter',
            onTap: onTapKeyButton,
          ),
        ),
        /* 456 */
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: KeyButoon(
            label: '0',
            onTap: onTapKeyButton,
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: KeyButoon(
            label: '.',
            onTap: onTapKeyButton,
          ),
        ),
      ],
    );
  }
}
