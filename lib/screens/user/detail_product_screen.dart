import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:webvinfast/api/api_service.dart';
import 'package:webvinfast/models/product_model.dart';
import 'package:webvinfast/providers/main_provider.dart';
import 'package:webvinfast/screens/admin/login_screen.dart';
import 'package:webvinfast/screens/user/about_screen.dart';
import 'package:webvinfast/screens/user/home.dart';
import 'package:webvinfast/screens/user/home_screen.dart';
import 'package:webvinfast/screens/user/policy_screen.dart';
import 'package:webvinfast/screens/user/product_screen.dart';
import 'package:webvinfast/widgets/bottom_web.dart';

class DetailProductScreen extends StatefulWidget {
  final int id;
  const DetailProductScreen({super.key, required this.id});
  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  int _selectedIndexPage = 0;
  void _onItemTappedPage(int index) {
    setState(() {
      _selectedIndexPage = index;
    });
  }

  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  String formatNumberWithCommas(int number) {
    final numberFormat = NumberFormat('#,##0');
    return numberFormat.format(number);
  }

  late Future<Product> _productsFuture;
  @override
  void initState() {
    super.initState();
    _productsFuture = Provider.of<MainViewModel>(context, listen: false)
        .fetchProductById(widget.id);
  }

  void showConsultationDialog(BuildContext context, String nameProduct) {
    final formKey = GlobalKey<FormState>(); // Khai báo biến _formKey
    final TextEditingController carModelController = TextEditingController();
    String name = '';
    String email = '';
    String phone = '';
    String carModel = nameProduct;
    String content = '';
    print(nameProduct);
    carModelController.text = nameProduct;

    Notification;
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
                  'Nhận tư vấn ngay',
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
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Loại xe',
                          border: OutlineInputBorder(),
                        ),
                        controller: carModelController,
                        textInputAction:
                            TextInputAction.done, // Thay đổi khi nhấn tab
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
                        content: Text('Nhận tư vấn thành công!'),
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
                  'Nhận tư vấn',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  final List<Widget> pages = [
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
    List<String> carModels = ['VF3', 'VF5', 'VF6'];

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

  final List<String> images = [
    'assets/images/noithat1.jpg',
    'assets/images/noithat2.jpg',
    'assets/images/noithat3.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            final product = snapshot.data!;

            return Scaffold(
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('BAC TU LIEM',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18))
                        ],
                      ),
                      SizedBox(
                        width: 500,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()),
                                  );
                                },
                                child: const Text('Trang chủ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18))),
                            // InkWell(
                            //     onTap: () {
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => const Home()),
                            //       );
                            //     },
                            //     child: const Text('Mẫu xe',
                            //         style: TextStyle(
                            //             fontWeight: FontWeight.bold, fontSize: 18))),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()),
                                  );
                                },
                                child: const Text('Chính sách - Sửa chữa',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18))),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()),
                                  );
                                },
                                child: const Text('Giới thiệu',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18))),
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
                                backgroundColor:
                                    const Color.fromARGB(255, 70, 75, 215),
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
                                      builder: (context) =>
                                          const LoginScreen()),
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
              body: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 100, right: 100),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          children: [
                            Text(
                                'Thông số chi tiết xe > ${product.name.toString()}',
                                style: const TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Container(
                          padding: const EdgeInsets.only(top: 50),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(198, 228, 228, 228),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                          width: MediaQuery.of(context).size.width - 100,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      100,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50, bottom: 50),
                                        child: Image.asset(
                                          product.image.toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      100,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Thông số xe: ${product.name.toString()}",
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(50),
                                            child: Column(
                                              children: [
                                                Container(
                                                    width: 150,
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          color: Color.fromARGB(
                                                              255,
                                                              70,
                                                              75,
                                                              215), // Màu xanh dương
                                                          width:
                                                              4.0, // Độ dày 2px
                                                        ),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15,
                                                              bottom: 15),
                                                      child: const Text(
                                                          'Tên xe',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      70,
                                                                      75,
                                                                      215))),
                                                    )),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15, bottom: 15),
                                                  child: Text(
                                                      product.name.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(50),
                                            child: Column(
                                              children: [
                                                Container(
                                                    width: 150,
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          color: Color.fromARGB(
                                                              255,
                                                              70,
                                                              75,
                                                              215), // Màu xanh dương
                                                          width:
                                                              4.0, // Độ dày 2px
                                                        ),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15,
                                                              bottom: 15),
                                                      child: const Text(
                                                          'Số ghế',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      70,
                                                                      75,
                                                                      215))),
                                                    )),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15, bottom: 15),
                                                  child: Text(
                                                      product.numberOfSeats
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(50),
                                            child: Column(
                                              children: [
                                                Container(
                                                    width: 150,
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          color: Color.fromARGB(
                                                              255,
                                                              70,
                                                              75,
                                                              215), // Màu xanh dương
                                                          width:
                                                              4.0, // Độ dày 2px
                                                        ),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15,
                                                              bottom: 15),
                                                      child: const Text(
                                                          'Giá từ',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      70,
                                                                      75,
                                                                      215))),
                                                    )),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15, bottom: 15),
                                                  child: Text(
                                                      formatNumberWithCommas(
                                                              product.price)
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 50,
                                                right: 50,
                                                bottom: 50),
                                            child: Column(
                                              children: [
                                                Container(
                                                    width: 150,
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          color: Color.fromARGB(
                                                              255,
                                                              70,
                                                              75,
                                                              215), // Màu xanh dương
                                                          width:
                                                              4.0, // Độ dày 2px
                                                        ),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15,
                                                              bottom: 15),
                                                      child: const Text(
                                                          'Kích thước(dài, rộng, cao)',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      70,
                                                                      75,
                                                                      215))),
                                                    )),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15, bottom: 15),
                                                  child: Text(
                                                      '${product.width.toString()} x ${product.length.toString()} x ${product.height.toString()}',
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 50,
                                                right: 50,
                                                bottom: 50),
                                            child: Column(
                                              children: [
                                                Container(
                                                    width: 150,
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          color: Color.fromARGB(
                                                              255,
                                                              70,
                                                              75,
                                                              215), // Màu xanh dương
                                                          width:
                                                              4.0, // Độ dày 2px
                                                        ),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15,
                                                              bottom: 15),
                                                      child: const Text(
                                                          'Quãng đường di chuyển',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      70,
                                                                      75,
                                                                      215))),
                                                    )),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15, bottom: 15),
                                                  child: Text(
                                                      '${product.line.toString()}km/lần sạc',
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 50,
                                                right: 50,
                                                bottom: 50),
                                            child: Column(
                                              children: [
                                                Container(
                                                    width: 150,
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          color: Color.fromARGB(
                                                              255,
                                                              70,
                                                              75,
                                                              215), // Màu xanh dương
                                                          width:
                                                              4.0, // Độ dày 2px
                                                        ),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15,
                                                              bottom: 15),
                                                      child: const Text(
                                                          'Kích thước la-zăng',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      70,
                                                                      75,
                                                                      215))),
                                                    )),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15, bottom: 15),
                                                  child: Text(
                                                      '${product.typeLaZang.toString()} inch',
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 100),
                                            child: ElevatedButton(
                                              onPressed: () =>
                                                  showConsultationDialog(
                                                      context,
                                                      product.name.toString()),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 70, 75, 215),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(1),
                                                ),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(15.0),
                                                child: Text(
                                                  'Tư vấn ngay',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(198, 228, 228, 228),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                          width: MediaQuery.of(context).size.width - 100,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Text('NỘI THẤT XE',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print(selectedIndex);
                                        if (selectedIndex > 0) {
                                          onItemTapped(selectedIndex - 1);
                                        } else {
                                          onItemTapped(images.length - 1);
                                        }
                                      },
                                      child: SvgPicture.asset(
                                        'assets/svgs/left.svg',
                                        width: 32,
                                        height: 52,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Image.asset(
                                        images[selectedIndex],
                                        width:
                                            MediaQuery.of(context).size.width -
                                                500,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (selectedIndex < images.length - 1) {
                                          onItemTapped(selectedIndex + 1);
                                        } else {
                                          onItemTapped(0);
                                        }
                                      },
                                      child: SvgPicture.asset(
                                        'assets/svgs/right.svg',
                                        width: 32,
                                        height: 52,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                          Text('Liên hệ hỗ trợ: Vũ Khải - 0395031862'),
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
            );
          }
        });
  }
}
