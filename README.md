# codex-goodies

`codex-goodies` is a public home for reusable Codex surfaces: the managed `~/.codex/AGENTS.md` source, subagent definitions, hooks, and skills that are meant to be useful across machines and safe to publish.

## What's Here

- [`AGENTS.md`](AGENTS.md): contributor guidance for working in this repository
- [`references/AGENTS.md`](references/AGENTS.md): managed source copied into `~/.codex/AGENTS.md` by dotfiles
- [`agents/`](agents): subagent role definitions, with a quick index in [`agents/README.md`](agents/README.md)
- [`hooks/`](hooks): lightweight hook surfaces, documented in [`hooks/README.md`](hooks/README.md)
- [`skills/`](skills): reusable skills, with an index in [`skills/README.md`](skills/README.md)
- [`CONTRIBUTING.md`](CONTRIBUTING.md): branch, commit, and pull request expectations
- [`docs/repo-settings.md`](docs/repo-settings.md): GitHub settings that support the repo's review and merge flow

## Contributing

Keep changes small, public-safe, and reusable. Work on a topic branch, open a pull request to `main`, update the relevant directory README when top-level agents, hooks, or skills change, and run [`scripts/check-repo-hygiene.sh`](scripts/check-repo-hygiene.sh) before updating a PR. [`CONTRIBUTING.md`](CONTRIBUTING.md) has the fuller workflow.

## License

Apache 2.0. See [`LICENSE`](LICENSE).
