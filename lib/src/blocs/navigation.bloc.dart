import 'dart:async';
import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/blocs/bloc-provider.bloc.dart';
import 'package:innovaciondocente_app/src/models/navigation.model.dart';

class NavigationBloc implements BlocBase {
  /// Streams to handle the navigation
  StreamController<List<IndevSection>> _navigationController =
      StreamController<List<IndevSection>>();
  Sink<List<IndevSection>> get _inNavigation => _navigationController.sink;
  Stream<List<IndevSection>> get outNavigation => _navigationController.stream;

  // Streams to handle the update state of the navigation
  StreamController<String> _navigationUpdateController = StreamController<String>();
  Sink<String> get uptateNavigation => _navigationUpdateController.sink;

  NavigationBloc() {
    // TODO: check if first state is necesary
    _inNavigation.add(_genRoutes('/'));
    _navigationUpdateController.stream.listen(_updateNavigation);
  }

  @override
  void dispose() {
    _navigationController.close();
    _navigationUpdateController.close();
  }

  void _updateNavigation(data) {
    _inNavigation.add(_genRoutes(data));
  }

  List<IndevSection> _genRoutes(String path) {
    return [
      IndevSection(
        routes: [
          IndevRoute(
            name: 'Inicio',
            route: '/',
            path: path,
            icon: Icons.home,
          ),
        ],
      ),
      IndevSection(
        name: 'Innovación Docente',
        routes: [
          IndevRoute(
            name: 'Buenas Prácticas',
            path: path,
            route: '/',
            icon: Icons.folder_special,
          ),
          IndevRoute(
            name: 'Proyectos Actuales',
            path: path,
            route: '/',
            icon: Icons.folder_special,
          ),
        ],
      ),
      IndevSection(
        name: 'Formación Docente',
        routes: [
          IndevRoute(
            name: 'Progama de Formación',
            path: path,
            route: '/formacion-docente/programa-formacion',
            icon: Icons.school,
          ),
          IndevRoute(
            name: 'Café Científico',
            path: path,
            route: '/formacion-docente/cafe-cientifico/encuentros',
            icon: Icons.chat,
          ),
        ],
      ),
      IndevSection(
        name: 'Observatorio EduTendencias',
        routes: [
          IndevRoute(
            name: 'Noticias',
            path: path,
            route: '/observatorio-edutendencias/noticias',
            icon: Icons.new_releases,
          ),
          IndevRoute(
            name: 'Tips de Innovacion',
            path: path,
            route: '/observatorio-edutendencias/tips',
            icon: Icons.wb_incandescent,
          ),
        ],
      ),
      IndevSection(
        routes: [
          IndevRoute(
            name: 'Información',
            path: path,
            route: '/observatorio-edutendencias/noticias',
            icon: Icons.info,
          ),
        ],
      )
    ];
  }
}
