// ignore_for_file: unnecessary_import

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


/** This is an auto generated class representing the Friends type in your schema. */
@immutable
class Friends extends Model {
  static const classType = const _FriendsModelType();
  final String id;
  final String? _profile_img_url;
  final String? _tag;
  final String? _latest_message;
  final String? _latest_message_time;
  final String? _name;
  final bool? _is_online;
  final String? _subscriber_id;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  FriendsModelIdentifier get modelIdentifier {
      return FriendsModelIdentifier(
        id: id
      );
  }
  
  String? get profile_img_url {
    return _profile_img_url;
  }
  
  String? get tag {
    return _tag;
  }
  
  String? get latest_message {
    return _latest_message;
  }
  
  String? get latest_message_time {
    return _latest_message_time;
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
  
  const Friends._internal({required this.id, profile_img_url, tag, latest_message, latest_message_time, name, is_online, subscriber_id}): _profile_img_url = profile_img_url, _tag = tag, _latest_message = latest_message, _latest_message_time = latest_message_time, _name = name, _is_online = is_online, _subscriber_id = subscriber_id;
  
  factory Friends({String? id, String? profile_img_url, String? tag, String? latest_message, String? latest_message_time, String? name, bool? is_online, String? subscriber_id}) {
    return Friends._internal(
      id: id == null ? UUID.getUUID() : id,
      profile_img_url: profile_img_url,
      tag: tag,
      latest_message: latest_message,
      latest_message_time: latest_message_time,
      name: name,
      is_online: is_online,
      subscriber_id: subscriber_id);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Friends &&
      id == other.id &&
      _profile_img_url == other._profile_img_url &&
      _tag == other._tag &&
      _latest_message == other._latest_message &&
      _latest_message_time == other._latest_message_time &&
      _name == other._name &&
      _is_online == other._is_online &&
      _subscriber_id == other._subscriber_id;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Friends {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("profile_img_url=" + "$_profile_img_url" + ", ");
    buffer.write("tag=" + "$_tag" + ", ");
    buffer.write("latest_message=" + "$_latest_message" + ", ");
    buffer.write("latest_message_time=" + "$_latest_message_time" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("is_online=" + (_is_online != null ? _is_online!.toString() : "null") + ", ");
    buffer.write("subscriber_id=" + "$_subscriber_id");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Friends copyWith({String? profile_img_url, String? tag, String? latest_message, String? latest_message_time, String? name, bool? is_online, String? subscriber_id}) {
    return Friends(
      id: id,
      profile_img_url: profile_img_url ?? this.profile_img_url,
      tag: tag ?? this.tag,
      latest_message: latest_message ?? this.latest_message,
      latest_message_time: latest_message_time ?? this.latest_message_time,
      name: name ?? this.name,
      is_online: is_online ?? this.is_online,
      subscriber_id: subscriber_id ?? this.subscriber_id);
  }
  
  Friends.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _profile_img_url = json['profile_img_url'],
      _tag = json['tag'],
      _latest_message = json['latest_message'],
      _latest_message_time = json['latest_message_time'],
      _name = json['name'],
      _is_online = json['is_online'],
      _subscriber_id = json['subscriber_id'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'profile_img_url': _profile_img_url, 'tag': _tag, 'latest_message': _latest_message, 'latest_message_time': _latest_message_time, 'name': _name, 'is_online': _is_online, 'subscriber_id': _subscriber_id
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'profile_img_url': _profile_img_url, 'tag': _tag, 'latest_message': _latest_message, 'latest_message_time': _latest_message_time, 'name': _name, 'is_online': _is_online, 'subscriber_id': _subscriber_id
  };

  static final QueryModelIdentifier<FriendsModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<FriendsModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField PROFILE_IMG_URL = QueryField(fieldName: "profile_img_url");
  static final QueryField TAG = QueryField(fieldName: "tag");
  static final QueryField LATEST_MESSAGE = QueryField(fieldName: "latest_message");
  static final QueryField LATEST_MESSAGE_TIME = QueryField(fieldName: "latest_message_time");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField IS_ONLINE = QueryField(fieldName: "is_online");
  static final QueryField SUBSCRIBER_ID = QueryField(fieldName: "subscriber_id");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Friends";
    modelSchemaDefinition.pluralName = "Friends";
    
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
      key: Friends.PROFILE_IMG_URL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Friends.TAG,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Friends.LATEST_MESSAGE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Friends.LATEST_MESSAGE_TIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Friends.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Friends.IS_ONLINE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Friends.SUBSCRIBER_ID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _FriendsModelType extends ModelType<Friends> {
  const _FriendsModelType();
  
  @override
  Friends fromJson(Map<String, dynamic> jsonData) {
    return Friends.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Friends';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Friends] in your schema.
 */
@immutable
class FriendsModelIdentifier implements ModelIdentifier<Friends> {
  final String id;

  /** Create an instance of FriendsModelIdentifier using [id] the primary key. */
  const FriendsModelIdentifier({
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
  String toString() => 'FriendsModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is FriendsModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}