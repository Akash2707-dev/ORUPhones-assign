import 'package:flutter/material.dart';
import 'package:oruphones_assign/Screens/Home/carousel_viewmodel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CarouselViewModel>.reactive(
      viewModelBuilder: () => CarouselViewModel(),
      builder: (context, viewModel, child) {
        return Column(
          children: [
            /// ✅ **Carousel Slider**
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: SizedBox(
                height: 175, // ✅ Carousel height
                child: PageView.builder(
                  controller: viewModel.pageController,
                  itemCount: viewModel.imagePaths.length,
                  onPageChanged: viewModel.onPageChanged,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius:
                          BorderRadius.circular(11.88), // ✅ Rounded corners
                      child: Image.asset(
                        viewModel.imagePaths[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 8),

            /// ✅ **Navigation Dots**
            SmoothPageIndicator(
              controller: viewModel.pageController, // ✅ Tracks page changes
              count: viewModel.imagePaths.length, // ✅ Number of dots
              effect: const SlideEffect(
                dotHeight: 5,
                dotWidth: 5,
                activeDotColor: Colors.grey, // ✅ Filled dot color
                dotColor: Color(0xFFABABAB), // ✅ Visible hollow dots
                paintStyle: PaintingStyle.stroke, // ✅ Makes dots outlined
                strokeWidth: 1.5, // ✅ Border thickness
              ),
              onDotClicked: (index) {
                viewModel.pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            )
          ],
        );
      },
    );
  }
}
