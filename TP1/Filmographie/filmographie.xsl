<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="iso-8859-1" indent="yes"/>

    <xsl:template match="/">
        <html><head> <title> cinématographie </title> </head>
        <body>
            <h1>Cinématographie</h1>
            <xsl:apply-templates select="films/film" />
        </body>
        </html>
    </xsl:template>

    <xsl:template match="film">
        <html><head><title>cinématographie</title></head>
        <body>
            <h2><xsl:value-of select="titre" /></h2>
            <i>Film <xsl:value-of select="nationalite"/> de <xsl:value-of select="duree"/>mn sortie en <xsl:value-of select="@annee"/></i><br/>
            réalisé par <xsl:value-of select="realisateur"/>
        </body>
        </html>
    </xsl:template>

</xsl:stylesheet>

