# SESI 1
# TAMPILKANLAH 10 PEMESANAN TERBARU YANG TELAH SELESAI PADA DATABASE THE LOO ECOMMERCE

SELECT order_id, status, created_at from bigquery-public-data.thelook_ecommerce.orders
where status = "Complete"
order by  created_at DESC
limit 10;

-- select distinct(status) from bigquery-public-data.thelook_ecommerce.orders

-- select distinct (country) from bigquery-public-data.thelook_ecommerce.users

# LATIHAN SESI 1
# TAMPILKANLAH NAMA PEMBELI YANG BERASAL DARI AMERIKA SERIKAT DENGAN UMUR DI ATAS 20 TAHUN
select id,
        first_name,
        last_name,
        from bigquery-public-data.thelook_ecommerce.users
where country = "United States" and age >20;

--------------------------------------------------------------

# SESI 2
# TAMPILKANLAH 10 USER DENGAN TOTAL ORDER TERBANYAK

SELECT user_id, count(order_id) AS total_order
FROM bigquery-public-data.thelook_ecommerce.orders
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

# TAMPILKANLAH 10 USER DENGAN TOTAL ORDER TERBANYAK BERDASARKAN GENDER
SELECT user_id, #NAg
        gender, #NAg
        count(order_id) AS total_order #Ag
FROM bigquery-public-data.thelook_ecommerce.orders
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 10;

# LATIHAN SESI 2
# TAMPILKANLAH 5 PRODUK YANG MEMILIKI HARGA JUAL MINIMUM TERTINGGI DAN BERAPA BANYAK TRANSAKSI YANG TERJADI
# Ketentuan: status transaksi "Complete", hitung jumlah transaksi, hanya tampilkan jumlah transaksi lebih dari 4, urutkan harga minimum tertinggi, tampilkan 5 produk teratas

SELECT product_id,
        MIN (sale_price) AS min_sales,
        COUNT(order_id) AS total_order
FROM bigquery-public-data.thelook_ecommerce.order_items
WHERE status = "Complete"
GROUP BY 1
HAVING total_order > 4
ORDER BY 2 DESC
LIMIT 5;

--------------------------------------------------------
# SESI 3
# Tampilkan order id, status, created at, first name, country

SELECT o.order_id, o.status, o.created_at, u.first_name, u.country
      FROM bigquery-public-data.thelook_ecommerce.orders o
      INNER JOIN bigquery-public-data.thelook_ecommerce.users u
      ON o.user_id = u.id
WHERE u.gender = 'F';

# LATIHAN MANDIRI - SOAL 1 (DASAR INNER JOIN)
# Tampilkan data order_id, user_id, status, created_at, serta first_name dan last_name dari user yang melakukan order.

SELECT o.order_id, o.user_id, o.status, o.created_at, u.first_name, u.last_name
      FROM bigquery-public-data.thelook_ecommerce.orders o
      INNER JOIN bigquery-public-data.thelook_ecommerce.users u
      ON o.user_id = u.id
WHERE status = "Complete"

# LATIHAN MANDIRI - SOAL 2 (INNER JOIN & FILTER)
# Tampilkan nama user dan jumlah order yang mereka lakukan, tetapi hanya untuk order dengan status Complete. Urutkan dari jumlah order terbanyak.
# Output: user_id, first_name, last_name, total_order

SELECT o.user_id, u.first_name, u.last_name, COUNT(o.order_id) AS total_order
      FROM bigquery-public-data.thelook_ecommerce.orders o
      INNER JOIN bigquery-public-data.thelook_ecommerce.users u
      ON o.user_id = u.id
WHERE o.status = "Complete"
GROUP BY 1, 2, 3
ORDER BY total_order DESC;

# LATIHAN MANDIRI - SOAL 3 (MENCARI CUSTOMER DENGAN TOTAL PEMBELIAN)

SELECT u.id,
      u.first_name,
      u.last_name,
      COUNT(DISTINCT o.order_id) AS jumlah_transaksi,
      SUM(oi.sale_price) AS total_pembelian
FROM bigquery-public-data.thelook_ecommerce.users u
INNER JOIN bigquery-public-data.thelook_ecommerce.orders o
ON u.id = o.user_id
INNER JOIN bigquery-public-data.thelook_ecommerce.order_items oi
ON o.order_id = oi.order_id
WHERE o.status = "Complete"
GROUP BY 1, 2, 3
ORDER BY total_pembelian DESC
LIMIT 10;

---------------------------
# SESI 4
# 5 country dengan jumlah order terbesar
# bisa pakai tabel user, order, order_items
# cek-cek dulu memastikan tabel mana yang perlu menggunakan distinct
# 1 tabel order
select
count (order_id) as count_order,
count (distinct(order_id)) as unique_count_order from bigquery-public-data.thelook_ecommerce.orders

# 2 tabel order_items
select
count (order_id) as count_order,
count (distinct(order_id)) as unique_count_order from bigquery-public-data.thelook_ecommerce.order_items


# OPSI 1
SELECT u.country, count (distinct(o.order_id)) as jumlah_order
from bigquery-public-data.thelook_ecommerce.users u
inner join bigquery-public-data.thelook_ecommerce.orders o
on u.id = o.user_id
group by u.country
order by jumlah_order DESC
limit 5;

# LATIHAN SESI 5
# Ada berapa banyak PRODUCT yang sudah terjual? Dan berapa harga rata-rata jualnya? (Retail Price)

# Tampilkan PRODUCT yang sudah terjual dengan rata-rata RETAIL PRICE dan rata-rata SALE PRICE. Urutkan berdasarkan rata-rata PRICE terbesar sampai terkecil.

# kolom PRODUCTS & ORDER_ITEMS
-- SELECT DISTINCT STATUS FROM bigquery-public-data.thelook_ecommerce.order_items

select p.name, AVG(p.retail_price) AS HARGA_JUAL_RATARATA, AVG(oi.sale_price) AS HARGA_JUAL
FROM bigquery-public-data.thelook_ecommerce.products p
INNER JOIN bigquery-public-data.thelook_ecommerce.order_items oi
on p.id = oi.product_id
WHERE oi.status = "Complete"
GROUP BY 1
ORDER BY 2 DESC;

