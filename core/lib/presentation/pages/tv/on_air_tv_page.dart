import 'package:core/core.dart';
import 'package:core/presentation/provider/tv/on_air_tv_notifier.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnAirTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-air-tv';

  @override
  _OnAirTvPageState createState() => _OnAirTvPageState();
}

class _OnAirTvPageState extends State<OnAirTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OnAirTvNotifier>(context, listen: false)
            .fetchOnAirTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On Air TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnAirTvNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tv[index];
                  return TvCard(tv);
                },
                itemCount: data.tv.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}