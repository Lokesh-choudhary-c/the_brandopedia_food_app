import 'package:flutter/material.dart';

class PromoCardLarge extends StatelessWidget {
  const PromoCardLarge({
    super.key,
    required this.category,
    required this.discount,
    required this.subtitle,
    required this.buttonLabel,
    required this.imagePath,
    required this.backgroundColor,
  });

  final String category, discount, subtitle, buttonLabel, imagePath;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category.toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 12)),
              const SizedBox(height: 4),
              Text(discount,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: backgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
                child: Text(buttonLabel,
                    style: const TextStyle(fontSize: 12)),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(imagePath,
                width: 60, height: 60, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}

class PromoCardSmall extends StatelessWidget {
  const PromoCardSmall({
    super.key,
    required this.discount,
    required this.subtitle,
    required this.backgroundColor,
  });

  final String discount, subtitle;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$discount\n',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 27),
                ),
                TextSpan(
                  text: subtitle,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
