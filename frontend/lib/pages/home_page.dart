import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/pages/add_new_note.dart';
import 'package:notesapp/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
        centerTitle: true,
      ),
      body: (notesProvider.isLoading == false) ? SafeArea(
        child: (notesProvider.notes.length > 0) ? ListView(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    searchQuery = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search"
                ),
              ),
            ),

            (notesProvider.getFilteredNotes(searchQuery).length > 0) ? GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2
              ),
              itemCount: notesProvider.getFilteredNotes(searchQuery).length,
              itemBuilder: (context, index) {

                Note currentNote = notesProvider.getFilteredNotes(searchQuery)[index];

                return GestureDetector(
                  onTap: () {
                    // Update
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => AddNewNotePage(isUpdate: true, note: currentNote,)
                      ),
                    );
                  },
                  onLongPress: () {
                    // Delete
                    notesProvider.deleteNote(currentNote);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(currentNote.title!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20), maxLines: 1, overflow: TextOverflow.ellipsis,),
                        const SizedBox(height: 7,),
                        Text(currentNote.content!, style: TextStyle( fontSize: 18, color: Colors.grey[700] ), maxLines: 5, overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                );

              },
            ) : Padding(
              padding: EdgeInsets.all(20),
              child: Text("No notes found!", textAlign: TextAlign.center,),
            ),
          ],
        ) : Center(
          child: Text("No notes yet"),
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      ),      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => const AddNewNotePage(isUpdate: false,)
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}