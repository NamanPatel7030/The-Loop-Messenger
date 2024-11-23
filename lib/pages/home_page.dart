import 'package:chatapp_firebase/helper/helper_function.dart';
import 'package:chatapp_firebase/pages/auth/ai_chat_page.dart';
import 'package:chatapp_firebase/pages/auth/login_page.dart';
import 'package:chatapp_firebase/pages/profile_page.dart';
import 'package:chatapp_firebase/pages/search_page.dart';
import 'package:chatapp_firebase/service/auth_service.dart';
import 'package:chatapp_firebase/service/database_service.dart';
import 'package:chatapp_firebase/widgets/group_tile.dart';
import 'package:chatapp_firebase/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () => _scaffoldKey.currentState?.openDrawer(), // Use GlobalKey
            icon: const Icon(Icons.menu),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                nextScreen(context, const SearchPage());
              },
              icon: const Icon(Icons.search),
            ),
          ),
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Groups",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),
      drawer: _buildDrawer(context),
      body: Stack(
        children: [
          _buildBackgroundGradient(),
          _buildBorderedMessagingArea(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButtons(context),
    );
  }

  Widget _buildBackgroundGradient() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50),
        children: [
          const CircleAvatar(
            radius: 70,
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.account_circle,
              size: 100,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            userName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const Divider(height: 30, thickness: 2),
          _buildDrawerTile(
            icon: Icons.group,
            title: "Groups",
            selected: true,
          ),
          _buildDrawerTile(
            icon: Icons.person,
            title: "Profile",
            onTap: () {
              nextScreenReplace(
                context,
                ProfilePage(userName: userName, email: email),
              );
            },
          ),
          _buildDrawerTile(
            icon: Icons.exit_to_app,
            title: "Logout",
            onTap: () async {
              await _logoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    bool selected = false,
  }) {
    return ListTile(
      selected: selected,
      selectedColor: const Color.fromARGB(255, 0, 0, 0),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildFloatingActionButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AIChatPage()),
            );
          },
          backgroundColor: Colors.orange,
          child: const Icon(Icons.bolt, color: Colors.white),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: () {
            popUpDialog(context);
          },
          backgroundColor: const Color.fromARGB(255, 4, 5, 7),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildBorderedMessagingArea() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
        ),
        child: groupList(),
      ),
    );
  }

  Widget groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null &&
              snapshot.data['groups'].isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: snapshot.data['groups'].length,
              itemBuilder: (context, index) {
                int reverseIndex = snapshot.data['groups'].length - index - 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GroupTile(
                    groupId: getId(snapshot.data['groups'][reverseIndex]),
                    groupName: getName(snapshot.data['groups'][reverseIndex]),
                    userName: snapshot.data['fullName'],
                  ),
                );
              },
            );
          } else {
            return noGroupWidget();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          );
        }
      },
    );
  }

  Widget noGroupWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.group_off, size: 100, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            "No Groups Found!",
            style: TextStyle(color: Colors.black54, fontSize: 20),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              popUpDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text("Create Group"),
          ),
        ],
      ),
    );
  }

  Future<void> _logoutDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await authService.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Create a Group"),
          content: TextField(
            onChanged: (val) {
              setState(() {
                groupName = val;
              });
            },
            decoration: InputDecoration(
              hintText: "Enter Group Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (groupName.isNotEmpty) {
                  setState(() => _isLoading = true);
                  await DatabaseService(
                    uid: FirebaseAuth.instance.currentUser!.uid,
                  ).createGroup(userName, FirebaseAuth.instance.currentUser!.uid, groupName);
                  setState(() => _isLoading = false);
                  Navigator.pop(context);
                  showSnackbar(
                      context, Colors.green, "Group created successfully");
                }
              },
              child: const Text("Create"),
            ),
          ],
        );
      },
    );
  }
}
