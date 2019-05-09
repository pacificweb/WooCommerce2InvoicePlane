SELECT 
	wp_woocommerce_order_items.order_id AS invoice_number,
	'Check' AS payment_method,
	

	DATE_FORMAT(p.post_date, "%Y-%m-%d")  AS payment_date ,

	SUM(wp_woocommerce_order_itemmeta.meta_value) AS payment_amount,
	'Imported' AS  payment_note
 FROM 
	wp_woocommerce_order_items 
	JOIN 
		wp_woocommerce_order_itemmeta 
		ON wp_woocommerce_order_itemmeta.order_item_id = wp_woocommerce_order_items.order_item_id
	JOIN
		wp_posts p 
		ON p.ID = wp_woocommerce_order_items.order_id
		
	JOIN
		(
		 SELECT 
			 wp_woocommerce_order_items.order_id ,	
			 meta_value,
			 wp_woocommerce_order_itemmeta.order_item_id 
			 FROM 
				wp_woocommerce_order_items 
				JOIN 
					wp_woocommerce_order_itemmeta 
					ON wp_woocommerce_order_itemmeta.order_item_id = wp_woocommerce_order_items.order_item_id
				JOIN
					wp_posts p 
					ON p.ID = wp_woocommerce_order_items.order_id
			 AND meta_key = '_qty'
		) Kwantiti
		ON Kwantiti.order_id = wp_woocommerce_order_items.order_id AND Kwantiti.order_item_id = wp_woocommerce_order_itemmeta.order_item_id
		
 WHERE wp_woocommerce_order_itemmeta.meta_key = '_line_total'
 -- WHERE  wp_woocommerce_order_items.order_id = 1325
 GROUP BY 1
 ORDER BY 1 DESC
	
 -- AND wp_woocommerce_order_itemmeta.meta_key = '_line_subtotal'
 