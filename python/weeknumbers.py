#!/usr/bin/env python3
"""
A family member wanted to know what dates are on weeks 26 and 31 and instead of
the answer received this script. I thought I would try to improve it for fun,
since it doesn't pass pylint or anything.
"""
import datetime

# Current year
# TODO: ask the user or if no answer, assume the actual current year?
CURRENT_YEAR = 2025


# TODO: ask for the week
# Calculate dates for weeks 26-31
def get_dates_for_week(week_number, year):
    """
    This function gets the dates for the week in question.
    """
    # Find the first day of the year
    first_day_of_year = datetime.date(year, 1, 1)

    # Find the first day of the desired week (ISO format week numbering)
    start_of_week = first_day_of_year + datetime.timedelta(
        weeks=week_number - 1
    )

    # Return the start and end date of the week
    start_of_week = start_of_week - datetime.timedelta(
        days=start_of_week.weekday()
    )  # Adjust to Monday
    end_of_week = start_of_week + datetime.timedelta(days=6)  # Sunday

    return (start_of_week, end_of_week)


# TODO: ansewr in a more human format
# Get the dates for weeks 26-31
weeks = {
    week: get_dates_for_week(week, CURRENT_YEAR) for week in range(26, 32)
}
print(weeks)
