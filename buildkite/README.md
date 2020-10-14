## BuildKite

### Key notes

- Buildkite agents run on your infra. They communicate with BuildKite (master) via BuildKite agent API. Polling for jobs to run is most commonly-known task for communication.
- One machine is allowed for multiple agents to run
- BuildKite use queue (label equivalent in Jenkins) to segregate build jobs
```shell
buildkite-agent start --tags "queue=building,queue=testing"
```

target a queue

```yml
steps:
  - command: tests.sh
    agents:
      queue: "deploy"
```
- Supports hooks

### How to run

- Build image via `build.sh`
- Call `run.sh` to stand up agent
- Commit and push your changes to trigger build
