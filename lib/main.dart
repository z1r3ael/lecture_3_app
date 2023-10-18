import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const ShowcaseAnimatedBouncy(),
    );
  }
}

//--------------------------------------------------------------------------------------------------

class StaticListView extends StatelessWidget {
  const StaticListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('StaticListView'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          const ListTile(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
          ),
          const ListTile(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
          ),
          const ListTile(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
            leading: Icon(Icons.inbox),
          ),
          const ListTile(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
          ),
          const ListTile(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
          ),
          const ListTile(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
          ),
          ListTile(
            title: const Text('Title'),
            subtitle: const Text('Subtitle'),
            leading: const Icon(Icons.info),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('AlertDialog'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
          const ListTile(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
          ),
          const ListTile(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
          ),
          const ListTile(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
          ),
          const ListTile(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
          ),
          const ListTile(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
          ),
        ],
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------

class ListViewBuilder extends StatefulWidget {
  const ListViewBuilder({super.key});

  @override
  State<ListViewBuilder> createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  final _items = <String>[];

  void _addItem(String item) {
    setState(() {
      _items.add(item);
    });
  }

  void _removeItem(String item) {
    setState(() {
      _items.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ListViewBuilder'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final currItem = _items[index];

          return ListTile(
            title: Text(
              currItem,
            ),
            subtitle: index.isOdd ? const Text('subtitle') : null,
            leading: const Icon(Icons.flutter_dash),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Удалить элемент?'),
                  content: Text(currItem),
                  actions: [
                    TextButton(
                      onPressed: () {
                        _removeItem(currItem);
                        Navigator.pop(context);
                      },
                      child: const Text('ДА'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('НЕТ'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItem('Item ${_items.length}');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------

class ListViewSeparated extends StatefulWidget {
  const ListViewSeparated({super.key});

  @override
  State<ListViewSeparated> createState() => _ListViewSeparatedState();
}

class _ListViewSeparatedState extends State<ListViewSeparated> {
  final _items = <String>[];

  void _addItem(String item) {
    setState(() {
      _items.add(item);
    });
  }

  void _removeItem(String item) {
    setState(() {
      _items.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ListViewSeparated'),
      ),
      body: ListView.separated(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final currItem = _items[index];

          return ListTile(
            title: Text(
              currItem,
            ),
            subtitle: index.isOdd ? const Text('subtitle') : null,
            leading: const Icon(Icons.flutter_dash),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Удалить элемент?'),
                  content: Text(currItem),
                  actions: [
                    TextButton(
                      onPressed: () {
                        _removeItem(currItem);
                        Navigator.pop(context);
                      },
                      child: const Text('ДА'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('НЕТ'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.black,
            indent: 50,
            endIndent: 10,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItem('Item ${_items.length}');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------

class AnimatedListWidget extends StatefulWidget {
  const AnimatedListWidget({super.key});

  @override
  State<AnimatedListWidget> createState() => _AnimatedListWidgetState();
}

class _AnimatedListWidgetState extends State<AnimatedListWidget> {
  final _listKey = GlobalKey<AnimatedListState>();
  final _items = <String>[];

  void _addItem(String item) {
    setState(() {
      _listKey.currentState?.insertItem(_items.length);
      _items.add(item);
    });
  }

  void _removeItem(String item) {
    setState(() {
      final index = _items.indexOf(item);
      _listKey.currentState?.removeItem(
        index,
        (context, animation) => _slideItem(context, animation, item),
      );
      _items.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('AnimatedListWidget'),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          final currItem = _items[index];
          return _slideItem(context, animation, currItem);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItem('Item ${_items.length}');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _slideItem(BuildContext context, Animation<double> animation, String currItem) {
    return SlideTransition(
      position: animation.drive(
        Tween(
          begin: const Offset(-1, 0),
          end: const Offset(0, 0),
        ),
      ),
      child: ListTile(
        title: Text(
          currItem,
        ),
        leading: const Icon(Icons.flutter_dash),
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Удалить элемент?'),
              content: Text(currItem),
              actions: [
                TextButton(
                  onPressed: () {
                    _removeItem(currItem);
                    Navigator.pop(context);
                  },
                  child: const Text('ДА'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('НЕТ'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------

class ListViewBuilderScrollNotification extends StatefulWidget {
  const ListViewBuilderScrollNotification({super.key});

  @override
  State<ListViewBuilderScrollNotification> createState() =>
      _ListViewBuilderScrollNotificationState();
}

class _ListViewBuilderScrollNotificationState extends State<ListViewBuilderScrollNotification> {
  final _items = <String>[];

  void _addItem(String item) {
    setState(() {
      _items.add(item);
    });
  }

  void _removeItem(String item) {
    setState(() {
      _items.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ListViewBuilderScrollNotification'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          print('notification: $notification');
          return false;
        },
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final currItem = _items[index];

            return ListTile(
              title: Text(
                currItem,
              ),
              subtitle: index.isOdd ? const Text('subtitle') : null,
              leading: const Icon(Icons.flutter_dash),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Удалить элемент?'),
                    content: Text(currItem),
                    actions: [
                      TextButton(
                        onPressed: () {
                          _removeItem(currItem);
                          Navigator.pop(context);
                        },
                        child: const Text('ДА'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('НЕТ'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItem('Item ${_items.length}');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------

class ListViewBuilderScrollController extends StatefulWidget {
  const ListViewBuilderScrollController({super.key});

  @override
  State<ListViewBuilderScrollController> createState() => _ListViewBuilderScrollControllerState();
}

class _ListViewBuilderScrollControllerState extends State<ListViewBuilderScrollController> {
  late final ScrollController _controller;
  final _items = <String>[];

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(
      () {
        print('controller: ${_controller.position.isScrollingNotifier.value}');
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addItem(String item) {
    setState(() {
      _items.add(item);
    });
  }

  void _removeItem(String item) {
    setState(() {
      _items.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ListViewBuilderScrollController'),
      ),
      body: ListView.builder(
        controller: _controller,
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final currItem = _items[index];

          return ListTile(
            title: Text(
              currItem,
            ),
            subtitle: index.isOdd ? const Text('subtitle') : null,
            leading: const Icon(Icons.flutter_dash),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Удалить элемент?'),
                  content: Text(currItem),
                  actions: [
                    TextButton(
                      onPressed: () {
                        _removeItem(currItem);
                        Navigator.pop(context);
                      },
                      child: const Text('ДА'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('НЕТ'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItem('Item ${_items.length}');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------

class SingleChildScrollViewWidget extends StatelessWidget {
  const SingleChildScrollViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('SingleChildScrollViewWidget'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const ListTile(
              title: Text('Title'),
              subtitle: Text('Subtitle'),
            ),
            const ListTile(
              title: Text('Title'),
              subtitle: Text('Subtitle'),
            ),
            const ListTile(
              title: Text('Title'),
              subtitle: Text('Subtitle'),
              leading: Icon(Icons.inbox),
            ),
            const ListTile(
              title: Text('Title'),
              subtitle: Text('Subtitle'),
            ),
            const ListTile(
              title: Text('Title'),
              subtitle: Text('Subtitle'),
            ),
            const ListTile(
              title: Text('Title'),
              subtitle: Text('Subtitle'),
            ),
            ListTile(
              title: const Text('Title'),
              subtitle: const Text('Subtitle'),
              leading: const Icon(Icons.info),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('AlertDialog'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const ListTile(
              title: Text('Title'),
              subtitle: Text('Subtitle'),
            ),
            const ListTile(
              title: Text('Title'),
              subtitle: Text('Subtitle'),
            ),
            const ListTile(
              title: Text('Title'),
              subtitle: Text('Subtitle'),
            ),
            const ListTile(
              title: Text('Title'),
              subtitle: Text('Subtitle'),
            ),
            const ListTile(
              title: Text('Title'),
              subtitle: Text('Subtitle'),
            ),
          ],
        ),
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------

class GridViewCount extends StatelessWidget {
  const GridViewCount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('GridViewCount'),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[100],
            child: const Text("He'd have you all unravel at the"),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[200],
            child: const Text('Heed not the rabble'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[300],
            child: const Text('Sound of screams but the'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[400],
            child: const Text('Who scream'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[500],
            child: const Text('Revolution is coming...'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[600],
            child: const Text('Revolution, they...'),
          ),
        ],
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------

class GridViewExtent extends StatelessWidget {
  const GridViewExtent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('GridViewCount'),
      ),
      body: GridView.extent(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        maxCrossAxisExtent: 200,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[100],
            child: const Text("He'd have you all unravel at the"),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[200],
            child: const Text('Heed not the rabble'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[300],
            child: const Text('Sound of screams but the'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[400],
            child: const Text('Who scream'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[500],
            child: const Text('Revolution is coming...'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[600],
            child: const Text('Revolution, they...'),
          ),
        ],
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------

class GridViewBuilder extends StatelessWidget {
  const GridViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('GridViewCount'),
      ),
      body: GridView.builder(
        primary: false,
        padding: const EdgeInsets.all(20),
        itemCount: 300,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.teal,
            child: Center(
              child: Text(
                index.toString(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------

class CustomScrollViewWidget extends StatelessWidget {
  const CustomScrollViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('GridViewCount'),
              centerTitle: true,
            ),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('Grid Item $index'),
                );
              },
              childCount: 20,
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('List Item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------

class ColorBlock extends StatefulWidget {
  final Color color;

  const ColorBlock({
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  State<ColorBlock> createState() => _ColorBlockState();
}

class _ColorBlockState extends State<ColorBlock> {
  late Color color;

  @override
  void initState() {
    super.initState();
    color = widget.color;
  }

  void incrementColor() {
    setState(() {
      color = Color.fromARGB(
        color.alpha,
        (color.red + 4) % 256,
        (color.green + 4) % 256,
        (color.blue + 4) % 256,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: incrementColor,
      child: Container(
        color: color,
        width: 100.0,
        height: 100.0,
      ),
    );
  }
}

class BoxSwitcher extends StatefulWidget {
  const BoxSwitcher({Key? key}) : super(key: key);

  @override
  State<BoxSwitcher> createState() => _BoxSwitcherState();
}

class _BoxSwitcherState extends State<BoxSwitcher> {
  var _colorBlocks = <Widget>[];

  @override
  void initState() {
    super.initState();
    final random = Random().nextInt(Colors.primaries.length - 2);
    _colorBlocks = [
      ColorBlock(
        color: Colors.primaries[random],
      ),
      ColorBlock(
        color: Colors.primaries[random + 1],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Switch'),
      ),
      body: Column(children: _colorBlocks),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.swap_vert),
        onPressed: () {
          setState(() {
            _colorBlocks = _colorBlocks.reversed.toList();
          });
        },
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------

class RandomColorBlock extends StatefulWidget {
  const RandomColorBlock({Key? key}) : super(key: key);

  @override
  State<RandomColorBlock> createState() => _RandomColorBlockState();
}

class _RandomColorBlockState extends State<RandomColorBlock> {
  late Color color;

  @override
  void initState() {
    super.initState();
    final random = Random();
    color = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: 100.0,
      height: 100.0,
    );
  }
}

class BoxSwitcherV2 extends StatefulWidget {
  const BoxSwitcherV2({Key? key}) : super(key: key);

  @override
  State<BoxSwitcherV2> createState() => _BoxSwitcherV2State();
}

class _BoxSwitcherV2State extends State<BoxSwitcherV2> {
  var _colorBlocks = <Widget>[];

  @override
  void initState() {
    super.initState();
    _generateRandomColorBlocks();
  }

  void _generateRandomColorBlocks() {
    setState(
      () {
        _colorBlocks = List.generate(
          3,
          (_) => RandomColorBlock(
            key: UniqueKey(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SwitchV2'),
      ),
      body: Column(children: _colorBlocks),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateRandomColorBlocks,
        child: const Icon(Icons.swap_vert),
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------

class BoxSwitcherOrientation extends StatefulWidget {
  const BoxSwitcherOrientation({Key? key}) : super(key: key);

  @override
  State<BoxSwitcherOrientation> createState() => _BoxSwitcherOrientationState();
}

class _BoxSwitcherOrientationState extends State<BoxSwitcherOrientation> {
  //final _columnKey = GlobalKey();
  var _colorBlocks = <Widget>[];

  @override
  void initState() {
    super.initState();
    final random = Random().nextInt(Colors.primaries.length - 2);
    _colorBlocks = [
      Padding(
        key: const Key('1'),
        padding: const EdgeInsets.all(8.0),
        child: ColorBlock(
          color: Colors.primaries[random],
        ),
      ),
      Padding(
        key: const Key('2'),
        padding: const EdgeInsets.all(8.0),
        child: ColorBlock(
          color: Colors.primaries[random + 1],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('SwitchO'),
          ),
          body: orientation == Orientation.portrait
              ? Column(
                  //key: _columnKey,
                  children: _colorBlocks,
                )
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    //key: _columnKey,
                    children: _colorBlocks,
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.swap_vert),
            onPressed: () {
              setState(
                () {
                  _colorBlocks = _colorBlocks.reversed.toList();
                },
              );
            },
          ),
        );
      },
    );
  }

/*
  body: Padding(
        padding: orientation == Orientation.portrait
					? EdgeInsets.zero
					: const EdgeInsets.all(8.0),
        child: Column(
          children: _colorBlocks,
        ),
      ),
  */
}

//--------------------------------------------------------------------------------------------------

class BoxSwitcherGetState extends StatefulWidget {
  const BoxSwitcherGetState({Key? key}) : super(key: key);

  @override
  State<BoxSwitcherGetState> createState() => _BoxSwitcherGetStateState();
}

class _BoxSwitcherGetStateState extends State<BoxSwitcherGetState> {
  final _colorBlockKeys = <GlobalKey<_ColorBlockState>>[];
  var _colorBlocks = <Widget>[];

  @override
  void initState() {
    super.initState();
    final random = Random().nextInt(Colors.primaries.length - 2);
    _colorBlocks = [
      ColorBlock(
        key: GlobalKey<_ColorBlockState>(),
        color: Colors.primaries[random],
      ),
      ColorBlock(
        key: GlobalKey<_ColorBlockState>(),
        color: Colors.primaries[random + 1],
      ),
    ];

    for (final colorBlock in _colorBlocks) {
      final key = colorBlock.key;
      if (key is GlobalKey<_ColorBlockState>) {
        _colorBlockKeys.add(key);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('BoxSwitcherGetState'),
          ),
          body: orientation == Orientation.portrait
              ? Column(
                  children: _colorBlocks,
                )
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: _colorBlocks,
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.swap_vert),
            onPressed: () {
              for (final key in _colorBlockKeys) {
                key.currentState?.incrementColor();
              }
            },
          ),
        );
      },
    );
  }
}

//--------------------------------------------------------------------------------------------------

class AnimatedContainerExample extends StatefulWidget {
  const AnimatedContainerExample({super.key});

  @override
  State<AnimatedContainerExample> createState() => _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool _value = true;

  void run() {
    setState(() {
      _value = !_value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedContainerExample'),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeIn,
          height: _value ? 100 : 200,
          width: _value ? 100 : 200,
          decoration: BoxDecoration(
              color: _value ? Colors.red : Colors.green,
              shape: _value ? BoxShape.circle : BoxShape.rectangle,
              boxShadow: _value
                  ? [
                      const BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                        blurStyle: BlurStyle.solid,
                      ),
                    ]
                  : null),
          child:
              _value ? const Icon(Icons.flutter_dash_rounded) : const Icon(Icons.ac_unit_rounded),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          run();
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------

class TweenAnimationBuilderExample extends StatefulWidget {
  const TweenAnimationBuilderExample({super.key});

  @override
  State<TweenAnimationBuilderExample> createState() => _TweenAnimationBuilderExampleState();
}

class _TweenAnimationBuilderExampleState extends State<TweenAnimationBuilderExample> {
  bool _value = false;
  bool _hasRun = false;

  void run() {
    setState(() {
      _value = !_value;
      _hasRun = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TweenAnimationBuilderExample'),
      ),
      body: Center(
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeIn,
          tween: _hasRun
              ? Tween<double>(
                  begin: _value ? 0.0 : pi,
                  end: _value ? pi : 0.0,
                )
              : Tween<double>(
                  begin: 0.0,
                  end: 0.0,
                ),
          builder: (context, value, child) {
            return Transform.rotate(
              angle: value,
              child: child,
            );
          },
          child: const Icon(
            Icons.flutter_dash_rounded,
            size: 50,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          run();
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------

class AnimatedVisibility extends StatefulWidget {
  final Widget child;
  final bool isVisible;
  final Duration duration;
  final Curve curve;

  const AnimatedVisibility({
    super.key,
    required this.child,
    required this.isVisible,
    required this.duration,
    required this.curve,
  });

  @override
  State<AnimatedVisibility> createState() => _AnimatedVisibilityState();
}

class _AnimatedVisibilityState extends State<AnimatedVisibility>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: widget.duration,
    value: widget.isVisible ? 1 : 0,
    vsync: this,
  );

  late final _animation = CurvedAnimation(
    parent: _controller,
    curve: widget.curve,
  );

  @override
  void didUpdateWidget(covariant AnimatedVisibility oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget.duration;
    _animation.curve = widget.curve;
    if (oldWidget.isVisible != widget.isVisible) {
      if (widget.isVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isVisible,
      child: ScaleTransition(
        scale: _animation,
        child: FadeTransition(
          opacity: _animation,
          child: widget.child,
        ),
      ),
    );
  }
}

class TestAnimatedVisibility extends StatefulWidget {
  const TestAnimatedVisibility({super.key});

  @override
  State<TestAnimatedVisibility> createState() => _TestAnimatedVisibilityState();
}

class _TestAnimatedVisibilityState extends State<TestAnimatedVisibility> {
  bool _value = true;

  void run() {
    setState(() {
      _value = !_value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestAnimatedVisibility'),
      ),
      body: Center(
        child: AnimatedVisibility(
          duration: const Duration(milliseconds: 1000),
          isVisible: _value,
          curve: Curves.easeIn,
          child: FloatingActionButton.large(
            onPressed: () {
              print('Tap');
            },
            child: const Icon(Icons.flutter_dash_rounded),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          run();
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------

class AnimatedClip extends StatefulWidget {
  final Widget child;
  final bool isVisible;
  final Duration duration;
  final Curve curve;

  const AnimatedClip({
    super.key,
    required this.child,
    required this.isVisible,
    required this.duration,
    required this.curve,
  });

  @override
  State<AnimatedClip> createState() => _AnimatedClipState();
}

class _AnimatedClipState extends State<AnimatedClip> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: widget.duration,
    value: widget.isVisible ? 1 : 0,
    vsync: this,
  );

  late final _animation = CurvedAnimation(
    parent: _controller,
    curve: widget.curve,
  );

  @override
  void didUpdateWidget(covariant AnimatedClip oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget.duration;
    _animation.curve = widget.curve;
    if (oldWidget.isVisible != widget.isVisible) {
      if (widget.isVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipPath(
          clipper: _Clipper(_animation.value),
          child: widget.child,
        );
      },
    );
  }
}

class _Clipper extends CustomClipper<Path> {
  final double factor;

  _Clipper(this.factor);

  @override
  Path getClip(Size size) {
    final path = Path();

    final center = size.center(Offset.zero);
    final r = size.shortestSide * factor;

    path.addRRect(
      RRect.fromLTRBR(
        center.dx - r,
        center.dy - r,
        center.dx + r,
        center.dy + r,
        Radius.circular(r),
      ),
    );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    if (oldClipper.runtimeType != _Clipper) {
      return true;
    }
    final typedOldClipper = oldClipper as _Clipper;
    return typedOldClipper.factor != factor;
  }
}

class TestAnimatedClip extends StatefulWidget {
  const TestAnimatedClip({super.key});

  @override
  State<TestAnimatedClip> createState() => _TestAnimatedClipState();
}

class _TestAnimatedClipState extends State<TestAnimatedClip> {
  bool _value = true;

  void run() {
    setState(() {
      _value = !_value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestAnimatedClip'),
      ),
      body: Center(
        child: AnimatedClip(
          duration: const Duration(milliseconds: 1000),
          isVisible: _value,
          curve: Curves.easeIn,
          child: Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueAccent,
            ),
            child: const Icon(
              Icons.flutter_dash_rounded,
              size: 50,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          run();
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

//Если хотим переиспользовать транзишн
class CircleClipTransition extends AnimatedWidget {
  final Widget child;

  const CircleClipTransition({
    super.key,
    required this.child,
    required Animation<double> animation,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final factor = listenable as Animation<double>;
    return ClipPath(
      clipper: _Clipper(factor.value),
      child: child,
    );
  }
}

//--------------------------------------------------------------------------------------------------

class ColoredCircle extends StatelessWidget {
  final double size;
  final Color color;

  const ColoredCircle({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: ColoredBox(
        color: color,
        child: SizedBox.square(
          dimension: size,
        ),
      ),
    );
  }
}

class AnimatedPulse extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;

  const AnimatedPulse({
    super.key,
    required this.color,
    required this.size,
    required this.duration,
  });

  @override
  State<AnimatedPulse> createState() => _AnimatedPulseState();
}

class _AnimatedPulseState extends State<AnimatedPulse> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  );

  late final _coreScaleUpAnimation = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
  ).drive(
    Tween(begin: 1.0, end: 1.25),
  );

  late final _coreScaleDownAnimation = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
  ).drive(
    Tween(begin: 1.0, end: 0.75),
  );

  //late final coreScaleAnimation = MultiplyAnimation(_coreScaleUpAnimation, _coreScaleDownAnimation);

  late final _outerScaleUpAnimation = Tween(begin: 1.0, end: 2.5).animate(_controller);

  late final _outerFadeAnimation = Tween(begin: 1.0, end: 0.0).animate(_controller);

  @override
  void initState() {
    _controller.repeat();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnimatedPulse oldWidget) {
    _controller.duration = widget.duration;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ScaleTransition(
          scale: _outerScaleUpAnimation,
          child: FadeTransition(
            opacity: _outerFadeAnimation,
            child: ColoredCircle(size: widget.size, color: widget.color),
          ),
        ),
        ScaleTransition(
          scale: _coreScaleUpAnimation,
          child: ScaleTransition(
            scale: _coreScaleDownAnimation,
            child: ColoredCircle(size: widget.size, color: widget.color),
          ),
        )
      ],
    );
  }
}

class MultiplyAnimation extends CompoundAnimation<double> {
  MultiplyAnimation(
    Animation<double> first,
    Animation<double> next,
  ) : super(first: first, next: next);

  @override
  double get value => first.value * next.value;
}

class PulseWidget extends StatelessWidget {
  const PulseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PulseWidget'),
      ),
      body: const Center(
        child: AnimatedPulse(
          color: Colors.red,
          size: 80,
          duration: Duration(milliseconds: 1000),
        ),
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------

/// Showcase of custom [AnimatedHeroStatsGraph]
class ShowcaseAnimatedHeroStatsGraph extends StatefulWidget {
  const ShowcaseAnimatedHeroStatsGraph({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowcaseAnimatedHeroStatsGraph> createState() => _ShowcaseAnimatedHeroStatsGraphState();
}

class _ShowcaseAnimatedHeroStatsGraphState extends State<ShowcaseAnimatedHeroStatsGraph> {
  /// current values of sliders
  var strength = HeroStats.zero.strength;
  var agility = HeroStats.zero.agility;
  var intelligence = HeroStats.zero.intelligence;

  /// current hero stats
  var stats = HeroStats.zero;

  /// whether to update stats immediately
  var immediately = false;

  /// updates stats
  void updateStats() {
    stats = HeroStats(
      strength: strength,
      agility: agility,
      intelligence: intelligence,
    );
  }

  /// updates stats if necessary
  void shouldUpdateStats() {
    if (immediately) {
      updateStats();
    }
  }

  /// updates stats and runs animation
  void onRun() {
    setState(() {
      updateStats();
    });
  }

  /// sets [immediately] and if necessary updates stats and runs animation
  void onToggleImmediately() {
    setState(() {
      immediately = !immediately;
      shouldUpdateStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: AnimatedHeroStatsGraph(
              duration: const Duration(milliseconds: 1000),
              stats: stats,
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 8.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('runImmediately'),
                    onTap: onToggleImmediately,
                    trailing: Checkbox(
                      value: immediately,
                      onChanged: (_) {
                        onToggleImmediately();
                      },
                    ),
                  ),
                  const Text('Strength'),
                  Slider(
                    min: 0.0,
                    max: 100.0,
                    value: strength,
                    activeColor: Colors.red,
                    onChanged: (double value) {
                      setState(() {
                        strength = value;
                        shouldUpdateStats();
                      });
                    },
                  ),
                  const Text('Agility'),
                  Slider(
                    min: 0.0,
                    max: 100.0,
                    value: agility,
                    activeColor: Colors.green,
                    onChanged: (double value) {
                      setState(() {
                        agility = value;
                        shouldUpdateStats();
                      });
                    },
                  ),
                  const Text('Intelligence'),
                  Slider(
                    min: 0.0,
                    max: 100.0,
                    value: intelligence,
                    activeColor: Colors.blue,
                    onChanged: (double value) {
                      setState(() {
                        intelligence = value;
                        shouldUpdateStats();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onRun();
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

/// HeroStats model
class HeroStats {
  static const max = 100.0;
  static const zero = HeroStats(
    agility: 0.0,
    strength: 0.0,
    intelligence: 0.0,
  );

  final double strength;
  final double agility;
  final double intelligence;

  const HeroStats({
    required this.strength,
    required this.agility,
    required this.intelligence,
  });

  HeroStats operator +(HeroStats other) => HeroStats(
        strength: strength + other.strength,
        agility: agility + other.agility,
        intelligence: intelligence + other.intelligence,
      );

  HeroStats operator -(HeroStats other) => HeroStats(
        strength: strength - other.strength,
        agility: agility - other.agility,
        intelligence: intelligence - other.intelligence,
      );

  HeroStats operator *(double operand) => HeroStats(
        strength: strength * operand,
        agility: agility * operand,
        intelligence: intelligence * operand,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeroStats &&
          runtimeType == other.runtimeType &&
          strength == other.strength &&
          agility == other.agility &&
          intelligence == other.intelligence;

  @override
  int get hashCode => strength.hashCode ^ agility.hashCode ^ intelligence.hashCode;

  /// convert to list of stats scale
  List<HeroScale> get scales {
    return [
      HeroScale(
        color: Colors.red,
        label: 'strength',
        angle: degreesToRadians(0),
        value: strength,
      ),
      HeroScale(
        color: Colors.green,
        label: 'agility',
        angle: degreesToRadians(120),
        value: agility,
      ),
      HeroScale(
        color: Colors.blue,
        label: 'intelligence',
        angle: degreesToRadians(240),
        value: intelligence,
      ),
    ];
  }
}

/// Hero stat scale model
class HeroScale {
  final String label;
  final Color color;
  final double angle;
  final double value;

  HeroScale({
    required this.label,
    required this.angle,
    required this.color,
    required this.value,
  });
}

/// Draws radial scale and fills with [HeroStats]
/// Animates on [HeroStats] changes
class AnimatedHeroStatsGraph extends StatefulWidget {
  final HeroStats stats;
  final Duration duration;
  final Curve curve;

  const AnimatedHeroStatsGraph({
    Key? key,
    required this.stats,
    required this.duration,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  State<AnimatedHeroStatsGraph> createState() => _AnimatedHeroStatsGraphState();
}

class _AnimatedHeroStatsGraphState extends State<AnimatedHeroStatsGraph>
    with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  );

  late final curve = CurvedAnimation(
    curve: widget.curve,
    parent: controller,
  );

  final tween = Tween<HeroStats>(
    begin: HeroStats.zero,
    end: HeroStats.zero,
  );

  late final Animation<HeroStats> animation = tween.animate(curve);

  @override
  void initState() {
    super.initState();
    shouldRun(widget.stats);
  }

  @override
  void didUpdateWidget(covariant AnimatedHeroStatsGraph oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.duration = widget.duration;
    curve.curve = widget.curve;
    shouldRun(widget.stats);
  }

  void shouldRun(HeroStats stats) {
    if (stats != tween.end) {
      controller.stop();
      tween.begin = animation.value;
      tween.end = stats;
      controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleLarge ?? const TextStyle();
    final color = Theme.of(context).colorScheme.primary.withOpacity(0.3);

    return CustomPaint(
      painter: _HeroStatsGraphScalePainter(
        stats: HeroStats.zero,
        style: style,
      ),
      foregroundPainter: _HeroStatsGraphPainter(
        stats: animation,
        color: color,
        style: style,
      ),
    );
  }
}

double degreesToRadians(num degrees) => degrees * pi / 180.0;

class _HeroStatsGraphScalePainter extends CustomPainter {
  final TextStyle style;
  final HeroStats stats;

  late final scalePaint = Paint()
    ..strokeWidth = 1.0
    ..color = Colors.black;

  late final textPainter = TextPainter(
    text: TextSpan(text: '', style: style),
    textDirection: TextDirection.ltr,
  );

  _HeroStatsGraphScalePainter({
    required this.style,
    required this.stats,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    textPainter.layout();
    final labelHeight = textPainter.height;

    final radius = size.shortestSide / 2 - labelHeight;

    final scales = stats.scales;

    _drawScaleLines(canvas, center, scales, radius);
    _drawScaleMarks(canvas, center, scales, radius);
    _drawLabels(canvas, center, scales, radius, size.width);
  }

  void _drawScaleLines(
    Canvas canvas,
    Offset center,
    List<HeroScale> scales,
    double radius,
  ) {
    for (final scale in scales) {
      canvas.drawLine(
        center,
        Offset(
          center.dx - radius * sin(scale.angle),
          center.dy - radius * cos(scale.angle),
        ),
        scalePaint,
      );
    }
  }

  void _drawScaleMarks(
    Canvas canvas,
    Offset center,
    List<HeroScale> scales,
    double radius,
  ) {
    const shortMark = 2.0;
    const bigMark = 4.0;
    final marks = List.generate(10, (i) => i + 1);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    var currentAngle = 0.0;
    for (final scale in scales) {
      if (scale.angle != 0) {
        canvas.rotate(scale.angle - currentAngle);
        currentAngle = scale.angle;
      }
      for (final mark in marks) {
        final markSize = mark % 5 == 0 ? bigMark : shortMark;
        canvas.drawLine(
          Offset(-markSize, -radius / 10 * mark),
          Offset(markSize, -radius / 10 * mark),
          scalePaint,
        );
      }
    }
    canvas.restore();
  }

  void _drawLabels(
    Canvas canvas,
    Offset center,
    List<HeroScale> scales,
    double radius,
    double width,
  ) {
    for (final scale in scales) {
      textPainter.text = TextSpan(
        text: scale.label,
        style: style.copyWith(color: scale.color),
      );
      textPainter.layout();
      final scaleTail = Offset(
        center.dx - radius * sin(scale.angle),
        center.dy - radius * cos(scale.angle),
      );

      final labelWidth = textPainter.width;
      final labelHeight = textPainter.height;
      final isCentered = scaleTail.dx == center.dx;
      final isAtLeft = scaleTail.dx < center.dx;

      final dx = isCentered
          ? scaleTail.dx - labelWidth / 2
          : (isAtLeft
              ? (scaleTail.dx - labelWidth).clamp(0.0, scaleTail.dx)
              : min(scaleTail.dx, width - labelWidth));

      final paintAbove = scaleTail.dy < center.dy;
      final dy = paintAbove ? scaleTail.dy - labelHeight : scaleTail.dy;
      textPainter.paint(
        canvas,
        Offset(dx, dy),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is _HeroStatsGraphScalePainter) {
      return oldDelegate.style != style;
    }
    return true;
  }
}

class _HeroStatsGraphPainter extends CustomPainter {
  final Animation<HeroStats> stats;
  final Color color;
  final TextStyle style;

  late final statsPaint = Paint()
    ..color = color
    ..style = PaintingStyle.fill;

  late final textPainter = TextPainter(
    text: TextSpan(text: '', style: style),
    textDirection: TextDirection.ltr,
  );

  _HeroStatsGraphPainter({
    required this.stats,
    required this.color,
    required this.style,
  }) : super(repaint: stats);

  @override
  void paint(Canvas canvas, Size size) {
    textPainter.layout();
    final labelHeight = textPainter.height;

    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - labelHeight;
    final scales = stats.value.scales;

    final path = Path();
    var isFirst = true;
    for (final scale in scales) {
      final value = scale.value / 100;
      final point = Offset(
        center.dx - radius * sin(scale.angle) * value,
        center.dy - radius * cos(scale.angle) * value,
      );
      if (isFirst) {
        isFirst = false;
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    canvas.drawPath(path, statsPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is _HeroStatsGraphPainter) {
      return oldDelegate.style != style;
    }
    return true;
  }
}

//--------------------------------------------------------------------------------------------------

/// Showcase of [AnimatedBouncy] usage
class ShowcaseAnimatedBouncy extends StatefulWidget {
  const ShowcaseAnimatedBouncy({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowcaseAnimatedBouncy> createState() => _ShowcaseAnimatedBouncyState();
}

class _ShowcaseAnimatedBouncyState extends State<ShowcaseAnimatedBouncy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShowcaseAnimatedBouncy'),
      ),
      body: const Center(
        child: AnimatedBouncy(
          child: ColoredCircle(
            size: 128,
            color: Colors.indigo,
          ),
        ),
      ),
    );
  }
}

class AnimatedBouncy extends StatefulWidget {
  final Widget child;

  const AnimatedBouncy({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AnimatedBouncy> createState() => _AnimatedBouncyState();
}

class _AnimatedBouncyState extends State<AnimatedBouncy> with SingleTickerProviderStateMixin {
  late final controller = AnimationController.unbounded(
    vsync: this,
  );

  final tween = Tween<Offset>(
    begin: Offset.zero,
    end: Offset.zero,
  );

  late final Animation<Offset> animation = tween.animate(controller);

  var offset = Offset.zero;

  @override
  void initState() {
    super.initState();
    animation.addListener(() {
      setState(() {
        offset = animation.value;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: GestureDetector(
        onPanUpdate: (update) {
          print('onPanUpdate');
          controller.stop();
          setState(() {
            offset = offset.translate(
              update.delta.dx,
              update.delta.dy,
            );
          });
        },
        onPanEnd: (update) {
          print('onPanEnd');
          tween.begin = offset;
          controller.animateWith(
            SpringSimulation(
              _springDescription(),
              0.0,
              1.0,
              (tween.begin! - tween.end!).distance / 128,
              tolerance: _kFlingTolerance,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

SpringDescription _springDescription() => SpringDescription.withDampingRatio(
      mass: 1,
      stiffness: Stiffness.medium,
      ratio: DampingRatio.highBouncy,
    );

const Tolerance _kFlingTolerance = Tolerance(
  velocity: double.infinity,
  distance: 0.00001,
);

class DampingRatio {
  static const highBouncy = 0.15;
  static const mediumBouncy = 0.5;
  static const lowBouncy = 0.75;
  static const noBouncy = 1.0;
}

class Stiffness {
  static const veryHigh = 10000.0;
  static const high = 5000.0;
  static const medium = 1500.0;
  static const low = 200.0;
  static const veryLow = 50.0;
}
