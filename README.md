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
- [x] Limit content length
- [ ] Cache
- [ ] Rate-limiting `save`
- [x] Delete expired pastes
- [ ] Testing and Static Analysis
  * [ ] ExUnit
  * [ ] Credo
  * [ ] Dialyzer
- [ ] CI/CD (Github actions)
- [x] Deploy
- [ ] meta/og tags for better links
- [ ] Mobile sidebar
- [ ] Overlayed alerts/errors

#### v2.0

- [ ] Improve/fix "flash" between `show` and `fork`
- [ ] Versions
- [ ] Advanced settings (`tabSize`, etc)
- [ ] Help menu
- [ ] Real-time(ish) code updates

#### v3.0 (potential ideas/wishlist for now)

- [ ] Monaco editor
- [ ] User accounts for non-expiring pastes

## About

### Why did I make this?

To be honest, I just don't like most pastebin things for code, and the ones I do
like don't support Elixir syntax highlighting. That's the reason I started it.

I just want a non-cluttered UI and support for the languages I use.

### Main technologies:

- [Elixir](https://elixir-lang.org)
- [Phoenix Framework](https://www.phoenixframework.org/)
- [CodeMirror 6](https://codemirror.net/6)
- [PostgreSQL](https://www.postgresql.org/)
