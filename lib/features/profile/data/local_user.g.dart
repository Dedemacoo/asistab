// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_user.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLocalUserCollection on Isar {
  IsarCollection<LocalUser> get localUsers => this.collection();
}

const LocalUserSchema = CollectionSchema(
  name: r'LocalUser',
  id: -4571928749043988992,
  properties: {
    r'connectedInstitutions': PropertySchema(
      id: 0,
      name: r'connectedInstitutions',
      type: IsarType.stringList,
    ),
    r'email': PropertySchema(
      id: 1,
      name: r'email',
      type: IsarType.string,
    ),
    r'geminiApiKey': PropertySchema(
      id: 2,
      name: r'geminiApiKey',
      type: IsarType.string,
    ),
    r'isFaceIdEnabled': PropertySchema(
      id: 3,
      name: r'isFaceIdEnabled',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'profilePicturePath': PropertySchema(
      id: 5,
      name: r'profilePicturePath',
      type: IsarType.string,
    ),
    r'surname': PropertySchema(
      id: 6,
      name: r'surname',
      type: IsarType.string,
    )
  },
  estimateSize: _localUserEstimateSize,
  serialize: _localUserSerialize,
  deserialize: _localUserDeserialize,
  deserializeProp: _localUserDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _localUserGetId,
  getLinks: _localUserGetLinks,
  attach: _localUserAttach,
  version: '3.1.0+1',
);

int _localUserEstimateSize(
  LocalUser object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.connectedInstitutions.length * 3;
  {
    for (var i = 0; i < object.connectedInstitutions.length; i++) {
      final value = object.connectedInstitutions[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.email;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.geminiApiKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.profilePicturePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.surname;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _localUserSerialize(
  LocalUser object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.connectedInstitutions);
  writer.writeString(offsets[1], object.email);
  writer.writeString(offsets[2], object.geminiApiKey);
  writer.writeBool(offsets[3], object.isFaceIdEnabled);
  writer.writeString(offsets[4], object.name);
  writer.writeString(offsets[5], object.profilePicturePath);
  writer.writeString(offsets[6], object.surname);
}

LocalUser _localUserDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalUser();
  object.connectedInstitutions = reader.readStringList(offsets[0]) ?? [];
  object.email = reader.readStringOrNull(offsets[1]);
  object.geminiApiKey = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.isFaceIdEnabled = reader.readBool(offsets[3]);
  object.name = reader.readStringOrNull(offsets[4]);
  object.profilePicturePath = reader.readStringOrNull(offsets[5]);
  object.surname = reader.readStringOrNull(offsets[6]);
  return object;
}

P _localUserDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _localUserGetId(LocalUser object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _localUserGetLinks(LocalUser object) {
  return [];
}

void _localUserAttach(IsarCollection<dynamic> col, Id id, LocalUser object) {
  object.id = id;
}

extension LocalUserQueryWhereSort
    on QueryBuilder<LocalUser, LocalUser, QWhere> {
  QueryBuilder<LocalUser, LocalUser, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LocalUserQueryWhere
    on QueryBuilder<LocalUser, LocalUser, QWhereClause> {
  QueryBuilder<LocalUser, LocalUser, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LocalUserQueryFilter
    on QueryBuilder<LocalUser, LocalUser, QFilterCondition> {
  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      connectedInstitutionsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'connectedInstitutions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      connectedInstitutionsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'connectedInstitutions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      connectedInstitutionsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'connectedInstitutions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      connectedInstitutionsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'connectedInstitutions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      connectedInstitutionsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'connectedInstitutions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      connectedInstitutionsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'connectedInstitutions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      connectedInstitutionsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'connectedInstitutions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      connectedInstitutionsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'connectedInstitutions',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      connectedInstitutionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'connectedInstitutions',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      connectedInstitutionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'connectedInstitutions',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      connectedInstitutionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'connectedInstitutions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      connectedInstitutionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'connectedInstitutions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      connectedInstitutionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'connectedInstitutions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      connectedInstitutionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'connectedInstitutions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      connectedInstitutionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'connectedInstitutions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      connectedInstitutionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'connectedInstitutions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> emailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> emailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> emailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> emailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> emailContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> emailMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      geminiApiKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'geminiApiKey',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      geminiApiKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'geminiApiKey',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> geminiApiKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'geminiApiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      geminiApiKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'geminiApiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      geminiApiKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'geminiApiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> geminiApiKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'geminiApiKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      geminiApiKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'geminiApiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      geminiApiKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'geminiApiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      geminiApiKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'geminiApiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> geminiApiKeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'geminiApiKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      geminiApiKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'geminiApiKey',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      geminiApiKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'geminiApiKey',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      isFaceIdEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFaceIdEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      profilePicturePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'profilePicturePath',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      profilePicturePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'profilePicturePath',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      profilePicturePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profilePicturePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      profilePicturePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'profilePicturePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      profilePicturePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'profilePicturePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      profilePicturePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'profilePicturePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      profilePicturePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'profilePicturePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      profilePicturePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'profilePicturePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      profilePicturePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'profilePicturePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      profilePicturePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'profilePicturePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      profilePicturePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profilePicturePath',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      profilePicturePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'profilePicturePath',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> surnameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'surname',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> surnameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'surname',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> surnameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'surname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> surnameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'surname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> surnameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'surname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> surnameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'surname',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> surnameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'surname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> surnameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'surname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> surnameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'surname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> surnameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'surname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition> surnameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'surname',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterFilterCondition>
      surnameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'surname',
        value: '',
      ));
    });
  }
}

extension LocalUserQueryObject
    on QueryBuilder<LocalUser, LocalUser, QFilterCondition> {}

extension LocalUserQueryLinks
    on QueryBuilder<LocalUser, LocalUser, QFilterCondition> {}

extension LocalUserQuerySortBy on QueryBuilder<LocalUser, LocalUser, QSortBy> {
  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> sortByGeminiApiKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geminiApiKey', Sort.asc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> sortByGeminiApiKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geminiApiKey', Sort.desc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> sortByIsFaceIdEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFaceIdEnabled', Sort.asc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> sortByIsFaceIdEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFaceIdEnabled', Sort.desc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> sortByProfilePicturePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profilePicturePath', Sort.asc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy>
      sortByProfilePicturePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profilePicturePath', Sort.desc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> sortBySurname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surname', Sort.asc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> sortBySurnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surname', Sort.desc);
    });
  }
}

extension LocalUserQuerySortThenBy
    on QueryBuilder<LocalUser, LocalUser, QSortThenBy> {
  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> thenByGeminiApiKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geminiApiKey', Sort.asc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> thenByGeminiApiKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geminiApiKey', Sort.desc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> thenByIsFaceIdEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFaceIdEnabled', Sort.asc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> thenByIsFaceIdEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFaceIdEnabled', Sort.desc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> thenByProfilePicturePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profilePicturePath', Sort.asc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy>
      thenByProfilePicturePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profilePicturePath', Sort.desc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> thenBySurname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surname', Sort.asc);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QAfterSortBy> thenBySurnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surname', Sort.desc);
    });
  }
}

extension LocalUserQueryWhereDistinct
    on QueryBuilder<LocalUser, LocalUser, QDistinct> {
  QueryBuilder<LocalUser, LocalUser, QDistinct>
      distinctByConnectedInstitutions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'connectedInstitutions');
    });
  }

  QueryBuilder<LocalUser, LocalUser, QDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QDistinct> distinctByGeminiApiKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'geminiApiKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QDistinct> distinctByIsFaceIdEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFaceIdEnabled');
    });
  }

  QueryBuilder<LocalUser, LocalUser, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QDistinct> distinctByProfilePicturePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profilePicturePath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalUser, LocalUser, QDistinct> distinctBySurname(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'surname', caseSensitive: caseSensitive);
    });
  }
}

extension LocalUserQueryProperty
    on QueryBuilder<LocalUser, LocalUser, QQueryProperty> {
  QueryBuilder<LocalUser, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LocalUser, List<String>, QQueryOperations>
      connectedInstitutionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'connectedInstitutions');
    });
  }

  QueryBuilder<LocalUser, String?, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<LocalUser, String?, QQueryOperations> geminiApiKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'geminiApiKey');
    });
  }

  QueryBuilder<LocalUser, bool, QQueryOperations> isFaceIdEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFaceIdEnabled');
    });
  }

  QueryBuilder<LocalUser, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<LocalUser, String?, QQueryOperations>
      profilePicturePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profilePicturePath');
    });
  }

  QueryBuilder<LocalUser, String?, QQueryOperations> surnameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'surname');
    });
  }
}
