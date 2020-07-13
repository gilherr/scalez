--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.2

-- Started on 2020-07-13 20:34:57 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 209 (class 1259 OID 16443)
-- Name: abtest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.abtest (
    abtest_id bigint NOT NULL,
    name character varying,
    groups character varying[],
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.abtest OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16441)
-- Name: abtest_abtest_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.abtest_abtest_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.abtest_abtest_id_seq1 OWNER TO postgres;

--
-- TOC entry 3016 (class 0 OID 0)
-- Dependencies: 208
-- Name: abtest_abtest_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.abtest_abtest_id_seq1 OWNED BY public.abtest.abtest_id;


--
-- TOC entry 211 (class 1259 OID 16455)
-- Name: abtest_allocation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.abtest_allocation (
    allocation_id bigint NOT NULL,
    name character varying,
    "group" character varying,
    conversion boolean DEFAULT false,
    created_at time with time zone DEFAULT now(),
    fk_user_id bigint,
    fk_abtest_id bigint
);


ALTER TABLE public.abtest_allocation OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16453)
-- Name: abtest_allocations_allocation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.abtest_allocations_allocation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.abtest_allocations_allocation_id_seq OWNER TO postgres;

--
-- TOC entry 3017 (class 0 OID 0)
-- Dependencies: 210
-- Name: abtest_allocations_allocation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.abtest_allocations_allocation_id_seq OWNED BY public.abtest_allocation.allocation_id;


--
-- TOC entry 202 (class 1259 OID 16393)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    product_id bigint NOT NULL,
    meta jsonb
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16399)
-- Name: product_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_product_id_seq OWNER TO postgres;

--
-- TOC entry 3018 (class 0 OID 0)
-- Dependencies: 203
-- Name: product_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_product_id_seq OWNED BY public.product.product_id;


--
-- TOC entry 204 (class 1259 OID 16401)
-- Name: rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rating (
    rating_id bigint NOT NULL,
    fk_product_id bigint NOT NULL,
    fk_user_id bigint NOT NULL,
    "like" boolean,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.rating OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16405)
-- Name: rating_rating_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rating_rating_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rating_rating_id_seq OWNER TO postgres;

--
-- TOC entry 3019 (class 0 OID 0)
-- Dependencies: 205
-- Name: rating_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rating_rating_id_seq OWNED BY public.rating.rating_id;


--
-- TOC entry 206 (class 1259 OID 16407)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    user_id bigint NOT NULL,
    is_new boolean,
    created_at time with time zone DEFAULT now()
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16411)
-- Name: user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_user_id_seq OWNER TO postgres;

--
-- TOC entry 3020 (class 0 OID 0)
-- Dependencies: 207
-- Name: user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_user_id_seq OWNED BY public."user".user_id;


--
-- TOC entry 2856 (class 2604 OID 16446)
-- Name: abtest abtest_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abtest ALTER COLUMN abtest_id SET DEFAULT nextval('public.abtest_abtest_id_seq1'::regclass);


--
-- TOC entry 2858 (class 2604 OID 16458)
-- Name: abtest_allocation allocation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abtest_allocation ALTER COLUMN allocation_id SET DEFAULT nextval('public.abtest_allocations_allocation_id_seq'::regclass);


--
-- TOC entry 2851 (class 2604 OID 16414)
-- Name: product product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN product_id SET DEFAULT nextval('public.product_product_id_seq'::regclass);


--
-- TOC entry 2853 (class 2604 OID 16415)
-- Name: rating rating_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating ALTER COLUMN rating_id SET DEFAULT nextval('public.rating_rating_id_seq'::regclass);


--
-- TOC entry 2855 (class 2604 OID 16416)
-- Name: user user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN user_id SET DEFAULT nextval('public.user_user_id_seq'::regclass);


--
-- TOC entry 3008 (class 0 OID 16443)
-- Dependencies: 209
-- Data for Name: abtest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.abtest (abtest_id, name, groups, created_at) FROM stdin;
1	test_a	{group_a,group_b}	2020-07-13 20:19:41.82196+00
\.


--
-- TOC entry 3010 (class 0 OID 16455)
-- Dependencies: 211
-- Data for Name: abtest_allocation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.abtest_allocation (allocation_id, name, "group", conversion, created_at, fk_user_id, fk_abtest_id) FROM stdin;
1	test_a	group_a	f	20:33:51.343546+00	2	1
\.


--
-- TOC entry 3001 (class 0 OID 16393)
-- Dependencies: 202
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (product_id, meta) FROM stdin;
1	{"size": "32", "brand": "Joie", "color": "Beige", "price": 228.0, "images": ["https://img.shopstyle-cdn.com/sim/8a/82/8a828d57f8025c0b0f271c0f4d11816f_best/park-high-waist-skinny-pants.jpg", "https://img.shopstyle-cdn.com/sim/35/f8/35f81a57f1e59dad5e937ef2169ae8d0_best/park-high-waist-skinny-pants.jpg", "https://img.shopstyle-cdn.com/sim/4c/30/4c309b5ca23b5608e39f6f2f3b803ec5_best/park-high-waist-skinny-pants.jpg", "https://img.shopstyle-cdn.com/sim/71/25/712505ce89882d3864433619005e6eb5_best/park-high-waist-skinny-pants.jpg", "https://img.shopstyle-cdn.com/sim/9e/8e/9e8e99b0991d297ad358dbc9d739b3e1_best/park-high-waist-skinny-pants.jpg", "https://img.shopstyle-cdn.com/sim/e3/da/e3da2b75b8aac66693fb4c528ac0b6e1_best/park-high-waist-skinny-pants.jpg"], "portal": "shopstyle", "inStock": true, "currency": "USD", "parentId": "shopstyle_840189456", "priceSale": null, "productId": "2b4c06b441db7406bfd5e973f1a6fd82", "categories": [["Skinny", "Women's Skinny Pants"]], "cleanedSize": ["32"], "originalUrl": null, "productLink": "https://api.shopstyle.com/action/apiVisitRetailer?id=840189456&pid=uid7249-42318943-68", "productName": "Park High Waist Skinny Pants", "productType": "Pants", "manufacturer": "Joie", "retailerName": "Nordstrom", "priceShipping": null, "descriptionLong": "Patch pockets and zip details add a dash of utility-style attitude to a pair of curve-hugging skinny pants cut from a stretchy cotton blend. Style Name:Joie Park High Waist Skinny Pants. Style Number: 6046765. Available in stores.", "descriptionShort": "Patch pockets and zip details add a dash of utility-style attitude to a pair of curve-hugging skinny pants cut from a stretchy cotton blend. Style Name:Joie Park High Waist Skinny Pants. Style Number: 6046765. Available in stores.", "originalPortalUrl": "https://api.shopstyle.com/action/apiVisitRetailer?id=840189456&pid=uid7249-42318943-68"}
2	{"size": "Small", "brand": "unbrandedName", "color": "Blue", "price": 19.99, "images": ["https://img.shopstyle-cdn.com/sim/61/e5/61e5078ceeb56ad5f499c992de8df61b_best/womens-norder-team-family-reunions-dna-heartbeat-lifetime-v-neck-t-shirt.jpg"], "portal": "shopstyle", "inStock": true, "currency": "USD", "parentId": "shopstyle_829432315", "priceSale": null, "productId": "f0f240e617ec5470628db148b0a458d9", "categories": [["Tees", "Women's Tees And Tshirts"]], "cleanedSize": ["s"], "originalUrl": "https://www.amazon.com/dp/B0834QLBTM", "productLink": "https://www.amazon.com/dp/B0834QLBTM/?tag=scalez0c-20", "productName": "Womens NORDER Team Family Reunions DNA Heartbeat Lifetime V-Neck T-Shirt", "productType": "Top", "manufacturer": "unbrandedName", "retailerName": "Amazon", "priceShipping": null, "descriptionLong": "Are you ready for family reunions and have German NORDER surnames? Get this outstanding eye-catching design. Your mother, father, sister, brother, grandma, grandpa, cousin, aunt, uncle will love this design. Your family in the DNA personalized outfit. Dear customers for other products in the same design please click on our brand. Thank you. Great family birthday gift idea, mix it with family mug, keychain or other personalized gift. This NORDER Team Family Reunions DNA Heartbeat Lifetime apparel is designed by NORDER Family Reunions Outfits.", "descriptionShort": "Are you ready for family reunions and have German NORDER surnames? Get this outstanding eye-catching design. Your mother, father, sister, brother, grandma, grandpa, cousin, aunt, uncle will love this design. Your family in the DNA personalized outfit. Dear customers for other products in the same design please click on our brand. Thank you. Great family birthday gift idea, mix it with family mug, keychain or other personalized gift. This NORDER Team Family Reunions DNA Heartbeat Lifetime apparel is designed by NORDER Family Reunions Outfits.", "originalPortalUrl": "https://api.shopstyle.com/action/apiVisitRetailer?id=829432315&pid=uid7249-42318943-68"}
3	{"size": "10", "brand": "Soul Naturalizer", "color": "White", "price": 59.99, "images": ["https://img.shopstyle-cdn.com/sim/26/14/26147b1124fad92d7f346d511d85ae58_best/detail-espadrille-platform-sandal.jpg", "https://img.shopstyle-cdn.com/sim/86/44/8644eada96cf29bac97aff1643dbe603_best/detail-espadrille-platform-sandal.jpg", "https://img.shopstyle-cdn.com/sim/8e/b5/8eb57db25183901fd11b34b158ae0cc6_best/detail-espadrille-platform-sandal.jpg", "https://img.shopstyle-cdn.com/sim/b6/3d/b63deb651ce54853b5de4b9f4ac4b28a_best/detail-espadrille-platform-sandal.jpg", "https://img.shopstyle-cdn.com/sim/bb/24/bb2435494bd77cb316e7066665aa5f74_best/detail-espadrille-platform-sandal.jpg", "https://img.shopstyle-cdn.com/sim/c1/b0/c1b096d623d9c6daf60c2742eef54919_best/detail-espadrille-platform-sandal.jpg", "https://img.shopstyle-cdn.com/sim/d5/57/d557f57be1ecffe7f73732444b954d93_best/detail-espadrille-platform-sandal.jpg"], "portal": "shopstyle", "inStock": true, "currency": "USD", "parentId": "shopstyle_830300709", "priceSale": null, "productId": "b0272053fd7b70b89553aa783af628ff", "categories": [["Platforms", "Platforms"], ["Sandals", "Women's Sandals"]], "cleanedSize": ["10"], "originalUrl": null, "productLink": "https://api.shopstyle.com/action/apiVisitRetailer?id=830300709&pid=uid7249-42318943-68", "productName": "Detail Espadrille Platform Sandal", "productType": "Shoes", "manufacturer": "Soul Naturalizer", "retailerName": "DSW", "priceShipping": null, "descriptionLong": "Walk around in comfy and cute style with the Detail sandal from SOUL Naturalizer. This silhouette is fashioned with a raffia platform and an elastic ankle strap for secured steps! Fabric upper Elastic ankle strap Round open toe Fabric lining Memory Foam footbed 11⁄4\\" espadrile flatform Synthetic sole Imported", "descriptionShort": "Walk around in comfy and cute style with the Detail sandal from SOUL Naturalizer. This silhouette is fashioned with a raffia platform and an elastic ankle strap for secured steps! Fabric upper Elastic ankle strap Round open toe Fabric lining Memory Foam footbed 11⁄4\\" espadrile flatform Synthetic sole Imported", "originalPortalUrl": "https://api.shopstyle.com/action/apiVisitRetailer?id=830300709&pid=uid7249-42318943-68"}
4	{"size": "8 Us", "brand": "Chloé", "color": "Blue", "price": 1895.0, "images": ["https://img.shopstyle-cdn.com/sim/c3/91/c3914593de0dd22fcc192f1d79c39b4a_best/asymmetrical-floral-print-stretch-silk-midi-skirt.jpg", "https://img.shopstyle-cdn.com/sim/24/be/24beaf1eaf586ec6b81cda39e3183e03_best/asymmetrical-floral-print-stretch-silk-midi-skirt.jpg", "https://img.shopstyle-cdn.com/sim/57/b9/57b90b5fce3829a9c0d926d48a6787c0_best/asymmetrical-floral-print-stretch-silk-midi-skirt.jpg", "https://img.shopstyle-cdn.com/sim/7e/31/7e3178134c528e5cc1ed6b4eef53dc3d_best/asymmetrical-floral-print-stretch-silk-midi-skirt.jpg", "https://img.shopstyle-cdn.com/sim/b0/7a/b07a259d4fb59413a9738889e01ac7e1_best/asymmetrical-floral-print-stretch-silk-midi-skirt.jpg", "https://img.shopstyle-cdn.com/sim/d7/a6/d7a60fb78cff24e688e26abbed2ed0a6_best/asymmetrical-floral-print-stretch-silk-midi-skirt.jpg"], "portal": "shopstyle", "inStock": true, "currency": "USD", "parentId": "shopstyle_818489945", "priceSale": 758.0, "productId": "22a111229ddb4145638d66d8da88c4f0", "categories": [["Mid-length", "Mid Length Skirts"]], "cleanedSize": ["8"], "originalUrl": null, "productLink": "https://api.shopstyle.com/action/apiVisitRetailer?id=818489945&pid=uid7249-42318943-68", "productName": "Asymmetrical Floral Print Stretch Silk Midi Skirt", "productType": "Skirt", "manufacturer": "Chloé", "retailerName": "Nordstrom", "priceShipping": null, "descriptionLong": "Subtly nodding to traditional cheongsams, the asymmetrical, buttoned slit of this floral skirt can be unfastened to show more leg and a mini-length lining. Style Name:Chloe Asymmetrical Floral Print Stretch Silk Midi Skirt. Style Number: 5940659. Available in stores.", "descriptionShort": "Subtly nodding to traditional cheongsams, the asymmetrical, buttoned slit of this floral skirt can be unfastened to show more leg and a mini-length lining. Style Name:Chloe Asymmetrical Floral Print Stretch Silk Midi Skirt. Style Number: 5940659. Available in stores.", "originalPortalUrl": "https://api.shopstyle.com/action/apiVisitRetailer?id=818489945&pid=uid7249-42318943-68"}
5	{"size": "10", "brand": "boohoo", "color": "Blue", "price": 40.0, "images": ["https://img.shopstyle-cdn.com/sim/ef/48/ef482f4e4ae773ddbe424a9067238f99_best/mid-rise-frayed-hem-denim-booty-shorts.jpg", "https://img.shopstyle-cdn.com/sim/47/5f/475f13f23e91452f19fe94749fce1ae4_best/mid-rise-frayed-hem-denim-booty-shorts.jpg", "https://img.shopstyle-cdn.com/sim/50/57/5057f3a901baca8d7cacef9e90788045_best/mid-rise-frayed-hem-denim-booty-shorts.jpg", "https://img.shopstyle-cdn.com/sim/c2/c7/c2c7339ba4f8638c949e14dde6ab0c7a_best/mid-rise-frayed-hem-denim-booty-shorts.jpg"], "portal": "shopstyle", "inStock": true, "currency": "USD", "parentId": "shopstyle_602747860", "priceSale": 16.0, "productId": "45b4f0c895a969a2733f3787e28a9b95", "categories": [["Shorts", "Women's Shorts"]], "cleanedSize": ["10"], "originalUrl": null, "productLink": "https://api.shopstyle.com/action/apiVisitRetailer?id=602747860&pid=uid7249-42318943-68", "productName": "Mid Rise Frayed Hem Denim Booty Shorts", "productType": "Shorts", "manufacturer": "boohoo", "retailerName": "boohoo", "priceShipping": null, "descriptionLong": "Womens Mid Rise Frayed Hem Denim Booty Shorts - blue - 2 - Parade your pins in a pair of shorts A versatile day-to-night option, new season shorts aren't all about showing some leg - think mid-length culottes and borrowed-from-the-boy longline styles for a more conservative take on the cropped length. But flesh-baring styles are still big for nights out, with shouty sequin shorts statement and denim hotpants easy to wear for cool-casual evenings. Dress down embellished designs with a slogan tee for added edge.", "descriptionShort": "Womens Mid Rise Frayed Hem Denim Booty Shorts - blue - 2 - Parade your pins in a pair of shorts A versatile day-to-night option, new season shorts aren't all about showing some leg - think mid-length culottes and borrowed-from-the-boy longline styles for a more conservative take on the cropped length. But flesh-baring styles are still big for nights out, with shouty sequin shorts statement and denim hotpants easy to wear for cool-casual evenings. Dress down embellished designs with a slogan tee for added edge.", "originalPortalUrl": "https://api.shopstyle.com/action/apiVisitRetailer?id=602747860&pid=uid7249-42318943-68"}
6	{"size": "4", "brand": "boohoo", "color": "Black", "price": 18.0, "images": ["https://img.shopstyle-cdn.com/sim/00/91/0091a72fe38e152fd72e98151a463b1f_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/08/e2/08e23c0dc8379406ccb4daa01c46aeea_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/37/75/3775a0b841aff20729bf4c4874c87056_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/6f/16/6f16cadd477d0e6441be93a42877a499_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/88/84/88846fbc2aedebb7028ab5756837cca9_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/b5/25/b52584fdd0c5097d6da7f42e520e3ab0_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/b8/b5/b8b57a882249acc1c94a29b26b644685_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/d1/2a/d12a9966fd0d60c506dea477efed78d8_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/d4/7a/d47aafb98badb229a22fb8a6fe28e4a2_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/d5/7a/d57a8b76ff4a1fdebbd1896bce7f454f_best/basic-ribbed-biker-short.jpg"], "portal": "shopstyle", "inStock": true, "currency": "USD", "parentId": "shopstyle_822286146", "priceSale": 7.2, "productId": "10c5dc03dfbba6b92d6d1d50cbf49a24", "categories": [["Shorts", "Women's Shorts"]], "cleanedSize": ["4"], "originalUrl": null, "productLink": "https://api.shopstyle.com/action/apiVisitRetailer?id=822286146&pid=uid7249-42318943-68", "productName": "Basic Ribbed Biker Short", "productType": "Shorts", "manufacturer": "boohoo", "retailerName": "boohoo", "priceShipping": null, "descriptionLong": "Womens Basic Ribbed Biker Short - orange - 4 - Parade your pins in a pair of shorts A versatile day-to-night option, new season shorts aren't all about showing some leg - think mid-length culottes and borrowed-from-the-boy longline styles for a more conservative take on the cropped length. But flesh-baring styles are still big for nights out, with shouty sequin shorts statement and denim hotpants easy to wear for cool-casual evenings. Dress down embellished designs with a slogan tee for added edge.", "descriptionShort": "Womens Basic Ribbed Biker Short - orange - 4 - Parade your pins in a pair of shorts A versatile day-to-night option, new season shorts aren't all about showing some leg - think mid-length culottes and borrowed-from-the-boy longline styles for a more conservative take on the cropped length. But flesh-baring styles are still big for nights out, with shouty sequin shorts statement and denim hotpants easy to wear for cool-casual evenings. Dress down embellished designs with a slogan tee for added edge.", "originalPortalUrl": "https://api.shopstyle.com/action/apiVisitRetailer?id=822286146&pid=uid7249-42318943-68"}
7	{"size": "12", "brand": "boohoo", "color": "Green", "price": 18.0, "images": ["https://img.shopstyle-cdn.com/sim/31/ea/31eab28b6403d43f50284662514a1064_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/11/0e/110ed90e6d4aa85d81e4f2bfaf5b6980_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/32/70/3270651a57e52580f9e7d802802f563d_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/4f/da/4fda4edf9bcbbcbd463694a557f57816_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/7f/81/7f8114cf9f1030aefec9dc639032f8c9_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/a0/b6/a0b69c48de8c6428450b8a9c67e9e219_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/bc/17/bc170ec7dfbe9fe7dc96a56128ec210d_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/f4/c4/f4c4eef57a3082f9b5e12f53147bf631_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/f6/5f/f65fa24d03d1786842a1164c9b9b0580_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/f6/ee/f6ee4724304df49b6a8a589712a5c6f6_best/basic-jersey-flippy-shorts.jpg"], "portal": "shopstyle", "inStock": true, "currency": "USD", "parentId": "shopstyle_838455733", "priceSale": 7.2, "productId": "1f6a716cca8e1af3481602b875f2bdd5", "categories": [["Shorts", "Women's Shorts"]], "cleanedSize": ["12"], "originalUrl": null, "productLink": "https://api.shopstyle.com/action/apiVisitRetailer?id=838455733&pid=uid7249-42318943-68", "productName": "Basic Jersey Flippy Shorts", "productType": "Shorts", "manufacturer": "boohoo", "retailerName": "boohoo", "priceShipping": null, "descriptionLong": "Womens Basic Jersey Flippy Shorts - pink - 4 - Parade your pins in a pair of shorts A versatile day-to-night option, new season shorts aren't all about showing some leg - think mid-length culottes and borrowed-from-the-boy longline styles for a more conservative take on the cropped length. But flesh-baring styles are still big for nights out, with shouty sequin shorts statement and denim hotpants easy to wear for cool-casual evenings. Dress down embellished designs with a slogan tee for added edge.", "descriptionShort": "Womens Basic Jersey Flippy Shorts - pink - 4 - Parade your pins in a pair of shorts A versatile day-to-night option, new season shorts aren't all about showing some leg - think mid-length culottes and borrowed-from-the-boy longline styles for a more conservative take on the cropped length. But flesh-baring styles are still big for nights out, with shouty sequin shorts statement and denim hotpants easy to wear for cool-casual evenings. Dress down embellished designs with a slogan tee for added edge.", "originalPortalUrl": "https://api.shopstyle.com/action/apiVisitRetailer?id=838455733&pid=uid7249-42318943-68"}
8	{"size": "6", "brand": "boohoo", "color": "Green", "price": 18.0, "images": ["https://img.shopstyle-cdn.com/sim/00/91/0091a72fe38e152fd72e98151a463b1f_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/08/e2/08e23c0dc8379406ccb4daa01c46aeea_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/37/75/3775a0b841aff20729bf4c4874c87056_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/6f/16/6f16cadd477d0e6441be93a42877a499_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/88/84/88846fbc2aedebb7028ab5756837cca9_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/b5/25/b52584fdd0c5097d6da7f42e520e3ab0_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/b8/b5/b8b57a882249acc1c94a29b26b644685_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/d1/2a/d12a9966fd0d60c506dea477efed78d8_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/d4/7a/d47aafb98badb229a22fb8a6fe28e4a2_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/d5/7a/d57a8b76ff4a1fdebbd1896bce7f454f_best/basic-ribbed-biker-short.jpg"], "portal": "shopstyle", "inStock": true, "currency": "USD", "parentId": "shopstyle_822286146", "priceSale": 7.2, "productId": "1c784eb19ac8ada8bba984c39edf0bd9", "categories": [["Shorts", "Women's Shorts"]], "cleanedSize": ["6"], "originalUrl": null, "productLink": "https://api.shopstyle.com/action/apiVisitRetailer?id=822286146&pid=uid7249-42318943-68", "productName": "Basic Ribbed Biker Short", "productType": "Shorts", "manufacturer": "boohoo", "retailerName": "boohoo", "priceShipping": null, "descriptionLong": "Womens Basic Ribbed Biker Short - orange - 4 - Parade your pins in a pair of shorts A versatile day-to-night option, new season shorts aren't all about showing some leg - think mid-length culottes and borrowed-from-the-boy longline styles for a more conservative take on the cropped length. But flesh-baring styles are still big for nights out, with shouty sequin shorts statement and denim hotpants easy to wear for cool-casual evenings. Dress down embellished designs with a slogan tee for added edge.", "descriptionShort": "Womens Basic Ribbed Biker Short - orange - 4 - Parade your pins in a pair of shorts A versatile day-to-night option, new season shorts aren't all about showing some leg - think mid-length culottes and borrowed-from-the-boy longline styles for a more conservative take on the cropped length. But flesh-baring styles are still big for nights out, with shouty sequin shorts statement and denim hotpants easy to wear for cool-casual evenings. Dress down embellished designs with a slogan tee for added edge.", "originalPortalUrl": "https://api.shopstyle.com/action/apiVisitRetailer?id=822286146&pid=uid7249-42318943-68"}
9	{"size": "2", "brand": "boohoo", "color": "Blue", "price": 40.0, "images": ["https://img.shopstyle-cdn.com/sim/ef/48/ef482f4e4ae773ddbe424a9067238f99_best/mid-rise-frayed-hem-denim-booty-shorts.jpg", "https://img.shopstyle-cdn.com/sim/47/5f/475f13f23e91452f19fe94749fce1ae4_best/mid-rise-frayed-hem-denim-booty-shorts.jpg", "https://img.shopstyle-cdn.com/sim/50/57/5057f3a901baca8d7cacef9e90788045_best/mid-rise-frayed-hem-denim-booty-shorts.jpg", "https://img.shopstyle-cdn.com/sim/c2/c7/c2c7339ba4f8638c949e14dde6ab0c7a_best/mid-rise-frayed-hem-denim-booty-shorts.jpg"], "portal": "shopstyle", "inStock": true, "currency": "USD", "parentId": "shopstyle_602747860", "priceSale": 16.0, "productId": "37ebeb32cb810996db47bed2db5a6ece", "categories": [["Shorts", "Women's Shorts"]], "cleanedSize": ["2"], "originalUrl": null, "productLink": "https://api.shopstyle.com/action/apiVisitRetailer?id=602747860&pid=uid7249-42318943-68", "productName": "Mid Rise Frayed Hem Denim Booty Shorts", "productType": "Shorts", "manufacturer": "boohoo", "retailerName": "boohoo", "priceShipping": null, "descriptionLong": "Womens Mid Rise Frayed Hem Denim Booty Shorts - blue - 2 - Parade your pins in a pair of shorts A versatile day-to-night option, new season shorts aren't all about showing some leg - think mid-length culottes and borrowed-from-the-boy longline styles for a more conservative take on the cropped length. But flesh-baring styles are still big for nights out, with shouty sequin shorts statement and denim hotpants easy to wear for cool-casual evenings. Dress down embellished designs with a slogan tee for added edge.", "descriptionShort": "Womens Mid Rise Frayed Hem Denim Booty Shorts - blue - 2 - Parade your pins in a pair of shorts A versatile day-to-night option, new season shorts aren't all about showing some leg - think mid-length culottes and borrowed-from-the-boy longline styles for a more conservative take on the cropped length. But flesh-baring styles are still big for nights out, with shouty sequin shorts statement and denim hotpants easy to wear for cool-casual evenings. Dress down embellished designs with a slogan tee for added edge.", "originalPortalUrl": "https://api.shopstyle.com/action/apiVisitRetailer?id=602747860&pid=uid7249-42318943-68"}
10	{"size": "6", "brand": "boohoo", "color": "Black", "price": 18.0, "images": ["https://img.shopstyle-cdn.com/sim/00/91/0091a72fe38e152fd72e98151a463b1f_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/08/e2/08e23c0dc8379406ccb4daa01c46aeea_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/37/75/3775a0b841aff20729bf4c4874c87056_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/6f/16/6f16cadd477d0e6441be93a42877a499_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/88/84/88846fbc2aedebb7028ab5756837cca9_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/b5/25/b52584fdd0c5097d6da7f42e520e3ab0_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/b8/b5/b8b57a882249acc1c94a29b26b644685_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/d1/2a/d12a9966fd0d60c506dea477efed78d8_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/d4/7a/d47aafb98badb229a22fb8a6fe28e4a2_best/basic-ribbed-biker-short.jpg", "https://img.shopstyle-cdn.com/sim/d5/7a/d57a8b76ff4a1fdebbd1896bce7f454f_best/basic-ribbed-biker-short.jpg"], "portal": "shopstyle", "inStock": true, "currency": "USD", "parentId": "shopstyle_822286146", "priceSale": 7.2, "productId": "18c6f38125c6763b62778fea9f85ef2b", "categories": [["Shorts", "Women's Shorts"]], "cleanedSize": ["6"], "originalUrl": null, "productLink": "https://api.shopstyle.com/action/apiVisitRetailer?id=822286146&pid=uid7249-42318943-68", "productName": "Basic Ribbed Biker Short", "productType": "Shorts", "manufacturer": "boohoo", "retailerName": "boohoo", "priceShipping": null, "descriptionLong": "Womens Basic Ribbed Biker Short - orange - 4 - Parade your pins in a pair of shorts A versatile day-to-night option, new season shorts aren't all about showing some leg - think mid-length culottes and borrowed-from-the-boy longline styles for a more conservative take on the cropped length. But flesh-baring styles are still big for nights out, with shouty sequin shorts statement and denim hotpants easy to wear for cool-casual evenings. Dress down embellished designs with a slogan tee for added edge.", "descriptionShort": "Womens Basic Ribbed Biker Short - orange - 4 - Parade your pins in a pair of shorts A versatile day-to-night option, new season shorts aren't all about showing some leg - think mid-length culottes and borrowed-from-the-boy longline styles for a more conservative take on the cropped length. But flesh-baring styles are still big for nights out, with shouty sequin shorts statement and denim hotpants easy to wear for cool-casual evenings. Dress down embellished designs with a slogan tee for added edge.", "originalPortalUrl": "https://api.shopstyle.com/action/apiVisitRetailer?id=822286146&pid=uid7249-42318943-68"}
11	{"size": "27", "brand": "Paige", "color": "Black", "price": 209.0, "images": ["https://img.shopstyle-cdn.com/sim/65/d6/65d6ac1d28973a297b9f7e90726fda81_best/verdugo-ultra-skinny-velvet-pants.jpg", "https://img.shopstyle-cdn.com/sim/15/b2/15b261a0f8de62131ed0eb2244adea1a_best/verdugo-ultra-skinny-velvet-pants.jpg", "https://img.shopstyle-cdn.com/sim/69/0d/690df41ed19b16b439625acc216efb4b_best/verdugo-ultra-skinny-velvet-pants.jpg", "https://img.shopstyle-cdn.com/sim/99/30/9930570afeeaf39af2400cf3e7e054cb_best/verdugo-ultra-skinny-velvet-pants.jpg", "https://img.shopstyle-cdn.com/sim/e2/4c/e24c70ad0d2ae417bae99a51cd2d7d68_best/verdugo-ultra-skinny-velvet-pants.jpg", "https://img.shopstyle-cdn.com/sim/f3/b5/f3b5f3dc9a3fabd85908e1d65224d055_best/verdugo-ultra-skinny-velvet-pants.jpg"], "portal": "shopstyle", "inStock": true, "currency": "USD", "parentId": "shopstyle_539265657", "priceSale": null, "productId": "7422580fbeb35a5fcb48173e5a2ae916", "categories": [["Skinny", "Women's Skinny Pants"]], "cleanedSize": ["27"], "originalUrl": null, "productLink": "https://api.shopstyle.com/action/apiVisitRetailer?id=539265657&pid=uid7249-42318943-68", "productName": "Verdugo Ultra Skinny Velvet Pants", "productType": "Pants", "manufacturer": "Paige", "retailerName": "Nordstrom", "priceShipping": null, "descriptionLong": "PAIGE's ultra-skinny silhouette goes luxe with sumptuous velvet in deep hues. Logo-etched hardware completes the cleanly styled pants. Style Name:Paige Verdugo Ultra Skinny Velvet Pants (Nordstrom Exclusive). Style Number: 5203707. Available in stores.", "descriptionShort": "PAIGE's ultra-skinny silhouette goes luxe with sumptuous velvet in deep hues. Logo-etched hardware completes the cleanly styled pants. Style Name:Paige Verdugo Ultra Skinny Velvet Pants (Nordstrom Exclusive). Style Number: 5203707. Available in stores.", "originalPortalUrl": "https://api.shopstyle.com/action/apiVisitRetailer?id=539265657&pid=uid7249-42318943-68"}
12	{"size": "4", "brand": "boohoo", "color": "Green", "price": 18.0, "images": ["https://img.shopstyle-cdn.com/sim/31/ea/31eab28b6403d43f50284662514a1064_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/11/0e/110ed90e6d4aa85d81e4f2bfaf5b6980_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/32/70/3270651a57e52580f9e7d802802f563d_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/4f/da/4fda4edf9bcbbcbd463694a557f57816_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/7f/81/7f8114cf9f1030aefec9dc639032f8c9_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/a0/b6/a0b69c48de8c6428450b8a9c67e9e219_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/bc/17/bc170ec7dfbe9fe7dc96a56128ec210d_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/f4/c4/f4c4eef57a3082f9b5e12f53147bf631_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/f6/5f/f65fa24d03d1786842a1164c9b9b0580_best/basic-jersey-flippy-shorts.jpg", "https://img.shopstyle-cdn.com/sim/f6/ee/f6ee4724304df49b6a8a589712a5c6f6_best/basic-jersey-flippy-shorts.jpg"], "portal": "shopstyle", "inStock": true, "currency": "USD", "parentId": "shopstyle_838455733", "priceSale": 7.2, "productId": "5b3ad5e9a604b44a6d37b72ace383940", "categories": [["Shorts", "Women's Shorts"]], "cleanedSize": ["4"], "originalUrl": null, "productLink": "https://api.shopstyle.com/action/apiVisitRetailer?id=838455733&pid=uid7249-42318943-68", "productName": "Basic Jersey Flippy Shorts", "productType": "Shorts", "manufacturer": "boohoo", "retailerName": "boohoo", "priceShipping": null, "descriptionLong": "Womens Basic Jersey Flippy Shorts - pink - 4 - Parade your pins in a pair of shorts A versatile day-to-night option, new season shorts aren't all about showing some leg - think mid-length culottes and borrowed-from-the-boy longline styles for a more conservative take on the cropped length. But flesh-baring styles are still big for nights out, with shouty sequin shorts statement and denim hotpants easy to wear for cool-casual evenings. Dress down embellished designs with a slogan tee for added edge.", "descriptionShort": "Womens Basic Jersey Flippy Shorts - pink - 4 - Parade your pins in a pair of shorts A versatile day-to-night option, new season shorts aren't all about showing some leg - think mid-length culottes and borrowed-from-the-boy longline styles for a more conservative take on the cropped length. But flesh-baring styles are still big for nights out, with shouty sequin shorts statement and denim hotpants easy to wear for cool-casual evenings. Dress down embellished designs with a slogan tee for added edge.", "originalPortalUrl": "https://api.shopstyle.com/action/apiVisitRetailer?id=838455733&pid=uid7249-42318943-68"}
13	{"size": "8.5", "brand": "Adam Tucker by Me Too", "color": "Cream", "price": 56.99, "images": ["https://img.shopstyle-cdn.com/sim/ec/e2/ece2eb34fc67ebb6dc55c8947b1362f2_best/brayden-espadrille-wedge-sandal.jpg", "https://img.shopstyle-cdn.com/sim/0a/21/0a21ef4eaeceb0bf2c53de75b861df3a_best/brayden-espadrille-wedge-sandal.jpg", "https://img.shopstyle-cdn.com/sim/17/8d/178dca0402b4512d73f20d44421d3a9a_best/brayden-espadrille-wedge-sandal.jpg", "https://img.shopstyle-cdn.com/sim/24/4f/244f8084d620bd3b87698d665cf45d30_best/brayden-espadrille-wedge-sandal.jpg", "https://img.shopstyle-cdn.com/sim/65/a9/65a9a061cd9a07d34c151d0d0e0e6b1a_best/brayden-espadrille-wedge-sandal.jpg", "https://img.shopstyle-cdn.com/sim/6b/8c/6b8cc6dac92cc92d731c730b7c4265a5_best/brayden-espadrille-wedge-sandal.jpg", "https://img.shopstyle-cdn.com/sim/6e/a2/6ea26e71346d699e02e5d1a8c7d134e2_best/brayden-espadrille-wedge-sandal.jpg", "https://img.shopstyle-cdn.com/sim/b6/23/b623f065839534232d5f4955c33414c0_best/brayden-espadrille-wedge-sandal.jpg", "https://img.shopstyle-cdn.com/sim/cd/c4/cdc46419015d0a92c7770704400f6611_best/brayden-espadrille-wedge-sandal.jpg", "https://img.shopstyle-cdn.com/sim/f3/a8/f3a8affd8c6da0b269e20ba5d4449e89_best/brayden-espadrille-wedge-sandal.jpg", "https://img.shopstyle-cdn.com/sim/fd/4a/fd4a1bb34af4137deabab5efb55b66c7_best/brayden-espadrille-wedge-sandal.jpg"], "portal": "shopstyle", "inStock": true, "currency": "USD", "parentId": "shopstyle_776958140", "priceSale": null, "productId": "e4165a5bb395da3872ae07aecbd3d8f2", "categories": [["Sandals", "Women's Sandals"], ["Wedges", "Wedges"]], "cleanedSize": ["8.5"], "originalUrl": null, "productLink": "https://api.shopstyle.com/action/apiVisitRetailer?id=776958140&pid=uid7249-42318943-68", "productName": "Brayden Espadrille Wedge Sandal", "productType": "Shoes", "manufacturer": "Adam Tucker by Me Too", "retailerName": "DSW", "priceShipping": null, "descriptionLong": "Adam Tucker by Me Too brings you the Brayden wedge sandal. This silhouette is fashioned with elastic crisscross straps and casual styling with the espadrille midsole. Canvas & stretch fabric upper Elastic crisscross straps Round toe Synthetic lining Cushioned footbed 31⁄4\\" espadrille wedge heel Synthetic sole Imported", "descriptionShort": "Adam Tucker by Me Too brings you the Brayden wedge sandal. This silhouette is fashioned with elastic crisscross straps and casual styling with the espadrille midsole. Canvas & stretch fabric upper Elastic crisscross straps Round toe Synthetic lining Cushioned footbed 31⁄4\\" espadrille wedge heel Synthetic sole Imported", "originalPortalUrl": "https://api.shopstyle.com/action/apiVisitRetailer?id=776958140&pid=uid7249-42318943-68"}
14	{"size": "6", "brand": "Easy Street Shoes", "color": "Black", "price": 49.99, "images": ["https://img.shopstyle-cdn.com/sim/f6/31/f631c4d88af14bcd6a9f51c04cb266c0_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/1b/e5/1be5e462ad6d3483e03bc7c8ac0885e6_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/2a/09/2a09ead6e06dd6fc590b828a2d825954_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/37/8f/378f8882c588ed81abe19a0ecc03e7b8_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/47/4e/474eb089ec1adcb6a80764f19132851f_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/60/a1/60a1ba7e83043d5407a81d2db760a7dd_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/71/26/71261e50b87dc7b28bbd7360a0554b0b_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/bb/cc/bbcccb035f2b61fc7d7076459c3b33f3_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/bd/87/bd8782ef57d003205fa505a67fc73969_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/e3/68/e3687541bb6cf9a6bfcaf8aa31a59d00_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/fc/21/fc21feca95e37b09c3594ee75689da1c_best/nori-sandal.jpg"], "portal": "shopstyle", "inStock": true, "currency": "USD", "parentId": "shopstyle_618407501", "priceSale": null, "productId": "652f2c23a907b6b610453e95d013bc86", "categories": [["Sandals", "Women's Sandals"]], "cleanedSize": ["6"], "originalUrl": null, "productLink": "https://api.shopstyle.com/action/apiVisitRetailer?id=618407501&pid=uid7249-42318943-68", "productName": "Nori Sandal", "productType": "Shoes", "manufacturer": "Easy Street Shoes", "retailerName": "DSW", "priceShipping": null, "descriptionLong": "Slip on the Nori slide sandals from Easy Street to complement your classic style! Comfy and versatile, these strappy sandals are the perfect flat sandals to pair with anything in your summer wardrobe! Faux leather upper Slip-on Round open toe Comfort cushioned footbed 1\\" molded heel Lightweight & flexible synthetic sole Imported", "descriptionShort": "Slip on the Nori slide sandals from Easy Street to complement your classic style! Comfy and versatile, these strappy sandals are the perfect flat sandals to pair with anything in your summer wardrobe! Faux leather upper Slip-on Round open toe Comfort cushioned footbed 1\\" molded heel Lightweight & flexible synthetic sole Imported", "originalPortalUrl": "https://api.shopstyle.com/action/apiVisitRetailer?id=618407501&pid=uid7249-42318943-68"}
15	{"size": "7.5", "brand": "Easy Street Shoes", "color": "Tan", "price": 49.99, "images": ["https://img.shopstyle-cdn.com/sim/f6/31/f631c4d88af14bcd6a9f51c04cb266c0_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/1b/e5/1be5e462ad6d3483e03bc7c8ac0885e6_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/2a/09/2a09ead6e06dd6fc590b828a2d825954_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/37/8f/378f8882c588ed81abe19a0ecc03e7b8_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/47/4e/474eb089ec1adcb6a80764f19132851f_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/60/a1/60a1ba7e83043d5407a81d2db760a7dd_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/71/26/71261e50b87dc7b28bbd7360a0554b0b_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/bb/cc/bbcccb035f2b61fc7d7076459c3b33f3_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/bd/87/bd8782ef57d003205fa505a67fc73969_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/e3/68/e3687541bb6cf9a6bfcaf8aa31a59d00_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/fc/21/fc21feca95e37b09c3594ee75689da1c_best/nori-sandal.jpg"], "portal": "shopstyle", "inStock": true, "currency": "USD", "parentId": "shopstyle_618407501", "priceSale": null, "productId": "b72223ede3911dc450584a3e94591af6", "categories": [["Sandals", "Women's Sandals"]], "cleanedSize": ["7.5"], "originalUrl": null, "productLink": "https://api.shopstyle.com/action/apiVisitRetailer?id=618407501&pid=uid7249-42318943-68", "productName": "Nori Sandal", "productType": "Shoes", "manufacturer": "Easy Street Shoes", "retailerName": "DSW", "priceShipping": null, "descriptionLong": "Slip on the Nori slide sandals from Easy Street to complement your classic style! Comfy and versatile, these strappy sandals are the perfect flat sandals to pair with anything in your summer wardrobe! Faux leather upper Slip-on Round open toe Comfort cushioned footbed 1\\" molded heel Lightweight & flexible synthetic sole Imported", "descriptionShort": "Slip on the Nori slide sandals from Easy Street to complement your classic style! Comfy and versatile, these strappy sandals are the perfect flat sandals to pair with anything in your summer wardrobe! Faux leather upper Slip-on Round open toe Comfort cushioned footbed 1\\" molded heel Lightweight & flexible synthetic sole Imported", "originalPortalUrl": "https://api.shopstyle.com/action/apiVisitRetailer?id=618407501&pid=uid7249-42318943-68"}
16	{"size": "12", "brand": "Easy Street Shoes", "color": "White", "price": 49.99, "images": ["https://img.shopstyle-cdn.com/sim/f6/31/f631c4d88af14bcd6a9f51c04cb266c0_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/1b/e5/1be5e462ad6d3483e03bc7c8ac0885e6_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/2a/09/2a09ead6e06dd6fc590b828a2d825954_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/37/8f/378f8882c588ed81abe19a0ecc03e7b8_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/47/4e/474eb089ec1adcb6a80764f19132851f_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/60/a1/60a1ba7e83043d5407a81d2db760a7dd_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/71/26/71261e50b87dc7b28bbd7360a0554b0b_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/bb/cc/bbcccb035f2b61fc7d7076459c3b33f3_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/bd/87/bd8782ef57d003205fa505a67fc73969_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/e3/68/e3687541bb6cf9a6bfcaf8aa31a59d00_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/fc/21/fc21feca95e37b09c3594ee75689da1c_best/nori-sandal.jpg"], "portal": "shopstyle", "inStock": true, "currency": "USD", "parentId": "shopstyle_618407501", "priceSale": null, "productId": "a7a6208a1548a783bdc47ec331953b0b", "categories": [["Sandals", "Women's Sandals"]], "cleanedSize": ["12"], "originalUrl": null, "productLink": "https://api.shopstyle.com/action/apiVisitRetailer?id=618407501&pid=uid7249-42318943-68", "productName": "Nori Sandal", "productType": "Shoes", "manufacturer": "Easy Street Shoes", "retailerName": "DSW", "priceShipping": null, "descriptionLong": "Slip on the Nori slide sandals from Easy Street to complement your classic style! Comfy and versatile, these strappy sandals are the perfect flat sandals to pair with anything in your summer wardrobe! Faux leather upper Slip-on Round open toe Comfort cushioned footbed 1\\" molded heel Lightweight & flexible synthetic sole Imported", "descriptionShort": "Slip on the Nori slide sandals from Easy Street to complement your classic style! Comfy and versatile, these strappy sandals are the perfect flat sandals to pair with anything in your summer wardrobe! Faux leather upper Slip-on Round open toe Comfort cushioned footbed 1\\" molded heel Lightweight & flexible synthetic sole Imported", "originalPortalUrl": "https://api.shopstyle.com/action/apiVisitRetailer?id=618407501&pid=uid7249-42318943-68"}
17	{"size": "10", "brand": "Easy Street Shoes", "color": "Navy", "price": 49.99, "images": ["https://img.shopstyle-cdn.com/sim/f6/31/f631c4d88af14bcd6a9f51c04cb266c0_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/1b/e5/1be5e462ad6d3483e03bc7c8ac0885e6_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/2a/09/2a09ead6e06dd6fc590b828a2d825954_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/37/8f/378f8882c588ed81abe19a0ecc03e7b8_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/47/4e/474eb089ec1adcb6a80764f19132851f_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/60/a1/60a1ba7e83043d5407a81d2db760a7dd_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/71/26/71261e50b87dc7b28bbd7360a0554b0b_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/bb/cc/bbcccb035f2b61fc7d7076459c3b33f3_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/bd/87/bd8782ef57d003205fa505a67fc73969_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/e3/68/e3687541bb6cf9a6bfcaf8aa31a59d00_best/nori-sandal.jpg", "https://img.shopstyle-cdn.com/sim/fc/21/fc21feca95e37b09c3594ee75689da1c_best/nori-sandal.jpg"], "portal": "shopstyle", "inStock": true, "currency": "USD", "parentId": "shopstyle_618407501", "priceSale": null, "productId": "461a08bb8bb67b5f6587ee5dd7879c43", "categories": [["Sandals", "Women's Sandals"]], "cleanedSize": ["10"], "originalUrl": null, "productLink": "https://api.shopstyle.com/action/apiVisitRetailer?id=618407501&pid=uid7249-42318943-68", "productName": "Nori Sandal", "productType": "Shoes", "manufacturer": "Easy Street Shoes", "retailerName": "DSW", "priceShipping": null, "descriptionLong": "Slip on the Nori slide sandals from Easy Street to complement your classic style! Comfy and versatile, these strappy sandals are the perfect flat sandals to pair with anything in your summer wardrobe! Faux leather upper Slip-on Round open toe Comfort cushioned footbed 1\\" molded heel Lightweight & flexible synthetic sole Imported", "descriptionShort": "Slip on the Nori slide sandals from Easy Street to complement your classic style! Comfy and versatile, these strappy sandals are the perfect flat sandals to pair with anything in your summer wardrobe! Faux leather upper Slip-on Round open toe Comfort cushioned footbed 1\\" molded heel Lightweight & flexible synthetic sole Imported", "originalPortalUrl": "https://api.shopstyle.com/action/apiVisitRetailer?id=618407501&pid=uid7249-42318943-68"}
\.


--
-- TOC entry 3003 (class 0 OID 16401)
-- Dependencies: 204
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rating (rating_id, fk_product_id, fk_user_id, "like", created_at) FROM stdin;
1	4	3	t	2020-07-13 18:19:59.768692+00
2	2	3	t	2020-07-13 18:20:40.746309+00
3	2	1	t	2020-07-13 18:51:10.50666+00
4	5	4	t	2020-07-13 18:51:26.685654+00
5	6	4	f	2020-07-13 18:51:32.108285+00
7	10	2	f	2020-07-13 19:08:54.899295+00
8	8	2	f	2020-07-13 19:10:56.22038+00
9	6	2	t	2020-07-13 19:11:02.841679+00
10	1	2	t	2020-07-13 19:11:09.20986+00
\.


--
-- TOC entry 3005 (class 0 OID 16407)
-- Dependencies: 206
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (user_id, is_new, created_at) FROM stdin;
1	t	11:15:04.283216+00
3	t	11:15:04.283216+00
4	t	11:15:04.283216+00
5	t	16:15:15.244578+00
6	t	16:39:02.034411+00
2	f	11:15:04.283216+00
\.


--
-- TOC entry 3021 (class 0 OID 0)
-- Dependencies: 208
-- Name: abtest_abtest_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.abtest_abtest_id_seq1', 1, true);


--
-- TOC entry 3022 (class 0 OID 0)
-- Dependencies: 210
-- Name: abtest_allocations_allocation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.abtest_allocations_allocation_id_seq', 1, true);


--
-- TOC entry 3023 (class 0 OID 0)
-- Dependencies: 203
-- Name: product_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_product_id_seq', 17, true);


--
-- TOC entry 3024 (class 0 OID 0)
-- Dependencies: 205
-- Name: rating_rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rating_rating_id_seq', 10, true);


--
-- TOC entry 3025 (class 0 OID 0)
-- Dependencies: 207
-- Name: user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_user_id_seq', 6, true);


--
-- TOC entry 2870 (class 2606 OID 16464)
-- Name: abtest_allocation abtest_allocations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abtest_allocation
    ADD CONSTRAINT abtest_allocations_pkey PRIMARY KEY (allocation_id);


--
-- TOC entry 2868 (class 2606 OID 16452)
-- Name: abtest abtest_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abtest
    ADD CONSTRAINT abtest_pkey1 PRIMARY KEY (abtest_id);


--
-- TOC entry 2862 (class 2606 OID 16420)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);


--
-- TOC entry 2864 (class 2606 OID 16422)
-- Name: rating rating_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_pkey PRIMARY KEY (rating_id);


--
-- TOC entry 2866 (class 2606 OID 16424)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (user_id);


--
-- TOC entry 2874 (class 2606 OID 16470)
-- Name: abtest_allocation abtest_allocations_fk_abtest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abtest_allocation
    ADD CONSTRAINT abtest_allocations_fk_abtest_id_fkey FOREIGN KEY (fk_abtest_id) REFERENCES public.abtest(abtest_id);


--
-- TOC entry 2873 (class 2606 OID 16465)
-- Name: abtest_allocation abtest_allocations_fk_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abtest_allocation
    ADD CONSTRAINT abtest_allocations_fk_user_id_fkey FOREIGN KEY (fk_user_id) REFERENCES public."user"(user_id);


--
-- TOC entry 2871 (class 2606 OID 16430)
-- Name: rating rating_fk_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_fk_product_id_fkey FOREIGN KEY (fk_product_id) REFERENCES public.product(product_id);


--
-- TOC entry 2872 (class 2606 OID 16435)
-- Name: rating rating_fk_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_fk_user_id_fkey FOREIGN KEY (fk_user_id) REFERENCES public."user"(user_id);


-- Completed on 2020-07-13 20:34:57 UTC

--
-- PostgreSQL database dump complete
--

