To reproduce the archive, the following dependencies should be met:

*this tutorial is for macOS only,*
but you should be able to get it running anywhere that can run ollama

**Currently, all paths are hard-coded, so the scripts will only work if the Repository is cloned to the home directory**
Plus, you have to adjust either your username or the entire path in the scripts

## Brew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## git

```bash
brew install git
```

## Node.js and npm, as well as yarn

```bash
brew install node
npm install --global yarn
```

## Babashka and Clojure

```bash
brew install borkdude/brew/babashka
brew install clojure/tools/clojure
```

both prerequisites for publish-spa

## Publish-spa

```bash
git clone https://github.com/logseq/publish-spa
cd publish-spa && yarn install
yarn global add $PWD
```

this is a tool used to automatically publish the logseq archive
everything works without, but you will have to manually export the archive

## The Logseq desktop app (optional)

```bash
brew install --cask logseq
```

only if you want a convenient way to modify the archive

## Python

```bash
brew install python@3.13
```

## Ollama

```bash
brew install --cask ollama
```

I am using the cask here because it autostarts the server, but you can also use the CLI version if you prefer.
ollama handles all the LLM needs. if that is not needed, you can skip this step

# The Archive Repository

```bash
git clone arontaupe/thesis
```

# Make the script executable

```bash
cd thesis/code
chmod +x publish.sh
chmod +x scan.sh
```

then, either run the scripts individually or use the provided app that should now work

```bash
./scan.sh
./publish.sh
```

the app is called `Scan to Archive` and should be in the thesis folder
