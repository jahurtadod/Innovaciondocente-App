import 'dart:async';

import 'package:flutter/material.dart';
import 'package:Ascendere_UTPL/src/ui/pages/start/presentation/page-dragger.dart';
import 'package:Ascendere_UTPL/src/ui/pages/start/presentation/page-reveal.dart';
import 'package:Ascendere_UTPL/src/ui/pages/start/presentation/pager-indicator.dart';
import 'package:Ascendere_UTPL/src/ui/pages/start/presentation/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PresentationPage extends StatefulWidget {
  @override
  _PresentationPageState createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> with TickerProviderStateMixin {
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger animatedPageDragger;

  @override
  void dispose() {
    if (!slideUpdateStream.isClosed) slideUpdateStream.close();
    super.dispose();
  }

  int activeIndex = 0;
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;

  _PresentationPageState() {
    slideUpdateStream = new StreamController<SlideUpdate>();

    slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }
        } else if (event.updateType == UpdateType.doneDragging) {
          if (slidePercent > 0.3) {
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          } else {
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );

            nextPageIndex = activeIndex;
          }

          animatedPageDragger.run();
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          activeIndex = nextPageIndex;

          slideDirection = SlideDirection.none;
          slidePercent = 0.0;

          animatedPageDragger.dispose();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: [
          new Page(
            viewModel: pages[activeIndex],
            percentVisible: 1.0,
            // continueStart: (activeIndex == pages.length - 1)? false : true,
          ),
          new PageReveal(
            revealPercent: slidePercent,
            child: new Page(
              viewModel: pages[nextPageIndex],
              percentVisible: slidePercent,
            ),
          ),
          new PagerIndicator(
            viewModel: new PagerIndicatorViewModel(
              pages,
              activeIndex,
              slideDirection,
              slidePercent,
            ),
          ),
          new PageDragger(
            canDragLeftToRight: activeIndex > 0,
            canDragRightToLeft: activeIndex < pages.length - 1,
            slideUpdateStream: this.slideUpdateStream,
          ),
          // Positioned(
          //   child: FloatingActionButton(
          //     child: Icon(Icons.close),
          //     backgroundColor: Colors.white,
          //     foregroundColor: Colors.blue,
          //     onPressed: () {},
          //   ),
          //   top: 0.0,
          //   right: 20.0,
          // )
        ],
      ),
    );
  }
}
