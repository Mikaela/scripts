import datetime

# Current year
current_year = 2025

# Calculate dates for weeks 26-31
def get_dates_for_week(week_number, year):
    # Find the first day of the year
    first_day_of_year = datetime.date(year, 1, 1)

    # Find the first day of the desired week (ISO format week numbering)
    start_of_week = first_day_of_year + datetime.timedelta(weeks=week_number - 1)

    # Return the start and end date of the week
    start_of_week = start_of_week - datetime.timedelta(days=start_of_week.weekday())  # Adjust to Monday
    end_of_week = start_of_week + datetime.timedelta(days=6)  # Sunday

    return (start_of_week, end_of_week)

# Get the dates for weeks 26-31
weeks = {week: get_dates_for_week(week, current_year) for week in range(26, 32)}
print(weeks)
