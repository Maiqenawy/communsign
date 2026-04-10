import 'package:flutter/material.dart';
import '../services/contact_service.dart';
import 'new_contact_page.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List contacts = [];
  String token = "YOUR_TOKEN";

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> loadContacts() async {
    final data = await ContactService.getContacts(token);
    setState(() {
      contacts = data;
    });
  }

  Future<void> deleteContact(int id) async {
    await ContactService.deleteContact(id, token);
    loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Contacts")),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final c = contacts[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: cs.surface.withOpacity(0.8),
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(c["name"]),
              subtitle: Text("${c["email"]} • ${c["relation"] ?? ""}"),
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
                            contact: c,
                          ),
                        ),
                      ).then((_) => loadContacts());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteContact(c["contactId"]),
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
