#!/bin/bash
set -e

echo "Installing ai-project-template..."

git clone --depth 1 https://github.com/taku-o/ai-project-template.git ai-project-template
rm -rf ai-project-template/.git ai-project-template/README.md ai-project-template/install.sh
if command -v gitignore-merge >/dev/null 2>&1 && [ -f .gitignore ]; then
  gitignore-merge .gitignore ai-project-template/.gitignore > ai-project-template/.gitignore
fi
(cd ai-project-template; tar cf - .) | tar xpf -
rm -rf ai-project-template

echo "Done!"

