<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.loc.gov/mods/v3"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:ns0="http://www.elsevier.com/xml/svapi/abstract/dtd"
    xmlns:ns1="http://prismstandard.org/namespaces/basic/2.0/"
    xmlns:ns3="http://www.elsevier.com/xml/ani/common"
    xmlns:ns4="http://www.elsevier.com/xml/ani/ait"
    xmlns:ns5="http://www.elsevier.com/xml/xocs/dtd"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    exclude-result-prefixes="ns0 ns1 ns3 ns4 ns5">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8" omit-xml-declaration="no"/>

    <xsl:key name="affiliationById" match="ns0:affiliation" use="@id" />
    <xsl:key name="authorByAuid" match="ns0:abstracts-retrieval-response/item/bibrecord/head/author-group/author" use="@auid" />

    <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

    <xsl:template match="/">
        <modsCollection xmlns="http://www.loc.gov/mods/v3"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-7.xsd">
            <xsl:apply-templates select="records/record"/>
        </modsCollection>
    </xsl:template>

    <xsl:template match="record">
        <mods version="3.7" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-7.xsd">
            <xsl:variable name="countryAbbr" select="translate(ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/conflocation/@country, $lowercase, $uppercase)"/>
            <xsl:variable name="countryName" select="document('/Users/ah3264/Downloads/ScopusMods/all.xml')/countries/country[@alpha-3 = $countryAbbr]/@name"/>
        <xsl:choose>
            <xsl:when test="ns0:abstracts-retrieval-response/ns0:coredata/ns0:subtypeDescription = 'Conference Paper'">
            <genre authority="diva" type="contentTypeCode">refereed</genre>
            <genre authority="diva" type="publicationTypeCode">conferencePaper</genre>
            <genre authority="svep" type="publicationType">kon</genre>
            <genre authority="diva" type="publicationType" lang="eng">Conference paper</genre>
            <genre authority="kev" type="publicationType" lang="eng">proceeding</genre>
            <genre authority="diva" type="publicationSubTypeCode">publishedPaper</genre>
                </xsl:when>
                <xsl:when test="ns0:abstracts-retrieval-response/ns0:coredata/ns0:subtypeDescription = 'Book Chapter'">
            <genre authority="diva" type="contentTypeCode">refereed</genre>
            <genre authority="diva" type="publicationTypeCode">chapter</genre>
            <genre authority="svep" type="publicationType">kap</genre>
            <genre authority="diva" type="publicationType" lang="eng">Chapter in book</genre>
            <genre authority="kev" type="publicationType" lang="eng">bookitem</genre>
                </xsl:when>
                <xsl:when test="ns0:abstracts-retrieval-response/ns0:coredata/ns0:subtypeDescription = 'Note'">
            <genre authority="diva" type="contentTypeCode">science</genre>
            <genre authority="diva" type="publicationTypeCode">article</genre>
            <genre authority="svep" type="publicationType">art</genre>
            <genre authority="diva" type="publicationType" lang="eng">Article in journal</genre>
            <genre authority="kev" type="publicationType" lang="eng">article</genre>
            <genre authority="diva" type="publicationSubTypeCode">letter</genre>
                </xsl:when>
                <xsl:when test="ns0:abstracts-retrieval-response/ns0:coredata/ns0:subtypeDescription = 'Letter'">
            <genre authority="diva" type="contentTypeCode">science</genre>
            <genre authority="diva" type="publicationTypeCode">article</genre>
            <genre authority="svep" type="publicationType">art</genre>
            <genre authority="diva" type="publicationType" lang="eng">Article in journal</genre>
            <genre authority="kev" type="publicationType" lang="eng">article</genre>
            <genre authority="diva" type="publicationSubTypeCode">letter</genre>
                </xsl:when>
                <xsl:when test="ns0:abstracts-retrieval-response/ns0:coredata/ns0:subtypeDescription = 'Editorial' and ns0:abstracts-retrieval-response/ns0:coredata/ns1:aggregationType = 'Journal'">
            <genre authority="diva" type="contentTypeCode">science</genre>
            <genre authority="diva" type="publicationTypeCode">article</genre>
            <genre authority="svep" type="publicationType">art</genre>
            <genre authority="diva" type="publicationType" lang="eng">Article in journal</genre>
            <genre authority="kev" type="publicationType" lang="eng">article</genre>
            <genre authority="diva" type="publicationSubTypeCode">editorialMaterial</genre>
                </xsl:when>
                <xsl:when test="ns0:abstracts-retrieval-response/ns0:coredata/ns0:subtypeDescription = 'Editorial' and ns0:abstracts-retrieval-response/ns0:coredata/ns1:aggregationType = 'Book'">
            <genre authority="diva" type="contentTypeCode">science</genre>
            <genre authority="diva" type="publicationTypeCode">chapter</genre>
            <genre authority="svep" type="publicationType">kap</genre>
            <genre authority="diva" type="publicationType" lang="eng">Chapter in book</genre>
            <genre authority="kev" type="publicationType" lang="eng">bookitem</genre>   
                </xsl:when>     
                <xsl:when test="ns0:abstracts-retrieval-response/ns0:coredata/ns0:subtypeDescription = 'Editorial' and ns0:abstracts-retrieval-response/ns0:coredata/ns1:aggregationType = 'Book Series'">
            <genre authority="diva" type="contentTypeCode">science</genre>
            <genre authority="diva" type="publicationTypeCode">chapter</genre>
            <genre authority="svep" type="publicationType">kap</genre>
            <genre authority="diva" type="publicationType" lang="eng">Chapter in book</genre>
            <genre authority="kev" type="publicationType" lang="eng">bookitem</genre>   
                </xsl:when>
                <xsl:when test="ns0:abstracts-retrieval-response/ns0:coredata/ns0:subtypeDescription = 'Editorial' and ns0:abstracts-retrieval-response/ns0:coredata/ns1:aggregationType = 'Conference Proceeding'">
            <genre authority="diva" type="contentTypeCode">science</genre>
            <genre authority="diva" type="publicationTypeCode">conferencePaper</genre>
            <genre authority="svep" type="publicationType">kon</genre>
            <genre authority="diva" type="publicationType" lang="eng">Conference paper</genre>
            <genre authority="kev" type="publicationType" lang="eng">proceeding</genre>
            <genre authority="diva" type="publicationSubTypeCode">publishedPaper</genre>  
                </xsl:when>     
                <xsl:when test="ns0:abstracts-retrieval-response/ns0:coredata/ns0:subtypeDescription = 'Review'">
            <genre authority="diva" type="contentTypeCode">refereed</genre>
            <genre authority="diva" type="publicationTypeCode">review</genre>
            <genre authority="svep" type="publicationType">for</genre>
            <genre authority="diva" type="publicationType" lang="eng">Article, review/survey</genre>
            <genre authority="kev" type="publicationType" lang="eng">article</genre>
                </xsl:when>
                <xsl:when test="ns0:abstracts-retrieval-response/ns0:coredata/ns0:subtypeDescription = 'Book'">
            <genre authority="diva" type="contentTypeCode">refereed</genre>
            <genre authority="diva" type="publicationTypeCode">book</genre>
            <genre authority="svep" type="publicationType">bok</genre>
            <genre authority="diva" type="publicationType" lang="eng">Book</genre>
            <genre authority="kev" type="publicationType" lang="eng">book</genre>
                </xsl:when>
                <xsl:otherwise>
            <genre authority="diva" type="contentTypeCode">refereed</genre>
            <genre authority="diva" type="publicationTypeCode">article</genre>
            <genre authority="svep" type="publicationType">art</genre>
            <genre authority="diva" type="publicationType" lang="eng">Article in journal</genre>
            <genre authority="kev" type="publicationType" lang="eng">article</genre>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:for-each select="ns0:abstracts-retrieval-response/ns0:authors/ns0:author">
                <name type="personal">
                    <namePart type="family"><xsl:value-of select="ns3:surname"/></namePart>
                    <namePart type="given">
                        <xsl:choose>
                            <xsl:when test="ns3:given-name">
                                <xsl:value-of select="ns3:given-name"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="ns3:initials"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </namePart>
                    <role>
                        <roleTerm type="code" authority="marcrelator">aut</roleTerm>
                    </role>
                    <affiliation>
                    <xsl:variable name="authorAuid" select="@auid"/>
                        <xsl:choose>
                           <xsl:when test="key('authorByAuid', @auid)/ancestor::author-group/affiliation/ns3:source-text">
                                <xsl:for-each select="../../item/bibrecord/head/author-group[author/@auid = $authorAuid]/affiliation/ns3:source-text">
                                <xsl:value-of select="."/>
                                <xsl:if test="position() != last()">
                                    <xsl:text>; </xsl:text>
                                </xsl:if>
                                </xsl:for-each>
                           </xsl:when>
                           <xsl:when test="../../item/bibrecord/head/author-group[author/@auid = $authorAuid]/affiliation/organization">
                                <xsl:for-each select="../../item/bibrecord/head/author-group[author/@auid = $authorAuid]/affiliation">
                                    <xsl:for-each select="organization">
                                        <xsl:value-of select="."/>
                                        <xsl:if test="position() != last()">
                                        <xsl:text>, </xsl:text>
                                        </xsl:if>
                                   </xsl:for-each>
                                    <xsl:text>, </xsl:text>
                                    <xsl:if test="city">
                                        <xsl:value-of select="city"/>
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:value-of select="country"/>
                                    <xsl:if test="position() != last()">
                                        <xsl:text>; </xsl:text>
                                    </xsl:if>
                                </xsl:for-each>
                             </xsl:when>
                            <xsl:otherwise>
                            <xsl:for-each select="ns0:affiliation">
                                <xsl:variable name="affilId" select="@id"/>
                                    <xsl:for-each select="../../../ns0:affiliation[@id = $affilId]">
                                    <xsl:value-of select="ns0:affilname"/>
                                    <xsl:text>, </xsl:text>
                                     <xsl:value-of select="ns0:affiliation-city"/>
                                        <xsl:text>, </xsl:text>
                                        <xsl:value-of select="ns0:affiliation-country"/>
                                        <xsl:if test="position() != last()">
                                            <xsl:text>; </xsl:text>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>  
                    </affiliation>
                <xsl:variable name="authorAuid" select="@auid"/>
                <xsl:variable name="orcid" select="key('authorByAuid', $authorAuid)/@orcid"/>
                <xsl:if test="$orcid">
                    <description>orcid.org=<xsl:value-of select="$orcid"/></description>
                </xsl:if>
                </name>
            </xsl:for-each>
            <titleInfo lang="eng">
                <xsl:variable name="title" select="ns0:abstracts-retrieval-response/ns0:coredata/dc:title"/>
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
                <languageTerm type="code" authority="iso639-2b">eng</languageTerm>
            </language>
            <originInfo>
                <publisher><xsl:value-of select="ns0:abstracts-retrieval-response/item/bibrecord/head/source/publisher/publishername"/></publisher>
                <dateIssued><xsl:value-of select="ns0:abstracts-retrieval-response/item/bibrecord/head/source/publicationdate/year"/></dateIssued>
            </originInfo>
            <physicalDescription>
                <form authority="marcform">print</form>
                <xsl:if test="ns0:abstracts-retrieval-response/ns0:coredata/ns0:subtypeDescription = 'Book'"> 
                    <extent><xsl:value-of select="ns0:abstracts-retrieval-response/ns0:coredata/ns1:endingPage"/></extent>
                </xsl:if>
            </physicalDescription>
            <xsl:if test="ns0:abstracts-retrieval-response/item/bibrecord/head/source/isbn[@type='print']">
                <identifier type="isbn" displayLabel="print"><xsl:value-of select="ns0:abstracts-retrieval-response/item/bibrecord/head/source/isbn[@type='print']"/></identifier>   
            </xsl:if>
            <xsl:if test="ns0:abstracts-retrieval-response/item/bibrecord/head/source/isbn[@type='electronic']">
                <identifier type="isbn" displayLabel="electronic"><xsl:value-of select="ns0:abstracts-retrieval-response/item/bibrecord/head/source/isbn[@type='electronic']"/></identifier>   
            </xsl:if>
            <xsl:if test="ns0:abstracts-retrieval-response/ns0:coredata/ns1:doi">
                <identifier type="doi"><xsl:value-of select="ns0:abstracts-retrieval-response/ns0:coredata/ns1:doi"/></identifier>
            </xsl:if>
            <xsl:if test="ns0:abstracts-retrieval-response/ns0:coredata/ns0:pubmed-id">
                <identifier type="pmid"><xsl:value-of select="ns0:abstracts-retrieval-response/ns0:coredata/ns0:pubmed-id"/></identifier>
            </xsl:if>
            <identifier type="scopus"><xsl:value-of select="ns0:abstracts-retrieval-response/ns0:coredata/ns0:eid"/></identifier>
            <xsl:if test="ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='electronic']">
                <identifier type="eissn"><xsl:value-of select="concat(substring(ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='electronic'], 1, 4), '-', substring(ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='electronic'], 5, 4))"/></identifier>
            </xsl:if>
            <xsl:if test="ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='print']">
                <identifier type="issn"><xsl:value-of select="concat(substring(ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='print'], 1, 4), '-', substring(ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='print'], 5, 4))"/></identifier>
            </xsl:if>
            <xsl:if test="ns0:abstracts-retrieval-response/item/bibrecord/head/source/article-number">
                <identifier type="articleId"><xsl:value-of select="ns0:abstracts-retrieval-response/item/bibrecord/head/source/article-number"/></identifier>
            </xsl:if>
            <typeOfResource>text</typeOfResource>
             <xsl:if test="ns0:abstracts-retrieval-response/ns0:coredata/ns1:aggregationType = 'Book Series'">
                <relatedItem type="series">
                    <titleInfo>
                        <title><xsl:value-of select="ns0:abstracts-retrieval-response/ns0:coredata/ns1:publicationName"/></title>
                    </titleInfo>
                    <xsl:if test="ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='print']">
                        <identifier type="issn"><xsl:value-of select="concat(substring(ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='print'], 1, 4), '-', substring(ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='print'], 5, 4))"/></identifier>
                    </xsl:if>
                    <xsl:if test="ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='electronic']">
                        <identifier type="eissn"><xsl:value-of select="concat(substring(ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='electronic'], 1, 4), '-', substring(ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='electronic'], 5, 4))"/></identifier>
                    </xsl:if>
                    <xsl:if test="ns0:abstracts-retrieval-response/ns0:coredata/ns1:volume">
                        <part>
                            <detail type="volume">
                                <number><xsl:value-of select="ns0:abstracts-retrieval-response/ns0:coredata/ns1:volume"/></number>
                            </detail>
                        </part>
                    </xsl:if>
                </relatedItem>
            </xsl:if>
            <subject lang="eng">
            <xsl:for-each select="ns0:abstracts-retrieval-response/ns0:authkeywords/ns0:author-keyword">
                <topic><xsl:value-of select="."/></topic>
            </xsl:for-each>
            </subject>
            <abstract><xsl:value-of select="ns0:abstracts-retrieval-response/ns0:coredata/dc:description/abstract/ns3:para"/></abstract>
            <xsl:if test="ns0:abstracts-retrieval-response/ns0:coredata/ns0:subtypeDescription != 'Book'">
                <relatedItem type="host">
                    <titleInfo>
                        <title><xsl:value-of select="ns0:abstracts-retrieval-response/ns0:coredata/ns1:publicationName"/></title>
                    </titleInfo>
                    <xsl:if test="ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='print']">
                    <identifier type="issn"><xsl:value-of select="concat(substring(ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='print'], 1, 4), '-', substring(ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='print'], 5, 4))"/></identifier>
                    </xsl:if>
                    <xsl:if test="ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='electronic']">
                    <identifier type="eissn"><xsl:value-of select="concat(substring(ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='electronic'], 1, 4), '-', substring(ns0:abstracts-retrieval-response/item/bibrecord/head/source/issn[@type='electronic'], 5, 4))"/></identifier>
                    </xsl:if>
                    <part>
                    <xsl:if test="ns0:abstracts-retrieval-response/ns0:coredata/ns1:volume">
                        <detail type="volume">
                            <number><xsl:value-of select="ns0:abstracts-retrieval-response/ns0:coredata/ns1:volume"/></number>
                        </detail>
                    </xsl:if>
                    <xsl:if test="ns0:abstracts-retrieval-response/ns0:coredata/ns1:issueIdentifier">
                        <detail type="issue">
                            <number><xsl:value-of select="ns0:abstracts-retrieval-response/ns0:coredata/ns1:issueIdentifier"/></number>
                        </detail>
                    </xsl:if>
                    <xsl:if test="ns0:abstracts-retrieval-response/ns0:coredata/ns1:startingPage">
                        <extent>
                            <start><xsl:value-of select="ns0:abstracts-retrieval-response/ns0:coredata/ns1:startingPage"/></start>
                            <end><xsl:value-of select="ns0:abstracts-retrieval-response/ns0:coredata/ns1:endingPage"/></end>
                        </extent>
                        </xsl:if>
                    </part>
                </relatedItem>
            </xsl:if>
            <xsl:if test="ns0:abstracts-retrieval-response/ns0:coredata/ns1:aggregationType = 'Journal' and not(ns0:abstracts-retrieval-response/ns0:coredata/ns1:volume) and not(ns0:abstracts-retrieval-response/ns0:coredata/ns1:issueIdentifier)">
                <note type="publicationStatus" lang="eng">Epub ahead of print</note>
            </xsl:if>
            <xsl:if test="ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo">
                <name type="conference">
                    <namePart><xsl:choose>
                        <xsl:when test="ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confdate/startdate/@month = ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confdate/enddate/@month">
                        <xsl:value-of select=
                            "concat(
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confname,
                            ', ',
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confdate/startdate/@day,
                            '-',
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confdate/enddate/@day,
                            ' ',
                            substring('JanFebMarAprMayJunJulAugSepOctNovDec', (number(ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confdate/enddate/@month) - 1) * 3 + 1, 3),
                            ' ',
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confdate/enddate/@year,
                            ', ',
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/conflocation/city,
                            ', ',
                            $countryName)"/>
                        
                        </xsl:when>
                        <xsl:otherwise>
                    <xsl:value-of select=
                            "concat(
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confname,
                            ', ',
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confdate/startdate/@day, 
                            ' ',
                            substring('JanFebMarAprMayJunJulAugSepOctNovDec', (number(ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confdate/startdate/@month) - 1) * 3 + 1, 3),
                            '-',
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confdate/enddate/@day,
                            ' ',
                            substring('JanFebMarAprMayJunJulAugSepOctNovDec', (number(ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confdate/enddate/@month) - 1) * 3 + 1, 3),
                            ' ',
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confdate/enddate/@year,
                            ', ',
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/conflocation/city,
                            ', ',
                            $countryName)"/>
                            <!-- om inte all.xml används för att hämta landnamn 
                            <xsl:value-of select=
                            "concat(
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confname,
                            ', ',
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confdate/startdate/@day, 
                            '-',
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confdate/startdate/@month,
                            '-',
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confdate/startdate/@year,
                            ' - ',
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confdate/enddate/@day,
                            '-',
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confdate/enddate/@month,
                            '-',
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/confdate/enddate/@year,
                            ', ',
                            ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/conflocation/city,
                            ', ',
                           translate(ns0:abstracts-retrieval-response/item/bibrecord/head/source/additional-srcinfo/conferenceinfo/confevent/conflocation/@country, $lowercase, $uppercase)
                            )"/>
                            -->
                    </xsl:otherwise>
                    </xsl:choose>
                    </namePart>
                </name>   
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
