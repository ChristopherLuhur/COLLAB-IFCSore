import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  final String profileImageUrl;
  final String username;

  // ignore: use_super_parameters
  const ProfilePage({
    Key? key,
    required this.profileImageUrl,
    required this.username,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _gender;
  Color? _usernameColor;
  final bool _isDarkMode = false;
  DateTime? _selectedDate;
  File? _profileImage;
  File? _passportImage;

  @override
  void initState() {
    super.initState();
    _usernameColor = Colors.black;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickProfileImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickPassportImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _passportImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Container(
        color: _isDarkMode ? Colors.grey[900] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: _profileImage == null
                            ? const NetworkImage('https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg')
                            : FileImage(_profileImage!) as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _pickProfileImage,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey[200],
                            child: const Icon(
                              Icons.camera_alt,
                              size: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Text(
                    'User',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _isDarkMode ? Colors.white : _usernameColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Date of Birth:",
                style: TextStyle(fontSize: 18, color: _isDarkMode ? Colors.white : null),
              ),
              Row(
                children: [
                  _selectedDate == null
                      ? Text(
                          'Select Date',
                          style: TextStyle(
                            fontSize: 18,
                            color: _isDarkMode ? Colors.white : Colors.black54,
                          ),
                        )
                      : Text(
                          '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                          style: TextStyle(
                            fontSize: 18,
                            color: _isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Gender:",
                style: TextStyle(fontSize: 18, color: _isDarkMode ? Colors.white : null),
              ),
              Row(
                children: [
                  _buildCustomRadioButton('Male'),
                  const SizedBox(width: 10),
                  _buildCustomRadioButton('Female'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Username Color:",
                    style: TextStyle(fontSize: 18, color: _isDarkMode ? Colors.white : null),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<Color>(
                    value: _usernameColor,
                    onChanged: (value) {
                      setState(() {
                        _usernameColor = value;
                      });
                    },
                    items: [
                      DropdownMenuItem<Color>(
                        value: Colors.black,
                        child: Text(
                          'Black',
                          style: TextStyle(
                            color: _isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      DropdownMenuItem<Color>(
                        value: Colors.blue,
                        child: Text(
                          'Blue',
                          style: TextStyle(
                            color: _isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      DropdownMenuItem<Color>(
                        value: Colors.red,
                        child: Text(
                          'Red',
                          style: TextStyle(
                            color: _isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      DropdownMenuItem<Color>(
                        value: Colors.green,
                        child: Text(
                          'Green',
                          style: TextStyle(
                            color: _isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Upload Passport:",
                style: TextStyle(fontSize: 18, color: _isDarkMode ? Colors.white : null),
              ),
              const SizedBox(height: 10),
              _passportImage == null
                  ? ElevatedButton(
                      onPressed: _pickPassportImage,
                      child: const Text('Upload Image'),
                    )
                  : Column(
                      children: [
                        Image.file(
                          _passportImage!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        TextButton(
                          onPressed: _pickPassportImage,
                          child: const Text('Change Image'),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomRadioButton(String label) {
    return InkWell(
      onTap: () {
        setState(() {
          _gender = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _gender == label ? Colors.blue : Colors.transparent,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: _gender == label ? Colors.white : _isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
