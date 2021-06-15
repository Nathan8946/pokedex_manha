import 'package:flutter/material.dart';
import 'package:infinite_widgets/infinite_widgets.dart';
import '../controllers/home_controller.dart';
import '../pages/detail_page.dart';
import '../repositories/poke_repository_impl.dart';
import '../widgets/poke_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController(PokeRepositoryImpl());
  bool search = false;

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  Future<void> _initialize() async {
    await _controller.fetch();
    setState(() {});
  }

  Future<void> _filter(String name) async {
    await _controller.filter(name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        child: InfiniteGridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: _buildPokemonCard,
          itemCount: _controller.length,
          hasNext: _controller.length < 1118,
          nextData: _onNextData,
          shrinkWrap: true,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: !search
          ? Text(
              'Pokedex',
              style: TextStyle(
                fontFamily: 'PokemonSolid', 
                color: Colors.black,
                ),
            )
          : TextField(
              style:
                  TextStyle(color: Colors.white, fontFamily: "PokemonHollow"),
              decoration: InputDecoration(
                hintText: "Buscar pokemon...",
                hintStyle:
                    TextStyle(color: Colors.white, fontFamily: "PokemonHollow"),
                icon: Icon(Icons.search, color: Colors.white),
              ),
              autofocus: true,
              onChanged: (name) {
                _filter(name);
              },
            ),
      centerTitle: true,
      backgroundColor: Colors.red.shade800,
      iconTheme: IconThemeData(color: Colors.white),
      actions: <Widget>[
        search
            ? Container(
                margin: EdgeInsets.only(right: 5),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      this.search = false;
                    });
                  },
                ),
              )
            : Container(
                margin: EdgeInsets.only(right: 5),
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.search = true;
                    });
                  },
                ),
              ),
      ],
    );
  }

  void _onNextData() async {
    await _controller.next();
    setState(() {});
  }

  Widget _buildPokemonCard(BuildContext context, int index) {
    final pokemon = _controller.pokemons[index];
    return PokeCard(
      pokemon: pokemon,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DetailPage(
              pokemon: pokemon,
            ),
          ),
        );
      },
    );
  }
}
