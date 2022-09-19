--================================================--
--================= SETUP PARTS ==================--
--================================================--
CREATE TABLE shop_setup (
    shop_id         NUMBER,
    shop_name       VARCHAR2(200),
    shop_location   VARCHAR2(500),
    phone_number    VARCHAR2(15),
    shop_email      VARCHAR2(100),
    shop_website    VARCHAR2(100),
    created_by      VARCHAR2(100),
    created_date    TIMESTAMP WITH TIME ZONE,
    updated_by      VARCHAR2(100),
    updated_date    TIMESTAMP WITH TIME ZONE,
    CONSTRAINT shop_setup_id_pk PRIMARY KEY(shop_id)
);

CREATE TABLE suppliers (
    supplier_id         NUMBER,
    supplier_name       VARCHAR2(200) CONSTRAINT suppliers_supp_name_nn NOT NULL,
    supplier_address    VARCHAR2(500),
    phone_number        VARCHAR2(20) CONSTRAINT suppliers_supp_number_nn NOT NULL,
    supplier_email      VARCHAR2(100),
    remarks             VARCHAR2(500),
	supplier_status		CHAR(1) DEFAULT 'Y',
    created_by          VARCHAR2(100),
    created_date        TIMESTAMP WITH TIME ZONE,
    updated_by          VARCHAR2(100),
    updated_date        TIMESTAMP WITH TIME ZONE,
    CONSTRAINT suppliers_supp_name_uq UNIQUE(supplier_name),
    CONSTRAINT suppliers_supp_id_pk PRIMARY KEY(supplier_id)
);

CREATE TABLE supplier_contacts (
    sup_contact_id      NUMBER,
    supplier_id         NUMBER,
    full_name           VARCHAR2(100),
    designation         VARCHAR2(100),
    phone_number        VARCHAR2(20),
    email_address  	    VARCHAR2(100),
    created_by          VARCHAR2(100),
    created_date        TIMESTAMP WITH TIME ZONE,
    updated_by          VARCHAR2(100),
    updated_date        TIMESTAMP WITH TIME ZONE,
    CONSTRAINT sup_contacts_id_pk PRIMARY KEY(sup_contact_id),
    CONSTRAINT sup_cont_sup_id_fk FOREIGN KEY(supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE categories (
    category_id     NUMBER,
    category_name   VARCHAR2(100) CONSTRAINT categories_ctgy_name_nn NOT NULL,
    category_desc   VARCHAR2(500),
    category_status CHAR(1) DEFAULT 'Y',
    created_by      VARCHAR2(100),
    created_date    TIMESTAMP WITH TIME ZONE,
    updated_by      VARCHAR2(100),
    updated_date    TIMESTAMP WITH TIME ZONE,
    CONSTRAINT categories_ctgy_id_pk PRIMARY KEY(category_id),
    CONSTRAINT categories_ctgy_name_uq UNIQUE(category_name)
);

CREATE TABLE products (
    product_id      NUMBER,
    product_name    VARCHAR2(100) CONSTRAINT products_prod_name_nn NOT NULL,
    category_id     NUMBER CONSTRAINT products_ctgy_id_nn NOT NULL,
    product_status  CHAR(1) DEFAULT 'Y',
    created_by      VARCHAR2(100),
    created_date    TIMESTAMP WITH TIME ZONE,
    updated_by      VARCHAR2(100),
    updated_date    TIMESTAMP WITH TIME ZONE,
    CONSTRAINT products_prod_name_uq UNIQUE(product_name),
    CONSTRAINT products_prod_id_pk PRIMARY KEY(product_id),
    CONSTRAINT products_ctgy_id_fk FOREIGN KEY(category_id) REFERENCES categories(category_id)
);

CREATE TABLE uoms (
    uom_id          NUMBER,
    uom_name        VARCHAR2(100) CONSTRAINT uom_uom_name_nn NOT NULL,
    uom_desc        VARCHAR2(500),
    uom_status      CHAR DEFAULT 'Y',
    created_by      VARCHAR2(100),
    created_date    TIMESTAMP WITH TIME ZONE,
    updated_by      VARCHAR2(100),
    updated_date    TIMESTAMP WITH TIME ZONE,
    CONSTRAINT uom_uom_name_uq UNIQUE(uom_name),
    CONSTRAINT uom_uom_id_pk PRIMARY KEY(uom_id)
);

CREATE TABLE brands (
    brand_id        NUMBER,
    brand_name      VARCHAR2(100) CONSTRAINT brands_brand_name_nn NOT NULL,
    brand_desc      VARCHAR2(500),
    brand_status    CHAR DEFAULT 'Y',
    created_by      VARCHAR2(100),
    created_date    TIMESTAMP WITH TIME ZONE,
    updated_by      VARCHAR2(100),
    updated_date    TIMESTAMP WITH TIME ZONE,
    CONSTRAINT brands_brand_name_uq UNIQUE(brand_name),
    CONSTRAINT brands_brand_id_pk PRIMARY KEY(brand_id)
);

CREATE TABLE product_details (
    pdetails_id     NUMBER,
    category_id     NUMBER CONSTRAINT prod_dtl_cat_id_nn NOT NULL,
    product_id      NUMBER CONSTRAINT product_dtls_prod_id_nn NOT NULL,
    brand_id        NUMBER CONSTRAINT product_dtls_brand_id_nn NOT NULL,
    style_size      VARCHAR2(100),
    barcode         VARCHAR2(20) CONSTRAINT product_dtls_barcode_nn NOT NULL,
    purchase_price  NUMBER CONSTRAINT product_dtls_pur_price_nn NOT NULL,
    sale_price      NUMBER CONSTRAINT product_dtls_sal_price_nn NOT NULL,
    vat             NUMBER,
    min_qty         NUMBER,
    max_qty         NUMBER,
    cartoon_size    NUMBER,
    uom_id          NUMBER,
    Weight_fraction CHAR(1) DEFAULT 'N',
    prod_dtl_status CHAR(1) DEFAULT 'Y',
    created_by      VARCHAR2(100),
    created_date    TIMESTAMP WITH TIME ZONE,
    updated_by      VARCHAR2(100),
    updated_date    TIMESTAMP WITH TIME ZONE,
    CONSTRAINT product_dtls_prod_style UNIQUE(product_id, style_size),
    CONSTRAINT product_dtls_barcode UNIQUE(barcode),
    CONSTRAINT product_dtls_id_pk PRIMARY KEY(pdetails_id),
    CONSTRAINT prod_dtl_cat_id_pk FOREIGN KEY(category_id) REFERENCES categories(category_id),
    CONSTRAINT product_dtls_prod_id_fk FOREIGN KEY(product_id) REFERENCES products(product_id),
    CONSTRAINT product_dtls_brand_id_fk FOREIGN KEY(brand_id) REFERENCES brands(brand_id),
    CONSTRAINT product_dtls_uom_id_fk FOREIGN KEY(uom_id) REFERENCES uoms(uom_id)
);

CREATE TABLE customers (
    customer_id         NUMBER,
    customer_name       VARCHAR2(100) CONSTRAINT customers_cus_name_nn NOT NULL,
    customer_address    VARCHAR2(200),
    customer_number     VARCHAR2(20) CONSTRAINT customers_cus_num_nn NOT NULL,
    customer_email      VARCHAR2(100),
    remarks             VARCHAR2(200),
    customer_status     CHAR(1) DEFAULT 'Y',
    created_by          VARCHAR2(100),
    created_date        TIMESTAMP WITH TIME ZONE,
    updated_by          VARCHAR2(100),
    updated_date        TIMESTAMP WITH TIME ZONE,
    CONSTRAINT customers_cus_number_uq UNIQUE(customer_number),
    CONSTRAINT customers_cus_id_pk PRIMARY KEY(customer_id)
);

INSERT INTO customers(customer_id, customer_name, customer_number)
VALUES(0, 'Unkonwn Customer', '00000000000');


CREATE TABLE payment_methods (
    payment_id      NUMBER,
    method_name     VARCHAR2(100) CONSTRAINT pay_methods_meth_name_nn NOT NULL,
    method_details  VARCHAR2(200),
    method_status   CHAR(1) DEFAULT 'Y',
    created_by      VARCHAR2(100),
    created_date    TIMESTAMP WITH TIME ZONE,
    updated_by      VARCHAR2(100),
    updated_date    TIMESTAMP WITH TIME ZONE,
    CONSTRAINT pay_methods_meth_name_uq UNIQUE(method_name),
    CONSTRAINT pay_methods_id_pk PRIMARY KEY(payment_id)
);


--================================================--
--=============== TRANSITION PARTS ===============--
--================================================--

-- PRODUCT PURCHASE FROM SUPPLIER --
CREATE TABLE purchases (
    purchase_id         NUMBER,
    supplier_id         NUMBER,
    purchase_date       TIMESTAMP WITH TIME ZONE CONSTRAINT purchases_pur_date NOT NULL,
    total_amount        NUMBER,
	total_comm_pct		NUMBER,
    total_comm_amt      NUMBER,
	total_vat_pct		NUMBER,
    total_vat_amount    NUMBER,
    net_amount          NUMBER,
    paid_status         CHAR(1) DEFAULT 'P',
    paid_date           TIMESTAMP WITH TIME ZONE,
    remarks             VARCHAR2(200),
    created_by          VARCHAR2(100),
    created_date        TIMESTAMP WITH TIME ZONE,
    updated_by          VARCHAR2(100),
    updated_date        TIMESTAMP WITH TIME ZONE,
    CONSTRAINT purchases_pur_id_pk PRIMARY KEY(purchase_id),
    CONSTRAINT purchases_supp_id_fk FOREIGN KEY(supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE purchase_details (
    purchase_id     NUMBER,
    pdetails_id     NUMBER,
    product_qty     NUMBER,
    purchase_price  NUMBER,
	product_total	NUMBER,
    seq_id          NUMBER,
    created_by      VARCHAR2(100),
    created_date    TIMESTAMP WITH TIME ZONE,
    updated_by      VARCHAR2(100),
    updated_date    TIMESTAMP WITH TIME ZONE,
    CONSTRAINT purchase_dtl_pk PRIMARY KEY(purchase_id, pdetails_id),
    CONSTRAINT purchase_dtl_pur_id_fk FOREIGN KEY(purchase_id) REFERENCES purchases(purchase_id),
    CONSTRAINT purchase_dtl_prod_dtlid_fk FOREIGN KEY(pdetails_id) REFERENCES product_details(pdetails_id)
);


-- PURCHASE PRODUCT RETURN TO SUPPLIERS --
CREATE TABLE purchase_returns (
    pur_return_id   NUMBER,
    supplier_id     NUMBER,
    return_date     TIMESTAMP WITH TIME ZONE,
    remarks         VARCHAR2(200),
    created_by      VARCHAR2(100),
    created_date    TIMESTAMP WITH TIME ZONE,
    updated_by      VARCHAR2(100),
    updated_date    TIMESTAMP WITH TIME ZONE,
    CONSTRAINT purchase_rtnid_pk PRIMARY KEY(pur_return_id),
    CONSTRAINT purchase_rtn_suppid_fk FOREIGN KEY(supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE return_details (
    pur_return_id   NUMBER,
    pdetails_id		NUMBER,
    product_qty     NUMBER,
    purchase_price  NUMBER,
    created_by      VARCHAR2(100),
    created_date    TIMESTAMP WITH TIME ZONE,
    updated_by      VARCHAR2(100),
    updated_date    TIMESTAMP WITH TIME ZONE,
    CONSTRAINT return_dtl_pk PRIMARY KEY(pur_return_id, pdetails_id),
    CONSTRAINT return_dtl_purid_fk FOREIGN KEY(pur_return_id) REFERENCES purchase_returns(pur_return_id),
    CONSTRAINT return_dtl_prodid_fk FOREIGN KEY(pdetails_id) REFERENCES product_details(pdetails_id)
);


-- PRODUCTS SALES TO CUSTOMERS --
CREATE TABLE sales (
    sale_id         NUMBER,
    customer_id     NUMBER DEFAULT 0,
    sale_date       TIMESTAMP WITH TIME ZONE CONSTRAINT sales_sal_date_nn NOT NULL,
    total_amount    NUMBER,
    total_discount  NUMBER,
    net_amount      NUMBER,
    created_by      VARCHAR2(100),
    created_date    TIMESTAMP WITH TIME ZONE,
    updated_by      VARCHAR2(100),
    updated_date    TIMESTAMP WITH TIME ZONE,
    CONSTRAINT sales_sal_id_pk PRIMARY KEY(sale_id),
    CONSTRAINT sales_cus_id_fk FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE sale_details (
    sale_id         NUMBER,
    pdetails_id     NUMBER,
    product_qty     NUMBER,
    sale_price      NUMBER,
    created_by      VARCHAR2(100),
    created_date    TIMESTAMP WITH TIME ZONE,
    updated_by      VARCHAR2(100),
    updated_date    TIMESTAMP WITH TIME ZONE,
    CONSTRAINT sale_dtl_pk PRIMARY KEY(sale_id, pdetails_id),
    CONSTRAINT sale_dtl_sal_id_fk FOREIGN KEY(sale_id) REFERENCES sales(sale_id),
    CONSTRAINT sale_dtl_proddtl_id_fk FOREIGN KEY(pdetails_id) REFERENCES product_details(pdetails_id)
);

CREATE TABLE payment_details(
    payment_id      NUMBER,
    sale_id         NUMBER,
    pay_amount      NUMBER,
    created_by      VARCHAR2(100),
    created_date    TIMESTAMP WITH TIME ZONE,
    updated_by      VARCHAR2(100),
    updated_date    TIMESTAMP WITH TIME ZONE,
    CONSTRAINT payment_datils_pk PRIMARY KEY(payment_id, sale_id),
    CONSTRAINT payment_dtls_pay_id_fk FOREIGN KEY(payment_id) REFERENCES payment_methods(payment_id),
    CONSTRAINT payment_dtls_sal_id_fk FOREIGN KEY(sale_id) REFERENCES sales(sale_id)
);


-- PRODUCT EXCHANGES FROM SHOP BY CUSTOMERS --
CREATE TABLE sale_exchanges (
    sale_exchange_id    NUMBER,
    old_sale_id         NUMBER,
    new_sale_id         NUMBER,
    total_amount        NUMBER,
    created_by          VARCHAR2(100),
    created_date        TIMESTAMP WITH TIME ZONE,
    updated_by          VARCHAR2(100),
    updated_date        TIMESTAMP WITH TIME ZONE,
    CONSTRAINT sale_exch_id_pk PRIMARY KEY(sale_exchange_id),
    CONSTRAINT sale_exch_old_sal FOREIGN KEY(old_sale_id) REFERENCES sales(sale_id),   
    CONSTRAINT sale_exch_new_sal FOREIGN KEY(new_sale_id) REFERENCES sales(sale_id)
);

CREATE TABLE exchange_details (
    sale_exchange_id    NUMBER,
    pdetails_id         NUMBER,
    product_qty         NUMBER,
    created_by          VARCHAR2(100),
    created_date        TIMESTAMP WITH TIME ZONE,
    updated_by          VARCHAR2(100),
    updated_date        TIMESTAMP WITH TIME ZONE,
    CONSTRAINT exch_dtl_pk PRIMARY KEY(sale_exchange_id, pdetails_id),
    CONSTRAINT exch_dtl_salexchid_fk FOREIGN KEY(sale_exchange_id) REFERENCES sale_exchanges(sale_exchange_id),
    CONSTRAINT exch_dtl_proddtlid_fk FOREIGN KEY(pdetails_id) REFERENCES product_details(pdetails_id)
);


-- DAMAGE PRODUCTS --
CREATE TABLE damage_products (
    damage_id           NUMBER,
    damage_date         TIMESTAMP WITH TIME ZONE CONSTRAINT damage_damage_date_nn NOT NULL,
    total_lost_amount   NUMBER,
    created_by          VARCHAR2(100),
    created_date        TIMESTAMP WITH TIME ZONE,
    updated_by          VARCHAR2(100),
    updated_date        TIMESTAMP WITH TIME ZONE,
    CONSTRAINT damage_damage_id_pk PRIMARY KEY(damage_id)
);

CREATE TABLE damage_details (
    damage_id           NUMBER,
    pdetails_id         NUMBER,
    avg_purchase_price  NUMBER,
    product_qty         NUMBER,
    created_by          VARCHAR2(100),
    created_date        TIMESTAMP WITH TIME ZONE,
    updated_by          VARCHAR2(100),
    updated_date        TIMESTAMP WITH TIME ZONE,
    CONSTRAINT damage_dtl_dam_id_pd_id_pk PRIMARY KEY(damage_id, pdetails_id),
    CONSTRAINT damage_details_damage_id_fk FOREIGN KEY(damage_id) REFERENCES damage_products(damage_id),
    CONSTRAINT damage_dtl_product_dtl_id_fk FOREIGN KEY(pdetails_id) REFERENCES product_details(pdetails_id) 
);


-- FOR OPENING AND INVENTORY MANAGE --
CREATE TABLE inventories (
    inventory_id        NUMBER,
    inventory_date      TIMESTAMP WITH TIME ZONE CONSTRAINT inventories_inv_date_nn NOT NULL,
    pre_total_amount    NUMBER,
    new_total_amount    NUMBER,
    created_by          VARCHAR2(100),
    created_date        TIMESTAMP WITH TIME ZONE,
    updated_by          VARCHAR2(100),
    updated_date        TIMESTAMP WITH TIME ZONE,
    CONSTRAINT inventories_inv_id_pk PRIMARY KEY(inventory_id)
);

CREATE TABLE inventories_details (
    inventory_id    NUMBER,
    pdetails_id     NUMBER,
    old_qty         NUMBER,
    new_qty         NUMBER,
    created_by      VARCHAR2(100),
    created_date    TIMESTAMP WITH TIME ZONE,
    updated_by      VARCHAR2(100),
    updated_date    TIMESTAMP WITH TIME ZONE,
    CONSTRAINT inv_dtl_inv_id_prod_dtl_id_pk PRIMARY KEY(inventory_id, pdetails_id),
    CONSTRAINT inv_dtl_inv_id_fk FOREIGN KEY(inventory_id) REFERENCES inventories(inventory_id),
    CONSTRAINT inv_dtl_prod_dtl_id_fk FOREIGN KEY(pdetails_id) REFERENCES product_details(pdetails_id) 
);
