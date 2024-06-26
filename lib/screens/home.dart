import 'package:flutter/material.dart';
import 'package:travel_apps/models/travel.dart';
import 'package:travel_apps/models/travels.dart';
import 'package:travel_apps/screens/history.dart';
import 'package:travel_apps/screens/profile.dart';
import 'package:travel_apps/screens/cart.dart';
import 'package:travel_apps/widgets/travel_card.dart';
import 'package:travel_apps/screens/info.dart';
import 'package:travel_apps/screens/favorite.dart';
import 'package:travel_apps/screens/setting.dart';

class Home extends StatefulWidget {
  // ignore: use_super_parameters
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  List<Travel> allTravels = Travels().travels;
  List<Travel> filteredTravels = [];
  int _selectedDrawerIndex = 0;

  @override
  void initState() {
    super.initState();
    filteredTravels = allTravels;
    searchController.addListener(_filterTravels);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterTravels);
    searchController.dispose();
    super.dispose();
  }

  void _filterTravels() {
    setState(() {
      filteredTravels = allTravels
          .where((travel) => travel.nama
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _onFavoriteToggle() {
    setState(() {
      _selectedDrawerIndex = 4;
    });
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const FavoriteScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Country Destiny"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: const ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                  onTap: () {
                    Future.delayed(Duration.zero, () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SettingScreen(),
                      ));
                    });
                  },
                ),
                PopupMenuItem(
                  child: const ListTile(
                    leading: Icon(Icons.info),
                    title: Text('Info'),
                  ),
                  onTap: () {
                    Future.delayed(Duration.zero, () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const InfoScreen(),
                      ));
                    });
                  },
                ),
                PopupMenuItem(
                  child: const ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                  ),
                  onTap: () {
                    Future.delayed(Duration.zero, () {
                      Navigator.pushReplacementNamed(context, '/login');
                    });
                  },
                ),
              ];
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg'),
                  ),
                  SizedBox(width: 25),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              selected: _selectedDrawerIndex == 2,
              onTap: () {
                setState(() {
                  _selectedDrawerIndex = 2;
                });
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProfilePage(username: '', profileImageUrl: ''),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('History'),
              selected: _selectedDrawerIndex == 1,
              onTap: () {
                setState(() {
                  _selectedDrawerIndex = 1;
                });
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorite'),
              selected: _selectedDrawerIndex == 4,
              onTap: () {
                setState(() {
                  _selectedDrawerIndex = 4;
                });
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FavoriteScreen(),
                ));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.25,
                ),
                itemCount: filteredTravels.length,
                itemBuilder: (context, index) {
                  final travel = filteredTravels[index];
                  return TravelCard(
                    travel: travel,
                    onFavoriteToggle: _onFavoriteToggle,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const Cart(),
          ));
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
