# tobias-klanert.de

Source code of my portfolio website, **[tobias-klanert.de](https://tobias-klanert.de)**.

I'm Tobias Klanert, a fullstack developer with 10 years of experience as a system administrator. I don't just build software, I run it too. This site is meant to prove it: built, deployed and operated by me, from the first commit to the running server.

> **Status:** Work in progress. tobias-klanert.de currently shows a placeholder page. The full site is planned to launch at the end of 2026.

## What makes this site different

- **Infrastructure graph:** My server landscape as a graph, generated with my own tool [StackGraph](https://stackgraph.tobias-klanert.de) from a sanitized Compose file. Each node links to the matching project.
- **Deploy info in the footer:** Commit hash, build number and deploy time, injected at build time by GitHub Actions. What you see is what's deployed.
- **Postmortems:** Lessons learned from running my projects, written as incident reports.

## Tech stack

| Area | Choice |
|---|---|
| Framework | Angular (current stable), standalone components |
| Language | TypeScript (strict), SCSS based on design tokens |
| Rendering | Static prerendering, no Node runtime in production |
| Languages | German (default) and English, with separate URLs (`/de/`, `/en/`) |
| Quality | ESLint, Prettier, Vitest, enforced in CI |
| Delivery | Multi-stage Docker build (Node → nginx) |
| Hosting | nginx container behind Caddy on my own Hetzner VPS |
| Analytics | Umami, self-hosted, no cookies |

## Principles

- **Accessibility:** WCAG 2.2 AA, light and dark theme, `prefers-reduced-motion` respected.
- **Privacy:** No unnecessary third-party requests. Fonts are self-hosted, no CDNs, no tracking cookies.
- **Security:** HTTPS via Caddy, security headers, no secrets in this repository.

## Workflow

| Branch | Purpose | Deploys to |
|---|---|---|
| Feature branches | One change per branch, merged into `develop` via pull request (squash) | – |
| `develop` | Integration branch | `staging.tobias-klanert.de` (password-protected) |
| `main` | Production, updated from `develop` via pull request (merge commit) | `tobias-klanert.de` |

- Every pull request runs lint, format check, tests and build. Merging requires a green pipeline.
- `main` and `develop` are protected by rulesets: no direct pushes, no force pushes, no deletions.
- Deployments happen only through the pipeline.

## Contact

- LinkedIn: [Tobias Klanert](https://www.linkedin.com/in/tobias-klanert-80563731a/)
- GitHub: [@TobiasKlanert](https://github.com/TobiasKlanert)

## License

No license is granted. The code is public so you can see how the site is built and run, but all rights are reserved. This includes all texts and images.
