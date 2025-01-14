import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailTail extends StatefulWidget {
  const DetailTail({super.key});

  @override
  State<DetailTail> createState() => _DetailTailState();
}

class _DetailTailState extends State<DetailTail> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar cho phép ảnh cuộn lên khi người dùng kéo
          SliverAppBar(
            expandedHeight: 260,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/demo.jpg',
                fit: BoxFit.cover,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: CircleAvatar(
                  backgroundColor: Colors.lightGreen[300],
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.transparent, // AppBar trong suốt
            elevation: 0, // Loại bỏ bóng của AppBar
            shadowColor: Colors.transparent,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.lightGreen[300],
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),

          // Nội dung bên dưới sẽ cuộn và có thể đè lên ảnh
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Paradise Hyderabadi Biryani',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Chawala Chicken, Crossing Republic',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Free Delivery',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            '\$13.00',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.orange, size: 20),
                              SizedBox(width: 4),
                              Text('4.7 Rating'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.favorite, color: Colors.red, size: 20),
                              SizedBox(width: 4),
                              Text('200 Favourite'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.photo, color: Colors.grey, size: 20),
                              SizedBox(width: 4),
                              Text('24 Photo'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'DETAILS',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),
                      Text(
                        'The name biryani itself brings water in your mouth. It is a one-pot meat dish that can fill your stomach itself...',
                      ),

                      // Add more content if necessary
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
