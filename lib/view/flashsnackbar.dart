import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSnackBarContent extends StatelessWidget {
  final String errorText;
  final String errorHeadline;
  final Color colorcontainer;
  final Color colorbubble;
  final String img;

  const  CustomSnackBarContent({super.key,required this.colorcontainer,required this.errorText,required this.errorHeadline,required this.colorbubble,required this.img});

  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: height/8,
          decoration: BoxDecoration(
              color: colorcontainer,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Row(
            children: [
              const SizedBox(width: 48,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(errorHeadline,style: TextStyle(fontSize: 18,color: Colors.white),),
                    const Spacer(),
                    Text(errorText,style: TextStyle(color: Colors.white,fontSize: 12,),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20)
                ),
                child: SvgPicture.asset("assets/bubbles.svg",height: height/12,width: 40,color: colorbubble))),
        Positioned(
            top: -14,
            right: 8,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset("assets/downThink.svg",height: 40,color: colorbubble,),
                Positioned(
                    top: 10,
                    child: SvgPicture.asset(img,height: 16,color: Colors.white,))
              ],
            ))
      ],
    );
  }
}