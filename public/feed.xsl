<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:webfeeds="http://webfeeds.org/rss/1.0"
  xmlns:media="http://search.yahoo.com/mrss/"
  exclude-result-prefixes="webfeeds"
>
  <!-- based on https://gist.github.com/andrewstiefel/57a0a400aa2deb6c9fe18c6da4e16e0f -->
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
        <title>
          Web Feed •
          <xsl:value-of select="webfeeds:rss/webfeeds:channel/webfeeds:title"/>
        </title>
        <style type="text/css">
            body {
                max-width: 768px;
                margin: 0 auto;
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
                font-size: 16px;
                line-height: 1.5em
            }

            section {
                margin: 30px 15px
            }

            div.logo {
              text-align: center;
            }

            h1 {
                font-size: 2em;
                margin: .67em 0;
                line-height: 1.125em
            }

            h2 {
                border-bottom: 1px solid #eaecef;
                padding-bottom: .3em
            }

            .alert {
                background: #fff5b1;
                padding: 4px 12px;
                margin: 0 -12px
            }

            a {
                text-decoration: none
            }

            .entry h3 {
                margin-bottom: 0
            }

            .entry p {
                margin: 4px 0
            }

            code {
                font-family: monospace;
                background: lightgray;
            }
        </style>
      </head>
      <body>
        <section>
          <div class="alert">
            <p>
                <strong>This is an web feed</strong>.
                Subscribe by copying the URL from the address bar into your feed reader app.
            </p>
          </div>
        </section>
        <section>
          <xsl:apply-templates select="webfeeds:rss/webfeeds:channel" />
        </section>
        <section>
          <h2>Recent Items</h2>
          <xsl:apply-templates select="webfeeds:rss/webfeeds:channel/webfeeds:item" />
        </section>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="webfeeds:channel">
    <div class="logo">
      <img class="logo">
        <xsl:attribute name="src">
          <xsl:value-of select="webfeeds:image/webfeeds:url"/>
        </xsl:attribute>
      </img>
    </div>
    <h1>
      <xsl:value-of select="webfeeds:title"/>
      Web Feed Preview
    </h1>

    <p>This feed provides the latest posts from <xsl:value-of select="webfeeds:title"/>.

    <a class="head_link" target="_blank">
      <xsl:attribute name="href">
        <xsl:value-of select="webfeeds:link"/>
      </xsl:attribute>
      Visit Website &#x2192;
    </a>

    </p>

    <h2>What is an web feed?</h2>
    <p>
        An web feed is a data format that contains the latest content from a website, blog, or podcast.
        You can use feeds to <strong>subscribe</strong> to websites and get the <strong>latest content in one place</strong>.
    </p>
    <ul>
    	<li>
            <strong>Feeds put you in control.</strong>
            Unlike social media apps, there is no algorithm deciding what you see or read.
            You always get the latest content from the creators you care about.
        </li>
    	<li>
            <strong>Feed are private by design.</strong>
            No one owns web feeds, so no one is harvesting your personal information and profiting by selling it to advertisers.
        </li>
    	<li>
            <strong>Feeds are spam-proof.</strong>
            Had enough? Easy, just unsubscribe from the feed.
        </li>
    </ul>
    <p>
        All you need to do to get started is to add the URL (web address) for this feed to a special app called a newsreader.
        Visit <a href="https://aboutfeeds.com/">About Feeds</a> to get started with newsreaders and subscribing. It's free.
    </p>
  </xsl:template>

  <xsl:template match="webfeeds:item">
    <div class="entry">
      <div>
        <xsl:value-of select="webfeeds:description" disable-output-escaping="yes"/>
      </div>
      <xsl:if test="count(webfeeds:category) > 0">
        <p>Categories:
            <ul>
            <xsl:for-each select="webfeeds:category">
                <li><xsl:value-of select="."/></li>
            </xsl:for-each>
            </ul>
        </p>
      </xsl:if>
      <small>
        Published:
        <a target="_blank">
          <xsl:attribute name="href">
            <xsl:value-of select="webfeeds:link"/>
          </xsl:attribute>
          <xsl:value-of select="webfeeds:pubDate" />
        </a>
      </small>
    </div>
  </xsl:template>

</xsl:stylesheet>
