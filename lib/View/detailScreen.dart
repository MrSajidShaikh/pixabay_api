import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixabay_api/Modal/pixaBay_modal.dart';
import 'package:pixabay_api/Provider/pixaBay_provider.dart';
import 'package:provider/provider.dart';

class Detailscreen extends StatelessWidget {
  const Detailscreen({super.key});

  @override
  Widget build(BuildContext context) {

    SearchProvider homeProviderTrue =
    Provider.of<SearchProvider>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          centerTitle: true,
          title: const Text(
            'PixaBay',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 620,
                width: double.infinity,
                color: Colors.grey.shade100,
                child: Column(
                  children: [
                    FutureBuilder(
                      future: Provider.of<SearchProvider>(context, listen: false)
                          .fromMap(homeProviderTrue.search),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          SearchModal? search = snapshot.data;
                          return Flexible(
                            child: Center(
                              child: Container(
                                height: 615,
                                width: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        search!.hits[selectIndex].webformatURL),
                                  ),
                                ),
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
                  ],
                ),
              ),
              const SizedBox(height: 15,),
              InkWell(
                onTap: ()
                async {
                  String result;
                  try {
                    result = await AsyncWallpaper.setWallpaper(
                      url: homeProviderTrue
                          .searchModal!.hits[selectIndex].webformatURL,
                      wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
                      goToHome: false,
                      toastDetails: ToastDetails.success(),
                      errorToastDetails: ToastDetails.error(),
                    )
                        ? 'Wallpaper set'
                        : 'Failed to get wallpaper.';
                  } on PlatformException {
                    result = 'Failed to get wallpaper.';
                  }
                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade300,
                      border: Border.all(color: Colors.black)
                  ),
                  child: const Center(child: Text('Set Wallpaper',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                ),
              )
            ],
          ),
        ));;
  }
}
