CREATE TABLE "users" (
  "id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(50) NOT NULL,
  "last_name" VARCHAR(50) NOT NULL,
  "email" VARCHAR(255) UNIQUE NOT NULL,
  "hashed_password" VARCHAR(255) NOT NULL,
  "phone" INTEGER UNIQUE NOT NULL,
  "is_admin" BOOLEAN DEFAULT false,
  "otp" VARCHAR(255),
  "is_blocked" BOOLEAN DEFAULT false,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "addresses" (
  "addressid" SERIAL PRIMARY KEY,
  "userid" INTEGER,
  "name" VARCHAR(255) NOT NULL,
  "phoneno" VARCHAR(20) NOT NULL,
  "houseno" VARCHAR(100) NOT NULL,
  "area" VARCHAR(255) NOT NULL,
  "landmark" VARCHAR(255) NOT NULL,
  "city" VARCHAR(100) NOT NULL,
  "pincode" VARCHAR(20) NOT NULL,
  "district" VARCHAR(100) NOT NULL,
  "state" VARCHAR(100) NOT NULL,
  "country" VARCHAR(100) NOT NULL,
  "defaultadd" BOOLEAN DEFAULT false
);

CREATE TABLE "admins" (
  "id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(50) NOT NULL,
  "last_name" VARCHAR(50) NOT NULL,
  "email" VARCHAR(255) UNIQUE NOT NULL,
  "hashed_password" VARCHAR(255) NOT NULL,
  "phone" INTEGER UNIQUE NOT NULL,
  "is_admin" BOOLEAN DEFAULT true
);

CREATE TABLE "catogeries" (
  "id" SERIAL PRIMARY KEY,
  "catogery_name" VARCHAR(255)
);

CREATE TABLE "brands" (
  "id" SERIAL PRIMARY KEY,
  "brand_name" VARCHAR(255) NOT NULL
);

CREATE TABLE "products" (
  "product_id" SERIAL PRIMARY KEY,
  "product_name" VARCHAR(255) NOT NULL,
  "description" TEXT NOT NULL,
  "stock" INTEGER NOT NULL,
  "price" INTEGER NOT NULL,
  "catogery_id" INTEGER,
  "brand_id" INTEGER
);

CREATE TABLE "carts" (
  "id" SERIAL PRIMARY KEY,
  "product_id" INTEGER,
  "quantity" INTEGER NOT NULL,
  "price" INTEGER NOT NULL,
  "total_price" INTEGER NOT NULL,
  "userid" INTEGER
);

CREATE TABLE "images" (
  "id" SERIAL PRIMARY KEY,
  "product_id" INTEGER,
  "image" VARCHAR(255) NOT NULL
);

CREATE TABLE "wishlists" (
  "id" SERIAL PRIMARY KEY,
  "userid" INTEGER,
  "product_id" INTEGER
);

CREATE TABLE "payments" (
  "payment_id" SERIAL PRIMARY KEY,
  "user_id" INTEGER,
  "payment_method" VARCHAR(255) NOT NULL,
  "total_amount" INTEGER NOT NULL,
  "status" VARCHAR(255) NOT NULL,
  "date" timestamp
);

CREATE TABLE "order_details" (
  "oderid" SERIAL PRIMARY KEY,
  "userid" INTEGER,
  "addressid" INTEGER,
  "payment_id" INTEGER,
  "oder_item_id" INTEGER,
  "product_id" INTEGER,
  "quantity" INTEGER NOT NULL,
  "status" VARCHAR(255) NOT NULL,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "oder_items" (
  "order_id" SERIAL PRIMARY KEY,
  "user_id_no" INTEGER NOT NULL,
  "total_amount" INTEGER NOT NULL,
  "payment_id" INTEGER,
  "order_status" VARCHAR(255),
  "add_id" INTEGER,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "coupons" (
  "id" SERIAL PRIMARY KEY,
  "coupon_code" VARCHAR(255),
  "discount_price" FLOAT,
  "created_at" timestamp,
  "expired" timestamp
);

CREATE TABLE "razorpays" (
  "userid" INTEGER NOT NULL,
  "razorpaymentid" VARCHAR(255) PRIMARY KEY,
  "razorpayorderid" VARCHAR(255),
  "signature" VARCHAR(255),
  "amountpaid" VARCHAR(255)
);

CREATE TABLE "wallets" (
  "id" SERIAL PRIMARY KEY,
  "user_id" INTEGER,
  "amount" FLOAT
);

CREATE TABLE "wallet_history" (
  "id" SERIAL PRIMARY KEY,
  "user_id" INTEGER,
  "amount" FLOAT,
  "transction_type" VARCHAR(255),
  "date" timestamp
);

ALTER TABLE "addresses" ADD FOREIGN KEY ("userid") REFERENCES "users" ("id") ON DELETE CASCADE;

ALTER TABLE "products" ADD FOREIGN KEY ("catogery_id") REFERENCES "catogeries" ("id");

ALTER TABLE "products" ADD FOREIGN KEY ("brand_id") REFERENCES "brands" ("id");

ALTER TABLE "carts" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("product_id");

ALTER TABLE "carts" ADD FOREIGN KEY ("userid") REFERENCES "users" ("id");

ALTER TABLE "images" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("product_id");

ALTER TABLE "wishlists" ADD FOREIGN KEY ("userid") REFERENCES "users" ("id");

ALTER TABLE "wishlists" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("product_id");

ALTER TABLE "payments" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "order_details" ADD FOREIGN KEY ("userid") REFERENCES "users" ("id");

ALTER TABLE "order_details" ADD FOREIGN KEY ("addressid") REFERENCES "addresses" ("addressid");

ALTER TABLE "order_details" ADD FOREIGN KEY ("payment_id") REFERENCES "payments" ("payment_id");

ALTER TABLE "order_details" ADD FOREIGN KEY ("oder_item_id") REFERENCES "oder_items" ("order_id");

ALTER TABLE "order_details" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("product_id");

ALTER TABLE "oder_items" ADD FOREIGN KEY ("user_id_no") REFERENCES "users" ("id");

ALTER TABLE "oder_items" ADD FOREIGN KEY ("payment_id") REFERENCES "payments" ("payment_id");

ALTER TABLE "oder_items" ADD FOREIGN KEY ("add_id") REFERENCES "addresses" ("addressid");

ALTER TABLE "razorpays" ADD FOREIGN KEY ("userid") REFERENCES "users" ("id");

ALTER TABLE "wallets" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "wallet_history" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");
