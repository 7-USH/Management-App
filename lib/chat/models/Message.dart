// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_import

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


/** This is an auto generated class representing the Message type in your schema. */
@immutable
class Message extends Model {
  static const classType = const _MessageModelType();
  final String id;
  final String? _message;
  final String? _from_user;
  final String? _to_user;
  final String? _time_stamp;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  MessageModelIdentifier get modelIdentifier {
      return MessageModelIdentifier(
        id: id
      );
  }
  
  String? get message {
    return _message;
  }
  
  String? get from_user {
    return _from_user;
  }
  
  String? get to_user {
    return _to_user;
  }
  
  String? get time_stamp {
    return _time_stamp;
  }
  
  const Message._internal({required this.id, message, from_user, to_user, time_stamp}): _message = message, _from_user = from_user, _to_user = to_user, _time_stamp = time_stamp;
  
  factory Message({String? id, String? message, String? from_user, String? to_user, String? time_stamp}) {
    return Message._internal(
      id: id == null ? UUID.getUUID() : id,
      message: message,
      from_user: from_user,
      to_user: to_user,
      time_stamp: time_stamp);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Message &&
      id == other.id &&
      _message == other._message &&
      _from_user == other._from_user &&
      _to_user == other._to_user &&
      _time_stamp == other._time_stamp;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Message {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("message=" + "$_message" + ", ");
    buffer.write("from_user=" + "$_from_user" + ", ");
    buffer.write("to_user=" + "$_to_user" + ", ");
    buffer.write("time_stamp=" + "$_time_stamp");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Message copyWith({String? message, String? from_user, String? to_user, String? time_stamp}) {
    return Message(
      id: id,
      message: message ?? this.message,
      from_user: from_user ?? this.from_user,
      to_user: to_user ?? this.to_user,
      time_stamp: time_stamp ?? this.time_stamp);
  }
  
  Message.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _message = json['message'],
      _from_user = json['from_user'],
      _to_user = json['to_user'],
      _time_stamp = json['time_stamp'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'message': _message, 'from_user': _from_user, 'to_user': _to_user, 'time_stamp': _time_stamp
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'message': _message, 'from_user': _from_user, 'to_user': _to_user, 'time_stamp': _time_stamp
  };

  static final QueryModelIdentifier<MessageModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<MessageModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField MESSAGE = QueryField(fieldName: "message");
  static final QueryField FROM_USER = QueryField(fieldName: "from_user");
  static final QueryField TO_USER = QueryField(fieldName: "to_user");
  static final QueryField TIME_STAMP = QueryField(fieldName: "time_stamp");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Message";
    modelSchemaDefinition.pluralName = "Messages";
    
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
      key: Message.MESSAGE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Message.FROM_USER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Message.TO_USER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Message.TIME_STAMP,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _MessageModelType extends ModelType<Message> {
  const _MessageModelType();
  
  @override
  Message fromJson(Map<String, dynamic> jsonData) {
    return Message.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Message';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Message] in your schema.
 */
@immutable
class MessageModelIdentifier implements ModelIdentifier<Message> {
  final String id;

  /** Create an instance of MessageModelIdentifier using [id] the primary key. */
  const MessageModelIdentifier({
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
  String toString() => 'MessageModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is MessageModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}