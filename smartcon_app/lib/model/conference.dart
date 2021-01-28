

class Conference {
  final String confId;
  String name;
  String category;
  String district;
  String website;
  String description;
  DateTime beginDate;
  DateTime endDate;
  double rating;
  int numRatings;

  Conference({this.confId, this.name, this.category, this.district, this.description, this.beginDate, this.endDate, this.website, this.rating, this.numRatings});

  Conference.onlyId({this.confId});

  @override
  bool operator == (covariant Conference other) => other.confId == this.confId;

}
