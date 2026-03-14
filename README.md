# lex-cognitive-fermentation

Slow non-linear cognitive maturation model for brain-modeled agentic AI in the LegionIO ecosystem.

## What It Does

Not all cognitive processing is immediate. Raw ideas, unresolved problems, partial patterns, and lingering questions sometimes need time to develop before they yield useful output. This extension models that incubation process using a fermentation metaphor: substrates move through stages from `inoculation` to `peak` maturity, developing potency along the way. Catalysts (analogies, emotional charge, dream residue) accelerate the process. Over-fermented substrates decay.

Substrates are grouped into domain-based batches for collective tracking. The engine surfaces which substrates are ripe or at peak, and provides an overall yield rate.

## Usage

```ruby
require 'legion/extensions/cognitive_fermentation'

client = Legion::Extensions::CognitiveFermentation::Client.new

# Add a substrate
result = client.create_substrate(
  substrate_type: :unresolved_problem,
  domain:         :analytical,
  content:        'Why do requests cluster in the morning?'
)
id = result[:substrate][:id]

# Advance fermentation naturally
client.ferment(substrate_id: id)

# Apply a catalyst to boost potency
client.catalyze(substrate_id: id, catalyst_type: :analogy)

# Run a full fermentation cycle on all substrates
client.ferment_all

# See what's ready
client.list_ripe
# => { count: 0, substrates: [] }

# Full status report
client.fermentation_status
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
