import 'package:journal/utils/uuid_maker.dart';
import 'package:hive/hive.dart';

part 'journal_entry.g.dart';

@HiveType(typeId: 1, adapterName: 'JournalEntryAdapter')
class JournalEntry {

  @HiveField(0)
  final String name; //Each journal entry must have a name associated with it

  @HiveField(1)
  final String text; //Each journal entry must have content (can be empty)

  @HiveField(2)
  final UUIDString uuid; //Each journal must have unique identifier (Inv: every entry has a different uuid)
  
  @HiveField(3)
  final DateTime updatedAt; //Each journal must have an update time (can change over time if entry is edited)
  
  @HiveField(4)
  final DateTime createdAt; //Each journal must have the time it was created at (Inv: createdAt must never change)

  //This is the factory constructor responsible for gathering information, setting defaults, and passing that information to another constructor
  JournalEntry({
    required this.name,
    required this.text,
    required this.uuid,
    required this.updatedAt,
    required this.createdAt,
  });

  // Created another constructor to replicate the behavior of the old default constructor
  // This constructor sets createdAt and updatedAt using DateTime.now()
  JournalEntry.defaultConstructor({this.name = '', this.text = ''})
      : uuid = UUIDMaker.generateUUID(),
        updatedAt = DateTime.now(),
        createdAt = DateTime.now();

  //This constructor is used to create an updated journal entry with the same information as before (namely the uuid) with only a different update time
  JournalEntry.withUpdatedText(JournalEntry entry, newName, newText) :  uuid=entry.uuid, createdAt=entry.createdAt, updatedAt=DateTime.now(), name=newName, text=newText;
}

