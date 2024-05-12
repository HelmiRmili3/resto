import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white.withOpacity(0.3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    "https://st3.depositphotos.com/15648834/17930/v/450/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "Welcome , Helmi Rmili",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 100,
              ),
              PopupMenuButton<String>(
                iconColor: Colors.white,
                onSelected: (String choice) {
                  switch (choice) {
                    case 'Option 1':
                      break;
                    case 'Option 2':
                      break;
                    case 'Option 3':
                      break;
                    // Add more cases for additional options if needed
                  }
                },
                itemBuilder: (BuildContext context) {
                  return const <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'Option 1',
                      child: Text('Orders'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Option 2',
                      child: Text('History'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Option 3',
                      child: Text('Profile'),
                    ),
                    // Add more PopupMenuItems for additional options if needed
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
