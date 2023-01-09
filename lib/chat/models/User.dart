/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _profile_img_url;
  final String? _tag;
  final String? _email;
  final String? _name;
  final String? _subscriber_id;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UserModelIdentifier get modelIdentifier {
      return UserModelIdentifier(
        id: id
      );
  }
  
  String? get profile_img_url {
    return _profile_img_url;
  }
  
  String? get tag {
    return _tag;
  }
  
  String? get email {
    return _email;
  }
  
  String? get name {
    return _name;
  }
  
  String? get subscriber_id {
    return _subscriber_id;
  }
  
  const User._internal({required this.id, profile_img_url, tag, email, name, subscriber_id}): _profile_img_url = profile_img_url, _tag = tag, _email = email, _name = name, _subscriber_id = subscriber_id;
  
  factory User({String? id, String? profile_img_url, String? tag, String? email, String? name, String? subscriber_id}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      profile_img_url: profile_img_url,
      tag: tag,
      email: email,
      name: name,
      subscriber_id: subscriber_id);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _profile_img_url == other._profile_img_url &&
      _tag == other._tag &&
      _email == other._email &&
      _name == other._name &&
      _subscriber_id == other._subscriber_id;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("profile_img_url=" + "$_profile_img_url" + ", ");
    buffer.write("tag=" + "$_tag" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("subscriber_id=" + "$_subscriber_id");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? profile_img_url, String? tag, String? email, String? name, String? subscriber_id}) {
    return User(
      id: id,
      profile_img_url: profile_img_url ?? this.profile_img_url,
      tag: tag ?? this.tag,
      email: email ?? this.email,
      name: name ?? this.name,
      subscriber_id: subscriber_id ?? this.subscriber_id);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _profile_img_url = json['profile_img_url'],
      _tag = json['tag'],
      _email = json['email'],
      _name = json['name'],
      _subscriber_id = json['subscriber_id'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'profile_img_url': _profile_img_url, 'tag': _tag, 'email': _email, 'name': _name, 'subscriber_id': _subscriber_id
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'profile_img_url': _profile_img_url, 'tag': _tag, 'email': _email, 'name': _name, 'subscriber_id': _subscriber_id
  };

  static final QueryModelIdentifier<UserModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<UserModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField PROFILE_IMG_URL = QueryField(fieldName: "profile_img_url");
  static final QueryField TAG = QueryField(fieldName: "tag");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField SUBSCRIBER_ID = QueryField(fieldName: "subscriber_id");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        // ignore: prefer_const_literals_to_create_immutables
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PROFILE_IMG_URL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.TAG,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.SUBSCRIBER_ID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'User';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [User] in your schema.
 */
@immutable
class UserModelIdentifier implements ModelIdentifier<User> {
  final String id;

  /** Create an instance of UserModelIdentifier using [id] the primary key. */
  const UserModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'UserModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UserModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}