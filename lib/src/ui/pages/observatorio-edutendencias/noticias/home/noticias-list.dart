import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/models/noticia.dart';
import 'package:innovaciondocente_app/src/ui/pages/observatorio-edutendencias/noticias/home/noticia-card.dart';

class NoticiasList extends SliverChildDelegate {
  final List<Noticia> noticias;

  const NoticiasList({
    @required this.noticias,
  });

  @override
  int get estimatedChildCount => noticias.length;

  @override
  Widget build(BuildContext context, int index) => NoticiaCard(noticia: noticias[index]);

  @override
  bool shouldRebuild(SliverChildDelegate oldDelegate) => this != oldDelegate;
}
