import 'package:flutter/material.dart';
import 'package:image_capture/image_provider.dart';
import 'package:image_capture/utils.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ImgProvider>(
      builder: (context, pvd, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Select Image", style: Utils.h1),
          ),
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (pvd.isLoading)
                        const CircularProgressIndicator()
                      else if (pvd.imageFile != null)
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: Image.file(pvd.imageFile!),
                        )
                      else
                        Text("No image selected", style: Utils.h1),
                      ElevatedButton(
                        onPressed: () {
                          pvd.fromCamera();
                        },
                        child: Text(
                          "Camera",
                          style:
                              Utils.h2.copyWith(fontWeight: FontWeight.normal),
                        ),
                      ),
                      ClipOval(
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          height: 3,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.red, Colors.pink],
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          pvd.fromGallery();
                        },
                        child: Text(
                          "Gallery",
                          style:
                              Utils.h2.copyWith(fontWeight: FontWeight.normal),
                        ),
                      ),
                      if (pvd.error.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            pvd.error,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
