import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Demo/reverse_model.dart';

class ReversePaginationListView extends StatefulWidget {
  final List<ListItem> items;

  const ReversePaginationListView({super.key, required this.items});

  @override
  _ReversePaginationListViewState createState() => _ReversePaginationListViewState();
}

class _ReversePaginationListViewState extends State<ReversePaginationListView> {
  final ScrollController _scrollController = ScrollController();
  int _currentMaxIndex = 0;
  bool _loadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _loadingMore = true;
      });
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    // Simulate loading more data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _loadingMore = false;
      _currentMaxIndex += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: ListView.builder(
            controller: _scrollController,
            reverse: true,
            itemCount: _currentMaxIndex + 10,
            itemBuilder: (context, index) {
              if (index == _currentMaxIndex + 9) {
                if (_loadingMore) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              } else {
                return ListTile(
                  title: Text(widget.items[index].title),
                  subtitle: Text(widget.items[index].subtitle),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
