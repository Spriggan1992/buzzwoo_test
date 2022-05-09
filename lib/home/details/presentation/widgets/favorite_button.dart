import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/themes/app_colors.dart';

class FavoriteButton extends StatefulWidget {
  final Function(bool isFavorite) onTap;
  final bool isFavorite;
  const FavoriteButton({
    required this.onTap,
    required this.isFavorite,
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _isFavorite;

  @override
  void initState() {
    _isFavorite = widget.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _toggleIsFavorite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.heart_fill,
            size: 24,
            color: AppColors.white,
          ),
          Text(
            _isFavorite ? 'Remove from favorite' : 'Add to favorite',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: AppColors.white),
          ),
        ],
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
          const EdgeInsets.symmetric(
            vertical: 12,
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle?>(
          const TextStyle(
            fontSize: 18,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color?>(
          Colors.blue,
        ),
        elevation: MaterialStateProperty.all<double?>(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
        ),
      ),
    );
  }

  void _toggleIsFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    widget.onTap(_isFavorite);
  }
}
