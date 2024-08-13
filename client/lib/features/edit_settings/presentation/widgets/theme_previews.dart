import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../utils/show_paywall.dart';

/// A list of [Image.asset] that represent theme previews.
final List<Widget> previews = [
  Image.asset('assets/img/theme-preview-1.png', fit: BoxFit.scaleDown),
  Image.asset('assets/img/theme-preview-2.png', fit: BoxFit.scaleDown),
  // Add more images as needed
];

/// Shows a modal bottom sheet with theme previews.
void showThemePreviews(BuildContext context) {
  final carouselController = CarouselSliderController();
  var activeIndex = 0;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Premium Theme Previews',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: 16),
                CarouselSlider(
                  items: previews.map((image) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: image,
                    );
                  }).toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    height: 300.0,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16),
                AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: previews.length,
                  effect: ScrollingDotsEffect(
                    activeDotColor: Theme.of(context).primaryColor,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                  onDotClicked: carouselController.animateToPage,
                ),
                SizedBox(height: 16),
                Text(
                  'Unlock premium themes with a subscription, along with other benefits like the Gemini AI coach, unlimited gameplay, and game history backup when transferring devices.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => showPaywall(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        'Purchase',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Close'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
