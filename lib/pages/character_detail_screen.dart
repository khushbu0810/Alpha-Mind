import 'package:after_layout/after_layout.dart';
import 'package:alpha_mind/models/character.dart';
import 'package:alpha_mind/widgets/styleguide.dart';
import 'package:flutter/material.dart';

class CharacterDetailScreen extends StatefulWidget {
  final double _expandedBottomSheetBottomPosition = 0;
  final double _collapsedBottomSheetBottomPosition = -250;
  final double _completeCollapsedBottomSheetBottomPosition = -330;
  final Character character;

  const CharacterDetailScreen({Key? key, required this.character})
      : super(key: key);

  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen>
    with AfterLayoutMixin<CharacterDetailScreen> {
  double _bottomSheetBottomPosition = -330;
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Hero(
            tag: "background-${widget.character.name}",
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.character.colors,
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16),
                  child: IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.close),
                    color: Colors.white.withOpacity(0.9),
                    onPressed: () {
                      setState(() {
                        _bottomSheetBottomPosition =
                            widget._completeCollapsedBottomSheetBottomPosition;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Hero(
                      tag: "image-${widget.character.name}",
                      child: Image.asset(widget.character.imagePath,
                          height: screenHeight * 0.45)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
                  child: Hero(
                      tag: "name-${widget.character.name}",
                      child: Material(
                          color: Colors.transparent,
                          child: Container(
                              child: Text(widget.character.name,
                                  style: AppTheme.heading)))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 8, 32),
                  child: Text(widget.character.description,
                      style: AppTheme.subHeading),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
            bottom: _bottomSheetBottomPosition,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: _onTap,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      height: 80,
                      child: Text(
                        "I will help you with..",
                        style:
                            AppTheme.subHeading.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _clipsWidget(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _clipsWidget() {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 22,
                    ),
                    Text(
                      'Reading',
                      style: TextStyle(
                          fontSize: 34,
                          fontFamily: 'Nunito',
                          color: Colors.white),
                    ),
                  ],
                ),
                width: 180,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFFFF585D),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 22,
                    ),
                    Text(
                      'Drawing',
                      style: TextStyle(
                          fontSize: 34,
                          fontFamily: 'Nunito',
                          color: Colors.white),
                    ),
                  ],
                ),
                width: 180,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFF9343D4),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 22,
                    ),
                    Text(
                      'Quizzes',
                      style: TextStyle(
                          fontSize: 34,
                          fontFamily: 'Nunito',
                          color: Colors.white),
                    ),
                  ],
                ),
                width: 180,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.pinkAccent[200],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 22,
                    ),
                    Text(
                      'Puzzles',
                      style: TextStyle(
                          fontSize: 34,
                          fontFamily: 'Nunito',
                          color: Colors.white),
                    ),
                  ],
                ),
                width: 180,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFF5DDEE8),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _onTap() {
    setState(() {
      _bottomSheetBottomPosition = isCollapsed
          ? widget._expandedBottomSheetBottomPosition
          : widget._collapsedBottomSheetBottomPosition;
      isCollapsed = !isCollapsed;
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isCollapsed = true;
        _bottomSheetBottomPosition = widget._collapsedBottomSheetBottomPosition;
      });
    });
  }
}
