DB_URL=postgresql://root:secret@localhost:5432/ecommerce_db?sslmode=disable

imagerm:
	docker rm -vf $(docker ps -aq)

network:
	docker network create ecommerce-network

postgres:
	docker run --name postgres-ecommerce --network ecommerce-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14-alpine


createdb:
	docker exec -it postgres-ecommerce createdb --username=root --owner=root ecommerce_db

dropdb:
	docker exec -it postgres dropdb ecommerce_db

migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

sqlc:
	sqlc generate

db_docs:
	dbdocs build doc/db.dbml

db_schema:
	dbml2sql --postgres -o doc/schema.sql doc/db.dbml

test:
	go test -v -cover -short ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/ruffiano/gocommerce/db/sqlc Store
	mockgen -package mockwk -destination worker/mock/distributor.go github.com/ruffiano/gocommerce/worker TaskDistributor

proto:
	rm -f pb/*.go
	rm -f doc/swagger/*.swagger.json
	protoc --proto_path=proto --go_out=pb --go_opt=paths=source_relative \
	--go-grpc_out=pb --go-grpc_opt=paths=source_relative \
	--grpc-gateway_out=pb --grpc-gateway_opt=paths=source_relative \
	--openapiv2_out=doc/swagger --openapiv2_opt=allow_merge=true,merge_file_name=ecommerce_db \
	proto/*.proto
	statik -src=./doc/swagger -dest=./doc

evans:
	evans --host localhost --port 9090 -r repl

redis:
	docker run --name redis -p 6379:6379 -d redis:7-alpine

.PHONY: imagerm network postgres createdb dropdb migrateup migratedown db_docs db_schema sqlc test server mock proto evans redis