import 'package:quiver/core.dart' show hash2;


class Oid {
  static final Oid _root = new Oid._internal(null, null);

  final Oid parent;
  final int node;
  final Map<int, Oid> _children = new Map<int, Oid>();

  int get length => parent == null ? 1 : parent.length + 1;
  bool get isLeaf => _children.isEmpty;

  factory Oid(String construct) {
    final nodes = construct.split('.');

    Oid oid = _root;
    for (var node in nodes) {
      oid = oid.getChild(int.parse(node));
    }

    return oid;
  }

  Oid._internal(this.parent, this.node);

  Oid getChild(int childNode) {
    return _children.putIfAbsent(childNode, () => new Oid._internal(this, childNode));
  }

  bool isChildOf(Oid oid) {
    if (oid == this.parent) return true;
    if (oid.length >= this.parent.length) return false;
    return this.parent.isChildOf(oid);
  }

  @override
  String toString() {
    return parent == _root ? node.toString() :
      this.parent.toString() + "." + node.toString();
  }

 @override
  int get hashCode => hash2(node, parent);

  @override
  bool operator ==(other) {
    if (!(other is Oid)) return false;
    return node == other.node && parent == other.parent;
  }
}
