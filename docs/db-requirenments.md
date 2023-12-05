# Database Schema requirements

## Develop a schema for a trip planning application

Consider following entities in the application:

- `User`
- `Hotel`
- `HotelRoom`
- `HotelBooking`
- `Restaurant`
- `RestaurantTable`
- `RestorantBooking`
- `Flight`
- `FlightSeat`
- `FlightBooking`
- `Car`
- `CarBooking`
- `Sightseeing`
- `Review`
- ...

With following relationships:

- `Hotel`s have one or more`HotelRoom`s
- `Restaurans` have one or more `RestaurantTables`
- `HotelRoom`s and `RestaurantTable`s have certan availability, in addition restaurants can have opeing hours
- `Flight`s have available `Seats`
- `User` can look for a `Hotel` or a `Restaurant` in a chosen location (address or geolocation) to see available `HotelRoom`s or `RestaurantTables`
- `User` can book a `HotelRoom` or reserve a `RestaurantTable` if available and create `RestaurantBooking` or `HotelBooking`
- `User` can search for a `Flight` from one location to another (city, geolocation)
- `User` can book a `Seat` for a `Flight` if available to create a `FlightReservation`
- ...


### HotelBooking
user_id
date
room_id
checkin_date
checkout_date

