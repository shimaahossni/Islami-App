// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskMdelAdapter extends TypeAdapter<TaskMdel> {
  @override
  final int typeId = 0;

  @override
  TaskMdel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskMdel(
      title: fields[1] as String,
      note: fields[2] as String,
      date: fields[3] as String,
      startTime: fields[4] as String,
      endTime: fields[5] as String,
      color: fields[6] as int,
      id: fields[0] as String,
      isCompleted: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskMdel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.startTime)
      ..writeByte(5)
      ..write(obj.endTime)
      ..writeByte(6)
      ..write(obj.color)
      ..writeByte(7)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskMdelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
