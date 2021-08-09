import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/business_logic/cubit/counter_cubit.dart';
import 'package:flutter_bloc_concepts/business_logic/cubit/internet_cubit.dart';
import 'package:flutter_bloc_concepts/constants/enums.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.color}) : super(key: key);
  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Navigator.pushNamed(context, '/settings')),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
              if (state is InternetConnected &&
                  state.connectionType == ConnectionType.Wifi) {
                return Text(
                  'Wifi',
                  style: Theme.of(context).textTheme.headline3.copyWith(
                        color: Colors.green,
                      ),
                );
              } else if (state is InternetConnected &&
                  state.connectionType == ConnectionType.Mobile) {
                return Text(
                  'Mobile',
                  style: Theme.of(context).textTheme.headline3.copyWith(
                        color: Colors.red,
                      ),
                );
              } else if (state is InternetDisconnected) {
                return Text(
                  'Disconnected',
                  style: Theme.of(context).textTheme.headline3.copyWith(
                        color: Colors.grey,
                      ),
                );
              }
              return CircularProgressIndicator();
            }),
            Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Incremented.'),
                      duration: Duration(milliseconds: 300)));
                }
              },
              builder: (context, state) {
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            SizedBox(height: 24),
            Builder(
              builder: (context) {
                final counterState = context.watch<CounterCubit>().state;
                final internetState = context.watch<InternetCubit>().state;
                if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.Wifi) {
                  return Text(
                    'Counter: ' +
                        counterState.counterValue.toString() +
                        ' Internet: Wifi',
                    style: Theme.of(context).textTheme.headline6,
                  );
                } else if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.Mobile) {
                  return Text(
                    'Counter: ' +
                        counterState.counterValue.toString() +
                        ' Internet: Mobile',
                    style: Theme.of(context).textTheme.headline6,
                  );
                }
                return Text('Counter: ' +
                    counterState.counterValue.toString() +
                    ' Internet: Disconnected');
              },
            ),
            SizedBox(height: 24),
            Builder(builder: (context) {
              final counterValue = context.select((CounterCubit counterCubit) =>
                  counterCubit.state.counterValue);
              return Text(
                'Counter: ' + counterValue.toString(),
                style: Theme.of(context).textTheme.headline6,
              );
            }),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'btn1',
                  backgroundColor: widget.color,
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  child: Icon(Icons.remove),
                  tooltip: 'Decrement',
                ),
                FloatingActionButton(
                  heroTag: 'btn2',
                  backgroundColor: widget.color,
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  child: Icon(Icons.add),
                  tooltip: 'Increment',
                ),
              ],
            ),
            SizedBox(height: 24),
            MaterialButton(
              color: widget.color,
              onPressed: () {
                Navigator.of(context).pushNamed('/second');
              },
              child: Text('Go to Second Screen'),
            ),
            SizedBox(height: 24),
            MaterialButton(
              color: widget.color,
              onPressed: () {
                Navigator.of(context).pushNamed('/third');
              },
              child: Text('Go to Third Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
