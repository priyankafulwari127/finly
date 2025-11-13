// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 0;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      categoryName: fields[0] as String?,
      totalAmount: fields[1] as double?,
      id: fields[2] as String,
      budgetAmount: fields[5] as double?,
      date: fields[4] as String?,
      description: fields[3] as String?,
      iconPoints: fields[6] as int,
      fontFamily: fields[7] as String,
      iconFontPackage: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.categoryName)
      ..writeByte(1)
      ..write(obj.totalAmount)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.budgetAmount)
      ..writeByte(6)
      ..write(obj.iconPoints)
      ..writeByte(7)
      ..write(obj.fontFamily)
      ..writeByte(8)
      ..write(obj.iconFontPackage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
