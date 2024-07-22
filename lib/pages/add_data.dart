import 'package:flutter/material.dart';

class InputDataPage extends StatefulWidget {
  const InputDataPage({Key? key}) : super(key: key);

  @override
  _InputDataPageState createState() => _InputDataPageState();
}

class _InputDataPageState extends State<InputDataPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedGender, _selectedPlace;

  void _handleGenderChange(String? value) {
  setState(() {
    _selectedGender = value;
  });
}

void _handlePlaceChange(String? value) {
  setState(() {
    _selectedPlace = value;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4D80DF), Color(0xFFA7E6FF)],
            begin: Alignment.center,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'Form Data Bayi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Silahkan Lengkapi Data Pada Form Berikut',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 50),
                  _radioButton('Posyandu', Icons.add_location, 'Anggrek', 'Cempaka', _selectedPlace, _handlePlaceChange),
                  const SizedBox(height: 20),
                  _textField('Nama Bayi', Icons.person, false),
                  const SizedBox(height: 20),
                  _textField('Tanggal Lahir', Icons.calendar_today, false),
                  const SizedBox(height: 20),
                  _radioButton('Jenis Kelamin', Icons.wc, 'Laki-laki', 'Perempuan', _selectedGender, _handleGenderChange),
                  const SizedBox(height: 20),
                  _textField('Nama Orang Tua (Ayah/Ibu)', Icons.people, false),
                  const SizedBox(height: 20),
                  _textField('Alamat', Icons.home, false),
                  const SizedBox(height: 20),
                  _spaceBetweenField('BB Lahir (kg)', 'PB Lahir (cm)', Icons.monitor_weight, Icons.height),
                  const SizedBox(height: 20),
                  _spaceBetweenField('LK Lahir (cm)', 'Anak Ke-', Icons.child_care, Icons.format_list_numbered),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {}
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField(String hintText, IconData icon, bool isPassword) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$hintText is still empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.blueGrey),
        prefixIcon: Icon(icon, color: Colors.blueGrey),
        filled: true,
        fillColor: Colors.white70,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.blueGrey),
    );
  }

  Widget _radioButton(String judul, IconData icons, String firstOption, String secondOption, String? groupV, void Function(String?) onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icons, color: Colors.blueGrey),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    judul,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: Text(firstOption, style: Theme.of(context).textTheme.displaySmall),
                    value: firstOption,
                    groupValue: groupV,
                    activeColor: Colors.blueGrey, 
                    onChanged: onChanged
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: Text(secondOption, style: Theme.of(context).textTheme.displaySmall),
                    value: secondOption,
                    groupValue: groupV,
                    activeColor: Colors.blueGrey, 
                    onChanged: onChanged
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _spaceBetweenField(String first, String second, IconData icon1, IconData icon2) {
    return Row(
      children: [
        Expanded(
          child: _textField(first, icon1, false),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _textField(second, icon2, false),
        ),
      ],
    );
  }
}
