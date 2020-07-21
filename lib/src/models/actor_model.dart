class Cast {
  List<Actor> actores = new List();

  Cast({this.actores});

  Cast.fromJson(List<dynamic> json) {
    if (json != null) {
      json.forEach((act) => actores.add(new Actor.fromJson(act)));
    }
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJson(Map<String, dynamic> json) {
    castId = json["cast_id"];
    character = json["character"];
    creditId = json["credit_id"];
    gender = json["gender"];
    id = json["id"];
    name = json["name"];
    order = json["order"];
    profilePath = json["profile_path"];
  }

  getFoto() {
    if (profilePath == null) {
      return "https://www.dovercourt.org/wp-content/uploads/2019/11/610-6104451_image-placeholder-png-user-profile-placeholder-image-png-286x300.jpg";
    }
    return "https://image.tmdb.org/t/p/w500/$profilePath";
  }
}
