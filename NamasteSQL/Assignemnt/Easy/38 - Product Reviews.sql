SELECT review_id, product_id, review_text
FROM product_reviews
WHERE (
    LOWER(review_text) LIKE '%excellent%' 
    OR LOWER(review_text) LIKE '%amazing%'
)
AND (
    LOWER(review_text) NOT LIKE '%not excellent%' 
    AND LOWER(review_text) NOT LIKE '%not amazing%'
)
ORDER BY review_id ASC;