import 'package:apollo/entity/userModel.dart';
import 'package:apollo/main.dart';
import 'package:apollo/services/authService.dart';
import 'package:apollo/views/main_screen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService authService = AuthService();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> _login() async {
    bool success = await authService.login(
        usernameController.text, passwordController.text);
    if (success) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyApp()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Đăng nhập thất bại!"),
        backgroundColor: Colors.amber.withOpacity(0.8),
      ));
    }
  }

  Future<void> _register() async {
    UserModel user = new UserModel();
    user.username = usernameController.text;
    user.fullName = fullnameController.text;
    user.email = emailController.text;
    user.phone = phoneController.text;
    user.address = addressController.text;
    bool success = await authService.register(user, passwordController.text);
    if (success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng ký thành công!')),
      );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng ký thất bại!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/logo.png"),
              const SizedBox(height: 20),
              const SizedBox(height: 40),
              TextField(
                controller: usernameController,
                cursorColor: Colors.amber,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  hintText: 'Tên đăng nhập',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                cursorColor: Colors.amber,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                  hintText: 'Mật khẩu',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     GestureDetector(
              //       onTap: () {},
              //       child: const Text(
              //         'Quên mật khẩu?',
              //         style: TextStyle(color: Colors.amber),
              //       ),
              //     )
              //   ],
              // ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: _login,
                  color: Colors.amber,
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Chưa có tài khoản? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return FractionallySizedBox(
                              heightFactor: 0.8, child: modalBottomItem());
                        },
                      );
                    },
                    child: const Text(
                      'Đăng ký tại đây',
                      style: TextStyle(color: Colors.amber),
                    ),
                  )
                ],
              ),
            ],
          ),
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
              "ĐĂNG KÝ TÀI KHOẢN",
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
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: usernameController,
              cursorColor: Colors.amber,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                hintText: 'Tên đăng nhập',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              cursorColor: Colors.amber,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                hintText: 'Mật khẩu',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                onPressed: _register,
                color: Colors.amber,
                child: const Text(
                  'Đăng ký tài khoản',
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
