import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UserMessage extends StatelessWidget {
  const UserMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            SizedBox(height: 20.h),
            Container(
              width: 285.w,
              constraints: BoxConstraints(
                minHeight: 50.h, // Initial minimum height
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                color: Colors.purple[400],
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                    10.0), // Padding to prevent text from sticking to edges
                child: Text(
                  "لا مشكلة , عنوان المنزل هو  الحى العاشر مدينة نصر",
                  style: GoogleFonts.cairo(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight:
                            FontWeight.w400), // Optional: change the text style
                  ),
                ),
              ),
            ),
            Text(
              "08:16 AM",
              style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0XFF7A7A7A))),
            ),
          ],
        ),
      ],
    );
  }
}
