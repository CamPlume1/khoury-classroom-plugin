include .env

# Installing frontend dependencies
.PHONY: frontend-dep
frontend-dep:
	cd frontend && npm install

# running the frontend
.PHONY: frontend-run
frontend-run:
	cd frontend && npm start

# Lint the frontend source code
.PHONY: frontend-lint
frontend-lint:
	cd frontend && npx eslint

# Installing backend dependencies
.PHONY: backend-dep
backend-dep:
	cd backend/cmd/server && go get .

# Lint backend source code
.PHONY: backend-lint
backend-lint:
	cd backend && golangci-lint run

# Format backend source code
.PHONY: backend-format
backend-format:
	cd backend && go fmt ./...

# Run backend tests
.PHONY: backend-test
backend-test:
	cd backend && go test ./...

# Run backend
.PHONY: backend-run
backend-run:
	cd backend/cmd/server && go run main.go

# Build backend
.PHONY: backend-build
backend-build:
	cd backend && go build -o bin/nightlife cmd/server/main.go

# convert the backend link to an ngrok link
.PHONY: backend-ngrok
backend-ngrok:
	@echo ${EXPO_PUBLIC_API_DOMAIN}
	cd backend && ngrok http --domain=${EXPO_PUBLIC_API_DOMAIN} 8080