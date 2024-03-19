<?php

/*

Address - 150
    address_id - auto
    street
    city
    state
    zip

Customer - 100
    - customer_id AUTO
    - first name
    - last name
    - email
    - phone
    - address_id


Order - 350
    - order_id AUTO
    - customer_id FOREIGN
    - address_id FOREIGN
    TRUNCATE TABLE orders;

    -- Then, insert random assignments of customers and their corresponding address IDs
    INSERT INTO orders (customer_id, address_id)
    SELECT 
        c.customer_id,
        c.address_id
    FROM
        customers c
    ORDER BY
        RAND()
    LIMIT 350;


Product - 750

Warehouse - 25

Order_item - 550

Product Warehouse - 1250
    -- First, truncate the product_warehouse table if it already exists
    TRUNCATE TABLE product_warehouse;

    -- Then, insert random assignments of products to warehouses
    INSERT INTO product_warehouse (product_id, warehouse_id)
    SELECT 
        p.product_id,
        w.warehouse_id
    FROM
        products p
    CROSS JOIN
        warehouses w
    ORDER BY
        RAND()
    LIMIT 1250;



*/

	// first names array
	$firstNames = file_get_contents("text_files/first_names.csv");
	$firstNamesAr = explode(",", $firstNames);

	// last names array
	$lastNames = file_get_contents("text_files/last_names.txt");
	$lastNamesAr = array_filter(explode("\n", $lastNames));

	// street names array
	$streetNames = file_get_contents("text_files/street_names.txt");
	$streetNamesAr = array_filter(preg_split( '/(:|\n)/', $streetNames));


	// street types array
	$streetTypes = file_get_contents("text_files/street_types.txt");
	$streetTypesAr = str_replace(array("\n","\r"),"",preg_split("/..;/", $streetTypes));


	//domains array
	$domains = file_get_contents("text_files/domains.txt");
	$domainsAll = explode(".", $domains);

	// combine every two entries:
	$domainsComplete = array();
	$domainsAr = array_chunk($domainsAll, 2);
	for ($i = 0; $i < sizeof($domainsAr); $i++){
		array_push($domainsComplete, implode(".", $domainsAr[$i]));
	}

    // states array
	$states = file_get_contents("text_files/states.txt");
	$statesArr = array_filter(explode("\n", $states));

    // cities array
	$cities = file_get_contents("text_files/cities.txt");
	$citiesArr = array_filter(explode("\n", $cities));

    $products = file_get_contents("text_files/products.txt");
    $productsArr = array_filter(explode("\n", $products));

    $nouns = file_get_contents("text_files/products.txt");
    $nounsArr = array_filter(explode("\n", $nouns));

    $adjectives = file_get_contents("text_files/products.txt");
    $adjectivesArr = array_filter(explode("\n", $adjectives));


for($i = 0; $i < 100; $i++){
	$firstName = str_replace(array("\n","\r"),"",$firstNamesAr[rand(0, 66)]);
	$lastName = $lastNamesAr[rand(0, 49)];
	$email = str_replace(array("\n","\r"),"",$firstName.".".$lastName."@".$domainsComplete[rand(0,7)]);
	$phone = rand(100,999)."-".rand(100,999)."-".rand(1000,9999);

	$state = $statesArr[rand(0,49)];
	$city = $citiesArr[rand(0,99)];
	$zip = rand(10000, 99999);

    $full = str_replace("\r","",$firstName.":".$lastName.":".$email.":".$phone."\n");
	file_put_contents("customer.txt",$full, FILE_APPEND);
}

for($i = 0; $i < 150; $i++){
    $address = rand(100,999)." ".$streetNamesAr[rand(0, 59)]." ".$streetTypesAr[rand(0, 11)];
    $state = $statesArr[rand(0,49)];
	$city = $citiesArr[rand(0,99)];
	$zip = rand(10000, 99999);

    $addressFull = str_replace("\r","",$address.":".$city.":".$state.":".$zip."\n");
	file_put_contents("address.txt", $addressFull, FILE_APPEND);
}



for($i = 0; $i < 750; $i++){
    
    $adjective1 = $adjectivesArr[rand(0,count($adjectivesArr))];
    $adjective2 = $adjectivesArr[rand(0,count($adjectivesArr))];
    $noun = $nounsArr[rand(0,count($nounsArr))];
    $product = $productsArr[rand(0,count($productsArr))];

    $productName = "{$adjective2} {$product}";
    $productDesc = "Introducing {$adjective2} {$product}, the ultimate solution for {$noun}s. With its {$adjective1} design and {$noun}-friendly features!";

    $weight = rand(0,99);
    $cost = rand(0,999).".99";

    $productFull = str_replace("\r","",$productName.":".$productDesc.":".$weight.":".$cost."\n");
	file_put_contents("product.txt", $productFull, FILE_APPEND);

}

for($i = 0; $i < 25; $i++) {

}


echo "Finished!";