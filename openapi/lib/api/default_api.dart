//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class DefaultApi {
  DefaultApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Delete Media
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] authorization (required):
  ///   format: [Bearer <token>]
  ///
  /// * [String] mediaId (required):
  Future<Response> deleteMediumMediaIdWithHttpInfo(String authorization, String mediaId,) async {
    // ignore: prefer_const_declarations
    final path = r'/media/{mediaId}'
      .replaceAll('{mediaId}', mediaId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Authorization'] = parameterToString(authorization);

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Delete Media
  ///
  /// Parameters:
  ///
  /// * [String] authorization (required):
  ///   format: [Bearer <token>]
  ///
  /// * [String] mediaId (required):
  Future<void> deleteMediumMediaId(String authorization, String mediaId,) async {
    final response = await deleteMediumMediaIdWithHttpInfo(authorization, mediaId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get Medias
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] authorization (required):
  ///   format: [Bearer <token>]
  Future<Response> getMediaWithHttpInfo(String authorization,) async {
    // ignore: prefer_const_declarations
    final path = r'/media';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Authorization'] = parameterToString(authorization);

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Medias
  ///
  /// Parameters:
  ///
  /// * [String] authorization (required):
  ///   format: [Bearer <token>]
  Future<GetMedia200Response?> getMedia(String authorization,) async {
    final response = await getMediaWithHttpInfo(authorization,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetMedia200Response',) as GetMedia200Response;
    
    }
    return null;
  }

  /// Get User Info by User ID
  ///
  /// Retrieve the information of the user with the matching user ID.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] authorization (required):
  ///   format: [Bearer <token>]
  Future<Response> getUsersUserIdWithHttpInfo(String authorization,) async {
    // ignore: prefer_const_declarations
    final path = r'/user';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Authorization'] = parameterToString(authorization);

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get User Info by User ID
  ///
  /// Retrieve the information of the user with the matching user ID.
  ///
  /// Parameters:
  ///
  /// * [String] authorization (required):
  ///   format: [Bearer <token>]
  Future<UserResponse?> getUsersUserId(String authorization,) async {
    final response = await getUsersUserIdWithHttpInfo(authorization,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UserResponse',) as UserResponse;
    
    }
    return null;
  }

  /// Update Media Info
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] authorization (required):
  ///   format: [Bearer <token>]
  ///
  /// * [String] mediaId (required):
  ///
  /// * [PatchMediumMediaIdRequest] patchMediumMediaIdRequest:
  Future<Response> patchMediumMediaIdWithHttpInfo(String authorization, String mediaId, { PatchMediumMediaIdRequest? patchMediumMediaIdRequest, }) async {
    // ignore: prefer_const_declarations
    final path = r'/media/{mediaId}'
      .replaceAll('{mediaId}', mediaId);

    // ignore: prefer_final_locals
    Object? postBody = patchMediumMediaIdRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PATCH',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Update Media Info
  ///
  /// Parameters:
  ///
  /// * [String] authorization (required):
  ///   format: [Bearer <token>]
  ///
  /// * [String] mediaId (required):
  ///
  /// * [PatchMediumMediaIdRequest] patchMediumMediaIdRequest:
  Future<Media?> patchMediumMediaId(String authorization, String mediaId, { PatchMediumMediaIdRequest? patchMediumMediaIdRequest, }) async {
    final response = await patchMediumMediaIdWithHttpInfo(authorization, mediaId,  patchMediumMediaIdRequest: patchMediumMediaIdRequest, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Media',) as Media;
    
    }
    return null;
  }

  /// Update User Information
  ///
  /// Update the information of an existing user.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] authorization (required):
  ///   format: [Bearer <token>]
  ///
  /// * [UserUpdate] userUpdate:
  ///   Patch user properties to update.
  Future<Response> patchUsersUserIdWithHttpInfo(String authorization, { UserUpdate? userUpdate, }) async {
    // ignore: prefer_const_declarations
    final path = r'/user';

    // ignore: prefer_final_locals
    Object? postBody = userUpdate;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PATCH',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Update User Information
  ///
  /// Update the information of an existing user.
  ///
  /// Parameters:
  ///
  /// * [String] authorization (required):
  ///   format: [Bearer <token>]
  ///
  /// * [UserUpdate] userUpdate:
  ///   Patch user properties to update.
  Future<UserResponse?> patchUsersUserId(String authorization, { UserUpdate? userUpdate, }) async {
    final response = await patchUsersUserIdWithHttpInfo(authorization,  userUpdate: userUpdate, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UserResponse',) as UserResponse;
    
    }
    return null;
  }

  /// Login
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UserLogin] userLogin:
  Future<Response> postLoginWithHttpInfo({ UserLogin? userLogin, }) async {
    // ignore: prefer_const_declarations
    final path = r'/login';

    // ignore: prefer_final_locals
    Object? postBody = userLogin;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Login
  ///
  /// Parameters:
  ///
  /// * [UserLogin] userLogin:
  Future<UserToken?> postLogin({ UserLogin? userLogin, }) async {
    final response = await postLoginWithHttpInfo( userLogin: userLogin, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UserToken',) as UserToken;
    
    }
    return null;
  }

  /// Create New Media
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] authorization (required):
  ///   format: [Bearer <token>]
  ///
  /// * [MediaCreate] mediaCreate:
  Future<Response> postMediaWithHttpInfo(String authorization, { MediaCreate? mediaCreate, }) async {
    // ignore: prefer_const_declarations
    final path = r'/media';

    // ignore: prefer_final_locals
    Object? postBody = mediaCreate;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Create New Media
  ///
  /// Parameters:
  ///
  /// * [String] authorization (required):
  ///   format: [Bearer <token>]
  ///
  /// * [MediaCreate] mediaCreate:
  Future<Media?> postMedia(String authorization, { MediaCreate? mediaCreate, }) async {
    final response = await postMediaWithHttpInfo(authorization,  mediaCreate: mediaCreate, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Media',) as Media;
    
    }
    return null;
  }

  /// Create New User
  ///
  /// Create a new user.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UserCreate] userCreate:
  ///   Post the necessary fields for the API to create a new user.
  Future<Response> postUserWithHttpInfo({ UserCreate? userCreate, }) async {
    // ignore: prefer_const_declarations
    final path = r'/signup';

    // ignore: prefer_final_locals
    Object? postBody = userCreate;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Create New User
  ///
  /// Create a new user.
  ///
  /// Parameters:
  ///
  /// * [UserCreate] userCreate:
  ///   Post the necessary fields for the API to create a new user.
  Future<UserToken?> postUser({ UserCreate? userCreate, }) async {
    final response = await postUserWithHttpInfo( userCreate: userCreate, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UserToken',) as UserToken;
    
    }
    return null;
  }
}
