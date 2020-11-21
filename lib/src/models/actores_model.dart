import 'dart:convert';

class Cast {
  List<Actor> actores = new List();

  Cast.fromJsonList( List<dynamic> jsonList ) {

    if(jsonList == null) return;

    jsonList.forEach((element) {
      final actor = Actor.fromJson(element);
      actores.add(actor);
    });

  }

}


class Actor {
  Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String department;
  String job;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    knownForDepartment: json["known_for_department"],
    name: json["name"],
    originalName: json["original_name"],
    popularity: json["popularity"].toDouble(),
    profilePath: json["profile_path"] == null ? null : json["profile_path"],
    castId: json["cast_id"] == null ? null : json["cast_id"],
    character: json["character"] == null ? null : json["character"],
    creditId: json["credit_id"],
    order: json["order"] == null ? null : json["order"],
    department: json["department"] == null ? null : json["department"],
    job: json["job"] == null ? null : json["job"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": knownForDepartment,
    "name": name,
    "original_name": originalName,
    "popularity": popularity,
    "profile_path": profilePath == null ? null : profilePath,
    "cast_id": castId == null ? null : castId,
    "character": character == null ? null : character,
    "credit_id": creditId,
    "order": order == null ? null : order,
    "department": department == null ? null : department,
    "job": job == null ? null : job,
  };

  String getPhoto() {
    if(profilePath == null) {
      return 'https://annam-finefood.com/wp-content/uploads/2016/09/no-avatar.png';
    }
    return 'https://image.tmdb.org/t/p/w138_and_h175_face$profilePath';
  }

}
