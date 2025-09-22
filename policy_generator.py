#!/usr/bin/env python3
"""
Simple Policy Generator

A minimal policy generator that converts natural language requirements
to Rego policies using LLM (Gemini, OpenAI, etc.).
"""

import json
import os
import sys
import argparse
from typing import Dict, Optional
from dotenv import load_dotenv

import google.generativeai as genai

load_dotenv()

class SimplePolicyGenerator:
    """Simple policy generator using LLM."""
    
    def __init__(self, provider: str = "google"):
        """Initialize the policy generator.
        
        Args:
            provider: LLM provider ('google', 'openai', 'anthropic')
        """
        self.provider = provider
        self.llm = self._setup_llm()
    
    def _setup_llm(self):
        """Set up the LLM based on provider."""
        if self.provider == "google":
            return self._setup_google_llm()
        elif self.provider == "openai":
            return self._setup_openai_llm()
        elif self.provider == "anthropic":
            return self._setup_anthropic_llm()
        else:
            raise ValueError(f"Unsupported provider: {self.provider}")
    
    def _setup_google_llm(self):
        """Set up Google Gemini LLM."""
        try:
            
            api_key = os.getenv("GOOGLE_API_KEY")
            if not api_key:
                raise ValueError("GOOGLE_API_KEY not found in environment variables")
            
            genai.configure(api_key=api_key)
            model = genai.GenerativeModel('gemini-2.0-flash-001')
            return model
            
        except ImportError:
            raise ImportError("google-generativeai package not installed. Run: pip install google-generativeai")
    
    def _setup_openai_llm(self):
        """Set up OpenAI LLM."""
        try:
            import openai
            
            api_key = os.getenv("OPENAI_API_KEY")
            if not api_key:
                raise ValueError("OPENAI_API_KEY not found in environment variables")
            
            openai.api_key = api_key
            return openai
            
        except ImportError:
            raise ImportError("openai package not installed. Run: pip install openai")
    
    def _setup_anthropic_llm(self):
        """Set up Anthropic LLM."""
        try:
            import anthropic
            
            api_key = os.getenv("ANTHROPIC_API_KEY")
            if not api_key:
                raise ValueError("ANTHROPIC_API_KEY not found in environment variables")
            
            client = anthropic.Anthropic(api_key=api_key)
            return client
            
        except ImportError:
            raise ImportError("anthropic package not installed. Run: pip install anthropic")
    
    def generate_policy(
        self, 
        requirements: str, 
        sample_data: Optional[Dict] = None,
        package_name: str = "policy"
    ) -> str:
        """Generate a Rego policy from natural language requirements.
        
        Args:
            requirements: Natural language description of policy requirements
            sample_data: Optional sample data to help understand structure
            package_name: Name for the Rego package
            
        Returns:
            Generated Rego policy as string
        """
        
        # Create the prompt
        prompt = self._create_prompt(requirements, sample_data, package_name)
        
        # Generate policy using LLM
        if self.provider == "google":
            response = self.llm.generate_content(prompt)
            policy_content = response.text
        elif self.provider == "openai":
            response = self.llm.chat.completions.create(
                model="gpt-4",
                messages=[{"role": "user", "content": prompt}],
                max_tokens=2000,
                temperature=0.1
            )
            policy_content = response.choices[0].message.content
        elif self.provider == "anthropic":
            response = self.llm.messages.create(
                model="claude-3-haiku-20240307",
                max_tokens=2000,
                temperature=0.1,
                messages=[{"role": "user", "content": prompt}]
            )
            policy_content = response.content[0].text
        
        # Clean up the policy
        return self._clean_policy(policy_content, package_name)
    
    def _create_prompt(self, requirements: str, sample_data: Optional[Dict], package_name: str) -> str:
        """Create the prompt for the LLM."""
        
#         prompt = f"""You are an expert in Open Policy Agent (OPA) and Rego policy language.

# Generate a Rego policy based on these requirements:

# REQUIREMENTS:
# {requirements}

# PACKAGE NAME: {package_name}
# """
        
#         if sample_data:
#             prompt += f"""
# SAMPLE DATA:
# {json.dumps(sample_data, indent=2)}

# Use this sample data to understand the expected input structure.
# """
        
#         prompt += """
# Generate a complete Rego policy with:
# 1. Proper package declaration
# 2. Default deny rule (default allow = false)
# 3. Main allow rule with conditions
# 4. Helper functions if needed
# 5. Comments explaining the logic

# Return ONLY the Rego code, no explanations or markdown formatting.
# """
        # I've added comments with ## to explain the changes I made to your original prompt.

        prompt = f"""
        You are an expert in OPA Gatekeeper and writing Rego for Kubernetes Admission Control.

        Generate the Rego logic for a Gatekeeper ConstraintTemplate based on these requirements:

        REQUIREMENTS:
        {requirements}

        PACKAGE NAME: {package_name}
        """

        if sample_data:
            prompt += f"""
        SAMPLE DATA (this represents `input.review.object`):
        {json.dumps(sample_data, indent=2)}

        Use this sample data to understand the structure of the Kubernetes object being reviewed.
        """

        prompt += """
        Generate the complete Rego code with the following structure:
        1. A descriptive package declaration based on the provided package name.
        2. A primary `deny` rule that generates a set of user-friendly error messages. The rule must have the signature `deny contains msg if { ... }`.
        3. The Kubernetes resource to be validated is available at the path `input.review.object`.
        4. **Do not** use `allow` or `default allow` rules. Gatekeeper's model is to deny if the `deny` set is not empty.
        5. Use helper functions if they make the code cleaner.
        6. Include comments explaining the logic.

        Return ONLY the Rego code, no explanations or markdown formatting.
        """
        return prompt
    
    def _clean_policy(self, policy_content: str, package_name: str) -> str:
        """Clean up the generated policy."""
        
        # Remove markdown formatting
        policy_content = policy_content.replace("```rego", "").replace("```", "")
        
        # Ensure proper package declaration
        if not policy_content.strip().startswith(f"package {package_name}"):
            policy_content = f"package {package_name}\n\n{policy_content}"
        
        # Clean up whitespace
        lines = []
        for line in policy_content.split('\n'):
            line = line.strip()
            if line:
                lines.append(line)
            elif lines and lines[-1]:
                lines.append("")
        
        return '\n'.join(lines)


def main():
    """Simple command line interface."""
    
    parser = argparse.ArgumentParser(description="Generate Rego policies from natural language")
    parser.add_argument("--requirements", required=True, help="Policy requirements in natural language")
    parser.add_argument("--data", help="Sample data JSON file")
    parser.add_argument("--package", default="policy", help="Package name")
    parser.add_argument("--provider", default="google", choices=["google", "openai", "anthropic"], help="LLM provider")
    parser.add_argument("--output", help="Output file path")
    
    args = parser.parse_args()
    
    # Load sample data if provided
    sample_data = None
    if args.data:
        with open(args.data, 'r') as f:
            sample_data = json.load(f)
    
    # Generate policy
    try:
        generator = SimplePolicyGenerator(provider=args.provider)
        policy = generator.generate_policy(
            requirements=args.requirements,
            sample_data=sample_data,
            package_name=args.package
        )
        
        # Output policy
        if args.output:
            with open(args.output, 'w') as f:
                f.write(policy)
            print(f"Policy saved to {args.output}")
        else:
            print(policy)
            
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()