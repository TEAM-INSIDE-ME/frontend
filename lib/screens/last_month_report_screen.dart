import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/colors.dart';

class LastMonthReportScreen extends StatelessWidget {
  const LastMonthReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Pagination'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext builder) {
                return Center(
                  child: SizedBox(
                    height: 548 * height,
                    //width: 353 * width,
                    child: Swiper(
                      itemCount: 20,
                      viewportFraction: 0.858, // 카드 너비 조정
                      scale: 0.9, // 양옆 카드 크기 조정
                      scrollDirection: Axis.horizontal,
                      axisDirection: AxisDirection.left,

                      itemHeight: 548 * height,
                      itemWidth: 353 * width,
                      itemBuilder: (BuildContext context, int index) {
                        return const Card();
                      },
                    ),
                  ),
                );
              },
            );
          },
          child: const Text("저를 누르세요"),
        ),
      ),
    );
  }
}
