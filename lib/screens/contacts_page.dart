import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'emergency.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<String> contacts = [];

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    contacts = prefs.getStringList("contacts") ?? [];
    setState(() {});
  }

  Future<void> deleteContact(int index) async {
    final prefs = await SharedPreferences.getInstance();
    contacts.removeAt(index);
    await prefs.setStringList("contacts", contacts);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final data = contacts[index].split("|");
          String first = data[0];
          String last = data[1];
          String phone = data[2];
          String relation = data[3];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: cs.surface.withOpacity(0.8),
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person, color: cs.onSurface),
                backgroundColor: cs.surface,
              ),
              title: Text("$first $last", style: TextStyle(color: cs.onSurface)),
              subtitle: Text("$phone • $relation",
                  style: TextStyle(color: cs.onSurface.withOpacity(0.7))),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: cs.primary),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NewContactPage(
                            editIndex: index,
                            existingContact: contacts[index],
                          ),
                        ),
                      ).then((_) => loadContacts());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      deleteContact(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}