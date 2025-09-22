# Rego Policy Generator

A tool that converts natural language policy requirements into Rego policies using Large Language Models (LLMs).

## Features

- **LLM-Powered**: Uses Gemini, OpenAI, or Anthropic
- **Natural Language Input**: Describe policies in plain English
- **Web Interface**: Simple Streamlit UI
- **Download Policies**: Save generated .rego files

## Quick Start

1. **Install uv**
   ```bash
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```

2. **Install Dependencies**
   ```bash
   uv sync
   ```

3. **Set Up API Key**
   ```bash
   cp .env.example .env
   # Edit .env and add: GOOGLE_API_KEY=your_api_key_here
   ```

4. **Run the App**
   ```bash
   uv run streamlit run app.py
   ```

## Usage

1. Select LLM provider in sidebar
2. Enter requirements in natural language
3. Add sample data (optional JSON)
4. Set package name for the Rego package
5. Click Generate Policy
6. Download the generated .rego file

## Getting API Keys

- **Google Gemini**: [Google AI Studio](https://makersuite.google.com/app/apikey)
- **OpenAI**: [OpenAI Platform](https://platform.openai.com/api-keys)
- **Anthropic**: [Anthropic Console](https://console.anthropic.com/)
