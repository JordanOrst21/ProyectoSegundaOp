class ImagenNota {
  int? id;
  int notaId;
  String url;

  ImagenNota({
    this.id,
    required this.notaId,
    required this.url,
  });

  factory ImagenNota.fromJson(Map<String, dynamic> json) {
    return ImagenNota(
      id: json['id'],
      notaId: json['nota_id'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nota_id': notaId,
      'url': url,
    };
  }
}
