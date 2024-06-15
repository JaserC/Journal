import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/providers/journal_provider.dart';
import 'package:journal/utils/journal_mocker.dart';
import 'package:journal/views/all_entries_view.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(JournalEntryAdapter());

  const secureStorage = FlutterSecureStorage(); //Instantiate Secure Storage Object
  
  final encryptionKeyString = await secureStorage.read(key: 'key'); //Read a value from the secureStorage with the key "key"
  // If there is no encription key...
  if (encryptionKeyString == null) {
    final key = Hive.generateSecureKey(); //Generates an encription key
    await secureStorage.write( //Will encode the key and save it as a value to a key called "key"
      key: 'key',
      value: base64UrlEncode(key),
    );
  }
  final key = await secureStorage.read(key: 'key'); //Reads the pre-existing key or newly generated one and saves it to a variable
  final encryptionKeyUint8List = base64Url.decode(key!); //Will decode the key from storage and save it to a variable 
  
  //Opens a Hive Box with the encryption cipher being the encryption key just returned from secure storage
  final storage = await Hive.openBox<JournalEntry>('vaultBox', encryptionCipher: HiveAesCipher(encryptionKeyUint8List)); 

  runApp(ChangeNotifierProvider(
    create: (context) => JournalProvider(storage),
    child: const MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal App',
      debugShowCheckedModeBanner: false, // to not block the + buttong
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const AllEntriesView(),
    );
  }
}