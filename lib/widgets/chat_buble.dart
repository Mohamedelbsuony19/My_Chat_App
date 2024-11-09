import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/shared/provider/theme-provider.dart';
import '../models/message-model.dart';

class chatBuble extends StatelessWidget {
  messageModel modelMassge;

  chatBuble({super.key, required this.modelMassge});
  @override
  Widget build(BuildContext context) {
    var themeprovider = Provider.of<themeProvider>(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(15),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                modelMassge.id ?? 'notFound',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: themeprovider.isLight
                        ? const Color(0xFF1611AF)
                        : Colors.grey),
              ),
            ),
            Text(
              modelMassge.message ?? '',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: themeprovider.isLight ? Colors.black : Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class chatBubleForFrind extends StatelessWidget {
  messageModel modelMassge;

  chatBubleForFrind({super.key, required this.modelMassge});

  @override
  Widget build(BuildContext context) {
    var themeprovider = Provider.of<themeProvider>(context);

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(15),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                modelMassge.id ?? 'notFound',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: themeprovider.isLight
                        ? const Color(0xFF1611AF)
                        : Colors.grey),
              ),
            ),
            Text(
              modelMassge.message ?? '',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: themeprovider.isLight ? Colors.black : Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
