select category, 
length(products) - length(replace(products,',','')) +1 product_count 
from categories
order by (length(products) - length(replace(products,',','')) +1) asc;