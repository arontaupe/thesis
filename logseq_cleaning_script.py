import os
import shutil

# Use os.path.expanduser to correctly expand ~ to the home directory
assets_dir = os.path.expanduser('~/thesis/logseq/assets')
journal_dir = os.path.expanduser('~/thesis/logseq/journals')
pages_dir = os.path.expanduser('~/thesis/logseq/pages')
to_delete_dir = os.path.expanduser('~/thesis/logseq/to_delete')

# Check and create the to_delete_dir if it doesn't exist
if not os.path.exists(to_delete_dir): 
    os.makedirs(to_delete_dir)

# List all files in the assets directory
assets_files = os.listdir(assets_dir)
referenced_files = []

# Iterate over the journal and pages directories to find referenced assets
for dirname in [journal_dir, pages_dir]:
    for filename in os.listdir(dirname):
        if filename.endswith('.md'):
            with open(os.path.join(dirname, filename)) as f:
                for line in f:
                    for asset in assets_files:
                        if asset in line:
                            referenced_files.append(asset)

# Move assets that are not referenced and do not end with ".edn" to the to_delete_dir
for asset in assets_files:
    if asset not in referenced_files and not asset.endswith(".edn"):
        print(asset)
        shutil.move(os.path.join(assets_dir, asset), to_delete_dir)
