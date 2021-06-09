import 'package:flutter/widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stacked/stacked.dart';

/// Viewmodel for StoryView.
class StoryViewmodel extends BaseViewModel {
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener _positionsListener =
      ItemPositionsListener.create();
  final PageController _pageController = PageController(initialPage: 0);

  /// ItemScrollController for story indictor listview.
  ItemScrollController get scrollController => _scrollController;

  /// ItemPositionsListener for story indicator listview.
  ItemPositionsListener get positionsListener => _positionsListener;

  /// Page controller for story asset pageview.
  PageController get pageController => _pageController;

  final int _itemCount = 6;

  /// Number of items in the stories list.
  int get itemCount => _itemCount;

  /// Current index of pageview.
  int currentIndex = 0;

  int _currentStoryIndex = 0;

  int currentStoryLength = 3;

  /// Index of the story of current club.
  int get currentStoryIndex => _currentStoryIndex;

  /// Scroll the indicator listview on pageview change.
  void pageChanged(int index) {
    _scrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 200),
    );
    currentIndex = index;
  }

  // TODO: Nested if won't work here in case of the last club.
  /// Navigates to next story or club.
  void next() {
    if (currentIndex != _itemCount - 1) {
      if (currentStoryIndex != currentStoryLength - 1) {
        _currentStoryIndex++;
      } else {
        _pageController.animateToPage(
          currentIndex + 1,
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear,
        );
        _currentStoryIndex = 0;
      }
    }
  }

  // TODO: Nested if won't work here in case of the first club.
  /// Navigates to next story or club.
  void previous() {
    if (currentIndex != 0) {
      if (currentStoryIndex != 0) {
        _currentStoryIndex--;
      } else {
        _currentStoryIndex = 2;
        _pageController.animateToPage(
          currentIndex - 1,
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear,
        );
      }
    }
  }
}
