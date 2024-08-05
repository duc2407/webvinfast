import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:webvinfast/providers/main_provider.dart';
import 'package:webvinfast/screens/admin/home_management.dart';
import 'package:webvinfast/screens/user/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Vui lòng điền đầy đủ thông tin');
      return;
    }

    try {
      final response = await Provider.of<MainViewModel>(context, listen: false)
          .login(email, password);

      if (response.statusCode == 200) {
        // Kiểm tra dữ liệu trả về từ API
        final responseData = response.data;
        if (responseData['errCode'] == 0) {
          // Đăng nhập thành công
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeManagement()),
          );
        } else {
          _showErrorDialog(responseData['message']);
        }
      } else {
        _showErrorDialog(
            'Đăng nhập không thành công với mã trạng thái: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog('Lỗi: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => SizedBox(
        width: 400,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 5,
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Lỗi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Màu nền của nút
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Đóng',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Container(
                color: const Color.fromARGB(181, 240, 240, 240),
                width: 500,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 200),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        },
                        child: SvgPicture.asset(
                          "assets/svgs/logo.svg",
                          height: 70,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Đăng nhập cho quản lý',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 70, 75, 215),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      textInputAction: TextInputAction
                          .next, // Chuyển đến trường tiếp theo khi nhấn Tab
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          // onTap: () {
                          //   showDialog(
                          //     context: context,
                          //     builder: (context) =>
                          //         const DialogForgotPassword(),
                          //   );
                          // },
                          child: Text(
                            'Quên mật khẩu ?',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 70, 75, 215),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(55),
                        backgroundColor: const Color.fromARGB(255, 70, 75, 215),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Đăng nhập',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      '© Copyright by VinFast',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
