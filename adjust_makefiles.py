import os
import re
import fileinput

def process_makefile(file_path):
    with open(file_path, 'r') as file:
        content = file.read()
    
    # Find the run section, including the "run:" line
    run_match = re.search(r'^(run:.*?$)(.*?)^\s*$', content, re.MULTILINE | re.DOTALL)
    if run_match:
        run_line = run_match.group(1)  # Preserve the original "run:" line
        run_section = run_match.group(2).strip()
        lines = run_section.split('\n')
        changes_made = []
        
        # Process each line in the run section
        new_lines = []
        for line in lines:
            words = line.split()
            for i in range(len(words) - 1, -1, -1):
                if words[i] == '1000':
                    words[i] = '100'
                    changes_made.append("1000 -> 100")
                    break
                elif words[i] == '100':
                    words[i] = '10'
                    changes_made.append("100 -> 10")
                    break
                elif words[i] == '10':
                    words[i] = '1'
                    changes_made.append("10 -> 1")
                    break
            new_lines.append(' '.join(words))
        
        new_run_section = '\n'.join(new_lines)
        
        if changes_made:
            # Replace the run section, keeping the original "run:" line
            new_content = re.sub(r'^run:.*?$(.*?)^\s*$', f'{run_line}\n{new_run_section}\n', content, flags=re.MULTILINE | re.DOTALL)
            with open(file_path, 'w') as file:
                file.write(new_content)
            print(f"Updated {file_path}:")
            for change in changes_made:
                print(f"  - Change made: {change}")
            print(f"  - New run section:\n{run_line}\n{new_run_section}")

def find_and_process_makefiles(directory):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.lower() == 'makefile':
                file_path = os.path.join(root, file)
                process_makefile(file_path)

# Use the current directory as the starting point
find_and_process_makefiles('.')