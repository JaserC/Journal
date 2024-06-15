import 'package:hive/hive.dart';

import 'journal_entry.dart'; // Assuming JournalEntry class is defined in journal_entry.dart

class Journal {
  final String name; //This Journal will have a name (like what would go on the cover of a physical journal)
  final List<JournalEntry> _entries; //The entries will represented by a list (like pages in a book)
  final Box<JournalEntry> _storage;

  //Constructor intializes journal name and entries list
  Journal({this.name = 'My Diary', List<JournalEntry>? entries, required Box<JournalEntry> storage})
      : _entries = entries ?? [], // Initialize entries list with provided entries or an empty list
        _storage = storage {
    _initializeEntriesFromStorage(); // Call a method to initialize _entries from _storage
  }
  
  List<JournalEntry> get entries => List.from(_entries); //Returns a list comprised of all entries in the list

  void _initializeEntriesFromStorage() {
    _entries.addAll(_storage.values); // Add all values from storage to _entries list
  }

  //Adds an entry to the entries list if not present already (updates an existing entry)
  void upsertEntry(JournalEntry entry) {
    _storage.put(entry.uuid, entry);
  }

  //Calls the constructor with a copy of the entries list to create an identical Journal object
  Journal clone() {
    return Journal(name: name, storage: _storage);
  }
}
