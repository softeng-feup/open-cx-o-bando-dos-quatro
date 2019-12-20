import 'package:flutter_test/flutter_test.dart';
import 'package:confview/graph.dart';
import 'package:confview/map_data.dart';

void main(){
  test('Nodes should start empty', () {
    final graph = Graph();
    expect(graph.getNodes().length, 0);
  });

  test('Edges should start empty', () {
    final graph = Graph();

    expect(graph.getEdges().length, 0);
  });

  test('Adding one node', () {
    final graph = Graph();
    graph.addNode(Node(1,"teste","",0,0));
    expect(graph.getNodes().length, 1);
  });
  test('Adding two nodes', () {
    final graph = Graph();
    graph.addNode(Node(1,"teste","",0,0));
    graph.addNode(Node(2,"teste","",0,0));
    expect(graph.getNodes().length, 2);
  });
  test('Adding two nodes with same id, only allow one', () {
    final graph = Graph();
    graph.addNode(Node(1,"teste","",0,0));
    graph.addNode(Node(1,"teste","",0,0));
    expect(graph.getNodes().length, 1);
  });
  test('Get node info', () {
    final graph = Graph();
    graph.addNode(Node(1,"teste1","",0,0));
    graph.addNode(Node(2,"teste2","",0,0));
    expect(graph.getNode(2).getName(), "teste2");
  });
  test('Adding one edge , returning 2 because os bidirectional edges', () {
    final graph = Graph();
    graph.addNode(Node(1,"teste1","",0,0));
    graph.addNode(Node(2,"teste2","",0,0));
    graph.addEdge(1, 2);
    expect(graph.getEdges().length, 2);
  });
  test('Adding edges of not existing nodes , part 1', () {
    final graph = Graph();
    graph.addNode(Node(1,"teste1","",0,0));
    graph.addNode(Node(2,"teste2","",0,0));
    graph.addEdge(1, 3);
    expect(graph.getEdges().length, 0);
  });
  test('Adding edges of not existing nodes , part 2', () {
    final graph = Graph();
    graph.addNode(Node(1,"teste1","",0,0));
    graph.addNode(Node(2,"teste2","",0,0));
    graph.addEdge(5, 2);
    expect(graph.getEdges().length, 0);
  });

}