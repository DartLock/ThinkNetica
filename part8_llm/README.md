
#### Анализ текста
![alt text](https://github.com/DartLock/ThinkNetica/blob/part8_llm/part8_llm/text_classify.png?raw=true)


#### Анализ изображения
![alt text](https://github.com/DartLock/ThinkNetica/blob/part8_llm/part8_llm/image_classify.png?raw=true)


#### Генерация текста
![alt text](https://github.com/DartLock/ThinkNetica/blob/part8_llm/part8_llm/text_generation.png?raw=true)

### Исходный код Сессии LiveBook
#### Part8 LLM Simakov

```elixir
Mix.install([
  {:bumblebee, "~> 0.6.0"},
  {:nx, "~> 0.9.0"},
  {:exla, "~> 0.9.0"},
  {:axon, "~> 0.7.0"},
  {:kino, "~> 0.14.2"},
  {:kino_bumblebee, "~> 0.5.0"}
])

Nx.global_default_backend(EXLA.Backend)
```

#### Text Classify

```elixir
{:ok, model_info} =
    Bumblebee.load_model({:hf, "finiteautomata/bertweet-base-emotion-analysis"},
      log_params_diff: false
    )

{:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, "vinai/bertweet-base"})

serving =
  Bumblebee.Text.text_classification(model_info, tokenizer,
    compile: [batch_size: 1, sequence_length: 100],
    defn_options: [compiler: EXLA]
  )

text_input = Kino.Input.textarea("Text For Classification", default: "WoW!")
form = Kino.Control.form([text: text_input], submit: "Run")
frame = Kino.Frame.new()
log_frame = Kino.Frame.new()

form
|> Kino.Control.stream()
|> Kino.listen(fn %{data: %{text: text}} ->
  Kino.Frame.render(frame, Kino.Markdown.new("Running..."))

  Kino.Frame.render(log_frame, "Entry text: #{text}")
  
  output = Nx.Serving.run(serving, text)
  
  output.predictions
  |> Enum.map(&{&1.label, &1.score})
  |> Kino.Bumblebee.ScoredList.new()
  |> then(&Kino.Frame.render(frame, &1))
end)

Kino.Layout.grid([form, frame], boxed: true, gap: 16)
```

#### Part8 LLM Simakov Image Classify

```elixir
{:ok, model_info} = Bumblebee.load_model({:hf, "google/vit-base-patch16-224"})
{:ok, featurizer} = Bumblebee.load_featurizer({:hf, "google/vit-base-patch16-224"})

serving =
  Bumblebee.Vision.image_classification(model_info, featurizer,
    compile: [batch_size: 1],
    defn_options: [compiler: EXLA]
  )

image_input = Kino.Input.image("Choose Image", size: {224, 224})
form = Kino.Control.form([image: image_input], submit: "Classify ")
frame = Kino.Frame.new()

Kino.listen(form, fn %{data: %{image: image}} ->
  if image do
    Kino.Frame.render(frame, Kino.Text.new("Running..."))

    image =
      image.file_ref
      |> Kino.Input.file_path()
      |> File.read!()
      |> Nx.from_binary(:u8)
      |> Nx.reshape({image.height, image.width, 3})

    output = Nx.Serving.run(serving, image)

    output.predictions
    |> Enum.map(&{&1.label, &1.score})
    |> Kino.Bumblebee.ScoredList.new()
    |> then(&Kino.Frame.render(frame, &1))
  end
end)

Kino.Layout.grid([form, frame], boxed: true, gap: 16)
```

#### Part8 LLM Simakov Text Generation

```elixir
{:ok, model} = Bumblebee.load_model({:hf, "openai-community/gpt2"})
{:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, "openai-community/gpt2"})
{:ok, generation_config} = Bumblebee.load_generation_config({:hf, "openai-community/gpt2"})

serving = Bumblebee.Text.generation(model, tokenizer, generation_config)
generation_config = Bumblebee.configure(generation_config, max_new_tokens: 100)

text_input = Kino.Input.textarea("Proposal", default: "Type any text")
form = Kino.Control.form([text: text_input], submit: "Generate")
frame = Kino.Frame.new()
log_frame = Kino.Frame.new()

serving =
  Bumblebee.Text.generation(model, tokenizer, generation_config,
    compile: [batch_size: 1, sequence_length: 100],
    stream: true,
    defn_options: [compiler: EXLA]
  )

Kino.listen(form, fn %{data: %{text: text}} ->
  Kino.Frame.render(log_frame, Kino.Text.new("Entry text: #{text}"))  

  for chunk <- Nx.Serving.run(serving, text) do
    Kino.Frame.append(frame, Kino.Text.new(chunk, chunk: true))
  end
end)

Kino.Layout.grid([form, log_frame, frame], boxed: true, gap: 16)
```
