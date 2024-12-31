import 'package:apollo/entity/Cart.dart';
import 'package:apollo/entity/userModel.dart';
import 'package:apollo/screens/loginpage.dart';
import 'package:apollo/services/authService.dart';
import 'package:apollo/services/userService.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService authService = AuthService();
  final UserService userService = UserService();

  Future<UserModel> _getUser() async {
    int? userId = await authService.getUserIdFromToken();
    var user = await userService.getUser(userId!);
    return user!;
  }

  Future<void> _logout() async {
    await authService.logout();

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  ShoppingCart spc = ShoppingCart();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<UserModel>(
        future: _getUser(),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          UserModel user = snapshot.data!;
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                height: size.height,
                width: size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.amber.withOpacity(0.5),
                                width: 5.0)),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(user.photoLink ?? ''),
                        ),
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
                              user.fullName ?? '',
                              style:
                                  TextStyle(color: Colors.amber, fontSize: 20),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        user.email ?? '',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            profileItem(
                                'Thay đổi thông tin tài khoản',
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 24,
                                )),
                            profileItem(
                                'Đăng xuất',
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                  size: 24,
                                )),
                          ],
                        ),
                      )
                    ]),
              ),
            ),
          );
        });
  }

  Widget profileItem(String name, Icon icon) {
    return GestureDetector(
      onTap: () {
        if (name == "Đăng xuất") {
          spc.delete();
          _logout();
        }
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.amber.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                SizedBox(
                  width: 16,
                ),
                Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
