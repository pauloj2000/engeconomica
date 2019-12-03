class ImagemItem {
  int id;
  int itemId;
  String content;

  ImagemItem({
    this.id,
    this.content,
    this.itemId,
  });

  factory ImagemItem.fromJson(Map<String, dynamic> json) => ImagemItem(
    id: json["id"],
    content: json["content"],
    itemId: json["itemId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "itemId": itemId,
  };
}

class ImagemItemList {
  final List<ImagemItem> imagemItemList;
  ImagemItemList({
    this.imagemItemList,
  });
  factory ImagemItemList.fromJson(List<dynamic> json) {
    return new ImagemItemList(
      imagemItemList: json.map((i) => ImagemItem.fromJson(i)).toList(),
    );
  }
}