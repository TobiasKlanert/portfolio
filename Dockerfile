# ---- Stage 1: Build ----
# Keep in sync with .nvmrc. package.json#devEngines rejects any other major.
FROM node:26.12.1-alpine AS build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .

# Deploy info for the footer, passed in by the pipeline. Local builds keep the
# defaults. Served as /build-info.json, so the running version can be checked.
ARG BUILD_COMMIT=local
ARG BUILD_NUMBER=0
ARG BUILD_TIME=unknown
RUN printf '{"commit":"%s","build":"%s","time":"%s"}\n' \
    "$BUILD_COMMIT" "$BUILD_NUMBER" "$BUILD_TIME" > public/build-info.json

RUN npm run build

# ---- Stage 2: Serve ----
# Unprivileged variant: nginx runs as a non-root user and listens on 8080.
FROM nginx/nginx-unprivileged:1.30-alpine AS serve

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist/portfolio/browser/ /usr/share/nginx/html/

EXPOSE 8080

# Checks that nginx answers and the start page is in place.
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -q --spider http://127.0.0.1:8080/ || exit 1