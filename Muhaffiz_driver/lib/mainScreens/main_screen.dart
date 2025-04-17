import 'package:flutter/material.dart';
import 'package:muhaffiz_driver/tabPages/earning_tab.dart';
import 'package:muhaffiz_driver/tabPages/home_tab.dart';
import 'package:muhaffiz_driver/tabPages/profile_tab.dart';
import 'package:muhaffiz_driver/tabPages/ratings_tab.dart';
import 'package:muhaffiz_driver/tabPages/schedule_tab.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{
  TabController? tabController;
  int selectedIndex = 0;
  onItemClicked(int index)
  {
    setState(() {
      selectedIndex=index;
      tabController!.index=selectedIndex;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController=TabController(length: 4, vsync: this);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children:const [
          HomeTabPage(),
          EarningsTabPage(),
          RatingsTabPage(),
          ProfileTabPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: "Earnings",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Ratings",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
          ),

        ],
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.blue,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemClicked,
      ),
      );
  }
}
