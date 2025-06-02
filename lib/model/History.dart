// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'History.g.dart';

@HiveType(typeId: 0)
class History extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String gender;

  @HiveField(2)
  String age;

  @HiveField(3)
  String hypertension;

  @HiveField(4)
  String heartDisease;

  @HiveField(5)
  String everMarried;

  @HiveField(6)
  String workType;

  @HiveField(7)
  String residenceType;

  @HiveField(8)
  String avgGlucoseLevel;

  @HiveField(9)
  String bmi;

  @HiveField(10)
  String smokingStatus;

  @HiveField(11)
  String prediction;

  History({
    required this.name,
    required this.gender,
    required this.age,
    required this.hypertension,
    required this.heartDisease,
    required this.everMarried,
    required this.workType,
    required this.residenceType,
    required this.avgGlucoseLevel,
    required this.bmi,
    required this.smokingStatus,
    required this.prediction,
  });
}
