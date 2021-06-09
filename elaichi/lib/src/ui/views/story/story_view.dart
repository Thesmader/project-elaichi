import 'package:cached_network_image/cached_network_image.dart';
import 'package:elaichi/core.dart';
import 'package:elaichi/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stacked/stacked.dart';

/// UI for viewing a single story.
class StoryView extends StatelessWidget {
  /// Constructor for StoryView.
  const StoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StoryViewmodel>.reactive(
      viewModelBuilder: () => StoryViewmodel(),
      builder: (BuildContext context, StoryViewmodel model, Widget? child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xFF0f1940),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      StoryIndicator(
                        itemCount: model.itemCount,
                        positionsListener: model.positionsListener,
                        scrollController: model.scrollController,
                      ),
                      StoryImage(
                        currentStoryIndex: model.currentStoryIndex,
                        pageController: model.pageController,
                        pageChanged: model.pageChanged,
                        imgUrl: Fixtures.posterLink,
                      ),
                      const Spacer()
                    ],
                  ),
                ),
                Positioned(
                  left: 0.0,
                  top: 0.0,
                  bottom: 0.0,
                  child: SizedBox(
                    width: 56.0,
                    child: GestureDetector(
                      onTap: model.previous,
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  bottom: 0.0,
                  child: SizedBox(
                    width: 56.0,
                    child: GestureDetector(
                      onTap: model.next,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// UI component for indicator at top on story view.
class StoryIndicator extends StatelessWidget {
  /// Constructor for StoryIndicator.
  const StoryIndicator({
    Key? key,
    required this.scrollController,
    required this.positionsListener,
    required this.itemCount,
  }) : super(key: key);

  /// ItemScrollController for story indicator list.
  final ItemScrollController scrollController;

  /// ItemPositionsListener for story indicator list.
  final ItemPositionsListener positionsListener;

  /// Number of clubs having stories currently.
  final int itemCount;

  final _pages = const [3, 0, 3];

  @override
  Widget build(BuildContext context) {
    final _itemSize = MediaQuery.of(context).size.width - 74;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SizedBox(
        height: 72.0,
        child: ShaderMask(
          blendMode: BlendMode.dstOut,
          shaderCallback: (rect) => const LinearGradient(
            colors: [Colors.transparent, Colors.white],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.85, 1.0],
          ).createShader(rect),
          child: ScrollablePositionedList.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemPositionsListener: positionsListener,
            itemScrollController: scrollController,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return SizedBox(
                width: index == itemCount - 1 ? _itemSize + 74 : _itemSize,
                child: Theme(
                  data: ThemeData.dark(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _pages
                              .map(
                                (it) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    child: Container(
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(2.5),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const Expanded(
                        child: ListTile(
                          leading: CircleAvatar(
                            foregroundImage: CachedNetworkImageProvider(
                              Fixtures.dtLogoLink,
                            ),
                          ),
                          title: Text('DesginTab'),
                          subtitle: Text('timeago'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Displays the image assets of the stories in a pageview.
class StoryImage extends StatelessWidget {
  /// Constructor for StoryImage.
  const StoryImage({
    Key? key,
    required this.pageChanged,
    required this.imgUrl,
    required this.pageController,
    required this.currentStoryIndex,
  }) : super(key: key);

  /// Function to run when the page changes in the pageview.
  final Function(int) pageChanged;

  /// Image asset URL.
  final String imgUrl;

  /// Page controller for pageview.
  final PageController pageController;

  /// Current story to show for a club.
  final int currentStoryIndex;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 5,
      fit: FlexFit.tight,
      child: PageView.builder(
        onPageChanged: pageChanged,
        controller: pageController,
        itemCount: 6,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: AspectRatio(
            aspectRatio: 380 / 540,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: IndexedStack(
                index: currentStoryIndex,
                children: [
                  CachedNetworkImage(
                    imageUrl: imgUrl,
                    fit: BoxFit.contain,
                  ),
                  CachedNetworkImage(
                    imageUrl: imgUrl,
                    fit: BoxFit.contain,
                  ),
                  CachedNetworkImage(
                    imageUrl: imgUrl,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
