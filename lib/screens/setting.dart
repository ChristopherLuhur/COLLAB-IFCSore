import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isDarkMode = false;
  bool _receiveNotifications = false;
  final List<String> languages = ['English', 'Indonesian'];
  String selectedLanguage = 'English';
  double _brightness = 0.5;

  final Map<String, Map<String, String>> localizedStrings = {
    'English': {
      'title': 'Select Language',
      'chooseLanguage': 'Choose your preferred language:',
      'languageChanged': 'Language Changed',
      'languageChangedMessage': 'The language has been changed to English.',
      'ok': 'OK',
      'settings': 'Settings',
      'darkMode': 'Dark Mode',
      'darkModeSubtitle': 'Enable or disable dark mode',
      'receiveNotifications': 'Receive Notifications',
      'receiveNotificationsSubtitle': 'Toggle to receive notifications',
      'brightness': 'Brightness',
      'brightnessSubtitle': 'Adjust screen brightness',
    },
    'Indonesian': {
      'title': 'Pilih Bahasa',
      'chooseLanguage': 'Pilih bahasa yang Anda inginkan:',
      'languageChanged': 'Bahasa Berubah',
      'languageChangedMessage': 'Bahasa telah diubah ke Bahasa Indonesia.',
      'ok': 'OK',
      'settings': 'Pengaturan',
      'darkMode': 'Mode Gelap',
      'darkModeSubtitle': 'Aktifkan atau nonaktifkan mode gelap',
      'receiveNotifications': 'Terima Notifikasi',
      'receiveNotificationsSubtitle': 'Beralih untuk menerima notifikasi',
      'brightness': 'Kecerahan',
      'brightnessSubtitle': 'Sesuaikan kecerahan layar',
    },
  };

  void _showLanguageChangedAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localizedStrings[selectedLanguage]!['languageChanged']!),
          content: Text(localizedStrings[selectedLanguage]!['languageChangedMessage']!),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(localizedStrings[selectedLanguage]!['ok']!),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(localizedStrings[selectedLanguage]!['settings']!),
      ),
      body: Container(
        color: _getBackgroundColor(),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildDarkModeSwitch(),
            const SizedBox(height: 20),
            _buildNotificationSwitch(),
            const SizedBox(height: 20),
            _buildBrightnessSlider(),
            const SizedBox(height: 20),
            _buildLanguageSelection(),
          ],
        ),
      ),
    );
  }

  Color? _getBackgroundColor() {
    if (_isDarkMode) {
      return Color.lerp(Colors.black, Colors.white, _brightness);
    } else {
      return Color.lerp(Colors.white, Colors.black, _brightness);
    }
  }

  Widget _buildDarkModeSwitch() {
    return SwitchListTile(
      title: Text(
        localizedStrings[selectedLanguage]!['darkMode']!,
        style: TextStyle(
          color: _isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      subtitle: Text(
        localizedStrings[selectedLanguage]!['darkModeSubtitle']!,
        style: TextStyle(
          color: _isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      value: _isDarkMode,
      onChanged: (value) {
        setState(() {
          _isDarkMode = value;
        });
      },
      activeColor: Colors.blue,
    );
  }

  Widget _buildNotificationSwitch() {
    return ListTile(
      title: Text(
        localizedStrings[selectedLanguage]!['receiveNotifications']!,
        style: TextStyle(
          color: _isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      subtitle: Text(
        localizedStrings[selectedLanguage]!['receiveNotificationsSubtitle']!,
        style: TextStyle(
          color: _isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      trailing: Switch(
        value: _receiveNotifications,
        onChanged: (value) {
          setState(() {
            _receiveNotifications = value;
          });
        },
        activeColor: Colors.blue,
      ),
    );
  }

  Widget _buildBrightnessSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            localizedStrings[selectedLanguage]!['brightness']!,
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          subtitle: Text(
            localizedStrings[selectedLanguage]!['brightnessSubtitle']!,
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        Slider(
          value: _brightness,
          min: 0.0,
          max: 1.0,
          divisions: 10,
          label: (_brightness * 100).toStringAsFixed(0),
          onChanged: (value) {
            setState(() {
              _brightness = value;
            });
          },
          activeColor: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildLanguageSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            localizedStrings[selectedLanguage]!['chooseLanguage']!,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: languages.length,
          itemBuilder: (context, index) {
            final language = languages[index];
            return ListTile(
              title: Text(
                language,
                style: TextStyle(
                  color: _isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              leading: Radio(
                value:                 language,
                groupValue: selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    selectedLanguage = value!;
                  });
                  _showLanguageChangedAlert();
                },
              ),
              onTap: () {
                setState(() {
                  selectedLanguage = language;
                });
                _showLanguageChangedAlert();
              },
            );
          },
        ),
      ],
    );
  }
}

                