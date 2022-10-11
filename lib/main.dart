import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Search Dialog App",
      home: SearchDialogScreen(),
    );
  }
}

class SearchDialogScreen extends StatefulWidget {
  const SearchDialogScreen({super.key});

  @override
  State<SearchDialogScreen> createState() => _SearchDialogScreenState();
}

class _SearchDialogScreenState extends State<SearchDialogScreen> {
  List<String> productList = [
    "Mobile",
    "Speakers",
    "WaterBottle",
    "Laptop",
    "Desktop",
    "Charger",
    "Watermelon",
    "Mixer",
    "Monitor",
  ];

  late List<String> _productItemList;

  @override
  void initState() {
    super.initState();
    _productItemList = productList;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedListState> _listKey =
        GlobalKey<AnimatedListState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Dialog Dynamic"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (ctx) => StatefulBuilder(
                builder: (ctx, setState) {
                  return AlertDialog(
                    title: const Text("Search Product"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration:
                              const InputDecoration(hintText: "Search Here..."),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                _productItemList = [
                                  ...productList.where(
                                    (item) => item
                                        .toLowerCase()
                                        .contains(value.toLowerCase()),
                                  )
                                ];

                                debugPrint(
                                    "item in the list: $_productItemList");
                              });
                            } else {
                              setState(() {
                                _productItemList = [...productList];

                                debugPrint(
                                    "Empty item in the list: $_productItemList");
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          child: _productItemList.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _productItemList.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (ctx, index) {
                                    var data = _productItemList[index];
                                    return ListTile(
                                      title: Text(data),
                                      leading: const CircleAvatar(
                                        child: Icon(Icons.abc_rounded),
                                      ),
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text('No data found.'),
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
          child: const Text("Press Button"),
        ),
      ),
    );
  }
}
