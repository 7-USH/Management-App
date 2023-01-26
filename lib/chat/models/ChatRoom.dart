// ignore_for_file: prefer_const_literals_to_create_immutables

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

/** This is an auto generated class representing the ChatRoom type in your schema. */
@immutable
class ChatRoom extends Model {
  static const classType = const _ChatRoomModelType();
  final String id;
  final List<Message>? _Messages;
  final String? _userID;
  final Message? _last_message;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _chatRoomLast_messageId;

  @override
  getInstanceType() => classType;

  @Deprecated(
      '[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;

  ChatRoomModelIdentifier get modelIdentifier {
    return ChatRoomModelIdentifier(id: id);
  }

  List<Message>? get Messages {
    return _Messages;
  }

  String get userID {
    try {
      return _userID!;
    } catch (e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  Message? get last_message {
    return _last_message;
  }

  TemporalDateTime? get createdAt {
    return _createdAt;
  }

  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  String? get chatRoomLast_messageId {
    return _chatRoomLast_messageId;
  }

  const ChatRoom._internal(
      {required this.id,
      Messages,
      required userID,
      last_message,
      createdAt,
      updatedAt,
      chatRoomLast_messageId})
      : _Messages = Messages,
        _userID = userID,
        _last_message = last_message,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _chatRoomLast_messageId = chatRoomLast_messageId;

  factory ChatRoom(
      {String? id,
      List<Message>? Messages,
      required String userID,
      Message? last_message,
      String? chatRoomLast_messageId}) {
    return ChatRoom._internal(
        id: id == null ? UUID.getUUID() : id,
        Messages:
            Messages != null ? List<Message>.unmodifiable(Messages) : Messages,
        userID: userID,
        last_message: last_message,
        chatRoomLast_messageId: chatRoomLast_messageId);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatRoom &&
        id == other.id &&
        DeepCollectionEquality().equals(_Messages, other._Messages) &&
        _userID == other._userID &&
        _last_message == other._last_message &&
        _chatRoomLast_messageId == other._chatRoomLast_messageId;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("ChatRoom {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("createdAt=" +
        (_createdAt != null ? _createdAt!.format() : "null") +
        ", ");
    buffer.write("updatedAt=" +
        (_updatedAt != null ? _updatedAt!.format() : "null") +
        ", ");
    buffer.write("chatRoomLast_messageId=" + "$_chatRoomLast_messageId");
    buffer.write("}");

    return buffer.toString();
  }

  ChatRoom copyWith(
      {List<Message>? Messages,
      String? userID,
      Message? last_message,
      String? chatRoomLast_messageId}) {
    return ChatRoom._internal(
        id: id,
        Messages: Messages ?? this.Messages,
        userID: userID ?? this.userID,
        last_message: last_message ?? this.last_message,
        chatRoomLast_messageId:
            chatRoomLast_messageId ?? this.chatRoomLast_messageId);
  }

  ChatRoom.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _Messages = json['Messages'] is List
            ? (json['Messages'] as List)
                .where((e) => e?['serializedData'] != null)
                .map((e) => Message.fromJson(
                    new Map<String, dynamic>.from(e['serializedData'])))
                .toList()
            : null,
        _userID = json['userID'],
        _last_message = json['last_message']?['serializedData'] != null
            ? Message.fromJson(new Map<String, dynamic>.from(
                json['last_message']['serializedData']))
            : null,
        _createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        _updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null,
        _chatRoomLast_messageId = json['chatRoomLast_messageId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'Messages': _Messages?.map((Message? e) => e?.toJson()).toList(),
        'userID': _userID,
        'last_message': _last_message?.toJson(),
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format(),
        'chatRoomLast_messageId': _chatRoomLast_messageId
      };

  Map<String, Object?> toMap() => {
        'id': id,
        'Messages': _Messages,
        'userID': _userID,
        'last_message': _last_message,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt,
        'chatRoomLast_messageId': _chatRoomLast_messageId
      };

  static final QueryModelIdentifier<ChatRoomModelIdentifier> MODEL_IDENTIFIER =
      QueryModelIdentifier<ChatRoomModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField MESSAGES = QueryField(
      fieldName: "Messages",
      fieldType:
          ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'Message'));
  static final QueryField USERID = QueryField(fieldName: "userID");
  static final QueryField LAST_MESSAGE = QueryField(
      fieldName: "last_message",
      fieldType:
          ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'Message'));
  static final QueryField CHATROOMLAST_MESSAGEID =
      QueryField(fieldName: "chatRoomLast_messageId");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ChatRoom";
    modelSchemaDefinition.pluralName = "ChatRooms";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["userID"], name: "byUser")
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: ChatRoom.MESSAGES,
        isRequired: false,
        ofModelName: 'Message',
        associatedKey: Message.CHATROOMID));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ChatRoom.USERID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
        key: ChatRoom.LAST_MESSAGE,
        isRequired: false,
        ofModelName: 'Message',
        associatedKey: Message.ID));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'createdAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'updatedAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ChatRoom.CHATROOMLAST_MESSAGEID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _ChatRoomModelType extends ModelType<ChatRoom> {
  const _ChatRoomModelType();

  @override
  ChatRoom fromJson(Map<String, dynamic> jsonData) {
    return ChatRoom.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'ChatRoom';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [ChatRoom] in your schema.
 */
@immutable
class ChatRoomModelIdentifier implements ModelIdentifier<ChatRoom> {
  final String id;

  /** Create an instance of ChatRoomModelIdentifier using [id] the primary key. */
  const ChatRoomModelIdentifier({required this.id});

  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{'id': id});

  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
      .entries
      .map((entry) => (<String, dynamic>{entry.key: entry.value}))
      .toList();

  @override
  String serializeAsString() => serializeAsMap().values.join('#');

  @override
  String toString() => 'ChatRoomModelIdentifier(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is ChatRoomModelIdentifier && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
