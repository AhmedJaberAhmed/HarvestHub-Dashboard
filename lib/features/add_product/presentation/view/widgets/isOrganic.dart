import 'package:flutter/material.dart';
import 'package:fruiteshubdashboard2/core/utils/app_text_styles.dart';

class IsOrganicCheckBox extends StatefulWidget {
  const IsOrganicCheckBox({super.key, required this.onChanged});

  final ValueChanged<bool> onChanged;

  @override
  State<IsOrganicCheckBox> createState() => _IsFeaturedCheckBoxState();
}

class _IsFeaturedCheckBoxState extends State<IsOrganicCheckBox> {
  bool isOrganic = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        setState(() {
          isOrganic = !isOrganic;
          widget.onChanged(isOrganic);
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Checkbox(
            value: isOrganic,
            onChanged: (value) {
              setState(() {
                isOrganic = value ?? false;
                widget.onChanged(isOrganic);
              });
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            activeColor: Colors.green,
            checkColor: Colors.white,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          SizedBox(width: 8),
          Text(
            'Is Organic Product?',
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
