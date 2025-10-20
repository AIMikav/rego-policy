#!/usr/bin/env python3
"""
Generate a Rego policy using the policy generator with automatic test case loading
"""

import json
import sys
from pathlib import Path
from policy_generator import SimplePolicyGenerator

def load_test_cases(policy_number):
    """Load pass and fail test cases for a given policy number."""
    base_path = Path('../test_files/test_contradicting_inputs')
    
    pass_file = base_path / 'pass' / f'policy_{policy_number}_pass.json'
    fail_file = base_path / 'fail' / f'policy_{policy_number}_fail.json'
    
    pass_test_case = None
    fail_test_case = None
    
    if pass_file.exists():
        with open(pass_file, 'r') as f:
            pass_test_case = json.load(f)
        print(f"Loaded pass test case: {pass_file}")
    else:
        print(f"Pass test case not found: {pass_file}")
    
    if fail_file.exists():
        with open(fail_file, 'r') as f:
            fail_test_case = json.load(f)
        print(f"Loaded fail test case: {fail_file}")
    else:
        print(f"Fail test case not found: {fail_file}")
    
    return pass_test_case, fail_test_case

def get_policy_requirements(policy_number):
    """Get policy requirements from text file based on policy number."""
    requirements_file = Path(f'../requirements/policy_{policy_number}_requirements.txt')
    
    if requirements_file.exists():
        with open(requirements_file, 'r') as f:
            requirements = f.read().strip()
        print(f"Loaded requirements from: {requirements_file}")
        return requirements
    else:
        print(f"Requirements file not found: {requirements_file}")
        return f"Policy {policy_number} requirements - please create requirements file at {requirements_file}"

def generate_single_policy(policy_number):
    """Generate a single policy for the given policy number."""
    print(f"Generating policy {policy_number}...")
    
    # Load test cases
    pass_test_case, fail_test_case = load_test_cases(policy_number)
    
    if not pass_test_case and not fail_test_case:
        print(f"No test cases found for policy {policy_number}. Skipping...")
        return False
    
    # Get policy requirements
    requirements = get_policy_requirements(policy_number)
    print(f"Requirements: {requirements}")
    
    # Generate policy
    generator = SimplePolicyGenerator(provider='google')
    policy = generator.generate_policy(
        requirements=requirements,
        pass_test_case=pass_test_case,
        fail_test_case=fail_test_case,
        package_name='policy'
    )

    print('\n' + '=' * 50)
    print(f'Generated Policy {policy_number}:')
    print('=' * 50)
    print(policy)
    
    # Save to file
    output_dir = Path('../outputs/after_prompt_reduction')
    output_dir.mkdir(exist_ok=True)
    output_file = output_dir / f'policy_{policy_number}_generated.rego'
    with open(output_file, 'w') as f:
        f.write(policy)
    
    print(f'\nPolicy saved to: {output_file}')
    return True

def generate_all_policies():
    """Generate all policies from 0 to 52."""
    print("Generating all policies (0-52) after prompt reduction...")
    print("=" * 60)
    
    successful_policies = []
    failed_policies = []
    skipped_policies = []
    
    for policy_number in range(53):  # 0 to 52 inclusive
        print(f"\n{'='*20} Policy {policy_number} {'='*20}")
        
        # Check if policy already exists
        output_dir = Path('../outputs/after_prompt_reduction')
        output_file = output_dir / f'policy_{policy_number}_generated.rego'
        
        if output_file.exists():
            print(f"Policy {policy_number} already exists at {output_file}. Skipping...")
            skipped_policies.append(policy_number)
            continue
        
        try:
            success = generate_single_policy(policy_number)
            if success:
                successful_policies.append(policy_number)
            else:
                failed_policies.append(policy_number)
        except Exception as e:
            print(f"Error generating policy {policy_number}: {e}")
            failed_policies.append(policy_number)
    
    # Summary
    print("\n" + "=" * 60)
    print("GENERATION SUMMARY")
    print("=" * 60)
    print(f"Successfully generated: {len(successful_policies)} policies")
    print(f"Skipped (already exist): {len(skipped_policies)} policies")
    print(f"Failed to generate: {len(failed_policies)} policies")
    
    if successful_policies:
        print(f"Successful policies: {successful_policies}")
    if skipped_policies:
        print(f"Skipped policies: {skipped_policies}")
    if failed_policies:
        print(f"Failed policies: {failed_policies}")

def main():
    # Get policy number from command line argument
    if len(sys.argv) != 2:
        print("Usage: python generate_policy.py <policy_number|all>")
        print("Examples:")
        print("  python generate_policy.py 0")
        print("  python generate_policy.py all")
        print("Supported policy numbers: 0-52")
        sys.exit(1)
    
    arg = sys.argv[1]
    
    if arg.lower() == 'all':
        generate_all_policies()
    else:
        try:
            policy_number = int(arg)
            if policy_number < 0 or policy_number > 52:
                print("Error: Policy number must be between 0 and 52")
                sys.exit(1)
            generate_single_policy(policy_number)
        except ValueError:
            print("Error: Policy number must be an integer or 'all'")
            sys.exit(1)

if __name__ == "__main__":
    main()