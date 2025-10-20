# Rego Policy Generator

A comprehensive system for generating and testing Rego policies for OPA Gatekeeper using LLM-based generation with optimized prompts for better policy quality.

## Project Structure

```
rego-policy/
├── src/                          # Source code
│   ├── policy_generator.py       # Main policy generator with LLM integration
│   ├── generate_policy.py        # Single policy generation script
│   ├── app.py                    # Streamlit web application
│   └── data-extract.ipynb        # Data extraction notebook
├── scripts/                      # Utility scripts
│   ├── run.sh                    # Main test runner
│   └── test_policy.sh            # Policy testing script
├── config/                       # Configuration files
│   └── openshift/                # OpenShift deployment configs
├── data/                         # Reference policies (policy_0.rego to policy_52.rego)
├── outputs/                      # Generated policy outputs
│   └── sample_output/            # Sample generated policies
├── test_files/                   # Test cases and data
│   ├── test_contradicting_inputs/ # Test cases (pass/fail scenarios)
│   │   ├── pass/                 # Pass test cases
│   │   └── fail/                 # Fail test cases
│   └── test_data/                # Test data files (YAML/JSON)
├── requirements/                 # Policy requirements (policy_0_requirements.txt to policy_52_requirements.txt)
├── .env.example                  # Environment variables template
├── pyproject.toml                # Python project configuration
└── requirements.txt              # Python dependencies
```

## Quick Start

### 1. Install Dependencies
```bash
# Using uv (recommended)
uv sync

# Or using pip
pip install -r requirements.txt
```

### 2. Set up Environment Variables
```bash
cp .env.example .env
# Edit .env and add your API keys:
# GOOGLE_API_KEY=your_google_api_key
# OPENAI_API_KEY=your_openai_api_key
# ANTHROPIC_API_KEY=your_anthropic_api_key
```

### 3. Generate a Single Policy
```bash
# Using uv
uv run python src/generate_policy.py 0

# Or using python directly
cd src && python generate_policy.py 0
```

### 4. Generate All Policies
```bash
# Using uv
uv run python src/generate_policy.py all

# Or using python directly
cd src && python generate_policy.py all
```

### 5. Test Policies
```bash
./scripts/run.sh
```

### 6. Run Web Application
```bash
# Using uv
uv run streamlit run src/app.py

# Or using streamlit directly
cd src && streamlit run app.py
```

## Key Features

- **LLM Integration**: Supports Google Gemini, OpenAI GPT, and Anthropic Claude
- **Optimized Prompts**: Concise, effective prompts that prevent common Rego syntax errors
- **Comprehensive Testing**: 53 policies with pass/fail test cases
- **Rego v1 Syntax**: Ensures compatibility with latest Rego standards
- **Web Interface**: Streamlit app for interactive policy generation
- **Batch Processing**: Generate and test multiple policies efficiently
- **OpenShift Integration**: Ready-to-deploy OPA Gatekeeper configurations

## Policy Generation Process

1. **Requirements Analysis**: Parse policy requirements from text files
2. **LLM Generation**: Generate policy using optimized prompts with critical syntax rules
3. **Validation**: Test generated policies with pass/fail test cases
4. **Quality Analysis**: Automated OPA evaluation of generated policies

## Testing

The system includes comprehensive testing with:
- **53 Policies**: Complete set from policy_0 to policy_52
- **Pass Test Cases**: Valid inputs that should not trigger violations
- **Fail Test Cases**: Invalid inputs that should trigger violations
- **Automated Validation**: OPA evaluation of generated policies
- **Quality Metrics**: Analysis of policy syntax and logic

## File Organization

- **`data/`**: Reference policies (policy_0.rego to policy_52.rego)
- **`outputs/sample_output/`**: Generated policies using the optimized prompt
- **`test_files/test_contradicting_inputs/`**: Pass/fail test cases for all policies
- **`requirements/`**: Policy requirements (policy_0_requirements.txt to policy_52_requirements.txt)
- **`test_data/`**: Test data files in YAML/JSON format


## License

This project follows the same license as the parent repository.
