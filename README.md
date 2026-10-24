# devops-labs

## How my pipeline works
1. **Trigger:** The pipeline starts when I push code to `main` or when I open a pull request.
2. **Job 1 – Quality:** First, the runner checks out the code and sets up Python 3.13.
   Then it installs the dependencies. After that, `ruff` lints the code and `pytest` runs the tests.
3. **Job 2 – build:** This job waits for the Quality job (`needs`). If a test fails, the build job is skipped.
4. **The image:** It builds a Docker image and pushes it to GHCR with the tag `sha-xxxxxxx`.
5. **Why the SHA tag?** It is used for traceability: each image matches one commit.
   Later, with a CD pipeline, a new tag will change Git, so Argo CD will see the difference and sync the cluster.

## What broke and how I fixed it
- **Wrong registry:** the login failed because `docker/login-action` uses Docker Hub by default.
  I fixed it with `registry: ghcr.io`.
- **Ruff failed (I001, unsorted imports):** I fixed it with `ruff check . --fix`.
  Now I run `ruff` and `pytest` locally before I push.
- **A test must be able to fail:** I broke the code on purpose to check that the test turns red.