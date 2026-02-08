# TEOREM – OPTIMUM REJİM

A narrative 2D RPG prototype inspired by Undertale mechanics. The project includes an overworld exploration layer, a bullet-hell style battle loop, branching dialogue, moral stat tracking, and a save system ready for expansion.

## Getting Started
1. Install Godot 4.x.
2. Run `download_assets.bat` on Windows to fetch free placeholder assets.
3. Open `project.godot` and run the main scene.

If downloads fail, the game falls back to procedural placeholder shapes (see `Scripts/overworld_player.gd`).

## Folder Structure
```
Scenes/
Scripts/
UI/
assets/
  sprites/
  music/
  sfx/
  fonts/
  backgrounds/
assets_manifest.txt
download_assets.bat
```

## Controls
- WASD / Arrow keys: Move
- E: Interact (hooked for dialogue and triggers)
- UI buttons: Battle commands

## Story Acts
- **Act 1**: City Aurelia, first boss Corrupted Student.
- **Act 2**: ZEk underground facility, future Büşra reveal.
- **Act 3**: Branching path, final boss ∞-B.

## Endings
- OPTIMUM REGIME
- CHAOS FREEDOM
- PARADOX TRUE
- Six unique death endings (driven by HP collapse and RNG).

## Notes
- Dialogue data lives in `Scripts/dialogue_data.gd` and supports branching, emotional tone, and moral stat deltas.
- Save data is stored in `user://save.json`.
- Extend `Scripts/battle_system.gd` with bullet patterns or real hitboxes as needed.
