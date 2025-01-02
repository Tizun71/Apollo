import 'package:apollo/configdata/color_codes.dart';
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

  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  late Future<UserModel> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _getUser();
    _init();
  }

  void _reloadUserData() {
    setState(() {
      _userFuture = _getUser();
    });
  }

  _init() async {
    UserModel userModel = await _getUser();
    fullnameController.text = userModel.fullName!;
    addressController.text = userModel.address!;
    emailController.text = userModel.email!;
    phoneController.text = userModel.phone!;
  }

  Future<UserModel> _getUser() async {
    int? userId = await authService.getUserIdFromToken();
    var user = await userService.getUser(userId!);
    return user!;
  }

  Future<void> _updateUser() async {
    int? userId = await authService.getUserIdFromToken();
    UserModel userModel = await _getUser();
    userModel.fullName = fullnameController.text;
    userModel.email = emailController.text;
    userModel.address = addressController.text;
    userModel.phone = phoneController.text;
    bool success = await userService.updateProfile(userId!, userModel);
    if (success) {
      _reloadUserData();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cập nhật thông tin thành công!')),
      );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cập nhật thông tin thất bại!')),
      );
    }
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
        future: _userFuture,
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          UserModel user = snapshot.data!;
          return Scaffold(
            backgroundColor: themeColor,
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
                          backgroundImage: NetworkImage(user.photoLink ??
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3ohhB35hNd0JDv4j3juY523JFYq7pZ2oqRsIqZDQnZc64tVaY-4KthOgRpoOdg8NHQ-8&usqp=CAU'),
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
        } else if (name == "Thay đổi thông tin tài khoản") {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return FractionallySizedBox(
                  heightFactor: 0.8, child: modalBottomItem());
            },
          );
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

  Widget modalBottomItem() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: const Color.fromARGB(244, 0, 0, 0)),
      child: Center(
        child: Column(
          children: [
            Text(
              "THAY ĐỔI THÔNG TIN CÁ NHÂN",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: fullnameController,
              cursorColor: Colors.amber,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_2_outlined),
                border: OutlineInputBorder(),
                hintText: 'Họ và tên',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: addressController,
              cursorColor: Colors.amber,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_city),
                border: OutlineInputBorder(),
                hintText: 'Địa chỉ',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: phoneController,
              cursorColor: Colors.amber,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
                hintText: 'Số điện thoại',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailController,
              cursorColor: Colors.amber,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                onPressed: _updateUser,
                color: Colors.amber,
                child: const Text(
                  'Cập nhật thông tin',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
