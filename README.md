Time And Date Ruby API
======================================
[![Build Status](https://app.travis-ci.com/timeanddate/libtad-ruby.svg?token=rE5e9bKU1VpTiyEVqLNS&branch=master)](https://app.travis-ci.com/timeanddate/libtad-ruby) ![Gem](https://img.shields.io/gem/v/libtad)

An access key and a secret key is required to use the API. If you are not already a Time and Date API user, please see our [API offers](https://dev.timeanddate.com/free-trial) to get a free 3 month trial. For more information, see our [API Services page](https://dev.timeanddate.com/).


Get started
--------------------------------------

Add the gem as a dependency in the Gemfile:

```ruby 
gem 'libtad'
```


Require the gem in your source code:

```ruby
require 'libtad'
```

Setup the client with your access key and secret key:

```ruby
client = ::LibTAD::Client.new(access_key: 'access_key', secret_key: 'secret_key')
```

Astronomy Service
--------------------------------------
  
Get astronomical events for a place on a date by textual ID:

```ruby
place = "usa/anchorage"
date = ::LibTAD::TADTime::TADDateTime(year: 2015, month: 1, day: 1)
client = ::LibTAD::Client.new(access_key: 'access_key', secret_key: 'secret_key')
astro_events = client.get_astro_events(:sun, place_id: place, start_date: date)
```

Get astronomical events for a place between two dates by numeric ID:
 
```ruby
place = 187
start_date = ::LibTAD::TADTime::TADDateTime(year: 2015, month: 1, day: 1)
end_date = ::LibTAD::TADTime::TADDateTime(year: 2015, month: 1, day: 30)
client = ::LibTAD::Client.new(access_key: 'access_key', secret_key: 'secret_key')
astro_events = client.get_astro_events(:moon, place_id: place, start_date: start_date, end_date: end_date)
```

Retrieve specific astronomy events:

```ruby
astro_events = client.get_astro_events(:moon, place_id: place, start_date: start_date, types: [:setrise, :twilight])
```

Retrieve astronomy positions:

```ruby
astro_position = client.get_astro_position(:moon, place_id: place, interval: [date_1, date_2])
```

Time Service
--------------------------------------

Get current time for a place:

```ruby
place = 179
result = client.get_current_time(place_id: place)
```

Convert time from a location:

```ruby
place = "norway/oslo"
datetime = ::LibTAD::TADTime::TADDateTime.new.now
utc, locations = client.convert_time(from_id: place, datetime: datetime)
```

Convert time from a location using an [ISO 8601](https://dev.timeanddate.com/docs/external-references#ISO8601)-string:

```ruby
utc, locations = client.convert_time(from_id: place, iso: "2015-04-21T16:45:00")
```

Convert time from one location to multiple locations:

```ruby
list_of_locations = ["usa/las-vegas", 179]
place = "oslo/norway"
utc, locations = client.convert_time(from_id: place, datetime: datetime, to_id: list_of_locations)
```

Get all daylight saving times:

```ruby
all_DST = client.get_daylight_savings_time
```

Get daylight saving time for a specified year:

```ruby
result = client.get_daylight_savings_time(year: 2014)
```

Get daylight saving time for a specified [ISO3166-1 (Alpha2)](https://dev.timeanddate.com/docs/external-references#ISO3166) country code:

```ruby
result = client.get_daylight_savings_time(country: "no")
```

Holidays Service
--------------------------------------

Get all holidays for a country by [ISO3166-1 (Alpha2)](https://dev.timeanddate.com/docs/external-references#ISO3166) country code:

```ruby
country = "no"
result = client.get_holidays(country: country)
```

Get all holidays for a country by year and [ISO3166-1 (Alpha2)](https://dev.timeanddate.com/docs/external-references#ISO3166) country code:

```ruby
country = "no"
result = client.get_holidays(country: country, year: 2014)
```

Get specific holidays for a country:

```ruby
country = "no"
result = client.get_holidays(country: country, types: [:federal, :weekdays])
```

Places Service
--------------------------------------

Get all places in Time and Date (these can be used to look up data in other services):

```ruby
result = client.get_places
```

Date Calculator Service
--------------------------------------

Add days to a date:

```ruby
date = ::LibTAD::TADTime::TADDateTime.new.now
geo, period = client.add_days(start_date: date, days: 31)
```

Subtract days from a date:

```ruby
geo, period = client.subtract_days(start_date: date, days: 31)
```

Caclculate the number of business days between two dates:

```ruby
geo, period = client.get_duration(start_date: start_date, end_date: end_date)
```
