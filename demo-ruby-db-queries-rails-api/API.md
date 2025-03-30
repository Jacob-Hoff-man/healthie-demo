# API Documentation

## Providers

### List Providers
```bash
curl http://localhost:3000/providers
```

### Get Provider
```bash
curl http://localhost:3000/providers/1
```

### Create Provider
```bash
curl -X POST http://localhost:3000/providers \
  -H "Content-Type: application/json" \
  -d '{"provider": {"name": "Dr. Smith", "email": "smith@example.com"}}'
```

### Update Provider
```bash
curl -X PUT http://localhost:3000/providers/1 \
  -H "Content-Type: application/json" \
  -d '{"provider": {"name": "Dr. Smith Jr"}}'
```

### Delete Provider
```bash
curl -X DELETE http://localhost:3000/providers/1
```

### List Provider's Clients
```bash
curl http://localhost:3000/providers/1/clients
```

### List Provider's Client Journals
```bash
curl http://localhost:3000/providers/1/journals
```

## Clients

### List Clients
```bash
curl http://localhost:3000/clients
```

### Get Client
```bash
curl http://localhost:3000/clients/1
```

### Create Client
```bash
curl -X POST http://localhost:3000/clients \
  -H "Content-Type: application/json" \
  -d '{"client": {"name": "John Doe", "email": "john@example.com"}}'
```

### Update Client
```bash
curl -X PUT http://localhost:3000/clients/1 \
  -H "Content-Type: application/json" \
  -d '{"client": {"name": "John Doe Jr"}}'
```

### Delete Client
```bash
curl -X DELETE http://localhost:3000/clients/1
```

### List Client's Providers
```bash
curl http://localhost:3000/clients/1/providers
```

## Plans

### List Plans
```bash
curl http://localhost:3000/plans
```

### Get Plan
```bash
curl http://localhost:3000/plans/basic
```

### Create Plan
```bash
curl -X POST http://localhost:3000/plans \
  -H "Content-Type: application/json" \
  -d '{"plan": {"name": "premium-plus"}}'
```

### Update Plan
```bash
curl -X PUT http://localhost:3000/plans/basic \
  -H "Content-Type: application/json" \
  -d '{"plan": {"name": "basic-plus"}}'
```

### Delete Plan
```bash
curl -X DELETE http://localhost:3000/plans/basic
```

### List Plan's Provider-Client Relationships
```bash
curl http://localhost:3000/plans/basic/provider_client_plans
```

## Journals

### List All Journals
```bash
curl http://localhost:3000/journals
```

### List Client's Journals
```bash
curl http://localhost:3000/clients/1/journals
```

### Get Journal
```bash
curl http://localhost:3000/journals/1
```

### Create Journal
```bash
curl -X POST http://localhost:3000/clients/1/journals \
  -H "Content-Type: application/json" \
  -d '{"journal": {"text": "Today was a good day"}}'
```

### Update Journal
```bash
curl -X PUT http://localhost:3000/journals/1 \
  -H "Content-Type: application/json" \
  -d '{"journal": {"text": "Today was a great day"}}'
```

### Delete Journal
```bash
curl -X DELETE http://localhost:3000/journals/1
```

## Provider-Client-Plan Relationships

### Create Relationship
```bash
curl -X POST http://localhost:3000/provider_client_plans \
  -H "Content-Type: application/json" \
  -d '{"provider_client_plan": {"provider_id": 1, "client_id": 1, "plan_name": "basic"}}'
```

### Delete Relationship
```bash
curl -X DELETE http://localhost:3000/provider_client_plans/1/1/basic
``` 