import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pickeat/const/color.dart';
import 'package:pickeat/function/user_activity.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  final List<String> locations = [
    '서울시 강남구',
    '서울시 관악구',
    '서울시 서대문구',
  ];

  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Choose Location",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 42,
                          ),
                        ),
                        Text(
                          "음식을 주문할 지역을 선택하세요",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: locations.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Icon(
                                Icons.location_on,
                                color: Colors.grey,
                              ),
                              title: Text(
                                locations[index],
                                style: TextStyle(
                                  color: selectedLocation == locations[index]
                                      ? picketColor
                                      : Colors.black,
                                ),
                              ),
                              trailing: selectedLocation == locations[index]
                                  ? Icon(Icons.check, color: picketColor)
                                  : null,
                              onTap: () {
                                setState(() async {
                                  switch (index) {
                                    case 0:
                                      await setUserActivity("Gangnam");
                                    case 1:
                                      await setUserActivity("Gwanak");
                                    case 2:
                                      await setUserActivity("Sinchon");
                                  }

                                  context.push('/login');
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  MaterialButton(
                    onPressed: selectedLocation != null
                        ? () {
                      Navigator.pop(context, selectedLocation);
                    }
                        : null,
                    height: 48,
                    color: selectedLocation != null
                        ? picketColor
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
