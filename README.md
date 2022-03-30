# Ctrlv

Code paste-bin and editor.

![ctrlv-02](https://user-images.githubusercontent.com/2897340/160538360-cab5957d-263d-4348-97af-bc9708087ffb.gif)

## Roadmap

#### v1.0

- [x] Save
- [x] Fork
- [x] New
- [x] CodeMirror 6 languages
- [x] CodeMirror Legacy languages
- [x] Elixir language
- [ ] Cache
- [ ] Rate-limiting `save`
- [ ] Delete expired pastes
- [ ] Testing and Static Analysis
  * [ ] ExUnit
  * [ ] Credo
  * [ ] Dialyzer
- [ ] CI/CD (Github actions)

#### v2.0

- [ ] Versions
- [ ] Advanced settings (`tabSize`, etc)
- [ ] Help menu
- [ ] Streaming code updates

#### v3.0 (potential ideas/wishlist for now)

- [ ] Monaco editor
- [ ] User accounts for non-expiring pastes

## About

### Main technologies:

- [Elixir](https://elixir-lang.org)
- [Phoenix Framework](https://www.phoenixframework.org/)
- [CodeMirror 6](https://codemirror.net/6)
- [PostgreSQL](https://www.postgresql.org/)
