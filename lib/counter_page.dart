import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc/cubit/counter_cubit.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        elevation: 0,
        backgroundColor: Colors.amber,
      ),
      body: BlocProvider(
        create: (context) => CounterCubit(),
        child: BlocConsumer<CounterCubit, CounterState>(
          listener: (context, state) {
            if (state is CounterInitial) {
              debugPrint('CounterInitialState');
              debugPrint('${BlocProvider.of<CounterCubit>(context).counter}');
            }

            if (state is CounterIncrementState) {
              debugPrint('CounterIncrementState');
              debugPrint('${BlocProvider.of<CounterCubit>(context).counter}');
            }

            if (state is CounterDecrementtState) {
              debugPrint('CounterDecrementState');
              debugPrint('${BlocProvider.of<CounterCubit>(context).counter}');
            }
          },
          builder: (context, state) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      CounterCubit.get(context).decrement();
                    },
                    child: const Icon(FontAwesomeIcons.minus),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '${CounterCubit.get(context).counter}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(width: 20),
                  FloatingActionButton(
                    onPressed: () {
                      CounterCubit.get(context).increment();
                    },
                    child: const Icon(FontAwesomeIcons.plus),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
