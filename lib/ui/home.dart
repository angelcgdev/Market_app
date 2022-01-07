import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/const/const.dart';
import 'package:store_app/data/products.dart';
import 'package:store_app/provider/category.dart';
import 'package:store_app/ui/widgets/card_product.dart';
import 'package:store_app/ui/widgets/drawer.dart';
import 'package:store_app/ui/widgets/hamburger_button.dart';
import 'package:store_app/ui/widgets/search_buttom.dart';
import 'package:store_app/ui/widgets/title.dart';

enum category {
  clocks,
  perfumes,
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late ThemeData _theme;
  late AnimationController _animationController;
  final _sizeHamburguerMenu = 55.0;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.addListener(_animationControllerListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = Theme.of(context);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.removeListener(_animationControllerListener);
    _animationController.dispose();
  }

  void _animationControllerListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _theme.backgroundColor,
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        MyTitle(sizeHamburguerMenu: _sizeHamburguerMenu),
        Body(sizeHamburguerMenu: _sizeHamburguerMenu),
        SearchButton(sizeHamburguerMenu: _sizeHamburguerMenu, theme: _theme),
        MyDrawer(animationController: _animationController),
        HamburgerMenuButton(
          sizeButtom: _sizeHamburguerMenu,
          animationController: _animationController,
        ),
      ],
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required double sizeHamburguerMenu,
    // required category category,
  })  : _sizeHamburguerMenu = sizeHamburguerMenu,
        // _category = category,
        super(key: key);

  final double _sizeHamburguerMenu;
  // final category _category;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _sizeHamburguerMenu + defaultPadding,
      left: 0,
      right: 0,
      bottom: 0,
      child: Consumer<CategoryProvider>(
        builder: (context, value, _) {
          return SafeArea(
            child: Column(
              children: [
                if (value.getCategory == category.perfumes) const PerfumesView(),
                if (value.getCategory == category.clocks) const ClocksView(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PerfumesView extends StatelessWidget {
  const PerfumesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(defaultPadding),
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: defaultPadding * .3,
          mainAxisSpacing: defaultPadding,
          mainAxisExtent: _size.width * .85,
        ),
        itemCount: perfumes.length,
        itemBuilder: (BuildContext context, int i) {
          return CardProduct( order: i,data: perfumes[i], maxHeight: _size.width * .85);
        },
      ),
    );
  }
}

class ClocksView extends StatelessWidget {
  const ClocksView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(defaultPadding),
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: defaultPadding * .3,
          mainAxisSpacing: defaultPadding,
          mainAxisExtent: _size.width * .85,
        ),
        itemCount: clocks.length,
        itemBuilder: (BuildContext context, int i) {
          return CardProduct(order: i,data: clocks[i], maxHeight: _size.width * .85);
        },
      ),
    );
  }
}
