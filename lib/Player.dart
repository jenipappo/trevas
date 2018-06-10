import 'package:flutter/material.dart';

class Player{

  var _nome, _classe, _vida,_iP, _pontosHeroicos, _magia, _fe, _focus;
  List<Widget> _itens;

  Player(var nome, var classe, var vida, var iP, var pontosHeroicos, List<Widget> itens, var magia, var fe, var focus)
  {
    this._nome = nome;
    this._classe = classe;
    this._vida = vida + pontosHeroicos; //para o jogo de Edson
    //this._vida = vida;
    this._iP = iP;
    //this._pontosHeroicos = pontosHeroicos;
    this._itens = itens;
    this._magia = magia;
    this._fe = fe;
    this._focus = focus;

  }

  void receiveDamage(int dano)
  {
    this._vida -= dano;
  }

  void doingMagic(int mp)
  {
    this._magia -= mp;
  }

  void applyDamage()
  {

  }




}