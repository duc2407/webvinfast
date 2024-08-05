import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:webvinfast/api/api_service.dart';
import 'package:webvinfast/screens/admin/login_screen.dart';
import 'package:webvinfast/screens/user/about_screen.dart';
import 'package:webvinfast/screens/user/home_screen.dart';
import 'package:webvinfast/screens/user/policy_screen.dart';
import 'package:webvinfast/screens/user/product_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndexPage = 0;
  void _onItemTappedPage(int index) {
    setState(() {
      _selectedIndexPage = index;
    });
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const ProductScreen(),
    const PolicyScreen(),
    const AboutScreen(),
  ];
  void _showTestDriveDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>(); // Khai báo biến _formKey

    String name = '';
    String email = '';
    String phone = '';
    String carModel = '';
    String content = '';
    List<String> carModels = [
      'VF3',
      'VF34',
      'VF5',
      'VF6',
      'VF7',
      'VF8',
      'VF9',
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 240, 240, 240),
          title: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Đăng Ký Lái Thử',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Vui lòng nhập đầy đủ thông tin.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          content: SizedBox(
            height: 280,
            width: 500,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Tên',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) => name = value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tên không được để trống';
                                }
                                return null;
                              },
                              textInputAction:
                                  TextInputAction.next, // Thay đổi khi nhấn tab
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Số Điện Thoại',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) => phone = value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Số điện thoại không được để trống';
                                }
                                return null;
                              },
                              textInputAction:
                                  TextInputAction.next, // Thay đổi khi nhấn tab
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => email = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email không được để trống';
                          }
                          return null;
                        },
                        textInputAction:
                            TextInputAction.next, // Thay đổi khi nhấn tab
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Loại Xe',
                          border: OutlineInputBorder(),
                        ),
                        items: carModels.map((String model) {
                          return DropdownMenuItem<String>(
                            value: model,
                            child: Text(model),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          carModel = newValue!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng chọn loại xe';
                          }
                          return null;
                        },
                        // Không hỗ trợ TextInputAction, vì không phải TextFormField
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Nội Dung',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => content = value,
                        textInputAction:
                            TextInputAction.done, // Thay đổi khi nhấn tab
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Hủy',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    // Xây dựng dữ liệu dưới dạng Map<String, dynamic>
                    final data = {
                      'name': name,
                      'number_phone': phone,
                      'email': email,
                      'name_car': carModel,
                      'note': content,
                      'type': 1 // Sửa lại nếu cần
                    };

                    // Gọi hàm newTestCar từ ApiService
                    final response =
                        await Provider.of<ApiService>(context, listen: false)
                            .newTestCar(data);

                    // Nếu thành công, hiển thị thông báo thành công
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Đăng ký thành công!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context).pop(); // Đóng dialog
                  } catch (e) {
                    // Hiển thị thông báo lỗi
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Lỗi: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 70, 75, 215),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Đăng kí',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          color: const Color.fromARGB(198, 228, 228, 228),
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svgs/logo.svg',
                    color: Colors.black,
                    height: 40,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('-',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('BAC TU LIEM',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                ],
              ),
              SizedBox(
                width: 500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () => _onItemTappedPage(0),
                        child: Text('Trang chủ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: _selectedIndexPage == 0
                                    ? const Color.fromARGB(255, 70, 75, 215)
                                    : Colors.black))),
                    // InkWell(
                    //     onTap: () => _onItemTappedPage(1),
                    //     child: Text('Mẫu xe',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 18,
                    //             color: _selectedIndexPage == 1
                    //                 ? const Color.fromARGB(255, 70, 75, 215)
                    //                 : Colors.black))),
                    InkWell(
                        onTap: () => _onItemTappedPage(2),
                        child: Text('Chính sách - Sửa chữa',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: _selectedIndexPage == 2
                                    ? const Color.fromARGB(255, 70, 75, 215)
                                    : Colors.black))),
                    InkWell(
                        onTap: () => _onItemTappedPage(3),
                        child: Text('Giới thiệu',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: _selectedIndexPage == 3
                                    ? const Color.fromARGB(255, 70, 75, 215)
                                    : Colors.black))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _showTestDriveDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 70, 75, 215),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Đăng kí lái thử',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/svgs/user.svg',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndexPage,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        height: 80,
        color: const Color.fromARGB(198, 228, 228, 228),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Liên hệ hỗ trợ: Vũ Khải - 0983057006'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svgs/logo.svg',
                    color: Colors.black,
                    height: 40,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Text('BAC TU LIEM',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12)),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('© Copyright by VinFast'),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
