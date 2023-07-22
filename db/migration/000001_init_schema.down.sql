-- Drop foreign keys first to avoid constraint errors

-- Drop foreign key constraints from the "razorpays" table
ALTER TABLE "razorpays" DROP CONSTRAINT "razorpays_userid_fkey";

-- Drop foreign key constraints from the "oder_items" table
ALTER TABLE "oder_items" DROP CONSTRAINT "oder_items_user_id_no_fkey";
ALTER TABLE "oder_items" DROP CONSTRAINT "oder_items_payment_id_fkey";
ALTER TABLE "oder_items" DROP CONSTRAINT "oder_items_add_id_fkey";

-- Drop foreign key constraints from the "order_details" table
ALTER TABLE "order_details" DROP CONSTRAINT "order_details_userid_fkey";
ALTER TABLE "order_details" DROP CONSTRAINT "order_details_addressid_fkey";
ALTER TABLE "order_details" DROP CONSTRAINT "order_details_payment_id_fkey";
ALTER TABLE "order_details" DROP CONSTRAINT "order_details_oder_item_id_fkey";
ALTER TABLE "order_details" DROP CONSTRAINT "order_details_product_id_fkey";

-- Drop foreign key constraints from the "payments" table
ALTER TABLE "payments" DROP CONSTRAINT "payments_user_id_fkey";

-- Drop foreign key constraints from the "wishlists" table
ALTER TABLE "wishlists" DROP CONSTRAINT "wishlists_userid_fkey";
ALTER TABLE "wishlists" DROP CONSTRAINT "wishlists_product_id_fkey";

-- Drop foreign key constraints from the "images" table
ALTER TABLE "images" DROP CONSTRAINT "images_product_id_fkey";

-- Drop foreign key constraints from the "carts" table
ALTER TABLE "carts" DROP CONSTRAINT "carts_product_id_fkey";
ALTER TABLE "carts" DROP CONSTRAINT "carts_userid_fkey";

-- Drop foreign key constraints from the "products" table
ALTER TABLE "products" DROP CONSTRAINT "products_catogery_id_fkey";
ALTER TABLE "products" DROP CONSTRAINT "products_brand_id_fkey";

-- Drop foreign key constraints from the "addresses" table
ALTER TABLE "addresses" DROP CONSTRAINT "addresses_userid_fkey";

-- Drop tables in reverse order of creation to avoid dependencies
DROP TABLE IF EXISTS "sessions";
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
DROP TABLE IF EXISTS "users";