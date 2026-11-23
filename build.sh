#!/bin/sh
# Wraps onboarding.html (artifact-style page body) into a standalone index.html for any static host.
set -e
cd "$(dirname "$0")"
{
  printf '<!doctype html>\n<html lang="pt-BR">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
  printf '<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}[hidden]{display:none!important}img{max-width:100%%}</style>\n'
  printf '</head>\n<body>\n'
  cat onboarding.html
  printf '\n</body>\n</html>\n'
} > index.html
echo "built index.html"
