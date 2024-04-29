import 'package:flutter/material.dart';
import 'package:newsapp_with_provider/controller/home_screen_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeScreenController>().getDataByCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeScreenController>();
    return DefaultTabController(
      length: provider.categories.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            onTap: (value) {
              context.read<HomeScreenController>().onCategorySelection(value);
            },
            tabs: List.generate(
              provider.categories.length, 
              (index) => Tab(
                child: 
                Text("${provider.categories[index].toUpperCase()}"),
                ))),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<HomeScreenController>().getDataByCategory();
          },
        ),
        body: provider.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                itemCount: provider.resByCategory?.articles?.length ?? 0,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.grey.shade100,
                    child: Column(
                      children: [
                      Container(
                        height: 200,
                        child: Image.network(
                          fit: BoxFit.cover,
                          "${provider.resByCategory?.articles?[index].urlToImage}")
                          ),
                          Text(
                            "${provider.resByCategory?.articles?[index].title?.toUpperCase()}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8,),
                            Text(
                            "${provider.resByCategory?.articles?[index].description?.toUpperCase()}",
                            style: TextStyle(fontWeight: FontWeight.normal),
                            )
                          ],),
                  );
                },
                
              ),
      ),
    );
  }
}
