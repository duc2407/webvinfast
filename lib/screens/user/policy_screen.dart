import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webvinfast/api/api_service.dart';
import 'package:webvinfast/widgets/bottom_web.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});
  void showConsultationDialog(BuildContext context) {
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
                  'Đặt lịch hẹn sửa chữa - bảo hành',
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
                          labelText: 'Loại xe cần bảo dưỡng sửa chữa',
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
                          labelText: 'Vui lòng nhập ngày, giờ hẹn',
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
                      'type': 2 // Sửa lại nếu cần
                    };

                    // Gọi hàm newTestCar từ ApiService
                    final response =
                        await Provider.of<ApiService>(context, listen: false)
                            .newTestCar(data);

                    // Nếu thành công, hiển thị thông báo thành công
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Đặt lịch thành công! Chúng tôi sẽ liên hệ trong 5 đến 10 phút'),
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
                  'Đặt lịch hẹn',
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
    return SingleChildScrollView(
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(198, 228, 228, 228),
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 20),
                            child: Column(
                              children: [
                                const Text(
                                  'CHÍNH SÁCH - BẢO HÀNH - SỬA CHỮA',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, bottom: 5),
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        showConsultationDialog(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 70, 75, 215),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(1),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 45, right: 45),
                                        child: Text(
                                          'Đặt lịch sửa chữa',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Hotline: 033.333.9999',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                                const Text(
                                  'Địa chỉ: Cổng đại học mỏ địa chất Hà Nội, Bắc Từ Liêm.',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: Image.asset('assets/images/baohanh.webp'),
                          )
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(198, 228, 228, 228),
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: Image.asset(
                                      'assets/images/baohanhoto.webp'),
                                ),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 20.0),
                                  child: const Text('Thời hạn bảo hành ô tô',
                                      style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 20.0),
                                  child: const Text(
                                      '- Thời hạn bảo hành 10 năm hoặc 200.000 km tùy điều kiện nào đến trước: Fadil, Lux A 2.0, Lux SA 2.0, President, VF e34, VF 7, VF 8, VF 9'),
                                ),
                                const SizedBox(
                                  width: 600,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, top: 20.0, bottom: 40),
                                    child: Text(
                                        '- Thời hạn bảo hành 7 năm hoặc 160.000 km tùy điều kiện nào đến trước: VF 5, VF 6.'),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 20, top: 40.0),
                                  child: Text('Thời hạn bảo hành xe máy điện',
                                      style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 20.0),
                                  child: const Text(
                                      '- Thời hạn bảo hành 5 năm (không giới hạn km) đối với các dòng xe máy điện VinFast sử dụng pin LFP và thời hạn bảo hành 3 năm (không giới hạn km) cho các dòng xe còn lại.'),
                                ),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 20.0),
                                  child: const Text(
                                      '- Quý khách hàng vui lòng tham khảo tại Sổ bảo hành để biết thêm các thông tin bảo hành chi tiết.'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: Image.asset(
                                      'assets/images/baohanhmay.webp'),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(198, 228, 228, 228),
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 40,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Image.asset('assets/images/phamvibaohanh.jpg'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 40,
                            child: Column(
                              children: [
                                const Text('Phạm vi bảo hành',
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.only(top: 20),
                                  child: const Text(
                                      'Bảo hành áp dụng cho các hư hỏng do lỗi phần mềm, lỗi chất lượng của linh kiện hoặc lỗi lắp ráp của VinFast với điều kiện sản phẩm được sử dụng và bảo dưỡng đúng cách, ngoại trừ các hạng mục không thuộc phạm vi bảo hành.'),
                                ),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.only(top: 20),
                                  child: const Text(
                                      'Phụ tùng thay thế trong bảo hành là những chi tiết, linh kiện chính hãng nhỏ nhất được VinFast cung cấp.'),
                                ),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.only(top: 20),
                                  child: const Text(
                                      'Bảo hành có hiệu lực trên toàn lãnh thổ Việt Nam, chỉ được áp dụng và thực hiện tại các Xưởng dịch vụ và Nhà phân phối ủy quyền của VinFast. '),
                                ),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.only(top: 20),
                                  child: const Text(
                                      'Công việc bảo hành được thực hiện miễn phí theo các điều khoản và điều kiện bảo hành. '),
                                ),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.only(top: 20),
                                  child: const Text(
                                      'VinFast không có trách nhiệm thu hồi và thay thế sản phẩm khác cho khách hàng nếu việc sửa chữa bảo hành có thể khắc phục được lỗi chất lượng, lỗi vật liệu hay lỗi lắp ráp của nhà sản xuất.'),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(198, 228, 228, 228),
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    child: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 40,
                            child: Column(
                              children: [
                                const Text('Bảo hành phụ tùng',
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.only(top: 20),
                                  child: const Text(
                                      'Phụ tùng thay thế cho xe của khách hàng trong quá trình sửa chữa tại XDV/NPP của VinFast do khách hàng chịu chi phí, sẽ có thời hạn bảo hành như sau:'),
                                ),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.only(top: 20),
                                  child: const Text(
                                      'Ô tô xăng: bao gồm Fadil, Lux A, Lux SA, President: 12 tháng hoặc 20.000 km tùy thuộc điều kiện nào đến trước từ ngày hoàn thành sửa chữa.'),
                                ),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.only(top: 20),
                                  child: const Text(
                                      'Xe máy điện: 1 năm từ ngày mua phụ tùng (không giới hạn quãng đường sử dụng) '),
                                ),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.only(top: 20),
                                  child: const Text(
                                      'Phụ tùng mua nhưng không được thay thế tại XDV/ NPP của VinFast sẽ không được bảo hành theo chính sách.'),
                                ),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.only(top: 20),
                                  child: const Text(
                                      'Để nhận được chế độ bảo hành phụ tùng, khách hàng có trách nhiệm lưu trữ hồ sơ (lệnh sửa chữa, hóa đơn, v.v.) cho những lần thay thế phụ tùng.'),
                                )
                              ],
                            )),
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width / 2 - 40,
                          child: Column(
                            children: [
                              Image.asset('assets/images/baohanhphutung.jpg'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const BottomWeb()
              ],
            )));
  }
}
