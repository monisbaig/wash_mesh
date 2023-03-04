// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wash_mesh/providers/admin_provider/admin_auth_provider.dart';
//
// import '../providers/admin_provider/place_model.dart';
// import '../widgets/location_input.dart';
//
// class AddPlaceScreen extends StatefulWidget {
//   const AddPlaceScreen({Key? key}) : super(key: key);
//   static const routeName = '/add-place';
//
//   @override
//   State<AddPlaceScreen> createState() => _AddPlaceScreenState();
// }
//
// class _AddPlaceScreenState extends State<AddPlaceScreen> {
//   PlaceLocation? _pickedLocation;
//
//   void _savePlace() {
//     if (_pickedLocation == null) {
//       return;
//     }
//     Provider.of<AdminAuthProvider>(context, listen: false)
//         .addPlace(_pickedLocation!);
//     Navigator.of(context).pop();
//   }
//
//   void _selectedPlace(double lat, double lng) {
//     _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add a New Place'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Column(
//                   children: [
//                     LocationInput(_selectedPlace),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           TextButton.icon(
//             onPressed: _savePlace,
//             icon: const Icon(Icons.add),
//             label: const Text('Add Place'),
//             style: TextButton.styleFrom(
//               elevation: 0,
//               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//               padding: const EdgeInsets.all(15),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
