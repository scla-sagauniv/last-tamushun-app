# openapi.api.DefaultApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteMediumMediaId**](DefaultApi.md#deletemediummediaid) | **DELETE** /media/{mediaId} | Delete Media
[**getMedia**](DefaultApi.md#getmedia) | **GET** /media | Get Media Info
[**getUsersUserId**](DefaultApi.md#getusersuserid) | **GET** /users/{userId} | Get User Info by User ID
[**patchMediumMediaId**](DefaultApi.md#patchmediummediaid) | **PATCH** /media/{mediaId} | Update Media Info
[**patchUsersUserId**](DefaultApi.md#patchusersuserid) | **PATCH** /users/{userId} | Update User Information
[**postLogin**](DefaultApi.md#postlogin) | **POST** /login | Login
[**postMedia**](DefaultApi.md#postmedia) | **POST** /media | Create New Media
[**postUser**](DefaultApi.md#postuser) | **POST** /signup | Create New User


# **deleteMediumMediaId**
> deleteMediumMediaId(mediaId)

Delete Media

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final mediaId = mediaId_example; // String | 

try {
    api_instance.deleteMediumMediaId(mediaId);
} catch (e) {
    print('Exception when calling DefaultApi->deleteMediumMediaId: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **mediaId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMedia**
> GetMedia200Response getMedia()

Get Media Info

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.getMedia();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->getMedia: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**GetMedia200Response**](GetMedia200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUsersUserId**
> GetUsersUserId200Response getUsersUserId(userId)

Get User Info by User ID

Retrieve the information of the user with the matching user ID.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final userId = 56; // int | Id of an existing user.

try {
    final result = api_instance.getUsersUserId(userId);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->getUsersUserId: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**| Id of an existing user. | 

### Return type

[**GetUsersUserId200Response**](GetUsersUserId200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **patchMediumMediaId**
> Media patchMediumMediaId(mediaId, patchMediumMediaIdRequest)

Update Media Info

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final mediaId = mediaId_example; // String | 
final patchMediumMediaIdRequest = PatchMediumMediaIdRequest(); // PatchMediumMediaIdRequest | 

try {
    final result = api_instance.patchMediumMediaId(mediaId, patchMediumMediaIdRequest);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->patchMediumMediaId: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **mediaId** | **String**|  | 
 **patchMediumMediaIdRequest** | [**PatchMediumMediaIdRequest**](PatchMediumMediaIdRequest.md)|  | [optional] 

### Return type

[**Media**](Media.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **patchUsersUserId**
> Object patchUsersUserId(userId, patchUsersUserIdRequest)

Update User Information

Update the information of an existing user.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final userId = 56; // int | Id of an existing user.
final patchUsersUserIdRequest = PatchUsersUserIdRequest(); // PatchUsersUserIdRequest | Patch user properties to update.

try {
    final result = api_instance.patchUsersUserId(userId, patchUsersUserIdRequest);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->patchUsersUserId: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**| Id of an existing user. | 
 **patchUsersUserIdRequest** | [**PatchUsersUserIdRequest**](PatchUsersUserIdRequest.md)| Patch user properties to update. | [optional] 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postLogin**
> PostLogin200Response postLogin(postLoginRequest)

Login

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final postLoginRequest = PostLoginRequest(); // PostLoginRequest | 

try {
    final result = api_instance.postLogin(postLoginRequest);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->postLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postLoginRequest** | [**PostLoginRequest**](PostLoginRequest.md)|  | [optional] 

### Return type

[**PostLogin200Response**](PostLogin200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postMedia**
> Media postMedia(postMediaRequest)

Create New Media

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final postMediaRequest = PostMediaRequest(); // PostMediaRequest | 

try {
    final result = api_instance.postMedia(postMediaRequest);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->postMedia: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postMediaRequest** | [**PostMediaRequest**](PostMediaRequest.md)|  | [optional] 

### Return type

[**Media**](Media.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postUser**
> PostUser201Response postUser(postUserRequest)

Create New User

Create a new user.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final postUserRequest = PostUserRequest(); // PostUserRequest | Post the necessary fields for the API to create a new user.

try {
    final result = api_instance.postUser(postUserRequest);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->postUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postUserRequest** | [**PostUserRequest**](PostUserRequest.md)| Post the necessary fields for the API to create a new user. | [optional] 

### Return type

[**PostUser201Response**](PostUser201Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

