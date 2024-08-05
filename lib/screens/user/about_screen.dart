import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webvinfast/widgets/bottom_web.dart';
import 'package:webvinfast/widgets/videos.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(198, 228, 228, 228),
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width / 2,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 120),
                        child: Videos(),
                      )),
                  const Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Giới thiệu về',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text('Công ty VinFast',
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 750,
                        child: Text(
                            'VinFast là công ty thành viên thuộc tập đoàn Vingroup, một trong những Tập đoàn Kinh tế tư nhân đa ngành lớn nhất Châu Á.',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400)),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 750,
                        child: Text(
                            "Với triết lý “Đặt khách hàng làm trọng tâm”, VinFast không ngừng sáng tạo để tạo ra các sản phẩm đẳng cấp và trải nghiệm xuất sắc cho mọi người.",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400)),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 750,
                        child: Text(
                            "VINFAST BẮC TỪ LIÊM: Cạnh trường đại học Mỏ Địa Chất, Hà Nội, 234 Phạm Văn Đồng, Cổ Nhuế, Bắc Từ Liêm, Hà Nội. Thời gian hoạt động: Thứ 2 - Thứ 6: 8h - 19h Thứ 7 - Chủ nhật: 8h - 17h",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400)),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(198, 228, 228, 228),
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Dấu Chân toàn cầu',
                        style: TextStyle(fontSize: 48)),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      width: 1200,
                      child: Text(
                          'VinFast đã nhanh chóng thiết lập sự hiện diện toàn cầu, thu hút những tài năng tốt nhất từ khắp nơi trên thế giới và hợp tác với một số thương hiệu mang tính biểu tượng nhất trong ngành Ô tô.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/about1.webp',
                          width: 800,
                        ),
                        Image.asset(
                          'assets/images/about2.webp',
                          width: 800,
                        )
                      ],
                    )
                  ],
                )),
          ),
          const BottomWeb()
        ],
      ),
    );
  }
}
