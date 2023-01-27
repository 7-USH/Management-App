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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the UserChatRoom type in your schema. */
@immutable
class UserChatRoom extends Model {
  static const classType = const _UserChatRoomModelType();
  final String id;
  final ChatRoom? _chatRoom;
  final User? _user;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UserChatRoomModelIdentifier get modelIdentifier {
      return UserChatRoomModelIdentifier(
        id: id
      );
  }
  
  ChatRoom get chatRoom {
    try {
      return _chatRoom!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  User get user {
    try {
      return _user!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const UserChatRoom._internal({required this.id, required chatRoom, required user, createdAt, updatedAt}): _chatRoom = chatRoom, _user = user, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory UserChatRoom({String? id, required ChatRoom chatRoom, required User user}) {
    return UserChatRoom._internal(
      id: id == null ? UUID.getUUID() : id,
      chatRoom: chatRoom,
      user: user);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserChatRoom &&
      id == other.id &&
      _chatRoom == other._chatRoom &&
      _user == other._user;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UserChatRoom {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("chatRoom=" + (_chatRoom != null ? _chatRoom!.toString() : "null") + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UserChatRoom copyWith({ChatRoom? chatRoom, User? user}) {
    return UserChatRoom._internal(
      id: id,
      chatRoom: chatRoom ?? this.chatRoom,
      user: user ?? this.user);
  }
  
  UserChatRoom.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _chatRoom = json['chatRoom']?['serializedData'] != null
        ? ChatRoom.fromJson(new Map<String, dynamic>.from(json['chatRoom']['serializedData']))
        : null,
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'chatRoom': _chatRoom?.toJson(), 'user': _user?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'chatRoom': _chatRoom, 'user': _user, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<UserChatRoomModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<UserChatRoomModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField CHATROOM = QueryField(
    fieldName: "chatRoom",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'ChatRoom'));
  static final QueryField USER = QueryField(
    fieldName: "user",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'User'));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserChatRoom";
    modelSchemaDefinition.pluralName = "UserChatRooms";
    
    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["chatRoomId"], name: "byChatRoom"),
      ModelIndex(fields: const ["userId"], name: "byUser")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: UserChatRoom.CHATROOM,
      isRequired: true,
      targetNames: ['chatRoomId'],
      ofModelName: 'ChatRoom'
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: UserChatRoom.USER,
      isRequired: true,
      targetNames: ['userId'],
      ofModelName: 'User'
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

class _UserChatRoomModelType extends ModelType<UserChatRoom> {
  const _UserChatRoomModelType();
  
  @override
  UserChatRoom fromJson(Map<String, dynamic> jsonData) {
    return UserChatRoom.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'UserChatRoom';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [UserChatRoom] in your schema.
 */
@immutable
class UserChatRoomModelIdentifier implements ModelIdentifier<UserChatRoom> {
  final String id;

  /** Create an instance of UserChatRoomModelIdentifier using [id] the primary key. */
  const UserChatRoomModelIdentifier({
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
  String toString() => 'UserChatRoomModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UserChatRoomModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}