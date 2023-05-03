{% macro translate_french_month_to_english(month) %}
  CASE
    WHEN lower({{ month }}) = 'janvier' THEN 'January'
    WHEN lower({{ month }}) = 'février' THEN 'February'
    WHEN lower({{ month }}) = 'mars' THEN 'March'
    WHEN lower({{ month }}) = 'avril' THEN 'April'
    WHEN lower({{ month }}) = 'mai' THEN 'May'
    WHEN lower({{ month }}) = 'juin' THEN 'June'
    WHEN lower({{ month }}) = 'juillet' THEN 'July'
    WHEN lower({{ month }}) = 'août' THEN 'August'
    WHEN lower({{ month }}) = 'septembre' THEN 'September'
    WHEN lower({{ month }}) = 'octobre' THEN 'October'
    WHEN lower({{ month }}) = 'novembre' THEN 'November'
    WHEN lower({{ month }}) = 'décembre' THEN 'December'
    ELSE NULL
  END
{% endmacro %}
