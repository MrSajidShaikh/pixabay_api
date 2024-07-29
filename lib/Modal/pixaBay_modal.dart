class SearchModal
{
  late List<Hit> hits = [];

  SearchModal({required this.hits});

  factory SearchModal.fromJson(Map m1)
  {
    return SearchModal(hits: (m1['hits'] as List).map((e) => Hit.fromJson(e),).toList());
  }
}
class Hit
{
  late String webformatURL;

  Hit({required this.webformatURL});

  factory Hit.fromJson(Map m1)
  {
    return Hit(webformatURL: m1['webformatURL']);
  }
}
