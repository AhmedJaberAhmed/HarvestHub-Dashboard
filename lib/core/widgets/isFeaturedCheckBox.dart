import 'package:flutter/material.dart';
import 'package:fruiteshubdashboard2/core/utils/app_text_styles.dart';

class IsFeaturedCheckBox extends StatefulWidget {
  const IsFeaturedCheckBox({super.key, required this.onChanged});

  final ValueChanged<bool> onChanged;

  @override
  State<IsFeaturedCheckBox> createState() => _IsFeaturedCheckBoxState();
}

class _IsFeaturedCheckBoxState extends State<IsFeaturedCheckBox> {
  bool isFeatured = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        setState(() {
          isFeatured = !isFeatured;
          widget.onChanged(isFeatured);
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Checkbox(
            value: isFeatured,
            onChanged: (value) {
              setState(() {
                isFeatured = value ?? false;
                widget.onChanged(isFeatured);
              });
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            activeColor: Colors.green,
            checkColor: Colors.white,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          SizedBox(width: 8),
          Text(
            'Is Featured Item?',
            style: TextStyles.semiBold13.copyWith(
              color: const Color(0xFF949D9E),
              fontSize: screenWidth * 0.035,
            ),
          ),
        ],
      ),
    );
  }
}
