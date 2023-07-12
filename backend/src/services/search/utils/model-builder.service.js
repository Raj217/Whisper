class ModelBuilder {
  static build(imageData, lowRes, midRes, highRes) {
    return {
      publisherName: imageData.publisherName,
      publisherURL: imageData.publisherUrl,
      tags: imageData.tags,
      color: imageData.color,
      images: {
        low: lowRes,
        mid: midRes,
        high: highRes,
      },
    };
  }
}

export default ModelBuilder;
