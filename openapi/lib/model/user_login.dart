//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserLogin {
  /// Returns a new [UserLogin] instance.
  UserLogin({
    this.email,
    this.hashedPassword,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? email;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? hashedPassword;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserLogin &&
    other.email == email &&
    other.hashedPassword == hashedPassword;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (email == null ? 0 : email!.hashCode) +
    (hashedPassword == null ? 0 : hashedPassword!.hashCode);

  @override
  String toString() => 'UserLogin[email=$email, hashedPassword=$hashedPassword]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
    if (this.hashedPassword != null) {
      json[r'hashed_password'] = this.hashedPassword;
    } else {
      json[r'hashed_password'] = null;
    }
    return json;
  }

  /// Returns a new [UserLogin] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserLogin? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserLogin[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserLogin[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserLogin(
        email: mapValueOfType<String>(json, r'email'),
        hashedPassword: mapValueOfType<String>(json, r'hashed_password'),
      );
    }
    return null;
  }

  static List<UserLogin> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserLogin>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserLogin.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserLogin> mapFromJson(dynamic json) {
    final map = <String, UserLogin>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserLogin.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserLogin-objects as value to a dart map
  static Map<String, List<UserLogin>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UserLogin>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UserLogin.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

