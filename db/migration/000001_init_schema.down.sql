-- Drop foreign key constraints
ALTER TABLE "wallet_history" DROP CONSTRAINT "wallet_history_user_id_fkey";
ALTER TABLE "wallets" DROP CONSTRAINT "wallets_user_id_fkey";
ALTER TABLE "razorpays" DROP CONSTRAINT "razorpays_user_id_fkey";
ALTER TABLE "order_details" DROP CONSTRAINT "order_details_product_id_fkey";
ALTER TABLE "order_details" DROP CONSTRAINT "order_details_oder_item_id_fkey";
ALTER TABLE "order_details" DROP CONSTRAINT "order_details_payment_id_fkey";
ALTER TABLE "order_details" DROP CONSTRAINT "order_details_addressid_fkey";
ALTER TABLE "order_details" DROP CONSTRAINT "order_details_user_id_fkey";
ALTER TABLE "payments" DROP CONSTRAINT "payments_user_id_fkey";
ALTER TABLE "wishlists" DROP CONSTRAINT "wishlists_product_id_fkey";
ALTER TABLE "wishlists" DROP CONSTRAINT "wishlists_user_id_fkey";
ALTER TABLE "images" DROP CONSTRAINT "images_product_id_fkey";
ALTER TABLE "carts" DROP CONSTRAINT "carts_user_id_fkey";
ALTER TABLE "carts" DROP CONSTRAINT "carts_product_id_fkey";
ALTER TABLE "products" DROP CONSTRAINT "products_brand_id_fkey";
ALTER TABLE "products" DROP CONSTRAINT "products_catogery_id_fkey";
ALTER TABLE "addresses" DROP CONSTRAINT "addresses_user_id_fkey";
ALTER TABLE "sessions" DROP CONSTRAINT "sessions_user_id_fkey";

-- Drop tables
DROP TABLE IF EXISTS "wallet_history";
DROP TABLE IF EXISTS "wallets";
DROP TABLE IF EXISTS "razorpays";
DROP TABLE IF EXISTS "coupons";
DROP TABLE IF EXISTS "oder_items";
DROP TABLE IF EXISTS "order_details";
DROP TABLE IF EXISTS "payments";
DROP TABLE IF EXISTS "wishlists";
DROP TABLE IF EXISTS "images";
DROP TABLE IF EXISTS "carts";
DROP TABLE IF EXISTS "products";
DROP TABLE IF EXISTS "brands";
DROP TABLE IF EXISTS "catogeries";
DROP TABLE IF EXISTS "admins";
DROP TABLE IF EXISTS "addresses";
DROP TABLE IF EXISTS "sessions";
DROP TABLE IF EXISTS "users";
