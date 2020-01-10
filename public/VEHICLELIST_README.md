## Blox Car Vehiclelist V1 API description

Default output without query parameters. (for readability, results truncated to 1)

`fetch: https://bloxcar.fi/vehiclelist`
```
[
    {
        "id": 1,
        "average_rating": 5.0,
        "seating_capacity": 5,
        "availability": [
            {
                "begin": "2020-01-09T12:54:56.911756",
                "end": "2022-08-08T22:45:00"
            }
        ],
        "added": "2016-06-20T10:15:50",
        "timezone": "Europe/Helsinki",
        "image": "https://s3-eu-west-1.amazonaws.com/prod-shareit-bloxcar/5d44d6c8-90e5-4578-9f47-8c2c2ae0b8e6.jpeg",
        "maker": "Audi",
        "model": "SQ5",
        "position": {
            "geometry": {
                "type": "Point",
                "coordinates": [
                    25.0144685,
                    60.18144470000001
                ]
            },
            "type": "Feature",
            "properties": {
                "city": "Helsinki",
                "description": "Autossa lukkoboksi kuljettajan puoleisessa ikkunassa. Omistaja l\u00e4hett\u00e4\u00e4 lukkoboksin koodin v\u00e4h\u00e4n ennen varauksen alkamista. Samassa osoitteessa jossa auto on l\u00f6ytyy ilmaista katuparkki tilaa. Auto voidaan jossain tilanteissa my\u00f6s toimittaa ja palauttaa Kulosaaren metroaseman parkkiin jossa 24tunnin P-kiekko pakko.",
                "area": "Helsinki",
                "zipcode": "00570",
                "address": "Lars Sonckin tie 14B"
            }
        },
        "prices": [
            {
                "pricing": "hourly",
                "price": 20.0,
                "free_km": 20,
                "extra_km_price": 0.33
            },
            {
                "pricing": "daily",
                "price": 89.0,
                "free_km": 400,
                "extra_km_price": 0.33
            },
            {
                "pricing": "weekly",
                "price": 570.0,
                "free_km": 650,
                "extra_km_price": 0.33
            }
        ],
        "short_description": [
            {
                "content": "Turvallinen neliveto-katumaasturi huippuvarusteilla ja urheiluautomaisella suorituskyvyll\u00e4. Kaksoisahdettu, automaattivaihteinen diesel-V6 kuljettaa jouhevasti koko perhett\u00e4 matkatavaroineen yli 300:n",
                "language": "fi"
            }
        ],
        "title": "Audi SQ5",
        "web_url": "https://bloxcar.fi/vehicle/1",
        "year": 2013,
        "vehicle_type": "suv",
        "distance": 4
    },
    ...
]
```

### Querying subset of vehicles

Querying for subset of results happens by passing search parameters as part of the URL. List of available parameters consist of

|| parameter | format              | example value | expected ouput |
|-| --------  | :----------------:| :-----------: | :----------: |
|| range     | `{start_index},{end_index}`  | [1, 50] | first 50 vehicles |
|| filter    | `{field_name},{value}`       | vehicle_type,van | vehicles which type is van |
|| search    | `{field_name},{less_than|greater_than|equals|contains|startswith},{value}`  | title,contains,audi | vehicles which title contains word "audi" |
|| availability | `{iso_format_datetime},{iso_format_datetime}`  | 2020-01-10T16:15:00,2020-01-18T16:15:00 | vehicles that owners have added availability on queried period |
|| at        | `{latitude},{longitude}`     | 60.1699,24.9384 | all vehicles with calculated `distance`-parameter from queried location |
|| sort      | `{field_name},{value}` | distance,asc | when used with `at`-parameter closest vehicles are at start of result array |
|*| distance  | `{number}` | 5 | when combined with `at` limits search results to given distance |

`* applied only with at-parameter`

### Example queries

Get vehicles with in 3 kilometer radius from Helsingin rautatieasema and sorted by closest one first

```
https://bloxcar.fi/vehiclelist
?at=60.16956743967486,24.94106769561768
&sort=distance,asc
&distance=3
```

***

Get vans with in 11 kilometer radius from Espoon asema and closest one first

```
https://bloxcar.fi/vehiclelist
?filter=vehicle_type,van
&at=60.204386,24.654387
&sort=distance,asc
&distance=11
```

***

Get 20 first vehicles which title contains "tesla"

```
https://bloxcar.fi/vehiclelist
?search=title,contains,tesla
&range=1,20
```

*** 

Get vehicles with in 10 kilometer radius from Tampere city center which are available for rent from 16 January 2020 to 17 January 2020, pick-up and return time at 16:00

```
https://bloxcar.fi/vehiclelist
?at=61.498584,23.77384
&sort=distance,asc
&availability=2020-01-16T16:00:00,2020-01-17T16:00:00
&distance=10
```

***

Fetching only `id, prices and availability` -data for smaller payload and faster request


```
https://bloxcar.fi/vehiclelist
?show=id,prices,availability
```
