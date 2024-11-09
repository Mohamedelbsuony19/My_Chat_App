import 'package:flutter/material.dart';
import '../helper/shared/provider/theme-provider.dart';
import '../models/message-model.dart';
import 'package:provider/provider.dart';

class ImageBuble extends StatelessWidget {
  messageModel? model;
  ImageBuble(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    var themeprovider = Provider.of<themeProvider>(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: themeprovider.isLight
                ? const Color(0xFFE7FFDB)
                : const Color(0xFF005D4B),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                model!.id ?? '',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: themeprovider.isLight
                          ? const Color(0xFF1611AF)
                          : Colors.grey,
                    ),
              ),
            ),
            model?.type == 2
                ? Image.network(
                    model!.message ?? '',
                    height: MediaQuery.of(context).size.height * 0.37,
                    width: MediaQuery.of(context).size.width * 0.45,
                  )
                : Text(
                    model!.message ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                  ),
          ],
        ),
      ),
    );
  }
}

class imageBubleForFrind extends StatelessWidget {
  messageModel model;
  imageBubleForFrind(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    var themeprovider = Provider.of<themeProvider>(context);
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: themeprovider.isLight
                ? const Color(0xFFFFFFFF)
                : const Color(0xFF2C3A35),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                model.id!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: themeprovider.isLight
                        ? const Color(0xFF1611AF)
                        : Colors.grey),
              ),
            ),
            model.type == 2
                ? Image.network(
                    model.message ?? '',
                    height: MediaQuery.of(context).size.height * 0.37,
                    width: MediaQuery.of(context).size.width * 0.45,
                  )
                : Text(
                    model.message ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                  ),
          ],
        ),
      ),
    );
  }
}
