SELECT
DISTINCT
    CONCAT(
    TRIM(MAX( CASE WHEN pm.meta_key = '_billing_first_name' AND p.ID = pm.post_id THEN pm.meta_value END ))  ," ",
    TRIM(MAX( CASE WHEN pm.meta_key = '_billing_last_name' AND p.ID = pm.post_id THEN pm.meta_value END ))) AS client_name,
    NULL AS client_address_1,
    NULL AS client_address_2,
    NULL AS client_city,
    NULL AS client_state,
    NULL AS client_zip,
    NULL AS client_country,

    NULL AS client_phone,
    NULL AS client_fax,
    NULL AS client_mobile,
    
    LOWER(CONCAT(
	TRIM(MAX( CASE WHEN pm.meta_key = '_billing_first_name' AND p.ID = pm.post_id THEN pm.meta_value END ))  ,".",
	TRIM(MAX( CASE WHEN pm.meta_key = '_billing_last_name' AND p.ID = pm.post_id THEN pm.meta_value END )),'@to_fix_later.com'
    )) AS client_email,
    
    NULL AS client_web,
    NULL AS client_vat_id,
    NULL AS client_tax_code,
    1 AS client_active 
    
FROM
    wp_posts AS p,
    wp_postmeta AS pm
WHERE
     
    post_type = 'shop_order' AND
    p.ID = pm.post_id AND
    post_date BETWEEN '2010-01-01' AND '2019-07-08'
    AND post_status != 'auto-draft'
    
GROUP BY
    p.ID
    
    ORDER BY 1