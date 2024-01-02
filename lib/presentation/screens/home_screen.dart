import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/res/assets/assets.dart';
import 'package:weather_app/utils/helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherDataLoadedState) {
            return Column(
              children: [
                Container(
                  height: size.height * 0.67,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(55)),
                      gradient: LinearGradient(
                          colors: [
                            Color(0xff1273f3),
                            Color(0xff17bdf7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.01),
                      Text(
                        state.currentWeatherData.name!,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        HelperFunctions.formatDate(
                            state.currentWeatherData.dt!),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: size.height * 0.04),
                      Image.asset(
                          HelperFunctions.getWeatherSticker(
                              state.currentWeatherData.weather![0].id!.toInt()),
                          width: 200,
                          height: 200),
                      SizedBox(height: size.height * 0.04),
                      Text(
                        state.currentWeatherData.weather![0].main!,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.1,
                          ),
                          Image.asset(
                            AppAssets.temp,
                            width: size.width * 0.1,
                          ),
                          SizedBox(
                            width: size.width * 0.28,
                          ),
                          Image.asset(
                            AppAssets.wind,
                            color: Colors.white70,
                            width: size.width * 0.1,
                          ),
                          SizedBox(
                            width: size.width * 0.25,
                          ),
                          Image.asset(
                            AppAssets.humidity,
                            color: Colors.white,
                            width: size.width * 0.07,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            HelperFunctions.kelvinToCelsius(
                                state.currentWeatherData.main!.temp!),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            HelperFunctions.windSpeedToKm(
                                state.currentWeatherData.wind!.speed!),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${state.currentWeatherData.main!.humidity!.toString()}%',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Min Temp',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  HelperFunctions.kelvinToCelsius(state
                                      .currentWeatherData.main!.tempMin!
                                      .toInt()),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Image.asset(
                              AppAssets.temp,
                              width: 45,
                              height: 45,
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Max Temp',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  HelperFunctions.kelvinToCelsius(state
                                          .currentWeatherData.main!.tempMax!
                                          .toInt() +
                                      1),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Divider(),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Sunrise',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  HelperFunctions.formatTime(state
                                      .currentWeatherData.sys!.sunrise!
                                      .toInt()),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Image.asset(
                              AppAssets.sun,
                              width: 45,
                              height: 45,
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Sunset',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  HelperFunctions.formatTime(state
                                      .currentWeatherData.sys!.sunset!
                                      .toInt()),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Divider(),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Clouds',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '${state.currentWeatherData.clouds!.all}%',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Image.asset(
                              AppAssets.clouds,
                              width: 45,
                              height: 45,
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Rain',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '${state.currentWeatherData.rain?.d1h ?? 0} mm',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          if (state is LocationState) {
            context.read<WeatherBloc>().add(GetWeatherData(
                state.userPosition.latitude, state.userPosition.longitude));
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(AppAssets.fetchWeather,
                      width: 200, height: 200, fit: BoxFit.fill),
                  const Text('Fetching weather',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                ],
              ),
            );
          }
          if (state is ErrorState) {
            return Center(
              child: Text(
                state.error.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      )),
    );
  }
}
