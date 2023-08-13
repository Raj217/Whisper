import 'package:flutter/material.dart';
import 'package:whisper/configs/theme/theme.dart';
import 'package:whisper/screens/home_screen/widgets/image_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/packages/database/database.dart';
import 'fetch_more_indicator.dart';

class ImageGallery extends ConsumerStatefulWidget {
  final Future<List<ImageInfoModel>> Function() fetchImages;
  final void Function(ImageInfoModel)? onImageChanged;
  final bool updateLastViewedCheckpoint;
  const ImageGallery({
    super.key,
    required this.fetchImages,
    this.onImageChanged,
    this.updateLastViewedCheckpoint = false,
  });

  @override
  ConsumerState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends ConsumerState<ImageGallery> {
  bool isLoading = true;
  List<ImageInfoModel> images = [];
  PageController pageController = PageController();

  Future<void> fetch() async {
    List<ImageInfoModel> newImages = await widget.fetchImages();
    print(newImages.map((e) => e.publisherName).toList());
    if (mounted) {
      setState(() {
        images.addAll(newImages);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    fetch().then((value) {
      if (widget.onImageChanged != null && images.isNotEmpty) {
        widget.onImageChanged!(images.first);
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FetchMoreIndicator(
      fetchFunction: () async {
        await fetch();
        double? page = pageController.page;
        if (page != null && page + 1 < images.length) {
          pageController.animateToPage(
            (page + 1).toInt(),
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
          );
        }
      },
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
                strokeCap: StrokeCap.round,
                color: whiteSwatch,
              ),
            )
          : PageView.builder(
              itemCount: images.isEmpty && !isLoading ? 1 : images.length,
              controller: pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (int index) {
                if (widget.onImageChanged != null) {
                  widget.onImageChanged!(images[index]);
                }
              },
              itemBuilder: (context, ind) {
                if (images.isEmpty) {
                  return Center(
                    child: Text("Couldn't find any image.",
                        style: Theme.of(context).textTheme.headlineMedium),
                  );
                }
                return ImageCard(
                  imageInfo: images[ind],
                  updateLastViewedCheckpoint: widget.updateLastViewedCheckpoint,
                );
              },
            ),
    );
  }
}
