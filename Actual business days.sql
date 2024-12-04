select * from tickets;
select * from holidays;

-- Business Days Excluding Weekends and Public Holidays

SELECT *
    , DATEDIFF(resolved_date, create_date) AS actual_days
    , week(create_date) as create_week, week(resolved_date) as resolve_week
	, week(resolved_date)-week(create_date) as week_diff
    , DATEDIFF(resolved_date, create_date) - 2*(week(resolved_date)-week(create_date)) as BUsiness_Days
FROM tickets;

SELECT *,
    DATEDIFF(resolved_date, create_date) - 2 * (WEEK(resolved_date) - WEEK(create_date)) - no_of_holiday AS actual_business_days
FROM (
    SELECT ticket_id, create_date, resolved_date, COUNT(holiday_date) AS no_of_holiday
    FROM tickets
    LEFT JOIN holidays ON holiday_date BETWEEN create_date AND resolved_date
    GROUP BY ticket_id, create_date, resolved_date
) AS subquery;

