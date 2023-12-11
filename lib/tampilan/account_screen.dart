import 'package:flutter/material.dart';
import 'package:flutter_helloword/widgets/bot_nav_bar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key});

  static const routeName = '/account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: const BottomNavBar(
        index: 2,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                // borderRadius: BorderRadius.only(
                //     bottomLeft: Radius.circular(20),
                //     bottomRight: Radius.circular(20)),
              ),
              height: 50,
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 5.0, bottom: 5.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                        'https://picsum.photos/id/88/200/300',
                      ),
                    ),
                    // SizedBox(width: 16.0),
                    Text(
                      "Akhmad Badawi",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: buildUserInfo("Nama Lengkap", "John Doe"),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: buildUserInfo("Alamat", "Jl. Contoh No. 123"),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: buildUserInfo("Email", "john.doe@example.com"),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: buildUserInfo("Jenis Kelamin", "Laki-laki"),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: buildUserInfo("Pekerjaan", "Software Developer"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUserInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          buildDivider()
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      height: 2.0,
      color: Color.fromARGB(255, 0, 0, 0),
    );
  }
}
