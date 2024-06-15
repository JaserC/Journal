import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/models/journal_entry.dart';

class JournalProvider extends ChangeNotifier {
  final Journal _journal;

  //Instantiate journal object with a new one
  JournalProvider(Box<JournalEntry> storage) : _journal = Journal(storage: storage);

  //Will return a clone of the journal
  Journal get journal => _journal.clone();

  //Upsert within provider will call journal's upsert
  void upsertJournalEntry(JournalEntry entry) {
    _journal.upsertEntry(entry);
    notifyListeners();
  }
}
