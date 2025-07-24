def valid_date(date):
    """You have to write a function which validates a given date string and
    returns True if the date is valid otherwise False.
    The date is valid if all of the following rules are satisfied:
    1. The date string is not empty.
    2. The number of days is not less than 1 or higher than 31 days for months 1,3,5,7,8,10,12. And the number of days is not less than 1 or higher than 30 days for months 4,6,9,11. And, the number of days is not less than 1 or higher than 29 for the month 2.
    3. The months should not be less than 1 or higher than 12.
    4. The date should be in the format: mm-dd-yyyy

    for example: 
    valid_date('03-11-2000') => True

    valid_date('15-01-2012') => False

    valid_date('04-0-2040') => False

    valid_date('06-04-2020') => True

    valid_date('06/04/2020') => False
    """
    
    # Check if date string is not empty
    if not date:
        return False
    
    # Check if format uses '-' as separator and has 3 parts
    parts = date.split('-')
    if len(parts) != 3:
        return False
    
    month_str, day_str, year_str = parts
    
    # Check if all parts are numeric and can be converted to integers
    try:
        month = int(month_str)
        day = int(day_str)
        year = int(year_str)
    except ValueError:
        return False
    
    # Check if month is valid (1-12)
    if month < 1 or month > 12:
        return False
    
    # Check if day is valid based on month
    if month in [1, 3, 5, 7, 8, 10, 12]:  # months with 31 days
        if day < 1 or day > 31:
            return False
    elif month in [4, 6, 9, 11]:  # months with 30 days
        if day < 1 or day > 30:
            return False
    elif month == 2:  # February
        if day < 1 or day > 29:
            return False
    
    return True