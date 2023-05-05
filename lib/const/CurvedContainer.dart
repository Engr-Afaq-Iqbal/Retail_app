import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurvedContainer extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _MyClipper(),
      child: Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      //height: 150,
                      width: MediaQuery.of(context).size.width * 0.7,
                      // width: isPortrait ? 200 : 300,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'searchItem'.tr,
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          filled: true,
                          fillColor: Theme.of(context).backgroundColor,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onChanged: (value) {},
                      )),
                  Icon(
                    Icons.notification_add_outlined,
                    color: kWhiteColor,
                  ),
                  Icon(
                    Icons.add,
                    color: kWhiteColor,
                  )
                ],
              ),
              Row(
                children: [
                  ClipRect(
                    child: CircleAvatar(
                      backgroundColor: kWhiteColor,
                      radius: 32,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Ashiq',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: kWhiteColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
