// aya_of_the_day/aya_screen.dart

import 'package:flutter/material.dart';
import 'package:islami/core/services/app_local_storage.dart';
import 'package:islami/features/quran/data/repo/quran_service.dart';

import '../../../../../core/functions/random_aya_number.dart';
import '../../../data/model/recieve/ayah_of_the_day/aya_of_the-day.dart';


class AyaScreen extends StatefulWidget {
  const AyaScreen({super.key});

  @override
  State<AyaScreen> createState() => _AyaScreenState();
}

class _AyaScreenState extends State<AyaScreen> {
  AyaOfTheDay? data;

  @override
  Widget build(BuildContext context) {
    QuranService.getAyaOfTheDay().then((Value) => setState(() => data = Value));
    var suraNameRandom=data?.arText.toString()??"";
    AppLocalStorage.cachedAyahData(AppLocalStorage.AyahKey,suraNameRandom );

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Ayah of the Day'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display the date
                Text(
                  "Today's Ayah for December 4, 2024",
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 20),
                // Card for the Ayah
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text(
                          data?.arText.toString()??"",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          data?.suraaName.toString()??"", // Example Surah and Ayah number
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Fetch a new Ayah
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refresh Ayah'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Share the Ayah
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('Share Ayah'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
