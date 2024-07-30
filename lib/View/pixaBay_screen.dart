import 'package:flutter/material.dart';
import 'package:pixabay_api/Modal/pixaBay_modal.dart';
import 'package:pixabay_api/Provider/pixaBay_provider.dart';
import 'package:provider/provider.dart';

TextEditingController txtSearch = TextEditingController();

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SearchProvider homeProvider =
    Provider.of<SearchProvider>(context, listen: false);
    SearchProvider homeProviderTrue =
    Provider.of<SearchProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        centerTitle: true,
        title: const Text(
          'PixaBay',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: txtSearch,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Colors.black),
                        label: const Text('Search Images'),
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        homeProvider.searchImg(txtSearch.text);
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 25,
                      )),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: Provider.of<SearchProvider>(context, listen: false)
                    .fromMap(homeProviderTrue.search),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    SearchModal? search = snapshot.data;
                    return GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1),
                      itemCount: search?.hits.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          selectIndex = index;
                          Navigator.of(context).pushNamed('/detail');
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PixbayDetailScreen()));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      '${search?.hits[index].webformatURL}'))),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}