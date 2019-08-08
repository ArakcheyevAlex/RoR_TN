days_per_month = {
  january: 31,
  february: 28,
  march: 31,
  april: 30,
  may: 31,
  june: 30,
  july: 31,
  august: 31,
  september: 30,
  october: 31,
  november: 30,
  december: 31
}

days_per_month.select { |month, days_count|
  days_count == 30
}.
each { |month, days_count|
   puts month
}
