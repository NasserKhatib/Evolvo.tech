import 'package:flutter/material.dart';
import 'package:movies_app/widgets/hexagonal_background.dart';
import 'package:movies_app/widgets/protfolio.dart';

class PortfolioDetailPage extends StatelessWidget {
  final PortfolioItem item;

  const PortfolioDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            HexagonalBackground(
              borderColor: Colors.blue,
              color: Colors.blue, // Hexagon color
              opacity: 0.06,

              // Adjust hexagon size for mobile
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    item.imagePath,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  item.details,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
