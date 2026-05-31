#!/usr/bin/env bash
# ---------------------------------------------------------------------
# Deploy the AVORA preview site to Cloudflare Pages.
#
# One-time prerequisite (your Cloudflare account):
#     npx wrangler login        # opens the browser, click "Allow"
#
# Then, any time you want to publish:
#     ./deploy.sh
# ---------------------------------------------------------------------
set -euo pipefail
cd "$(dirname "$0")"

PROJECT="avora-preview"
DIST=".deploy"

# Stage ONLY the public site files (keep .git, deploy.sh, README, etc.
# out of what gets served publicly).
rm -rf "$DIST"
mkdir -p "$DIST"
cp index.html "$DIST"/
cp -R assets  "$DIST"/assets
cp -R styles  "$DIST"/styles

echo "Publishing -> Cloudflare Pages project '$PROJECT'..."
npx --yes wrangler@latest pages deploy "$DIST" \
  --project-name="$PROJECT" \
  --commit-dirty=true

rm -rf "$DIST"
echo "Done. URL: https://$PROJECT.pages.dev  (first deploy also creates the project)."
