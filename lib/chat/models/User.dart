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

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _profile_img_url;
  final String? _tag;
  final String? _name;
  final bool? _is_online;
  final String? _subscriber_id;
  final List<Message>? _Messages;
  final List<ChatRoom>? _ChatRooms;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

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
  
  String? get name {
    return _name;
  }
  
  bool? get is_online {
    return _is_online;
  }
  
  String? get subscriber_id {
    return _subscriber_id;
  }
  
  List<Message>? get Messages {
    return _Messages;
  }
  
  List<ChatRoom>? get ChatRooms {
    return _ChatRooms;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const User._internal({required this.id, profile_img_url, tag, name, is_online, subscriber_id, Messages, ChatRooms, createdAt, updatedAt}): _profile_img_url = profile_img_url, _tag = tag, _name = name, _is_online = is_online, _subscriber_id = subscriber_id, _Messages = Messages, _ChatRooms = ChatRooms, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory User({String? id, String? profile_img_url, String? tag, String? name, bool? is_online, String? subscriber_id, List<Message>? Messages, List<ChatRoom>? ChatRooms}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      profile_img_url: profile_img_url,
      tag: tag,
      name: name,
      is_online: is_online,
      subscriber_id: subscriber_id,
      Messages: Messages != null ? List<Message>.unmodifiable(Messages) : Messages,
      ChatRooms: ChatRooms != null ? List<ChatRoom>.unmodifiable(ChatRooms) : ChatRooms);
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
      _name == other._name &&
      _is_online == other._is_online &&
      _subscriber_id == other._subscriber_id &&
      DeepCollectionEquality().equals(_Messages, other._Messages) &&
      DeepCollectionEquality().equals(_ChatRooms, other._ChatRooms);
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
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("is_online=" + (_is_online != null ? _is_online!.toString() : "null") + ", ");
    buffer.write("subscriber_id=" + "$_subscriber_id" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? profile_img_url, String? tag, String? name, bool? is_online, String? subscriber_id, List<Message>? Messages, List<ChatRoom>? ChatRooms}) {
    return User._internal(
      id: id,
      profile_img_url: profile_img_url ?? this.profile_img_url,
      tag: tag ?? this.tag,
      name: name ?? this.name,
      is_online: is_online ?? this.is_online,
      subscriber_id: subscriber_id ?? this.subscriber_id,
      Messages: Messages ?? this.Messages,
      ChatRooms: ChatRooms ?? this.ChatRooms);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _profile_img_url = json['profile_img_url'],
      _tag = json['tag'],
      _name = json['name'],
      _is_online = json['is_online'],
      _subscriber_id = json['subscriber_id'],
      _Messages = json['Messages'] is List
        ? (json['Messages'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Message.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _ChatRooms = json['ChatRooms'] is List
        ? (json['ChatRooms'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ChatRoom.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'profile_img_url': _profile_img_url, 'tag': _tag, 'name': _name, 'is_online': _is_online, 'subscriber_id': _subscriber_id, 'Messages': _Messages?.map((Message? e) => e?.toJson()).toList(), 'ChatRooms': _ChatRooms?.map((ChatRoom? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'profile_img_url': _profile_img_url, 'tag': _tag, 'name': _name, 'is_online': _is_online, 'subscriber_id': _subscriber_id, 'Messages': _Messages, 'ChatRooms': _ChatRooms, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<UserModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<UserModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField PROFILE_IMG_URL = QueryField(fieldName: "profile_img_url");
  static final QueryField TAG = QueryField(fieldName: "tag");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField IS_ONLINE = QueryField(fieldName: "is_online");
  static final QueryField SUBSCRIBER_ID = QueryField(fieldName: "subscriber_id");
  static final QueryField MESSAGES = QueryField(
    fieldName: "Messages",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'Message'));
  static final QueryField CHATROOMS = QueryField(
    fieldName: "ChatRooms",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'ChatRoom'));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
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
      key: User.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.IS_ONLINE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.SUBSCRIBER_ID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.MESSAGES,
      isRequired: false,
      ofModelName: 'Message',
      associatedKey: Message.USERID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.CHATROOMS,
      isRequired: false,
      ofModelName: 'ChatRoom',
      associatedKey: ChatRoom.USERID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
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