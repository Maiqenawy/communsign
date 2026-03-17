import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contacts_page.dart';
import '../widgets/gradient_background.dart';

class NewContactPage extends StatefulWidget {
  final int? editIndex;
  final String? existingContact;
  const NewContactPage({super.key, this.editIndex, this.existingContact});

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final TextEditingController first = TextEditingController();
  final TextEditingController last = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController relation = TextEditingController();

  bool showPhone = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingContact != null) {
      List<String> data = widget.existingContact!.split("|");
      first.text = data[0];
      last.text = data[1];
      phone.text = data[2];
      relation.text = data[3];
      showPhone = phone.text.isNotEmpty;
    }
  }

  Future<void> saveContact() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> contacts = prefs.getStringList("contacts") ?? [];
    String contact =
        "${first.text}|${last.text}|${phone.text}|${relation.text}";

    if (widget.editIndex != null) {
      contacts[widget.editIndex!] = contact; // تعديل
    } else {
      contacts.add(contact); // إضافة جديدة
    }

    await prefs.setStringList("contacts", contacts);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ContactsPage()),
    );
  }

  @override
  void dispose() {
    first.dispose();
    last.dispose();
    phone.dispose();
    relation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final gradientColors = isDark
        ? [Color(0xFF0F1720), Color(0xFF020409)]
        : [Color(0xFFF2F2F7), Color(0xFFE5E5EA)];

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 17,
                              color: cs.primary,
                            ),
                          ),
                        ),
                        Text(
                          widget.editIndex != null
                              ? "Edit Contact"
                              : "New Contact",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: cs.onSurface,
                          ),
                        ),
                        GestureDetector(
                          onTap: saveContact,
                          child: Text(
                            "Done",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: cs.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Avatar
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: cs.outlineVariant, width: 2),
                    ),
                    child: Icon(
                      CupertinoIcons.person,
                      size: 60,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Name Fields
                  _card([
                    _field(first, "First name"),
                    const Divider(height: 1),
                    _field(last, "Last name")
                  ], cs),
                  const SizedBox(height: 20),
                  // Phone Section
                  _card([
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showPhone = true;
                        });
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.add, color: Colors.green),
                          SizedBox(width: 10),
                          Text("add phone")
                        ],
                      ),
                    ),
                    if (showPhone) ...[
                      const SizedBox(height: 10),
                      const Divider(height: 1),
                      _field(phone, "Phone number", keyboard: TextInputType.phone)
                    ]
                  ], cs),
                  const SizedBox(height: 20),
                  // Relation
                  _card([_field(relation, "Relation")], cs),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _card(List<Widget> children, ColorScheme cs) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surface.withOpacity(0.8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(children: children),
    );
  }

  Widget _field(TextEditingController c, String hint,
      {TextInputType keyboard = TextInputType.text}) {
    final cs = Theme.of(context).colorScheme;
    return TextField(
      controller: c,
      keyboardType: keyboard,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: cs.onSurface.withOpacity(0.5),
        ),
        border: InputBorder.none,
      ),
      style: TextStyle(color: cs.onSurface),
    );
  }
}