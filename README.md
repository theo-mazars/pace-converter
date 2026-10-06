# Pace Converter

A one-page converter for runners. Fill in any two of distance, time, pace and speed and the other two update as you type. Works in km or miles.

No build step, no backend, no cookies, no analytics, and no requests to other sites. Everything is one HTML file plus three self-hosted font files.

## Files

| File | Purpose |
| --- | --- |
| `index.html` | The whole app (markup, styles and script) |
| `favicon.svg`, `favicon.png`, `apple-touch-icon.png` | Browser tab and home-screen icons |
| `og-image.png` | 1200x630 preview image for link sharing |
| `robots.txt`, `sitemap.xml` | Search engine crawl hints |
| `fonts/` | Big Shoulders Display and Space Mono (woff2, Latin subset) with their licences |
| `Dockerfile` | nginx image that serves the page on port 8080 |
| `nginx.conf` | Caching, compression, security headers and a `/healthz` endpoint |

## Try it locally

Either open `index.html` in a browser, or run it the way it will run in production:

```sh
docker build -t pace-converter .
docker run --rm -p 8080:8080 pace-converter
# then open http://localhost:8080
```

## Deploy on Dokploy

1. Push this folder to a git repository.
2. Point a DNS `A` record for your subdomain (for example `pace.example.com`) at your Dokploy server's IP address.
3. In Dokploy, create a project, then add an **Application**.
4. Under the application's **Provider** settings, connect the repository and branch. For a private repository, add the SSH key or access token Dokploy asks for.
5. Set **Build Type** to **Dockerfile**, with the Dockerfile path `Dockerfile` and the build context `.`, then save.
6. Open the **Domains** tab and add your subdomain with:
   - **Container port**: `8080`
   - **HTTPS** enabled, with **Let's Encrypt** as the certificate provider
7. Click **Deploy**.

Menu labels move around a little between Dokploy versions, but these are the settings that matter. The container port must be `8080`, not `80`, because the image runs nginx as a non-root user.

To redeploy after a change, push to the branch and deploy again, or enable auto-deploy on the application so a push triggers it.

## Changing things

Everything lives in `index.html`. Conversion logic sits in the first `<script>` block, between the `PURE:START` and `PURE:END` comments. Colours and fonts are CSS variables at the top of the stylesheet. The design is deliberately one bright look, with no dark variant.

## How the fields link

Each of distance, time and "rate" (pace and speed together) counts as one quantity. Any two of the three determine the third. The page remembers the two you edited most recently and recalculates the other one. Calculated fields show in a yellow striped box with a "calc" sticker; fields you typed stay white.

Pace shows to the nearest second and distance to two decimal places, but calculations use the unrounded values. A half marathon appears as 21.1 km while the exact 21.0975 km is used underneath.

## Licences

The fonts are open source under the SIL Open Font License 1.1. The licence texts are in `fonts/`.

## SEO

The canonical URL `https://pace-converter.theomazars.com/` appears in `index.html` (canonical, Open Graph, Twitter and JSON-LD tags), `robots.txt` and `sitemap.xml`. Change all of them together if the domain moves. Update `lastmod` in `sitemap.xml` when the page content changes.
