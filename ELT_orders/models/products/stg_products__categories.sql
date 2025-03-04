{{
    config(
        materialized='table'
    )
}}


WITH unique_categories AS (
    SELECT DISTINCT
        category,
        sub_category
    FROM
        {{ source('public', 'products') }}
)

SELECT
    DENSE_RANK() OVER (ORDER BY category, sub_category) AS category_id,
    category,
    sub_category
FROM
    unique_categories