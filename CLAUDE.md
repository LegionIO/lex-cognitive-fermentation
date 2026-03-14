# lex-cognitive-fermentation

**Level 3 Leaf Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`
- **Gem**: `lex-cognitive-fermentation`

## Purpose

Models slow, non-linear cognitive maturation using a fermentation metaphor. Raw, unresolved, or partial cognitive material (substrates) ferments over time, developing potency and maturity through natural processing and catalysis. When substrates reach peak stage, they are ready for use or harvest. Over-fermented substrates decay. Domain-grouped batches track collective fermentation progress.

## Gem Info

| Field | Value |
|---|---|
| Gem name | `lex-cognitive-fermentation` |
| Version | `0.1.0` |
| Namespace | `Legion::Extensions::CognitiveFermentation` |
| Ruby | `>= 3.4` |
| License | MIT |
| GitHub | https://github.com/LegionIO/lex-cognitive-fermentation |

## File Structure

```
lib/legion/extensions/cognitive_fermentation/
  cognitive_fermentation.rb         # Top-level require
  version.rb                        # VERSION = '0.1.0'
  client.rb                         # Client class
  helpers/
    constants.rb                    # Types, stages, rates, label hashes
    substrate.rb                    # Substrate value object
    batch.rb                        # Batch (domain group) value object
    fermentation_engine.rb          # Engine: substrates + batches
  runners/
    cognitive_fermentation.rb       # Runner module
```

## Key Constants

| Constant | Value | Meaning |
|---|---|---|
| `MAX_SUBSTRATES` | 500 | Hard cap; evicts spoiled then lowest-potency |
| `MAX_BATCHES` | 50 | Batch cap |
| `MATURATION_RATE` | 0.05 | Default fermentation step size |
| `CATALYSIS_BOOST` | 0.12 | Potency boost from catalyst application |
| `SPOILAGE_THRESHOLD` | 0.1 | Potency below this = spoiled |
| `RIPE_THRESHOLD` | 0.7 | Potency above this = ripe |
| `PEAK_THRESHOLD` | 0.9 | Potency above this = peak |
| `OVER_FERMENTED_DECAY` | 0.03 | Post-peak potency loss rate |
| `SUBSTRATE_TYPES` | array | `raw_idea`, `unresolved_problem`, `partial_pattern`, etc. |
| `FERMENTATION_STAGES` | array | `inoculation` through `over_fermented` |
| `CATALYST_TYPES` | array | `analogy`, `contrast`, `emotional_charge`, `dream_residue`, etc. |

## Helpers

### `Substrate`

Tracks the fermentation state of a single cognitive material unit.

- `initialize(substrate_type:, domain:, content:, potency: nil, volatility: nil)`
- `ferment!(rate)` — advances maturity and potency by rate; transitions stage
- `catalyze!(catalyst_type)` — boosts potency by `CATALYSIS_BOOST` if valid catalyst
- `ripe?`, `peak?`, `spoiled?`, `raw?` — state predicates
- `to_h` — includes stage, potency, maturity, volatility, labels

### `Batch`

Groups substrates by domain.

- `add_substrate(substrate)`
- `ferment_all!(rate)` — delegates to each substrate

### `FermentationEngine`

Manages substrates and batches.

- `create_substrate(substrate_type:, domain:, content:, potency: nil, volatility: nil)` — auto-assigns to batch; prunes when at cap
- `ferment(substrate_id:, rate: MATURATION_RATE)` — single substrate advance
- `catalyze(substrate_id:, catalyst_type:)` — catalyzes single substrate
- `ferment_all!(rate: MATURATION_RATE)` — advances all batches
- `substrates_by_domain(domain:)`, `substrates_by_type(type:)`, `substrates_by_stage(stage:)`
- `ripe_substrates`, `peak_substrates`, `spoiled_substrates`, `raw_substrates`
- `most_potent(limit: 5)`, `most_mature(limit: 5)`
- `overall_potency`, `overall_maturity`, `overall_volatility`, `yield_rate`, `stage_distribution`
- `fermentation_report` — full stats with labels and top substrates

## Runners

**Module**: `Legion::Extensions::CognitiveFermentation::Runners::CognitiveFermentation`

| Method | Key Args | Returns |
|---|---|---|
| `create_substrate` | `substrate_type:`, `domain:`, `content:` | `{ success:, substrate: }` |
| `ferment` | `substrate_id:`, `rate: nil` | `{ success:, substrate: }` |
| `catalyze` | `substrate_id:`, `catalyst_type:` | `{ success:, substrate: }` |
| `ferment_all` | `rate: nil` | `{ success: }` |
| `list_ripe` | — | `{ count:, substrates: }` |
| `fermentation_status` | — | Full fermentation report |

Private: `@default_engine` — memoized `FermentationEngine`. Runner uses `engine || @default_engine` pattern.

## Integration Points

- **`lex-dream`**: Dream cycle is a natural catalyst source. The `dream_residue` catalyst type in the constants is specifically for materials that surface during the dream cycle and catalyze substrate development.
- **`lex-memory`**: Ripe substrates could be promoted to memory traces after maturation.
- **`lex-genesis`**: Fermentation produces potent substrates ready for concept birth.

## Development Notes

- Pruning order on cap: first removes `spoiled?` substrates, then lowest-potency if still over cap.
- `ferment_all!` works through the batch grouping, not directly over substrates. Batch-level iteration.
- `CATALYST_TYPES` includes `sleep` and `dream_residue` — these are valid symbols recognized by `catalyze!`.
- In-memory only. No persistence.

---

**Maintained By**: Matthew Iverson (@Esity)
