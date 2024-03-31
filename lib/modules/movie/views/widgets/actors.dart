import 'package:flutter/material.dart';

class ActorsWidget extends StatelessWidget {
  const ActorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 140,
          child: ListView(
            padding: const EdgeInsets.all(0),
            scrollDirection: Axis.horizontal,
            children: const [
              SizedBox(width:5),
              _ActorItem(
                imageUrl: 'assets/images/image9.png',
                name: 'Jason Statham',
                role: 'Mr.Clay',
              ),
              _ActorItem(
                imageUrl: 'assets/images/image2.png',
                name: 'Edwin Hodge',
                role: 'Derek',
              ),
               _ActorItem(
                imageUrl: 'assets/images/image3.png',
                name: 'Betty Gabriel',
                role: 'Lazarus',
              ),
              _ActorItem(
                imageUrl: 'assets/images/image4.png',
                name: 'Julian Soria',
                role: 'Server',
              ),
               _ActorItem(
                imageUrl: 'assets/images/image5.png',
                name: 'M.Wiliamson',
                role: 'President',
              ),
              _ActorItem(
                imageUrl: 'assets/images/image6.png',
                name: 'M. Wallace',
                role: 'Sear',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActorItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String role;

  const _ActorItem({
    required this.imageUrl,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Column(
        children: [
          SizedBox(
            height: 90,
            width: 90,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Text(
            name,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 10,
              height:1,
            ),
          ),
          const SizedBox(height:4),
          Text(
            role,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}
