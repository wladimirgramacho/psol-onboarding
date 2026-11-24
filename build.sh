#!/bin/sh
# Wraps onboarding.html (artifact-style page body) into a standalone index.html for GitHub Pages,
# adding the <head> with link-preview metadata (WhatsApp, Telegram, Facebook, X, LinkedIn, iMessage).
set -e
cd "$(dirname "$0")"

URL="https://wladimirgramacho.github.io/psol-onboarding/"
TITLE="Primeiros Passos no PSOL"
DESC="Guia para novas filiadas e filiados: entenda o partido e comece a militar em 9 passos."
IMG="${URL}og-image.png"
# Cloudflare Web Analytics token (dash.cloudflare.com > Web Analytics). Empty = no analytics.
CF_TOKEN="b4ded63f8fee481eb4c1615da9f514c1"

{
  cat <<EOF
<!doctype html>
<html lang="pt-BR">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="description" content="$DESC">
<meta name="theme-color" content="#650078">
<link rel="canonical" href="$URL">
<link rel="icon" type="image/png" href="favicon.png">
<link rel="apple-touch-icon" href="favicon.png">
<meta property="og:type" content="website">
<meta property="og:locale" content="pt_BR">
<meta property="og:site_name" content="$TITLE">
<meta property="og:title" content="$TITLE">
<meta property="og:description" content="$DESC">
<meta property="og:url" content="$URL">
<meta property="og:image" content="$IMG">
<meta property="og:image:secure_url" content="$IMG">
<meta property="og:image:type" content="image/png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta property="og:image:alt" content="Primeiros Passos no PSOL: guia para novas filiadas e filiados, com o sol do PSOL em amarelo sobre fundo roxo.">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="$TITLE">
<meta name="twitter:description" content="$DESC">
<meta name="twitter:image" content="$IMG">
<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}[hidden]{display:none!important}img{max-width:100%}</style>
EOF
  if [ -n "$CF_TOKEN" ]; then
    printf '<script defer src="https://static.cloudflareinsights.com/beacon.min.js" data-cf-beacon='"'"'{"token": "%s"}'"'"'></script>\n' "$CF_TOKEN"
  fi
  # the page's own <title>, description meta and font links belong in <head> too
  sed -n '1,/<style>/p' onboarding.html | grep -v '<style>' | grep -v 'name="description"'
  printf '</head>\n<body>\n'
  sed -n '/<style>/,$p' onboarding.html
  printf '\n</body>\n</html>\n'
} > index.html
echo "built index.html"
