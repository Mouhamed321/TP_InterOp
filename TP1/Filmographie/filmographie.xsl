<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="iso-8859-1" indent="yes"/>
    <xsl:template match="/films">
    <html>
        <head>
            <script src="https://code.jquery.com/jquery-2.2.4.min.js"> </script>
            <script src="scroll.js"> </script>
            <link rel="stylesheet" type="text/css" href="scroll.css" />
            <link rel="stylesheet" type="text/css" href="film.css" />
            <title>Cinématographie</title>
        </head>
        <body>
            <div id="main">

                <section>
                    <h2>Table des matières des films</h2>
                        <ul> <xsl:apply-templates select="film" mode="tdm"/></ul>
                </section>

                <section>
                    <h2>Table des matières des acteurs</h2>
                    <ul><xsl:apply-templates select="acteurDescription" mode="tdm" /></ul>
                </section>
                
                <xsl:apply-templates select="film" mode="complet">
                    <xsl:sort select="@annee" order="descending" data-type="number" />
                </xsl:apply-templates>
                
            </div>           

            <script>
                $("#main").onepage_scroll({
                    sectionContainer: "section",
                    easing: "ease",
                    animationTime: 2000,
                    pagination: true,
                    updateURL: false,
                    beforeMove: function(index) {},
                    afterMove: function(index) {},
                    loop: false,
                    keyboard: true,
                    responsiveFallback: false
                    });
            </script>
        </body>
    </html>
    </xsl:template>

    <xsl:template match="film" mode="complet">
        <section>
            <xsl:if test="@annee = 2023">
                <div class="new">Nouveauté</div>
            </xsl:if>

            <h2>
                <a>
                    <xsl:attribute name="name"><xsl:value-of select="titre" /></xsl:attribute>
                    <xsl:value-of select="titre" />
                </a>
            </h2>

            <div>
                <xsl:apply-templates select="genres"></xsl:apply-templates>
            </div>

            <div>
                <xsl:variable name="posterFilm">
                    <xsl:value-of select="image/@ref" /> 
                </xsl:variable>
                <img src="{$posterFilm}" alt="image" />
            </div> <br/>

            <p>
                <i>Film <xsl:value-of select="nationalite"/> de <xsl:value-of select="duree"/>mn sorti en <xsl:value-of select="@annee"/></i><br/>
            réalisé par <xsl:value-of select="realisateur"/>
            </p> 
    
              
    
            <h3>Acteurs :</h3>
            <ul>
                <xsl:apply-templates select="acteurs/acteur"/>               
            </ul>
            
            <h3>Scénario :</h3>
            <p class="histoireType">
                <xsl:value-of select="scenario"/>
            </p>
        </section>
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

    <xsl:template match="acteur">
        <li><xsl:value-of select="." /></li>
    </xsl:template>

    <xsl:template match="acteurDescription" mode="tdm">
        <li>
            <xsl:apply-templates select="films/acteurDescription" />
            <xsl:apply-templates select ="prenom"/> <xsl:text> </xsl:text>    
            <xsl:apply-templates select ="nom"/> né(e) le 
            <xsl:apply-templates select ="dateNaissance"/>, de sexe : 
            <xsl:apply-templates select ="sexe"/>, a joué dans 
            <xsl:value-of select="count(/films/film[acteurs/acteur[@ref=current()/@id]])"/> film(s).
            <xsl:apply-templates select="/films/film[acteurs/acteur[@ref=current()/@id]]" mode="filmActeur"/>            
        </li>
    </xsl:template>

    <xsl:template match="film" mode="filmActeur"> 
        <xsl:text> </xsl:text>
        <a href="#">
        <xsl:attribute name="onclick">$('.main').moveTo(<xsl:value-of select="position()+2" />);</xsl:attribute>
        <xsl:value-of select="position()" />
        </a>
    </xsl:template>


</xsl:stylesheet>