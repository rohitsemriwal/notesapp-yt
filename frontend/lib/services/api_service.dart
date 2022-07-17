import 'dart:convert';
import 'dart:developer';

import 'package:notesapp/models/note.dart';
import 'package:http/http.dart' as http;

class ApiService {

  static String _baseUrl = "https://cryptic-basin-24863.herokuapp.com/notes";

  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + "/add");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }
  
  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + "/delete");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<List<Note>> fetchNotes(String userid) async {
    Uri requestUri = Uri.parse(_baseUrl + "/list");
    var response = await http.post(requestUri, body: { "userid": userid });
    var decoded = jsonDecode(response.body);
    
    List<Note> notes = [];
    for(var noteMap in decoded) {
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }

    return notes;
  }

}