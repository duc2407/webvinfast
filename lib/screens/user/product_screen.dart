import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<String> texts = [
    'VF3',
    'VF5',
    'VF6',
    'VF7',
    'VF8',
    'VF9',
    'VF34',
  ];
  final List<String> images = [
    'assets/images/vf3.webp',
    'assets/images/vf5.webp',
    'assets/images/vf6.webp',
    'assets/images/vf7.webp',
    'assets/images/vf8.webp',
    'assets/images/vf9.webp',
    'assets/images/vf34.webp',
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 1000,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Căn giữa theo chiều dọc
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text('DANH SÁCH Ô TÔ ĐANG BÁN',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 400, right: 400),
                  height: 80, // Chiều cao của danh sách ngang
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: texts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Center(
                          child: InkWell(
                            onTap: () => {
                              onItemTapped(index),
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(texts[index],
                                  style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                    color: selectedIndex == index
                                        ? const Color.fromARGB(255, 70, 75, 215)
                                        : Colors.grey,
                                  )),
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
                            print(selectedIndex);
                            if (selectedIndex > 0) {
                              onItemTapped(selectedIndex - 1);
                            } else {
                              onItemTapped(texts.length - 1);
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
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Image.asset(
                            images[selectedIndex],
                            width: 900,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (selectedIndex < texts.length - 1) {
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
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Dòng xe',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text('MiniCar',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 70, 75, 215)))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Số ghế ngồi',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                    Text('4 Chỗ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 70, 75, 215)))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Quãng đường lên tới',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                    Text('~ 210 km(NEDC)',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 70, 75, 215)))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Giá từ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                    Text('123.123.123 VND',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 70, 75, 215)))
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 70, 75, 215),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 45, right: 45),
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
                                  onPressed: () {},
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
        ],
      ),
    );
  }
}
