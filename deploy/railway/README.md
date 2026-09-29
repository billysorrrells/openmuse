# Railway deployment (Billy Sorrells Entertainment)

Four Railway services in one project:

| Service | Build | Notes |
|---|---|---|
| `postgres` | Railway Postgres | `DATABASE_URL` referenced by `api` |
| `api` | `deploy/railway/api.Dockerfile` | Volume at `/data`, public domain |
| `web` | `deploy/railway/web.Dockerfile` | Build arg `EXPO_PUBLIC_API_URL` = api public URL |
| `browser-worker` | `apps/worker/Dockerfile` (root dir `apps/worker`) | Private only; `WORKER_HOST=::` |

`api` runs in `WORKSPACE_MODE=live`, `AGENT_BACKEND=model`. Secrets
(`CPK_INTELLIGENCE_API_KEY`, model key, `OPENMUSE_ACCESS_KEY`,
`TOKEN_ENCRYPTION_KEY`, `WORKER_TOKEN`) live only in Railway variables.
