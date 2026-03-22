# ruby_llm-pollinations

[Pollinations AI](https://pollinations.ai) provider plugin for [RubyLLM](https://github.com/crmne/ruby_llm).

Adds chat, image/video generation, text-to-speech, music generation, and transcription — without modifying RubyLLM core.

## Installation

Add to your Gemfile:

```ruby
gem 'ruby_llm'
gem 'ruby_llm-pollinations', github: 'compasify/ruby_llm-pollinations'
```

Then:

```bash
bundle install
```

## Configuration

```ruby
RubyLLM.configure do |c|
  c.pollinations_api_key = ENV['POLLINATIONS_API_KEY']

  # Optional
  c.pollinations_api_base = 'https://gen.pollinations.ai' # default
  c.default_audio_model = 'tts-1'                         # default
end
```

## Usage

### Chat

```ruby
chat = RubyLLM.chat(model: 'openai', provider: :pollinations)
response = chat.ask("What is Pollinations AI?")
puts response.content
```

Streaming:

```ruby
chat = RubyLLM.chat(model: 'openai', provider: :pollinations)
chat.ask("Tell me a story") { |chunk| print chunk.content }
```

### Image Generation

```ruby
image = RubyLLM.paint(
  "a cyberpunk cat in neon lights",
  model: 'flux',
  provider: :pollinations,
  size: '1024x1024',
  seed: 42,
  enhance: true,
  negative_prompt: 'blurry, low quality'
)

image.save('cat.jpg')
```

### Video Generation

```ruby
video = RubyLLM.paint(
  "a cat walking on the moon",
  model: 'veo',
  provider: :pollinations,
  size: '1024x576',
  duration: 6,
  aspect_ratio: '16:9',
  audio: true
)

video.save('moon_cat.mp4')
```

Supported video models: `veo`, `seedance`, `seedance-pro`, `grok-video`, `ltx-2`

### Text-to-Speech

```ruby
audio = RubyLLM.speak(
  "Hello from Pollinations!",
  model: 'tts-1',
  voice: 'alloy',
  provider: :pollinations
)

audio.save('hello.mp3')
```

Available voices: `alloy`, `echo`, `fable`, `onyx`, `shimmer`, `coral`, `verse`, `ballad`, `ash`, `sage`, `amuch`, `dan`, `rachel`, `bella`

### Music Generation

```ruby
music = RubyLLM.speak(
  "Upbeat electronic track with synth leads",
  model: 'elevenmusic',
  provider: :pollinations,
  duration: 120,
  instrumental: true
)

music.save('track.mp3')
```

### Transcription

```ruby
transcription = RubyLLM.transcribe(
  'audio.mp3',
  model: 'whisper-large-v3',
  provider: :pollinations,
  language: 'en'
)

puts transcription.text
```

### Tool Calling

```ruby
class WeatherTool < RubyLLM::Tool
  description "Get current weather"
  param :city, type: :string, desc: "City name"

  def execute(city:)
    "25°C, sunny in #{city}"
  end
end

chat = RubyLLM.chat(model: 'openai', provider: :pollinations)
chat.with_tool(WeatherTool)
chat.ask("What's the weather in Tokyo?")
```

### Account & Billing

```ruby
config = RubyLLM::Configuration.new.tap { |c| c.pollinations_api_key = ENV['POLLINATIONS_API_KEY'] }
provider = RubyLLM::Pollinations::Provider::Pollinations.new(config)

provider.balance        # => { balance: 1234.56 }
provider.profile        # => { name: "...", tier: "seed", ... }
provider.usage          # => { usage: [...], count: 42 }
provider.usage_daily    # => { usage: [...], count: 7 }
provider.key_info       # => { valid: true, type: "secret", pollen_budget: 10000, ... }
```

### List Available Models

```ruby
RubyLLM.models.refresh!
pollinations_models = RubyLLM.models.all.select { |m| m.provider == 'pollinations' }
pollinations_models.each { |m| puts "#{m.id} (#{m.family})" }
```

## How It Works

This gem registers itself as a RubyLLM provider via `Provider.register` and applies three defensive monkey-patches that automatically skip themselves if RubyLLM adds native support:

| Patch | Purpose |
|---|---|
| `Provider#paint(**options)` | Passes extra options (seed, enhance, negative_prompt) through the paint call chain |
| `Image.paint(**options)` | Forwards options from the public API to the provider |
| `RubyLLM.speak` | Adds text-to-speech support (not yet in RubyLLM core) |

## Supported Models

| Type | Models |
|---|---|
| Chat | `openai`, `gemini`, `claude`, and others via Pollinations |
| Image | `flux`, `zimage`, `gptimage`, `seedream`, `nanobanana`, `kontext`, `imagen`, `klein`, `wan` |
| Video | `veo`, `seedance`, `seedance-pro`, `grok-video`, `ltx-2` |
| Audio/TTS | `tts-1` |
| Music | `elevenmusic`, `music` |
| Transcription | `whisper-large-v3`, `whisper-1` |

Run `RubyLLM.models.refresh!` to get the latest list from the API.

## Development

```bash
git clone https://github.com/compasify/ruby_llm-pollinations.git
cd ruby_llm-pollinations
bundle install
bundle exec rspec
```

## License

MIT License. See [LICENSE](LICENSE).
