// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'History.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryAdapter extends TypeAdapter<History> {
  @override
  final int typeId = 0;

  @override
  History read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return History(
      name: fields[0] as String,
      gender: fields[1] as String,
      age: fields[2] as String,
      hypertension: fields[3] as String,
      heartDisease: fields[4] as String,
      everMarried: fields[5] as String,
      workType: fields[6] as String,
      residenceType: fields[7] as String,
      avgGlucoseLevel: fields[8] as String,
      bmi: fields[9] as String,
      smokingStatus: fields[10] as String,
      prediction: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, History obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.gender)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.hypertension)
      ..writeByte(4)
      ..write(obj.heartDisease)
      ..writeByte(5)
      ..write(obj.everMarried)
      ..writeByte(6)
      ..write(obj.workType)
      ..writeByte(7)
      ..write(obj.residenceType)
      ..writeByte(8)
      ..write(obj.avgGlucoseLevel)
      ..writeByte(9)
      ..write(obj.bmi)
      ..writeByte(10)
      ..write(obj.smokingStatus)
      ..writeByte(11)
      ..write(obj.prediction);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
