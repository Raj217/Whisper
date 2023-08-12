part of image_browsing;

final imageBrowsingProvider =
    StateNotifierProvider<ImageBrowsingNotifier, ImageBrowsingModel>((ref) {
  return ImageBrowsingNotifier();
});

class ImageBrowsingNotifier extends StateNotifier<ImageBrowsingModel> {
  ImageBrowsingNotifier() : super(ImageBrowsingModel());

  ImageInfoModel? get imageInfo => state.imageInfo;
  int get publisherPageNo => state.publisherPageNo;
  int get tagsPageNo => state.tagsPageNo;

  reset() => state = state.reset();

  set loading(bool isLoading) => state = state.copyWith(isLoading: isLoading);
  set publisherName(String? publisher) =>
      state = state.copyWith(publisherName: publisher);
  set tags(List<String> tags) => state = state.copyWith(tags: tags);
  set imageInfo(ImageInfoModel? imageInfo) =>
      state = state.copyWith(imageInfo: imageInfo ?? this.imageInfo);
  set publisherPageNo(int pageNo) =>
      state = state.copyWith(publisherPageNo: pageNo);
  set tagsPageNo(int pageNo) => state = state.copyWith(tagsPageNo: pageNo);
}
