import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditItemPage extends StatefulWidget {
  final Map<String, dynamic> item;
  final Function(Map<String, dynamic>) onSave;
  final Function()? onDelete;

  EditItemPage({
    required this.item,
    required this.onSave,
    this.onDelete,
  });

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _price;
  late String _size;
  late String _quantity;
  late String _description;
  String? _image;
  String? _imageError;

  final List<String> _sizeOptions = ['XS', 'S', 'M', 'L', 'XL'];

  @override
  void initState() {
    super.initState();
    _name = widget.item['name'] ?? '';
    _price = widget.item['price'] ?? '';
    _size = widget.item['size'] ?? _sizeOptions[0];
    _quantity = widget.item['quantity'] ?? '';
    _description = widget.item['description'] ?? '';
    _image = widget.item['image'];
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile.path;
        _imageError = null;
      });
    }
  }

  void _saveItem() {
    setState(() {
      _imageError = _image == null ? 'Please pick an image' : null;
    });

    if (_formKey.currentState!.validate() && _image != null) {
      _formKey.currentState!.save();
      final newItem = {
        'name': _name,
        'price': _price,
        'size': _size,
        'quantity': _quantity,
        'description': _description,
        'image': _image,
      };
      if (widget.item.containsKey('index')) {
        newItem['index'] = widget.item['index'];
      }
      widget.onSave(newItem);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.item.containsKey('index') ? 'Edit Item' : 'Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _price,
                decoration: InputDecoration(labelText: 'Price (BHD)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  if (double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Please enter a valid number greater than 0';
                  }
                  return null;
                },
                onSaved: (value) => _price = value!,
              ),
              DropdownButtonFormField<String>(
                value: _size,
                decoration: InputDecoration(labelText: 'Size'),
                items: _sizeOptions.map((String size) {
                  return DropdownMenuItem<String>(
                    value: size,
                    child: Text(size),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _size = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a size';
                  }
                  return null;
                },
                onSaved: (value) => _size = value!,
              ),
              TextFormField(
                initialValue: _quantity,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => _quantity = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value!,
              ),
              SizedBox(height: 16.0),
              _image != null
                  ? kIsWeb
                      ? Image.network(
                          _image!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(_image!),
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                  : Container(),
              TextButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              if (_imageError != null)
                Text(
                  _imageError!,
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveItem,
                child: Text('Save'),
              ),
              if (widget.onDelete != null)
                TextButton(
                  onPressed: () {
                    widget.onDelete!();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
