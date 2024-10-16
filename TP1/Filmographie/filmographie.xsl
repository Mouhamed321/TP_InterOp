<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="iso-8859-1" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="film.css" />
                <title>Cinématographie</title>
            </head>
            <body>
                <h1>Cinématographie</h1>
                <ul><xsl:apply-templates select="film" mode="tdm">
                    <xsl:sort select="@anneeSortie" order="descending" data-type="number" />
                    <xsl:sort select="exploitation/nbreEntree" order="descending" data-type="number" />
                </xsl:apply-templates></ul>

                <h2>Table des matières des acteurs</h2>
                <ul><xsl:apply-templates select="acteurDescription">
                    <xsl:sort select="id" order="ascending" data-type="number" />
                </xsl:apply-templates></ul>

                <xsl:apply-templates select="film" mode="complet">
                    <xsl:sort select="@anneeSortie" order="descending" data-type="number" />
                    <xsl:sort select="exploitation/nbreEntree" order="descending" data-type="number" />
                </xsl:apply-templates>

            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="film" mode="complet">
        <xsl:if test="@annee =2023">
            <div class="new">Nouveauté</div>
        </xsl:if>

        <xsl:variable name="posterFilm">
            <xsl:value-of select="image/@ref" /> 
        </xsl:variable>
        <img src="{$posterFilm}" alt="image" />
        <h2>
            <a>
                <xsl:attribute name="name"><xsl:value-of select="titre"/></xsl:attribute>
                <xsl:value-of select="titre" />
            </a>
        </h2>
        
        <i>Film <xsl:value-of select="nationalite"/> de <xsl:value-of select="duree"/>mn sorti en <xsl:value-of select="@annee"/></i><br/>
        réalisé par <xsl:value-of select="realisateur"/>
        
        <h3>Acteurs :</h3>
        <ul>
            <xsl:apply-templates select="acteurs/acteur"/>
        </ul>
        
        <h3>Scénario :</h3>
        <p class="histoireType">
            <xsl:value-of select="scenario"/>
        </p>

        
    </xsl:template>
    
    <xsl:template match="acteur">
        <li><xsl:value-of select="." /></li>
    </xsl:template>
    
    <xsl:template match="scenario">
        <xsl:apply-templates/>
    </xsl:template>

    


    
    
</xsl:stylesheet>