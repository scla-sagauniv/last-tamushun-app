//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PostMediaRequest {
  /// Returns a new [PostMediaRequest] instance.
  PostMediaRequest({
    this.imageUrl,
    this.movieUrl,
    this.lat,
    this.lon,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? imageUrl;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? movieUrl;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? lat;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? lon;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PostMediaRequest &&
    other.imageUrl == imageUrl &&
    other.movieUrl == movieUrl &&
    other.lat == lat &&
    other.lon == lon;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (imageUrl == null ? 0 : imageUrl!.hashCode) +
    (movieUrl == null ? 0 : movieUrl!.hashCode) +
    (lat == null ? 0 : lat!.hashCode) +
    (lon == null ? 0 : lon!.hashCode);

  @override
  String toString() => 'PostMediaRequest[imageUrl=$imageUrl, movieUrl=$movieUrl, lat=$lat, lon=$lon]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.imageUrl != null) {
      json[r'image_url'] = this.imageUrl;
    } else {
      json[r'image_url'] = null;
    }
    if (this.movieUrl != null) {
      json[r'movie_url'] = this.movieUrl;
    } else {
      json[r'movie_url'] = null;
    }
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

  /// Returns a new [PostMediaRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PostMediaRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PostMediaRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PostMediaRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PostMediaRequest(
        imageUrl: mapValueOfType<String>(json, r'image_url'),
        movieUrl: mapValueOfType<String>(json, r'movie_url'),
        lat: mapValueOfType<int>(json, r'lat'),
        lon: mapValueOfType<int>(json, r'lon'),
      );
    }
    return null;
  }

  static List<PostMediaRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PostMediaRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PostMediaRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PostMediaRequest> mapFromJson(dynamic json) {
    final map = <String, PostMediaRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PostMediaRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PostMediaRequest-objects as value to a dart map
  static Map<String, List<PostMediaRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PostMediaRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PostMediaRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

