part of image_browsing;

class ImageBrowsingModel {
  bool isLoading;
  ImageInfoModel? imageInfo;
  int publisherPageNo;
  int tagsPageNo;
  ImageBrowsingModel({
    this.isLoading = false,
    this.imageInfo,
    this.publisherPageNo = 0,
    this.tagsPageNo = 0,
  });

  ImageBrowsingModel reset() {
    return ImageBrowsingModel(
      isLoading: false,
      imageInfo: null,
      publisherPageNo: 0,
      tagsPageNo: 0,
    );
  }

  ImageBrowsingModel copyWith({
    bool? isLoading,
    ImageInfoModel? imageInfo,
    int? publisherPageNo,
    int? tagsPageNo,
  }) {
    return ImageBrowsingModel(
      isLoading: isLoading ?? false,
      imageInfo: imageInfo ?? this.imageInfo,
      publisherPageNo: publisherPageNo ?? this.publisherPageNo,
      tagsPageNo: tagsPageNo ?? this.tagsPageNo,
    );
  }
}
