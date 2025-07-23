class FlightModel {
  String? version;
  String? code;
  List<String>? message;
  String? sessionKey;
  Data? data;

  FlightModel({
    this.version,
    this.code,
    this.message,
    this.sessionKey,
    this.data,
  });

  factory FlightModel.fromJson(Map<String, dynamic> json) => FlightModel(
    version: json["Version"],
    code: json["Code"],
    message: (json["Message"] as List?)?.map((x) => x.toString()).toList(),
    sessionKey: json["SessionKey"],
    data: json["Data"] != null ? Data.fromJson(json["Data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "Version": version,
    "Code": code,
    "Message": message,
    "SessionKey": sessionKey,
    "Data": data?.toJson(),
  };
}

class Data {
  int? resultCount;
  bool? polStatus;
  String? currency;
  List<String>? suppliers;
  List<FlightTrip>? flightTrips;

  Data({
    this.resultCount,
    this.polStatus,
    this.currency,
    this.suppliers,
    this.flightTrips,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    resultCount: json["ResultCount"],
    polStatus: json["PolStatus"],
    currency: json["Currency"],
    suppliers: (json["Suppliers"] as List?)?.map((x) => x.toString()).toList(),
    flightTrips: (json["FlightTrips"] as List?)?.map((x) => FlightTrip.fromJson(x)).toList(),
  );

  Map<String, dynamic> toJson() => {
    "ResultCount": resultCount,
    "PolStatus": polStatus,
    "Currency": currency,
    "Suppliers": suppliers,
    "FlightTrips": flightTrips?.map((x) => x.toJson()).toList(),
  };
}

class FlightTrip {
  dynamic contractIdentifier;
  int? displayOrder;
  String? flightTripKey;
  dynamic galelioPnr;
  dynamic bookingPnr;
  FareDetails? fareDetails;
  List<AdditionalFare>? additionalFares;
  List<FlightJourney>? flightJourneys;
  TripDuration? tripDuration;
  int? tripDirection;
  String? compareKey;
  bool? isPreferredDeal;
  bool? isLcc;
  bool? isFlightAvail;

  FlightTrip({
    this.contractIdentifier,
    this.displayOrder,
    this.flightTripKey,
    this.galelioPnr,
    this.bookingPnr,
    this.fareDetails,
    this.additionalFares,
    this.flightJourneys,
    this.tripDuration,
    this.tripDirection,
    this.compareKey,
    this.isPreferredDeal,
    this.isLcc,
    this.isFlightAvail,
  });

  factory FlightTrip.fromJson(Map<String, dynamic> json) => FlightTrip(
    contractIdentifier: json["ContractIdentifier"],
    displayOrder: json["DisplayOrder"],
    flightTripKey: json["FlightTripKey"],
    galelioPnr: json["GalelioPnr"],
    bookingPnr: json["BookingPnr"],
    fareDetails: json["FareDetails"] != null ? FareDetails.fromJson(json["FareDetails"]) : null,
    additionalFares: (json["AdditionalFares"] as List?)?.map((x) => AdditionalFare.fromJson(x)).toList(),
    flightJourneys: (json["FlightJourneys"] as List?)?.map((x) => FlightJourney.fromJson(x)).toList(),
    tripDuration: json["TripDuration"] != null ? TripDuration.fromJson(json["TripDuration"]) : null,
    tripDirection: json["TripDirection"],
    compareKey: json["CompareKey"],
    isPreferredDeal: json["IsPreferredDeal"],
    isLcc: json["IsLcc"],
    isFlightAvail: json["IsFlightAvail"],
  );

  Map<String, dynamic> toJson() => {
    "ContractIdentifier": contractIdentifier,
    "DisplayOrder": displayOrder,
    "FlightTripKey": flightTripKey,
    "GalelioPnr": galelioPnr,
    "BookingPnr": bookingPnr,
    "FareDetails": fareDetails?.toJson(),
    "AdditionalFares": additionalFares?.map((x) => x.toJson()).toList(),
    "FlightJourneys": flightJourneys?.map((x) => x.toJson()).toList(),
    "TripDuration": tripDuration?.toJson(),
    "TripDirection": tripDirection,
    "CompareKey": compareKey,
    "IsPreferredDeal": isPreferredDeal,
    "IsLcc": isLcc,
    "IsFlightAvail": isFlightAvail,
  };
}

class FareDetails {
  String? currency;
  String? baseFare;
  String? tax;
  String? service;
  String? total;
  String? grossAmount;

  FareDetails({
    this.currency,
    this.baseFare,
    this.tax,
    this.service,
    this.total,
    this.grossAmount,
  });

  factory FareDetails.fromJson(Map<String, dynamic> json) => FareDetails(
    currency: json["Currency"],
    baseFare: json["BaseFare"],
    tax: json["Tax"],
    service: json["Service"],
    total: json["Total"],
    grossAmount: json["GrossAmount"],
  );

  Map<String, dynamic> toJson() => {
    "Currency": currency,
    "BaseFare": baseFare,
    "Tax": tax,
    "Service": service,
    "Total": total,
    "GrossAmount": grossAmount,
  };
}

class AdditionalFare {
  String? fareKey;
  int? fareType;
  bool? isRefundable;
  RefundInfo? refundInfo;
  FareDetails? fareDetails;

  AdditionalFare({
    this.fareKey,
    this.fareType,
    this.isRefundable,
    this.refundInfo,
    this.fareDetails,
  });

  factory AdditionalFare.fromJson(Map<String, dynamic> json) => AdditionalFare(
        fareKey: json["FareKey"],
        fareType: json["FareType"],
        isRefundable: json["IsRefundable"],
        refundInfo: json["RefundInfo"] != null ? RefundInfo.fromJson(json["RefundInfo"]) : null,
        fareDetails: json["FareDetails"] != null ? FareDetails.fromJson(json["FareDetails"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "FareKey": fareKey,
        "FareType": fareType,
        "IsRefundable": isRefundable,
        "RefundInfo": refundInfo?.toJson(),
        "FareDetails": fareDetails?.toJson(),
      };
}

class RefundInfo {
  int? value;
  String? name;
  dynamic notes;

  RefundInfo({
    this.value,
    this.name,
    this.notes,
  });

  factory RefundInfo.fromJson(Map<String, dynamic> json) => RefundInfo(
        value: json["Value"],
        name: json["Name"],
        notes: json["Notes"],
      );

  Map<String, dynamic> toJson() => {
        "Value": value,
        "Name": name,
        "Notes": notes,
      };
}


class FlightJourney {
  String? journeyId;
  int? travelDirection;
  TripDuration? journeyTime;
  int? totalStops;
  List<FlightItem>? flightItems;
  bool? dayChange;
  bool? isConnection;

  FlightJourney({
    this.journeyId,
    this.travelDirection,
    this.journeyTime,
    this.totalStops,
    this.flightItems,
    this.dayChange,
    this.isConnection,
  });

  factory FlightJourney.fromJson(Map<String, dynamic> json) => FlightJourney(
    journeyId: json["JourneyId"],
    travelDirection: json["TravelDirection"],
    journeyTime: json["JourneyTime"] != null ? TripDuration.fromJson(json["JourneyTime"]) : null,
    totalStops: json["TotalStops"],
    flightItems: (json["FlightItems"] as List?)?.map((x) => FlightItem.fromJson(x)).toList(),
    dayChange: json["DayChange"],
    isConnection: json["IsConnection"],
  );

  Map<String, dynamic> toJson() => {
    "JourneyId": journeyId,
    "TravelDirection": travelDirection,
    "JourneyTime": journeyTime?.toJson(),
    "TotalStops": totalStops,
    "FlightItems": flightItems?.map((x) => x.toJson()).toList(),
    "DayChange": dayChange,
    "IsConnection": isConnection,
  };
}

class FlightItem {
  String? legId;
  String? segmentIdentifier;
  Arrival? departure;
  Arrival? arrival;
  FlightInfo? flightInfo;
  TripDuration? durationPerLeg;
  int? numberOfStops;

  FlightItem({
    this.legId,
    this.segmentIdentifier,
    this.departure,
    this.arrival,
    this.flightInfo,
    this.durationPerLeg,
    this.numberOfStops,
  });

  factory FlightItem.fromJson(Map<String, dynamic> json) => FlightItem(
    legId: json["LegId"],
    segmentIdentifier: json["SegmentIdentifier"],
    departure: json["Departure"] != null ? Arrival.fromJson(json["Departure"]) : null,
    arrival: json["Arrival"] != null ? Arrival.fromJson(json["Arrival"]) : null,
    flightInfo: json["FlightInfo"] != null ? FlightInfo.fromJson(json["FlightInfo"]) : null,
    durationPerLeg: json["DurationPerLeg"] != null ? TripDuration.fromJson(json["DurationPerLeg"]) : null,
    numberOfStops: json["NumberOfStops"],
  );

  Map<String, dynamic> toJson() => {
    "LegId": legId,
    "SegmentIdentifier": segmentIdentifier,
    "Departure": departure?.toJson(),
    "Arrival": arrival?.toJson(),
    "FlightInfo": flightInfo?.toJson(),
    "DurationPerLeg": durationPerLeg?.toJson(),
    "NumberOfStops": numberOfStops,
  };
}

class Arrival {
  String? airportCode;
  Name? countryName;
  Name? cityName;
  Name? airportName;
  DateTime? dateTime;
  String? terminal;

  Arrival({
    this.airportCode,
    this.countryName,
    this.cityName,
    this.airportName,
    this.dateTime,
    this.terminal,
  });

  factory Arrival.fromJson(Map<String, dynamic> json) => Arrival(
    airportCode: json["AirportCode"],
    countryName: json["CountryName"] != null ? Name.fromJson(json["CountryName"]) : null,
    cityName: json["CityName"] != null ? Name.fromJson(json["CityName"]) : null,
    airportName: json["AirportName"] != null ? Name.fromJson(json["AirportName"]) : null,
    dateTime: json["DateTime"] != null ? DateTime.tryParse(json["DateTime"]) : null,
    terminal: json["Terminal"],
  );

  Map<String, dynamic> toJson() => {
    "AirportCode": airportCode,
    "CountryName": countryName?.toJson(),
    "CityName": cityName?.toJson(),
    "AirportName": airportName?.toJson(),
    "DateTime": dateTime?.toIso8601String(),
    "Terminal": terminal,
  };
}

class Name {
  String? en;
  String? ar;

  Name({this.en, this.ar});

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    en: json["en"],
    ar: json["ar"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
    "ar": ar,
  };
}

class FlightInfo {
  Name? name;
  String? code;
  String? number;
  String? cabinClass;
  String? brandName;
  String? bookingCode;
  String? aircraftName;
  String? equipmentNumber;
  bool? isRedEye;

  FlightInfo({
    this.name,
    this.code,
    this.number,
    this.cabinClass,
    this.brandName,
    this.bookingCode,
    this.aircraftName,
    this.equipmentNumber,
    this.isRedEye,
  });

  factory FlightInfo.fromJson(Map<String, dynamic> json) => FlightInfo(
    name: json["Name"] != null ? Name.fromJson(json["Name"]) : null,
    code: json["Code"],
    number: json["Number"],
    cabinClass: json["CabinClass"],
    brandName: json["BrandName"],
    bookingCode: json["BookingCode"],
    aircraftName: json["AircraftName"],
    equipmentNumber: json["EquipmentNumber"],
    isRedEye: json["IsRedEye"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name?.toJson(),
    "Code": code,
    "Number": number,
    "CabinClass": cabinClass,
    "BrandName": brandName,
    "BookingCode": bookingCode,
    "AircraftName": aircraftName,
    "EquipmentNumber": equipmentNumber,
    "IsRedEye": isRedEye,
  };
}

class TripDuration {
  int? days;
  int? hours;
  int? minutes;

  TripDuration({
    this.days,
    this.hours,
    this.minutes,
  });

  factory TripDuration.fromJson(Map<String, dynamic> json) => TripDuration(
    days: json["Days"],
    hours: json["Hours"],
    minutes: json["Minutes"],
  );

  Map<String, dynamic> toJson() => {
    "Days": days,
    "Hours": hours,
    "Minutes": minutes,
  };

  String get formatted {
    if ((days ?? 0) > 0) {
      return "${days}d ${hours}h ${minutes}m";
    } else {
      return "${hours}h ${minutes}m";
    }
  }
}
