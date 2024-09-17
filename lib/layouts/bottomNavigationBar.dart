import 'package:flutter/material.dart';

class MyBottonNavigation extends StatefulWidget {
  const MyBottonNavigation({super.key});

  @override
  State<MyBottonNavigation> createState() => _MyBottonNavigationState();
}

class _MyBottonNavigationState extends State<MyBottonNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 1. Container, Stack, GridView, ListView, ListTile, Card, SizedBox, Flexible
  static final List<Widget> _widgetOption = <Widget>[
    Stack(
      children: [
        Container(
          color: Colors.blue[50],
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(10),
            children: const <Widget>[
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, size: 50, color: Colors.yellow),
                    SizedBox(height: 10),
                    Text("Pencapaian",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("Menang Medali Emas Prompt Engineer",
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.code, size: 50, color: Colors.blue),
                    SizedBox(height: 10),
                    Text("Coding Expert",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("Python, Flutter, Dart, dan masih banyak lagi...",
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.book, size: 50, color: Colors.green),
                    SizedBox(height: 10),
                    Text("Anime Ditonton",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("50+ Judul Anime", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.games, size: 50, color: Colors.green),
                    SizedBox(height: 10),
                    Text("Jam Terbang Bermain Game",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("2000+ Jam", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    // ListView & ListTile
    ListView(
      children: const <Widget>[
        Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('lib/assets/Bintang.jpg'),
            ),
            title: Text('Bintang Putra Sadewa'),
            subtitle: Text('NIM: 2209106110'),
          ),
        ),
        Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('lib/assets/Alif.jpg'),
            ),
            title: Text('Muhammad Alif'),
            subtitle: Text('NIM: 2209106127'),
          ),
        ),
      ],
    ),
    // Column, Row, and SizedBox , Form & DateTime
    // Panggil Class atau Halaman ProfileForm 
    const ProfileForm(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplikasi Profile"),
      ),
      body: Center(
        child: _widgetOption.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Tentang Kami"),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), label: "Tim Developer"),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), label: "Profile & Form"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  DateTime? _selectedDate;

  void _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Nama"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'nama tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Flexible(
                  child: Text(
                    _selectedDate == null
                        ? "Tanggal Lahir: belum dipilih"
                        : "Tanggal Lahir: ${_selectedDate!.toLocal()}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _pickDate,
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            // Submit button
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileSummary(
                        name: _nameController.text,
                        birthDate: _selectedDate,
                      ),
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

// Output setelah submit
class ProfileSummary extends StatelessWidget {
  final String name;
  final DateTime? birthDate;

  const ProfileSummary({required this.name, this.birthDate, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ringkasan Profil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nama: $name", style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            Text(
              birthDate == null
                  ? "Tanggal Lahir: Tidak Dipilih"
                  : "Tanggal Lahir: ${birthDate!.toLocal()}",
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
