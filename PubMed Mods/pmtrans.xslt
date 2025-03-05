<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.loc.gov/mods/v3"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8" omit-xml-declaration="no"/>

    <xsl:template match="/">
        <modsCollection xmlns="http://www.loc.gov/mods/v3"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-7.xsd">
            <xsl:apply-templates select="PubmedArticleSet/PubmedArticle"/>
        </modsCollection>
    </xsl:template>

    <xsl:template match="PubmedArticle">
        <mods version="3.7" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-7.xsd">
        <xsl:choose>
            <xsl:when test="MedlineCitation/Article/PublicationTypeList/PublicationType = 'Review'">
            <genre authority="diva" type="contentTypeCode">refereed</genre>
            <genre authority="diva" type="publicationTypeCode">review</genre>
            <genre authority="svep" type="publicationType">for</genre>
            <genre authority="diva" type="publicationType" lang="eng">Article, review/survey</genre>
            <genre authority="kev" type="publicationType" lang="eng">article</genre>
                </xsl:when>
                <xsl:when test="MedlineCitation/Article/PublicationTypeList/PublicationType = 'Systematic Review'">
            <genre authority="diva" type="contentTypeCode">refereed</genre>
            <genre authority="diva" type="publicationTypeCode">review</genre>
            <genre authority="svep" type="publicationType">for</genre>
            <genre authority="diva" type="publicationType" lang="eng">Article, review/survey</genre>
            <genre authority="kev" type="publicationType" lang="eng">article</genre>
                </xsl:when>
                <xsl:when test="MedlineCitation/Article/PublicationTypeList/PublicationType = 'Comment'">
                        <genre authority="diva" type="contentTypeCode">science</genre>
            <genre authority="diva" type="publicationTypeCode">article</genre>
            <genre authority="svep" type="publicationType">art</genre>
            <genre authority="diva" type="publicationType" lang="eng">Article in journal</genre>
            <genre authority="kev" type="publicationType" lang="eng">article</genre>
            <genre authority="diva" type="publicationSubTypeCode">letter</genre>
            <genre authority="diva" type="publicationSubType" lang="eng">Letter</genre>
                </xsl:when>
                <xsl:when test="MedlineCitation/Article/PublicationTypeList/PublicationType = 'Letter'">            
            <genre authority="diva" type="contentTypeCode">science</genre>
            <genre authority="diva" type="publicationTypeCode">article</genre>
            <genre authority="svep" type="publicationType">art</genre>
            <genre authority="diva" type="publicationType" lang="eng">Article in journal</genre>
            <genre authority="kev" type="publicationType" lang="eng">article</genre>
            <genre authority="diva" type="publicationSubTypeCode">letter</genre>
            <genre authority="diva" type="publicationSubType" lang="eng">Letter</genre>
                </xsl:when>
                 <xsl:when test="MedlineCitation/Article/PublicationTypeList/PublicationType = 'Editorial'">
            <genre authority="diva" type="contentTypeCode">science</genre>
            <genre authority="diva" type="publicationTypeCode">article</genre>
            <genre authority="svep" type="publicationType">art</genre>
            <genre authority="diva" type="publicationType" lang="eng">Article in journal</genre>
            <genre authority="kev" type="publicationType" lang="eng">article</genre>
            <genre authority="diva" type="publicationSubTypeCode">editorialMaterial</genre>
                </xsl:when>
            <xsl:when test="MedlineCitation/Article/PublicationTypeList/PublicationType = 'Published Erratum'">
            <genre authority="diva" type="contentTypeCode">other</genre>
            <genre authority="diva" type="publicationTypeCode">other</genre>
            <genre authority="svep" type="publicationType">ovr</genre>
            <genre authority="diva" type="publicationType" lang="eng">Other</genre>
            <genre authority="kev" type="publicationType" lang="eng"></genre>
                </xsl:when>
                <xsl:otherwise>
            <genre authority="diva" type="contentTypeCode">refereed</genre>
            <genre authority="diva" type="publicationTypeCode">article</genre>
            <genre authority="svep" type="publicationType">art</genre>
            <genre authority="diva" type="publicationType" lang="eng">Article in journal</genre>
            <genre authority="kev" type="publicationType" lang="eng">article</genre>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:for-each select="MedlineCitation/Article/AuthorList/Author">
                <name type="personal">
                    <namePart type="family"><xsl:value-of select="LastName"/></namePart>
                    <namePart type="given">
                        <xsl:choose>
                            <xsl:when test="ForeName">
                                <xsl:value-of select="ForeName"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="Initials"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </namePart>
                    <role>
                        <roleTerm type="code" authority="marcrelator">aut</roleTerm>
                    </role>                    
                    <affiliation>
                        <xsl:for-each select="AffiliationInfo/Affiliation">
                            <xsl:variable name="affiliationText" select="."/>
                            
                            <!-- Check if the affiliation text contains an email address -->
                            <xsl:choose>
                                <xsl:when test="contains($affiliationText, '@')">
                                   
                                    <!-- Get the part of the text before the email address -->
                                    <xsl:variable name="cleanedAffiliation" select="substring-before($affiliationText, '. ')"/>
                                    
                                    <!-- Output the cleaned affiliation text -->
                                    <xsl:value-of select="$cleanedAffiliation"/>
                                    <xsl:text>.</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                
                                    <!-- Output the entire affiliation text if no email address is found -->
                                    <xsl:value-of select="$affiliationText"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            
                            <!-- Add a semicolon and space if this is not the last affiliation -->
                            <xsl:if test="position() != last()">
                                <xsl:text>; </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </affiliation>
                    <xsl:if test="Identifier">
                        <description>orcid.org=<xsl:value-of select="Identifier"/></description>
                    </xsl:if>
                   </name>
            </xsl:for-each>   
            <titleInfo lang="eng">
                <xsl:variable name="title" select="MedlineCitation/Article/ArticleTitle"/>
                <xsl:choose>
                    <xsl:when test="contains($title, ':')">
                        <title><xsl:value-of select="substring-before($title, ':')"/></title>
                        <subTitle><xsl:value-of select="substring-after($title, ':')"/></subTitle>
                    </xsl:when>
                    <xsl:when test="contains($title, '—')">
                         <title><xsl:value-of select="substring-before($title, '—')"/></title>
                         <subTitle><xsl:value-of select="substring-after($title, '—')"/></subTitle>
                    </xsl:when>
                    <xsl:otherwise>
                        <title><xsl:value-of select="$title"/></title>
                    </xsl:otherwise>
                </xsl:choose>
            </titleInfo>
            <language>
                <languageTerm type="code" authority="iso639-2b"><xsl:value-of select="MedlineCitation/Article/Language"/></languageTerm>
            </language>
            <originInfo>
                <dateIssued><xsl:value-of select="MedlineCitation/Article/Journal/JournalIssue/PubDate/Year"/></dateIssued>
            </originInfo>
            <physicalDescription>
                <form authority="marcform">print</form>
            </physicalDescription>
            <xsl:if test="MedlineCitation/Article/ELocationID[@EIdType='doi']">
                <identifier type="doi"><xsl:value-of select="MedlineCitation/Article/ELocationID[@EIdType='doi']"/></identifier>
            </xsl:if>
            <identifier type="pmid"><xsl:value-of select="MedlineCitation/PMID"/></identifier>
             <xsl:if test="MedlineCitation/Article/Journal/ISSN[@IssnType='Electronic']">   
                <identifier type="eissn"><xsl:value-of select="MedlineCitation/Article/Journal/ISSN[@IssnType='Electronic']"/></identifier>
            </xsl:if>
            <xsl:if test="MedlineCitation/Article/Journal/ISSN[@IssnType='Print']">
                <identifier type="issn"><xsl:value-of select="MedlineCitation/Article/Journal/ISSN[@IssnType='Print']"/></identifier>
            </xsl:if>
            <xsl:if test="MedlineCitation/Article/Pagination/StartPage = MedlineCitation/Article/Pagination/MedlinePgn">
                <identifier type="articleId"><xsl:value-of select="MedlineCitation/Article/Pagination/StartPage"/></identifier>
            </xsl:if>
                    <!-- Lägger till MeSH-termer, ger många dublettkeywords, så avvaktiverar.-->
        <subject lang="eng">
            <!-- Process MeshHeadings -->
            <xsl:for-each select="MedlineCitation/MeshHeadingList/MeshHeading">
                <xsl:variable name="concatenatedDescriptorNames">
                    <xsl:value-of select="DescriptorName"/>
                    <xsl:for-each select="QualifierName">
                        <xsl:text> / </xsl:text>
                        <xsl:value-of select="."/>
                    </xsl:for-each>
                </xsl:variable>
                <topic><xsl:value-of select="$concatenatedDescriptorNames"/></topic>
            </xsl:for-each>
            <!-- Process Keywords, remove keywords that also appears as Mesh headings -->
            <xsl:variable name="meshHeadings" select="MedlineCitation/MeshHeadingList/MeshHeading/DescriptorName"/>
            <xsl:for-each select="MedlineCitation/KeywordList/Keyword">
                <xsl:variable name="keyword" select="translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
                <xsl:variable name="isDuplicate" select="boolean($meshHeadings[translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = $keyword])"/>
                <xsl:if test="not($isDuplicate)">
                    <topic><xsl:value-of select="."/></topic>
                </xsl:if>
            </xsl:for-each>
        </subject>
        <abstract lang="eng">
            <xsl:for-each select="MedlineCitation/Article/Abstract/AbstractText">
                <xsl:if test="@Label">
                    <xsl:text>&lt;p&gt;&lt;strong&gt;</xsl:text>
                    <xsl:value-of select="@Label"/>
                    <xsl:text>:&lt;/strong&gt; </xsl:text>
                </xsl:if>
                <xsl:value-of select="."/>
                <xsl:if test="position() != last()">
                    <xsl:text>&lt;/p&gt;</xsl:text>
                </xsl:if>
            </xsl:for-each>
        </abstract>
         <relatedItem type="host">
                <titleInfo>
                        <title><xsl:value-of select="MedlineCitation/Article/Journal/Title"/></title>
                    </titleInfo>
                    <xsl:if test="MedlineCitation/Article/Journal/ISSN[@IssnType='Electronic']">   
                        <identifier type="eissn"><xsl:value-of select="MedlineCitation/Article/Journal/ISSN[@IssnType='Electronic']"/></identifier>
                    </xsl:if>
                    <xsl:if test="MedlineCitation/Article/Journal/ISSN[@IssnType='Print']">
                        <identifier type="issn"><xsl:value-of select="MedlineCitation/Article/Journal/ISSN[@IssnType='Print']"/></identifier>
                    </xsl:if>
                    <part>
                    <xsl:if test="MedlineCitation/Article/Journal/JournalIssue/Volume">
                        <detail type="volume">
                            <number><xsl:value-of select="MedlineCitation/Article/Journal/JournalIssue/Volume"/></number>
                        </detail>
                    </xsl:if>
                    <xsl:if test="MedlineCitation/Article/Journal/JournalIssue/Issue">
                        <detail type="issue">
                            <number><xsl:value-of select="MedlineCitation/Article/Journal/JournalIssue/Issue"/></number>
                        </detail>
                    </xsl:if>
                    <xsl:if test="MedlineCitation/Article/Pagination/EndPage">
                        <extent>
                            <start><xsl:value-of select="MedlineCitation/Article/Pagination/StartPage"/></start>
                            <end><xsl:value-of select="MedlineCitation/Article/Pagination/EndPage"/></end>
                        </extent>
                    </xsl:if>
                    </part>
            </relatedItem>
            <xsl:if test="PubmedData/PublicationStatus = 'aheadofprint' and not(MedlineCitation/Article/Journal/JournalIssue/Volume) and not(MedlineCitation/Article/Journal/JournalIssue/Issue)">
                <note type="publicationStatus" lang="eng">Epub ahead of print</note>
            </xsl:if>
        </mods> 
    </xsl:template>
    <!-- Remove all fields that have not been transformed -->
    <xsl:template match="*|@*">
        <!-- This template matches all nodes and attributes that do not match any other template.
             By doing so, it ensures that any elements or attributes not explicitly handled by other templates
             will be ignored and not included in the output. This is useful for filtering out unwanted data
             and keeping the output clean and focused on the desired elements. -->
    </xsl:template>
</xsl:stylesheet>
