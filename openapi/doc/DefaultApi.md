# openapi.api.DefaultApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteMediumMediaId**](DefaultApi.md#deletemediummediaid) | **DELETE** /media/{mediaId} | Delete Media
[**getMedia**](DefaultApi.md#getmedia) | **GET** /media | Get Medias
[**getUsersUserId**](DefaultApi.md#getusersuserid) | **GET** /user | Get User Info by User ID
[**patchMediumMediaId**](DefaultApi.md#patchmediummediaid) | **PATCH** /media/{mediaId} | Update Media Info
[**patchUsersUserId**](DefaultApi.md#patchusersuserid) | **PATCH** /user | Update User Information
[**postLogin**](DefaultApi.md#postlogin) | **POST** /login | Login
[**postMedia**](DefaultApi.md#postmedia) | **POST** /media | Create New Media
[**postUser**](DefaultApi.md#postuser) | **POST** /signup | Create New User


# **deleteMediumMediaId**
> deleteMediumMediaId(authorization, mediaId)

Delete Media

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final authorization = authorization_example; // String | format: [Bearer <token>]
final mediaId = mediaId_example; // String | 

try {
    api_instance.deleteMediumMediaId(authorization, mediaId);
} catch (e) {
    print('Exception when calling DefaultApi->deleteMediumMediaId: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| format: [Bearer <token>] | 
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
> GetMedia200Response getMedia(authorization)

Get Medias

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final authorization = authorization_example; // String | format: [Bearer <token>]

try {
    final result = api_instance.getMedia(authorization);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->getMedia: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| format: [Bearer <token>] | 

### Return type

[**GetMedia200Response**](GetMedia200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUsersUserId**
> UserResponse getUsersUserId(authorization)

Get User Info by User ID

Retrieve the information of the user with the matching user ID.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final authorization = authorization_example; // String | format: [Bearer <token>]

try {
    final result = api_instance.getUsersUserId(authorization);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->getUsersUserId: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| format: [Bearer <token>] | 

### Return type

[**UserResponse**](UserResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **patchMediumMediaId**
> Media patchMediumMediaId(authorization, mediaId, patchMediumMediaIdRequest)

Update Media Info

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final authorization = authorization_example; // String | format: [Bearer <token>]
final mediaId = mediaId_example; // String | 
final patchMediumMediaIdRequest = PatchMediumMediaIdRequest(); // PatchMediumMediaIdRequest | 

try {
    final result = api_instance.patchMediumMediaId(authorization, mediaId, patchMediumMediaIdRequest);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->patchMediumMediaId: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| format: [Bearer <token>] | 
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
> UserResponse patchUsersUserId(authorization, userUpdate)

Update User Information

Update the information of an existing user.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final authorization = authorization_example; // String | format: [Bearer <token>]
final userUpdate = UserUpdate(); // UserUpdate | Patch user properties to update.

try {
    final result = api_instance.patchUsersUserId(authorization, userUpdate);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->patchUsersUserId: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| format: [Bearer <token>] | 
 **userUpdate** | [**UserUpdate**](UserUpdate.md)| Patch user properties to update. | [optional] 

### Return type

[**UserResponse**](UserResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postLogin**
> UserToken postLogin(userLogin)

Login

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final userLogin = UserLogin(); // UserLogin | 

try {
    final result = api_instance.postLogin(userLogin);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->postLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userLogin** | [**UserLogin**](UserLogin.md)|  | [optional] 

### Return type

[**UserToken**](UserToken.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postMedia**
> Media postMedia(authorization, mediaCreate)

Create New Media

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final authorization = authorization_example; // String | format: [Bearer <token>]
final mediaCreate = MediaCreate(); // MediaCreate | 

try {
    final result = api_instance.postMedia(authorization, mediaCreate);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->postMedia: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**| format: [Bearer <token>] | 
 **mediaCreate** | [**MediaCreate**](MediaCreate.md)|  | [optional] 

### Return type

[**Media**](Media.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postUser**
> UserToken postUser(userCreate)

Create New User

Create a new user.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final userCreate = UserCreate(); // UserCreate | Post the necessary fields for the API to create a new user.

try {
    final result = api_instance.postUser(userCreate);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->postUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userCreate** | [**UserCreate**](UserCreate.md)| Post the necessary fields for the API to create a new user. | [optional] 

### Return type

[**UserToken**](UserToken.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

