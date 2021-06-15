import 'package:flutter/material.dart';
import '../helpers/poke_helper.dart';
import '../models/pokemon_model.dart';
import '../widgets/metric_tile.dart';
import '../widgets/poke_header.dart';
import '../widgets/poke_stat_bar.dart';
import '../widgets/poke_type_chip.dart';

class DetailPage extends StatefulWidget {
  final PokemonModel? pokemon;

  const DetailPage({
    Key? key,
    this.pokemon,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        widget.pokemon!.name,
        style: TextStyle(
          fontFamily: 'PokemonHollow',
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: PokeHelper.getColor(widget.pokemon!.type1),
      iconTheme: IconThemeData(color: Colors.black),
      actions: [
        Container(
          height: 52,
          width: 80,
          child: Center(
            child: Text(
              '#${widget.pokemon!.id.toString().padLeft(4, '0')}',
              style: TextStyle(
                fontFamily: 'PokemonSolid',
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PokeHeader(
          backgroundColor: PokeHelper.getColor(widget.pokemon!.type1),
          imageUrl: widget.pokemon!.imageUrl,
        ),
        _buildTypes(),
        _buildMetrics(),
        _buildStats(),
      ],
    );
  }

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'Estatísticas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          PokeStatBar(
            label: 'HP',
            value: widget.pokemon!.health,
            foregroundColor: PokeHelper.getColor(widget.pokemon!.type1),
          ),
          PokeStatBar(
            label: 'ATK',
            value: widget.pokemon!.attack,
            foregroundColor: PokeHelper.getColor(widget.pokemon!.type1),
          ),
          PokeStatBar(
            label: 'DEF',
            value: widget.pokemon!.defense,
            foregroundColor: PokeHelper.getColor(widget.pokemon!.type1),
          ),
          PokeStatBar(
            label: 'SPCATK',
            value: widget.pokemon!.specialAttack,
            foregroundColor: PokeHelper.getColor(widget.pokemon!.type1),
          ),
          PokeStatBar(
            label: 'SPCDEF',
            value: widget.pokemon!.specialDefense,
            foregroundColor: PokeHelper.getColor(widget.pokemon!.type1),
          ),
          PokeStatBar(
            label: 'SPD',
            value: widget.pokemon!.speed,
            foregroundColor: PokeHelper.getColor(widget.pokemon!.type1),
          ),
        ],
      ),
    );
  }

  Widget _buildTypes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PokeTypeChip(type: widget.pokemon!.type1),
        widget.pokemon!.type2 != null ? SizedBox(width: 20) : SizedBox(),
        widget.pokemon!.type2 != null
            ? PokeTypeChip(type: widget.pokemon!.type2)
            : SizedBox(),
      ],
    );
  }

  Widget _buildMetrics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: MetricTile(
            value: widget.pokemon!.weight / 10,
            unit: 'kg',
            label: 'Peso',
          ),
        ),
        Expanded(
          child: MetricTile(
            value: widget.pokemon!.height / 10,
            unit: 'm',
            label: 'Altura',
          ),
        ),
      ],
    );
  }
}