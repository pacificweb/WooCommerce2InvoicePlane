SELECT

  'someuser@of_your_invoice_plane_instance.com' AS user_email,
    
    CONCAT(
    TRIM(MAX( CASE WHEN pm.meta_key = '_billing_first_name' AND p.ID = pm.post_id THEN pm.meta_value END ))  ," ",
    TRIM(MAX( CASE WHEN pm.meta_key = '_billing_last_name' AND p.ID = pm.post_id THEN pm.meta_value END ))) AS client_name,
    
    DATE_FORMAT(p.post_date, "%Y-%m-%d")AS invoice_date_created,
    DATE_FORMAT(p.post_date, "%Y-%m-%d")AS invoice_date_due,
    p.ID AS invoice_number,
    'Imported' AS invoice_terms
FROM
    wp_posts p 
    JOIN wp_postmeta pm ON p.ID = pm.post_id
    JOIN wp_woocommerce_order_items oi ON p.ID = oi.order_id
WHERE
    post_type = 'shop_order' AND     
    post_status != 'auto-draft' 
GROUP BY
    p.ID
    ORDER BY 5 DESC