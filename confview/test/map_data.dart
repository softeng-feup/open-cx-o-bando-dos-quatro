import 'package:confview/map_data.dart' as prefix0;
import 'package:flutter_test/flutter_test.dart';
import 'package:confview/map_data.dart';


void main() {
  test('Node id', () {
    final node = Node(0,"teste","",1,2);
    expect(node.getID(), 0);
  });
  test('Node name', () {
    final node = Node(0,"teste","",1,2);
    expect(node.getName(), "teste");
  });
  test('Node position 1', () {
    final node = Node(0,"teste","url_test",1,2);
    expect(node.getX(), 1);
  });
  test('Node position 2', () {
    final node = Node(0,"teste","",1,2);
    expect(node.getY(), 2);
  });
  test('Node add edge', () {
    final node1 = Node(1,"teste","",1,2);
    final node2 = Node(2,"teste","",1,2);
    final edge = new prefix0.Edge(node1,node2);
    expect(node1.addEdge(edge), true);
  });
  test('Node add edge node not equal', () {
    final node1 = Node(0,"teste","",1,2);
    final node2 = Node(0,"teste","",1,2);
    final edge = new prefix0.Edge(node2,node1);
    expect(node1.addEdge(edge), false);
  });
  test('Node update position 1', () {
    final node = Node(0,"teste","",1,2);
    node.updatePosition(Offset(3,5));
    expect(node.getX(), 4);
  });
  test('Node update position 2', () {
    final node = Node(0,"teste","",1,2);
    node.updatePosition(Offset(3,5));
    expect(node.getY(), 7);
  });

  test('Edge source', () {
    final node1 = Node(0,"teste1","",1,2);
    final node2 = Node(1,"teste2","",1,2);
    final edge = new prefix0.Edge(node1,node2);
    expect(edge.getSrcNode().getID(), 0);
  });
  test('Edge dest', () {
    final node1 = Node(0,"teste1","",1,2);
    final node2 = Node(1,"teste2","",1,2);
    final edge = new prefix0.Edge(node1,node2);
    expect(edge.getDestNode().getID(), 1);
  });
  test('Edge source name', () {
    final node1 = Node(0,"teste1","",1,2);
    final node2 = Node(1,"teste2","",1,2);
    final edge = new prefix0.Edge(node1,node2);
    expect(edge.getScrName(), "teste1");
  });
  test('Edge dest name', () {
    final node1 = Node(0,"teste1","",1,2);
    final node2 = Node(1,"teste2","",1,2);
    final edge = new prefix0.Edge(node1,node2);
    expect(edge.getDestName(), "teste2");
  });
  test('Edge length', () {
    final node1 = Node(0,"teste1","",0,0);
    final node2 = Node(1,"teste2","",4,3);
    final edge = new prefix0.Edge(node1,node2);
    expect(edge.getDistance(), 5);
  });



}