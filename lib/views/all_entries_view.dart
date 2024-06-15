import 'package:flutter/material.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/providers/journal_provider.dart';
import 'package:journal/views/entry_view.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllEntriesView extends StatelessWidget {

  const AllEntriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JournalProvider>(
      builder: (context, journalprovider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Journal'),
            actions: [
              IconButton(onPressed: () {
                JournalEntry newEntry = JournalEntry.defaultConstructor();
                journalprovider.upsertJournalEntry(newEntry);
                _navigateToEntry(context, newEntry);
              }, icon: Semantics(label: 'Create New Journal', child: const Icon(Icons.add)))
            ],
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: journalprovider.journal.entries.length,
                  itemBuilder: ((BuildContext context, int index) => _createListElementForEntry(context, journalprovider.journal.entries[index])))
              )
            ],
          ),
        );
      }
    );
  }
  
  //Takes an entry and returns a widget that displays its relevant information in an element within a list
  Widget _createListElementForEntry(BuildContext context, JournalEntry entry){
    return Card(
        // ignore: sort_child_properties_last
        child: ListTile(
          onTap: () async { await _navigateToEntry(context, entry); },
          title: Semantics(
            label: 'Name of entry',
            child: Text(
              entry.name, 
              style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ), // Display name
          subtitle: Semantics(
            label: 'Journal entry creation date and time',
            child: Text(
              'Created on ${_formatDateTime(entry.createdAt)}',
              style: const TextStyle(color: Color.fromARGB(255, 178, 178, 178)),
            ),
          ),
          trailing: Semantics(
            label: 'Entry last update timestamp',
            child: Text(
              'Last Updated: ${_formatDateTime(entry.updatedAt)}',
              style: const TextStyle(color: Colors.white),
            ),
          ), // Display distance
        ),
        color: const Color.fromARGB(255, 50, 50, 50),
    );
  }

  


  Future<void> _navigateToEntry(BuildContext context, JournalEntry entry) async {
    final newEntry = await Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => EntryView(entry: entry))
    );

    if (!context.mounted) return; // If the widget is not mounted, then we will just return 
                                  // If the user is interacting with the app and the async navigation does not happen fast enough, the widget might be altered before it does

    final journalProvider = Provider.of<JournalProvider>(context, listen: false);
    journalProvider.upsertJournalEntry(newEntry);

  }

  _formatDateTime(DateTime when){
    return DateFormat.yMd().add_jm().format(when);
  }

}