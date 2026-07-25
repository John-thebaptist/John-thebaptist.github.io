<?xml version="1.0" encoding="UTF-8"?>
<!-- Browser-only presentation for feed.xml. Feed readers ignore this
     stylesheet entirely and consume the underlying RSS 2.0 document. -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="html" encoding="UTF-8" indent="yes"
    doctype-system="about:legacy-compat"/>

  <xsl:template match="/rss/channel">
    <html lang="en">
      <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title><xsl:value-of select="title"/> &#183; RSS feed</title>
        <meta name="robots" content="noindex,follow"/>
        <link rel="icon" href="/assets/favicon.svg" type="image/svg+xml"/>
        <link rel="preload" href="/assets/fonts/carme-latin.woff2" as="font" type="font/woff2" crossorigin="anonymous"/>
        <link rel="preload" href="/assets/fonts/cantata-one-latin.woff2" as="font" type="font/woff2" crossorigin="anonymous"/>
        <link rel="stylesheet" href="/assets/styles.css"/>
      </head>
      <body>
        <header class="site-header">
          <div class="shell">
            <a class="brand" href="/">
              <span>John The Baptist</span>
            </a>
            <nav class="site-nav" aria-label="Main">
              <a href="/articles/">Articles</a>
              <a href="/builds/">Builds</a>
              <a href="/about/">About</a>
              <a href="https://github.com/John-thebaptist">GitHub</a>
            </nav>
          </div>
        </header>

        <main class="shell page-main">
          <div class="page-header">
            <p class="label">RSS feed</p>
            <h1><xsl:value-of select="title"/></h1>
            <p class="lead"><xsl:value-of select="description"/></p>
          </div>

          <div class="feed-note">
            <h2>This page is a feed, not an article.</h2>
            <p>
              You are looking at the styled version of an RSS feed. Paste the address
              below into any feed reader and new posts will arrive automatically, with
              no account, algorithm or newsletter involved.
            </p>
            <p><code>https://john-thebaptist.github.io/feed.xml</code></p>
          </div>

          <div class="section">
            <div class="section-head">
              <h2>Published posts</h2>
              <p class="section-count"><xsl:value-of select="count(item)"/> in this feed</p>
            </div>
            <ul class="feed-list">
              <xsl:for-each select="item">
                <li>
                  <article class="card feed-item">
                    <span class="feed-date"><xsl:value-of select="pubDate"/></span>
                    <h3><xsl:value-of select="title"/></h3>
                    <p><xsl:value-of select="description"/></p>
                    <a class="card-action" href="{link}">
                      Read the post <span aria-hidden="true">&#8594;</span>
                    </a>
                  </article>
                </li>
              </xsl:for-each>
            </ul>
          </div>
        </main>

        <footer class="site-footer">
          <div class="shell">
            <p>Built by John.</p>
            <p>Powered by GitHub Pages and unreasonable persistence.</p>
          </div>
        </footer>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
