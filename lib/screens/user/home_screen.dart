import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:webvinfast/api/api_service.dart';
import 'package:webvinfast/models/product_model.dart';
import 'package:webvinfast/providers/main_provider.dart';
import 'package:webvinfast/screens/user/detail_product_screen.dart';
import 'package:webvinfast/screens/user/policy_screen.dart';
import 'package:webvinfast/widgets/bottom_web.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  late Future<List<Product>> _productsFuture;
  // int selectedIndex = 0; // Thêm state để lưu trạng thái được chọn
  String formatNumberWithCommas(int number) {
    final numberFormat = NumberFormat('#,##0');
    return numberFormat.format(number);
  }

  @override
  void initState() {
    super.initState();
    _productsFuture =
        Provider.of<MainViewModel>(context, listen: false).getAllProducts();
  }

  void showConsultationDialog(BuildContext context) {
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
                  'Nhận tư vấn',
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
                          labelText: 'Loại Xe Cần Tư Vấn',
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

  void _showSaleVoucherDriveDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>(); // Khai báo biến _formKey

    String name = '';
    String phone = '';

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
                  'Đăng Ký nhận ưu đãi',
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
            height: 80,
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
                      'email': '',
                      'name_car': 'uu dai',
                      'note': 'nhan uu dai',
                      'type': 3 // Sửa lại nếu cần
                    };

                    // Gọi hàm newTestCar từ ApiService
                    final response =
                        await Provider.of<ApiService>(context, listen: false)
                            .newTestCar(data);

                    // Nếu thành công, hiển thị thông báo thành công
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Đăng kí nhận ưu đãi thành công!'),
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
                  'Nhận ưu đãi',
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
    return FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          final products = snapshot.data!;
          return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/homepage.jpg'), // Đường dẫn tới hình ảnh của bạn
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(children: [
                        Container(
                            padding: const EdgeInsets.only(top: 650),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height - 160,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () =>
                                      showConsultationDialog(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 70, 75, 215),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      'Nhận tư vấn',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      _showSaleVoucherDriveDialog(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 70, 75, 215),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      'Nhận ưu đãi',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ])),
                  SizedBox(
                    height: 800,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Căn giữa theo chiều dọc
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 30, bottom: 20),
                          child: Text('DANH SÁCH Ô TÔ ĐANG BÁN',
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic
                                  // decoration: TextDecoration.underline,
                                  )),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 400, right: 400),
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Center(
                                  child: InkWell(
                                    onTap: () => onItemTapped(index),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        products[index].name,
                                        style: TextStyle(
                                          fontSize: 45,
                                          fontWeight: FontWeight.bold,
                                          color: selectedIndex == index
                                              ? const Color.fromARGB(
                                                  255, 70, 75, 215)
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (selectedIndex > 0) {
                                      onItemTapped(selectedIndex - 1);
                                    } else {
                                      onItemTapped(products.length - 1);
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
                                    products[selectedIndex].image,
                                    width: 900,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (selectedIndex < products.length - 1) {
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 350, right: 350),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.grey, // Màu của border
                                  width: 1.0, // Độ dày của border
                                ),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 80,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            const Text(
                                              'Dòng xe',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                                products[selectedIndex]
                                                    .type
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 70, 75, 215)))
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Text('Số ghế ngồi',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                            Text(
                                                "${products[selectedIndex].numberOfSeats.toString()} Chỗ",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 70, 75, 215)))
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Text('Quãng đường lên tới',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                            Text(
                                                "${products[selectedIndex].line.toString()} KM(ENDC)",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 70, 75, 215)))
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Text('Giá từ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                            Text(
                                              "${formatNumberWithCommas(products[selectedIndex].price).toString()} VND",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 70, 75, 215),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () => (context),
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
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 45, right: 45),
                                              child: Text(
                                                'Nhận tư vấn ngay',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            print(products[selectedIndex].id);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailProductScreen(
                                                          id: products[
                                                                  selectedIndex]
                                                              .id),
                                                ));
                                          },
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
                                              'Thông số chi tiết',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(198, 228, 228, 228),
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 100, left: 350),
                            child: Column(
                              children: [
                                const Text('Bảo hành & Dịch vụ',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 70, 75, 215),
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  width: 400,
                                  child: const Text(
                                    'VinFast đã đầu tư nghiêm túc và bài bản để phát triển hệ thống Showroom, Nhà phân phối và xưởng dịch vụ rộng khắp, đáp ứng tối đa nhu cầu của Khách hàng.',
                                    maxLines: 4,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 220),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Navigator.pushReplacement(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           const PolicyScreen()),
                                      // );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 70, 75, 215),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(1),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Text(
                                        'Chính sách',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/bg_vf88.webp',
                                height: 400,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // CUT

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 500,
                                    height: 300,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/pin.jpg'), // Đường dẫn tới hình ảnh của bạn
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: const Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Sạc ô tô di động',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight
                                                .bold, // Optional background color for text
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    width: 500,
                                    height: 300,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/pin2.webp'), // Đường dẫn tới hình ảnh của bạn
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: const Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Sạc xe máy điện công cộng',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Container(
                                width: 500,
                                height: 640,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/sac3.webp'), // Đường dẫn tới hình ảnh của bạn
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: const Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Thiết bị sạc di động',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                  const BottomWeb()
                ],
              )));
        });
  }
}
