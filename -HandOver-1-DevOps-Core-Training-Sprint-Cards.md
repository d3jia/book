# DevOps Core Familiarisation Sprint Cards

- DevOps Team are to familiarize with below commands.
- Labs will be added later.

---

## 🧠 Git — Non-Negotiable Core

- [ ] Understand repo states: working tree vs staging vs HEAD
- [ ] `git clone`, `status`, `add`, `commit`, `push`, `pull`
- [ ] `git fetch` vs `git pull`
- [ ] Branch creation & switching (`checkout`, `switch`)
- [ ] Merge vs rebase (when & why)
- [ ] Resolve merge conflicts manually (no panic)
- [ ] `git revert` vs `git reset --soft|--hard`
- [ ] Read history (`git log --oneline --graph`)
- [ ] Inspect changes (`git diff`)
- [ ] Basic `git blame` usage

---

## 🚀 GitLab CI/CD — Practical Operator Level

- [ ] Understand `.gitlab-ci.yml` structure
- [ ] Stages vs jobs
- [ ] Job dependencies & execution order
- [ ] `rules` / `only` / `except`
- [ ] Artifacts vs cache (difference & use cases)
- [ ] Environment variables & secrets
- [ ] Shared runners vs specific runners (conceptual)
- [ ] Basic pipeline for build → test → deploy
- [ ] Read & debug failed pipelines
- [ ] Modify existing pipeline safely (no cowboy edits)

---

## 🐳 Docker — Clean, Predictable Builds

- [ ] What a Docker image actually contains
- [ ] Dockerfile anatomy
- [ ] Layer caching concept
- [ ] Multi-stage builds (build vs runtime)
- [ ] COPY vs ADD
- [ ] ENTRYPOINT vs CMD
- [ ] Image size optimisation basics
- [ ] Build & run images locally
- [ ] Understand stateless vs stateful containers
- [ ] Read & modify existing Dockerfiles confidently

---

## 🌍 Terraform — Survival & Literacy Level

- [ ] Terraform workflow (`init → plan → apply`)
- [ ] Providers & versions
- [ ] Resources vs data sources
- [ ] Variables & outputs
- [ ] State file concept (local vs remote)
- [ ] Read existing Terraform without fear
- [ ] Understand what *will change* from `plan`
- [ ] Safe destroy & cleanup
- [ ] Basic module awareness (no writing yet)
- [ ] Know what NOT to touch blindly

---
