import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webvinfast/screens/admin/login_screen.dart';
import 'package:webvinfast/screens/admin/management/dashboard.dart';
import 'package:webvinfast/screens/admin/management/management_consulting.dart';
import 'package:webvinfast/screens/admin/management/management_product.dart';
import 'package:webvinfast/screens/admin/management/management_repair.dart';
import 'package:webvinfast/screens/admin/management/management_sale_voucher.dart';
import 'package:webvinfast/screens/admin/management/management_test_car.dart';

class HomeManagement extends StatefulWidget {
  const HomeManagement({super.key});

  @override
  State<HomeManagement> createState() => _HomeManagementState();
}

class _HomeManagementState extends State<HomeManagement> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              backgroundColor: const Color.fromARGB(181, 240, 240, 240),
              // showTooltip: false,
              displayMode: SideMenuDisplayMode.auto,
              showHamburger: false,
              hoverColor: const Color.fromARGB(70, 0, 70, 127),
              // selectedHoverColor: Colors.blue[100],
              selectedColor: const Color.fromARGB(142, 70, 75, 215),
              selectedTitleTextStyle: const TextStyle(color: Colors.black),
              selectedIconColor: Colors.white,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              // ),
              // backgroundColor: Colors.grey[200]
            ),
            title: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 150,
                    maxWidth: 150,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: SvgPicture.asset(
                      'assets/svgs/logo.svg',
                      width: 300,
                    ),
                  ),
                ),
                const Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: Text(
                    '© Copyright by VinFast',
                    style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  ),
                ),
              ),
            ),
            items: [
              SideMenuItem(
                title: 'Thống kê',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.home),
                badgeContent: const Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              // SideMenuItem(
              //   title: 'Users',
              //   onTap: (index, _) {
              //     sideMenu.changePage(index);
              //   },
              //   icon: const Icon(Icons.supervisor_account),
              // ),
              SideMenuExpansionItem(
                title: "Quản lý",
                icon: const Icon(Icons.kitchen),
                children: [
                  SideMenuItem(
                    title: 'Đăng kí lái thử',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                    },
                    icon: const Icon(Icons.home),
                    badgeContent: const Text(
                      '3',
                      style: TextStyle(color: Colors.white),
                    ),
                    tooltipContent: "Expansion Item 1",
                  ),
                  SideMenuItem(
                    title: 'Tư vấn',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                    },
                    icon: const Icon(Icons.supervisor_account),
                  ),
                  SideMenuItem(
                    title: 'Nhận ưu đãi',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                    },
                    icon: const Icon(Icons.supervisor_account),
                  ),
                ],
              ),
              SideMenuItem(
                  title: 'Mẫu xe',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.supervisor_account),
                  trailing: Container(
                      decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 3),
                        child: Text(
                          'Mới',
                          style:
                              TextStyle(fontSize: 11, color: Colors.grey[800]),
                        ),
                      ))),
              SideMenuItem(
                title: 'Bảo hành & Sửa chữa',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.supervisor_account),
              ),

              SideMenuItem(
                builder: (context, displayMode) {
                  return const Divider(
                    endIndent: 8,
                    indent: 8,
                  );
                },
              ),
              SideMenuItem(
                title: 'Cài đặt',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.settings),
              ),
              // SideMenuItem(
              //   onTap:(index, _){
              //     sideMenu.changePage(index);
              //   },
              //   icon: const Icon(Icons.image_rounded),
              // ),
              // SideMenuItem(
              //   title: 'Only Title',
              //   onTap:(index, _){
              //     sideMenu.changePage(index);
              //   },
              // ),
              SideMenuItem(
                onTap: (index, _) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                title: 'Đăng xuất',
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          const VerticalDivider(
            width: 0,
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                const DashBoard(),
                const ManagementTestCar(),
                const ManagementConsulting(),
                const ManagementSaleVoucher(),
                const ManagementProduct(),
                const ManagementRepair(),

                // this is for SideMenuItem with builder (divider)
                const SizedBox.shrink(),

                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 35),
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
