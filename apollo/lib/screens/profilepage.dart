import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          height: size.height,
          width: size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              width: 150,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                    "https://yt3.ggpht.com/yti/ANjgQV_sTUVvISXZVjh7g7xAgClYUBG2iik0k3IFsatvX8zQ8AI=s88-c-k-c0x00ffffff-no-rj"),
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.amber.withOpacity(0.5), width: 5.0)),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: size.width * 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tizun",
                    style: TextStyle(color: Colors.amber, fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 24,
                    width: 20,
                    child: Image.network(
                        "https://static.vecteezy.com/system/resources/thumbnails/047/309/980/small_2x/verified-badge-profile-icon-png.png"),
                  )
                ],
              ),
            ),
            Text(
              'tizun0701@gmail.com',
              style: TextStyle(color: Colors.white),
            )
          ]),
        ),
      ),
    );
  }
}
