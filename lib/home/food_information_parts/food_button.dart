import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../const/color.dart';

class FoodButton extends StatefulWidget {
  const FoodButton({super.key});

  @override
  State<FoodButton> createState() => _FoodButtonState();
}

class _FoodButtonState extends State<FoodButton> {

  void _launchURL(String url) async {
    final urlToUri = Uri.parse(url);
    if (await canLaunchUrl(urlToUri)) {
      launchUrl(urlToUri);
    } else {
      print("fail load url");
    }
  }

  void _showDeliveryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '배달 주문하기',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffD9D9D9),),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: Image.asset("assets/image/baemin_logo.png",
                              width: 70,
                              fit: BoxFit.fill,),
                            onPressed: () {
                              _launchURL('https://www.baemin.com');
                            },
                          ),
                          Text("배달의 민족",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Image.asset("assets/image/yogiyo_logo.png",
                              width: 70,
                              fit: BoxFit.fill,),
                            onPressed: () {
                              _launchURL('https://www.yogiyo.co.kr');
                            },
                          ),
                          Text("요기요",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Image.asset("assets/image/coupang_logo.png",
                              width: 70,
                              fit: BoxFit.fill,),
                            onPressed: () {
                              _launchURL('https://www.coupang.com');
                            },
                          ),
                          Text("쿠팡 이츠",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPickupBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: EdgeInsets.all(23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '지도 보러가기',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffD9D9D9),),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: Image.asset("assets/image/Naver_logo.png",
                              width: 70,
                              fit: BoxFit.fill,),
                            onPressed: () {
                              _launchURL('https://map.naver.com');
                            },
                          ),
                          Text("네이버지도",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Image.asset("assets/image/Kakao_logo.png",
                              width: 70,
                              fit: BoxFit.fill,),
                            onPressed: () {
                              _launchURL('https://map.kakao.com');
                            },
                          ),
                          Text("카카오지도",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => _showPickupBottomSheet(context),
            child: Text(
              "지도 보러가기",
              style: TextStyle(
                color: picketColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(width: 15), // 버튼 사이 간격
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: picketColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => _showDeliveryBottomSheet(context),
            child: Text(
              "배달 주문하기",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
