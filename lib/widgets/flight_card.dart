import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/flight_model.dart'; 

class FlightCard extends StatelessWidget {
  final FlightTrip? flight;

  const FlightCard({Key? key, this.flight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (flight == null) return const SizedBox.shrink();

    final journeys = flight!.flightJourneys ?? [];
    final fareDetails = flight!.fareDetails;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                for (int i = 0; i < journeys.length; i++) ...[
                  _buildJourneySection(journeys[i], i),
                  if (i < journeys.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Return Flight',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),
                    ),
                ],
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 183, 220, 239), 
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (_) {
                    final isRefundable =
                        flight!.additionalFares?.any(
                              (f) => f.isRefundable == true,
                            ) ??
                            false;
                    return Text(
                      isRefundable ? 'Refundable' : 'Non Refundable',
                      style: TextStyle(
                        color: isRefundable ? Colors.green : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
                if (fareDetails?.total != null)
                  Text(
                    '${fareDetails!.currency ?? 'EGP'} ${fareDetails!.total}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJourneySection(FlightJourney journey, int journeyIndex) {
    final flightItems = journey.flightItems ?? [];
    if (flightItems.isEmpty) return const SizedBox.shrink();

    final firstSegment = flightItems.first;
    final lastSegment = flightItems.last;

    final airlineCode = firstSegment.flightInfo?.code ?? 'XX';
    final airlineName = firstSegment.flightInfo?.name?.en ?? 'Unknown Airline';
    final flightNumber = firstSegment.flightInfo?.number ?? '';
    final logoUrl =
        'https://booksultanuat.caxita.ca/images/AirlineIcons/$airlineCode.png';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            
            Flexible( 
              flex: 2, 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: logoUrl,
                        width: 32,
                        height: 32,
                        placeholder: (context, url) =>
                            _airlinePlaceholder(airlineCode),
                        errorWidget: (context, url, error) =>
                            _airlinePlaceholder(airlineCode),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              airlineName,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '$airlineCode $flightNumber',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Departure',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(firstSegment.departure?.dateTime),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    firstSegment.departure?.airportCode ?? '',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  if ((firstSegment.departure?.cityName?.en ?? '').isNotEmpty)
                    Text(
                      firstSegment.departure?.cityName?.en ?? '',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                ],
              ),
            ),

            Expanded( 
              flex: 3, 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 38), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return CustomPaint(
                                size: Size(constraints.maxWidth, 2),
                                painter: DashedLinePainter(),
                              );
                            },
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.flight_takeoff,
                        color: Colors.orange,
                        size: 20,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return CustomPaint(
                                size: Size(constraints.maxWidth, 2),
                                painter: DashedLinePainter(),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8), 

                  Column(
                    children: [
                      if (journey.journeyTime != null)
                        Text(
                          journey.journeyTime!.formatted,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      if (journey.totalStops != null && journey.totalStops! > 0)
                        Text(
                          '${journey.totalStops} Stop${journey.totalStops! > 1 ? 's' : ''}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        )
                      else
                        Text(
                          'Direct',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            Flexible( 
              flex: 2, 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 38), 
                   Text(
                    'Arrival',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(lastSegment.arrival?.dateTime),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    lastSegment.arrival?.airportCode ?? '',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  if ((lastSegment.arrival?.cityName?.en ?? '').isNotEmpty)
                    Text(
                      lastSegment.arrival?.cityName?.en ?? '',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                ],
              ),
            ),
          ],
        ),

        if (journey.dayChange == true) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Next day arrival',
              style: TextStyle(
                color: Colors.orange[800],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _airlinePlaceholder(String airlineCode) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          airlineCode.length >= 2 ? airlineCode.substring(0, 2) : airlineCode,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '--:--';
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.orange 
      ..strokeWidth = 1.5 
      ..strokeCap = StrokeCap.round;

    const double dashWidth = 5; 
    const double dashSpace = 4; 
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, size.height / 2),
          Offset(startX + dashWidth, size.height / 2), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}