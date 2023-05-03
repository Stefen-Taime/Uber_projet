{% macro parse_custom_date(date_column) %}
  CAST(
    CONCAT(
      SPLIT_PART({{ date_column }}::text, ' ', 3),
      '-',
      LPAD(
        CAST(
          CASE
            WHEN LOWER(SPLIT_PART({{ date_column }}::text, ' ', 2)) = 'janvier' THEN 1
            WHEN LOWER(SPLIT_PART({{ date_column }}::text, ' ', 2)) = 'février' THEN 2
            WHEN LOWER(SPLIT_PART({{ date_column }}::text, ' ', 2)) = 'mars' THEN 3
            WHEN LOWER(SPLIT_PART({{ date_column }}::text, ' ', 2)) = 'avril' THEN 4
            WHEN LOWER(SPLIT_PART({{ date_column }}::text, ' ', 2)) = 'mai' THEN 5
            WHEN LOWER(SPLIT_PART({{ date_column }}::text, ' ', 2)) = 'juin' THEN 6
            WHEN LOWER(SPLIT_PART({{ date_column }}::text, ' ', 2)) = 'juillet' THEN 7
            WHEN LOWER(SPLIT_PART({{ date_column }}::text, ' ', 2)) = 'août' THEN 8
            WHEN LOWER(SPLIT_PART({{ date_column }}::text, ' ', 2)) = 'septembre' THEN 9
            WHEN LOWER(SPLIT_PART({{ date_column }}::text, ' ', 2)) = 'octobre' THEN 10
            WHEN LOWER(SPLIT_PART({{ date_column }}::text, ' ', 2)) = 'novembre' THEN 11
            WHEN LOWER(SPLIT_PART({{ date_column }}::text, ' ', 2)) = 'décembre' THEN 12
          END
        AS TEXT),
        2,
        '0'
      ),
      '-',
      LPAD(SPLIT_PART({{ date_column }}::text, ' ', 1), 2, '0')
    ) AS DATE
  )
{% endmacro %}
