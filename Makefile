.PHONY: up-auto down-auto logs-auto status-auto

up-auto:
	docker compose -f docker-compose.yml up -d

logs-auto:
	docker compose -f docker-compose.yml logs -f

down-auto:
	docker compose -f docker-compose.yml down

status-auto:
	docker compose -f docker-compose.yml ps
