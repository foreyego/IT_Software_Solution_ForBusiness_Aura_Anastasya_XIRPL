import 'package:flutter/material.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  List<Map<String, dynamic>> items = [
    {'name': 'Item A', 'category': 'Electronics'},
    {'name': 'Item B', 'category': 'Clothing'},
    {'name': 'Item C', 'category': 'Electronics'},
  ];

  String searchQuery = '';
  String selectedCategory = 'All';
  int _currentIndex = 1; // index untuk Items

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  void _addOrEditItem({Map<String, dynamic>? item, int? index}) {
    if (item != null) {
      _nameController.text = item['name'];
      _categoryController.text = item['category'];
    } else {
      _nameController.clear();
      _categoryController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(item != null ? 'Edit Item' : 'Add Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: _categoryController, decoration: const InputDecoration(labelText: 'Category')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final newItem = {
                'name': _nameController.text,
                'category': _categoryController.text,
              };
              setState(() {
                if (item != null && index != null) {
                  items[index] = newItem;
                } else {
                  items.add(newItem);
                }
              });
              Navigator.pop(context);
            },
            child: Text(item != null ? 'Update' : 'Add'),
          ),
        ],
      ),
    );
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredItems = items
        .where((item) =>
            (selectedCategory == 'All' || item['category'] == selectedCategory) &&
            item['name'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    final primaryColor = Colors.deepOrange.shade400;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // <- ini yang menonaktifkan tombol back
        title: const Text("Items"),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _addOrEditItem(),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search bar & Filter
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search item...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: selectedCategory,
                  items: ['All', 'Electronics', 'Clothing']
                      .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedCategory = value;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // List Items
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    child: ListTile(
                      title: Text(item['name']),
                      subtitle: Text("Category: ${item['category']}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _addOrEditItem(item: item, index: index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteItem(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/dashboard');
          }
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: 'Items',
          ),
        ],
      ),
    );
  }
}
