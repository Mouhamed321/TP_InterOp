<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="iso-8859-1" indent="yes"/>
    <xsl:template match="/films">
    <html>
        <head>
            <link rel="stylesheet" type="text/css" href="film.css" />
            <title>Cinématographie</title>
        </head>
        <body>
            <h1>Cinématographie</h1>


            <h2>Table des matières des films</h2>
             <ul> <xsl:apply-templates select="film" mode="tdm"/></ul>

            <h2>Table des matières des acteurs</h2>
                <ul><xsl:apply-templates select="acteurDescription" mode="tdm" /></ul>

             <xsl:apply-templates select="film" mode="complet">
                <xsl:sort select="@annee" order="descending" data-type="number" />
            </xsl:apply-templates>

            
        </body>
    </html>
    </xsl:template>

   <xsl:template match="film" mode="tdm">
    <li>
                            <a>
                                <xsl:attribute name="href">#<xsl:apply-templates select="films/film" /></xsl:attribute>
                                <xsl:value-of select="titre" />
                            </a>
                            <xsl:text> (</xsl:text>
                            <xsl:value-of select="count(acteurs/acteur)" />
                            <xsl:text> acteurs)</xsl:text>
     </li>
  </xsl:template>

  <xsl:template match="acteurDescription" mode="tdm">
    <li>
        <xsl:apply-templates select="films/acteurDescription" />
        <xsl:apply-templates select ="nom"/> <xsl:apply-templates select ="prenom"/> né le <xsl:apply-templates select ="dateNaissance"/>, de sexe : <xsl:apply-templates select ="sexe"/>, a joué(e) dans <xsl:value-of select="count(/films/film[acteurs/acteur[@ref=current()/@id]])"/> film(s).
    </li>
  </xsl:template>
    
   <xsl:template match="film" mode="complet">
    <xsl:if test="@annee = 2023">
        <div class="new">Nouveauté</div>
    </xsl:if>

    <xsl:variable name="posterFilm">
        <xsl:value-of select="image/@ref" /> 
    </xsl:variable>
    <img src="{$posterFilm}" alt="image" />
    
    <!-- Encadrer le titre avec un lien nommé pour l'ancre -->
    <h2>
        <a>
            <xsl:attribute name="name"><xsl:value-of select="titre" /></xsl:attribute>
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





    


</xsl:stylesheet>