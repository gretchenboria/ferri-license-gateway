# Ferri NFC License Gateway

Web gateway for NFC-based license activation.

## Files

- `index.html` - License activation page (shows license key and installation instructions)
- `install.sh` - Installation script for ferri CLI

## Deployment to GitHub Pages

### 1. Create GitHub Repository

Go to https://github.com/new and create a new repository:
- Name: `ferri-license-gateway`
- Public
- Don't initialize with README (we already have files)

### 2. Push to GitHub

```bash
cd /Users/dr.gretchenboria/ferribyte/web-gateway
git remote add origin https://github.com/YOUR_USERNAME/ferri-license-gateway.git
git branch -M main
git push -u origin main
```

### 3. Enable GitHub Pages

1. Go to repository Settings → Pages
2. Under "Source", select "main" branch
3. Click "Save"
4. Wait 1-2 minutes for deployment

Your site will be at: `https://YOUR_USERNAME.github.io/ferri-license-gateway/`

## NFC Tag Configuration

Write tags with hash-based URL using `{TAG_ID}` variable:
```
https://YOUR_USERNAME.github.io/ferri-license-gateway/#{TAG_ID}
```

The hash format is NFC-safe (query strings get mangled).

## Testing

Local: `http://localhost:8080/#0464AAFA771D91`
Production: `https://YOUR_USERNAME.github.io/ferri-license-gateway/#0464AAFA771D91`
