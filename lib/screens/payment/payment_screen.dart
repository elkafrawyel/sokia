// import 'package:flutter/material.dart';
// import 'package:my_fatoorah/my_fatoorah.dart';
//
// class PaymentScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 0,
//       ),
//       body: Builder(
//         builder: (BuildContext context) {
//           return MyFatoorah(
//             builder: (methods, state, submit) => AppBar(
//               title: Text('دفع ماى فاتورة'),
//               actions: [
//                 IconButton(
//                     icon: Icon(Icons.payment),
//                     onPressed: () {
//                       MyFatoorah.startPayment(
//                         context: context,
//                         errorChild: Center(
//                           child: Icon(
//                             Icons.error,
//                             color: Colors.redAccent,
//                             size: 50,
//                           ),
//                         ),
//                         succcessChild: Center(
//                           child: Icon(
//                             Icons.done_all,
//                             color: Colors.greenAccent,
//                             size: 50,
//                           ),
//                         ),
//                         request: MyfatoorahRequest(
//                           url: 'https://apitest.myfatoorah.com',
//                           token:
//                               'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
//                           currencyIso: Country.SaudiArabia,
//                           successUrl:
//                               'https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png',
//                           errorUrl:
//                               'https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png',
//                           invoiceAmount: 500,
//                           language: ApiLanguage.Arabic,
//                         ),
//                       ).then((response) {
//                         print(response);
//                       }).catchError((e) {
//                         print(e);
//                       });
//                     })
//               ],
//             ),
//             request: MyfatoorahRequest(
//               url: 'https://apitest.myfatoorah.com',
//               token:
//                   'Kex5A9D5fZwk9-3BH_YVyO0b7ondoNgUW1tSmQkS3XCSBIa3Uj_qm19shSgW8VZHjVs5S3RoQIbcQ6XMDLPMUNvRogAlWdk3NfpMFfW1xm4IPxdh9cByXptPmLaEg7EFG9sZDLIxRbrKYXbbliRbI43pXr27nnFOjsvEJwc6c8NLZZfE2_DQugn0rtfDrwqCxICeL0mYtaEokpCFFbz3yN6Jr-Y4F95YUWC6z6NJY-gNANG7RiE8nWJRTTPZNznAZDugmJ2Ggyt5jOY4b-oQEolqRCx9GjwzrtwsgMYCU1TbxSDfvNy340UFhDP39k87hL2ZOcsLhx4a29gRjVwq3hBHzN-rPWT_MaD21-5Te0bkEpAQMb6OIZR7D2AtVTOvKMtaDj7j7w-i7LMLVBhk7Td-CKqfRJ6CX0zBi-F9kcNJJG2PEAxyOIzGphWqgTUfua7fDqX6GPP9ZmqtBG4ax-k0UwZMS2R4_XDrdYOZibniIzGHt1GKLSuXkFMzsHUhQCVwSdt2rkMuP-OTDueFH0MjCtTnOcbmKN7m6HMeJlc4E1RdKZPlgbNmMX-MKlO4bOpuTW0A6GYcyebl9d0F-xGpU20A3_1UJ3JChlC9m-ZImxVDNa6RldmCtznxDi6ak80pcbd7N37J5i91PSY_N5oVh1smKGk_RZ_cGU53pIB0LHjGsxcIo1QkWdwLRM0EtKlX5A',
//               currencyIso: Country.SaudiArabia,
//               successUrl:
//                   'https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png',
//               errorUrl:
//                   'https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png',
//               invoiceAmount: 100,
//               language: ApiLanguage.Arabic,
//             ),
//             errorChild: Center(
//               child: Icon(
//                 Icons.error,
//                 color: Colors.redAccent,
//                 size: 50,
//               ),
//             ),
//             succcessChild: Center(
//               child: Icon(
//                 Icons.done_all,
//                 color: Colors.greenAccent,
//                 size: 50,
//               ),
//             ),
//             onResult: (PaymentResponse res) {
//               Scaffold.of(context).showSnackBar(SnackBar(
//                 content: Text(res.status.toString()),
//               ));
//             },
//           );
//         },
//       ),
//     );
//   }
// }
