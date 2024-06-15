import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/utils/uuid_maker.dart';

class EntryView extends StatefulWidget {
  final JournalEntry entry;

  const EntryView({super.key, required this.entry});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView>{

  late String name;
  late String currentText;
  late UUIDString uuid; 
  late DateTime updatedAt;
  late DateTime createdAt;

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    name = widget.entry.name;
    currentText = widget.entry.text;
    uuid = widget.entry.uuid;
    createdAt = widget.entry.createdAt;
    updatedAt = widget.entry.updatedAt;

    _nameEditingController.text = widget.entry.name;
    _textEditingController.text = widget.entry.text;
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if(!didPop){
            _popBack(context);
          }
        },
        child: Column(
          children: [
            Semantics(
              label: 'Input for the name of the journal entry',
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
                  child: const Text('Name', textAlign: TextAlign.start, style: TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w900)),
                ),
              ),
            ),
            SizedBox(
              child: Container(
                margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 30.0),
                child: TextField(
                      controller: _nameEditingController,
                      onChanged: (text) {
                        setState(() {
                          // Update the entry text when the text field changes
                          name = text;
                        });
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 42, 42, 42),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none
                        ),
                      ),
                ),
              ),
            ),
            Semantics(
              label: 'Input for journal entry content',
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
                  child: const Text('Entry', textAlign: TextAlign.start, style: TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w900)),
                ),
              ),
            ),
            SizedBox(
              child: Container(
                margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: TextFormField(
                      controller: _textEditingController,
                      onChanged: (text) {
                        setState(() {
                          // Update the entry text when the text field changes
                          currentText = text;
                        });
                      },
                      minLines: 4,
                      maxLines: 6, // Set this 
                      //expands: true, // and this
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 42, 42, 42),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none
                        ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _popBack(BuildContext context){
    JournalEntry newEntry = JournalEntry.withUpdatedText(widget.entry, name, currentText);
    Navigator.pop(context, newEntry);
    
  }

}

