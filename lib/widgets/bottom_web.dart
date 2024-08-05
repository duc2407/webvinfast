import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomWeb extends StatelessWidget {
  const BottomWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(198, 228, 228, 228),
            borderRadius: BorderRadius.circular(12)),
        width: MediaQuery.of(context).size.width - 40,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width / 3 - 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/logoend.png', width: 300),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      'CÔNG TY TNHH KINH DOANH THƯƠNG MẠI VÀ DỊCH VỤ VINFAST',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      children: [
                        Text(
                          'MST/MSDN: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                        Text(
                          '0108926276 do Sở KHĐT TP Hà Nội cấp ngày 01/10/2019.',
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      children: [
                        Text(
                          'Địa chỉ trụ sở chính:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                        Text(
                          ' Số 7, Đường Bằng Lăng 1,Việt Hưng, Quận Long Biên,HN',
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width / 3 - 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'HOTLINE',
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 45),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svgs/phone.svg'),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          '1900 23 23 89',
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svgs/email.svg'),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'support.vn@vinfastauto.com',
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width / 3 - 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/logoend.png', width: 300),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        '- BẮC TỪ LIÊM',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      'CHI NHÁNH BẮC TỪ LIÊM VINFAST',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      children: [
                        Text(
                          'Địa chỉ: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                        Text(
                          'Cổng trường ĐH Mở Địa Chất',
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      children: [
                        Text(
                          'Địa chỉ trụ sở chính:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                        Text(
                          ' Số 7, Đường Bằng Lăng 1,Việt Hưng, Quận Long Biên,HN',
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Bằng cách đăng ký, Quý khách xác nhận đã đọc, hiểu và đồng ý với Chính sách quyền riêng tư của VinFas