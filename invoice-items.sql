SELECT 
	wp_woocommerce_order_items.order_id AS invoice_number,
	0 AS item_tax_rate,
	DATE_FORMAT(p.post_date, "%Y-%m-%d")  AS item_date_added,
	order_item_name AS item_name,
	order_item_name AS item_description, 
	Kwantiti.meta_value AS item_quantity,
	wp_woocommerce_order_itemmeta.meta_value/Kwantiti.meta_value AS item_price
	
	 -- ,wp_woocommerce_order_items.*
	 -- ,wp_woocommerce_order_itemmeta.*
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
 ORDER BY 1 DESC 