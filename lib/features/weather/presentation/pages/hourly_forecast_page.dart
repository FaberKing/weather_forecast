import 'package:course_weather_forecast/api/urls.dart';
import 'package:course_weather_forecast/common/app_constants.dart';
import 'package:course_weather_forecast/features/weather/domain/entities/weather_entity.dart';
import 'package:course_weather_forecast/features/weather/presentation/blocs/hourly_forecast/hourly_forecast_bloc.dart';
import 'package:d_view/d_view.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class HourlyForecastPage extends StatefulWidget {
  const HourlyForecastPage({super.key});

  @override
  State<HourlyForecastPage> createState() => _HourlyForecastPageState();
}

class _HourlyForecastPageState extends State<HourlyForecastPage> {
  refresh() {
    context.read<HourlyForecastBloc>().add(OnGetHourlyForecast());
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: background(),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          foreground(),
        ],
      ),
    );
  }

  Widget background() {
    return Image.asset(
      weatherBG['shower rain']!,
      fit: BoxFit.cover,
    );
  }

  Widget foreground() {
    return Column(
      children: [
        AppBar(
          title: const Text('Hourly Forecase'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          forceMaterialTransparency: true,
        ),
        Expanded(
          child: BlocBuilder<HourlyForecastBloc, HourlyForecastState>(
            builder: (context, state) {
              if (state is HourlyForecastLoading) {
                return DView.loadingCircle();
              }
              if (state is HourlyForecastFailure) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // DView.error(data: state.message),
                    Text(
                      state.message,
                      style: const TextStyle(
                        color: Colors.white60,
                      ),
                    ),
                    DView.height(8),
                    IconButton.filledTonal(
                      onPressed: () {
                        refresh();
                      },
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                );
              }
              if (state is HourlyForecastLoaded) {
                final list = state.data;
                return GroupedListView<WeatherEntity, String>(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  elements: list,
                  groupBy: (element) => DateFormat('yyyy-MM-dd').format(
                    element.dataTime,
                  ),
                  groupHeaderBuilder: (element) {
                    return Align(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 16,
                        ),
                        child: Text(
                          DateFormat('EEEE, d MMM yyyy').format(element.dataTime),
                        ),
                      ),
                    );
                  },
                  itemBuilder: (context, element) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 16,
                      ),
                      child: Row(
                        children: [
                          ExtendedImage.network(
                            URLs.weatherIcon(element.icon),
                            height: 80,
                            width: 80,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat('HH:mm').format(element.dataTime),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  element.description,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${(element.temperature - 273.15).round()}\u2103",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
