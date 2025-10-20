# Rego Policy Generator

A comprehensive system for generating and testing Rego policies for OPA Gatekeeper using LLM-based generation and RAG (Retrieval-Augmented Generation) techniques.

## Project Structure

```
rego-policy/
├── src/                          # Source code
│   ├── policy_generator.py       # Main policy generator with LLM integration
│   ├── generate_policy.py        # Single policy generation script
│   ├── generate_policies.py      # Batch policy generation script
│   ├── generate_namespace_policy.py  # Namespace-specific policy generator
│   ├── app.py                    # Web application (if applicable)
│   └── data-extract.ipynb        # Data extraction notebook
├── docs/                         # Documentation
│   ├── OPA_SETUP_SUMMARY.md      # OPA setup instructions
│   ├── LLM_Policy_Generation_Failure_Report.md  # Failure analysis
│   └── rego_rules_reference.md   # Rego rules reference guide
├── scripts/                      # Utility scripts
│   ├── run.sh                    # Main test runner
│   └── test_policy.sh            # Policy testing script
├── config/                       # Configuration files
│   └── openshift/                # OpenShift deployment configs
├── examples/                     # Example policies and templates
│   └── lib/                      # Library of example Rego policies
├── policies/                     # Generated policies
├── sample_output/                # Sample policy outputs
├── test_output/                  # Test policy outputs
├── test_contradicting_inputs/    # Test cases (pass/fail)
├── test_data/                    # Test data files
├── test_data_reformatted/        # Reformatted test data
├── requirements/                 # Policy requirements
├── tests/                        # Test files
└── requirements.txt              # Python dependencies
```

## Quick Start

### 1. Install Dependencies
```bash
pip install -r requirements.txt
```

### 2. Generate a Single Policy
```bash
cd src
python generate_policy.py --policy-number 0
```

### 3. Generate Multiple Policies
```bash
cd src
python generate_policies.py --start 0 --end 10
```

### 4. Test Policies
```bash
cd scripts
./run.sh
```

## Key Features

- **LLM Integration**: Uses OpenAI/Gemini for policy generation
- **Comprehensive Testing**: Automated test case generation and validation
- **Rego v1 Syntax**: Ensures compatibility with latest Rego standards
- **Error Prevention**: Built-in checks for common Rego syntax errors
- **Batch Processing**: Generate and test multiple policies efficiently

## Policy Generation Process

1. **Requirements Analysis**: Parse policy requirements from text files
2. **Context Retrieval**: Use RAG to find relevant Rego rules and patterns
3. **LLM Generation**: Generate policy using context-aware prompts
4. **Validation**: Test generated policies with pass/fail test cases
5. **Quality Analysis**: Automated analysis of policy correctness

## Testing

The system includes comprehensive testing with:
- **Pass Test Cases**: Valid inputs that should not trigger violations
- **Fail Test Cases**: Invalid inputs that should trigger violations
- **Automated Validation**: OPA evaluation of generated policies
- **Quality Metrics**: Analysis of policy syntax and logic

## Documentation

- [OPA Setup Guide](docs/OPA_SETUP_SUMMARY.md)
- [Rego Rules Reference](docs/rego_rules_reference.md)
- [Failure Analysis Report](docs/LLM_Policy_Generation_Failure_Report.md)


## License

This project follows the same license as the parent repository.
