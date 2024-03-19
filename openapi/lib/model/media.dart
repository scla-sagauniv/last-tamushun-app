//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Media {
  /// Returns a new [Media] instance.
  Media({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.movieUrl,
    this.lat,
    this.lon,
  });

  int id;

  int userId;

  String imageUrl;

  String movieUrl;

  int? lat;

  int? lon;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Media &&
    other.id == id &&
    other.userId == userId &&
    other.imageUrl == imageUrl &&
    other.movieUrl == movieUrl &&
    other.lat == lat &&
    other.lon == lon;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (userId.hashCode) +
    (imageUrl.hashCode) +
    (movieUrl.hashCode) +
    (lat == null ? 0 : lat!.hashCode) +
    (lon == null ? 0 : lon!.hashCode);

  @override
  String toString() => 'Media[id=$id, userId=$userId, imageUrl=$imageUrl, movieUrl=$movieUrl, lat=$lat, lon=$lon]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'user_id'] = this.userId;
      json[r'image_url'] = this.imageUrl;
      json[r'movie_url'] = this.movieUrl;
    if (this.lat != null) {
      json[r'lat'] = this.lat;
    } else {
      json[r'lat'] = null;
    }
    if (this.lon != null) {
      json[r'lon'] = this.lon;
    } else {
      json[r'lon'] = null;
    }
    return json;
  }

  /// Returns a new [Media] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Media? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Media[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Media[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Media(
        id: mapValueOfType<int>(json, r'id')!,
        userId: mapValueOfType<int>(json, r'user_id')!,
        imageUrl: mapValueOfType<String>(json, r'image_url')!,
        movieUrl: mapValueOfType<String>(json, r'movie_url')!,
        lat: mapValueOfType<int>(json, r'lat'),
        lon: mapValueOfType<int>(json, r'lon'),
      );
    }
    return null;
  }

  static List<Media> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Media>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Media.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Media> mapFromJson(dynamic json) {
    final map = <String, Media>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Media.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Media-objects as value to a dart map
  static Map<String, List<Media>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Media>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Media.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'user_id',
    'image_url',
    'movie_url',
  };
}

