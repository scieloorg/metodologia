;<?php /*
[SITE_INFO]
SITE_NAME=SciELO - Scientific Electronic Library Online
SHORT_NAME=Scielo Brazil
SITE_AUTHOR=FAPESP - CNPq - FapUNIFESP - BIREME
ADDRESS_1=R. Dr. Diogo de Faria, 1087 cj.810
ADDRESS_2=04037-003 - Sao Paulo/SP
COUNTRY=Brasil
PHONE_NUMBER=+55 11 3369-4080/4085
#FAX_NUMBER=+55 11 5575-8868
E_MAIL=scielo@bireme.br
STANDARD_LANG=en
APP_NAME=scielo
ANALYTICS_CODE=scl

[LILACS]
SERVER_LILACS=www.bireme.br
PATH_WXIS_LILACS=/cgi-bin/wxislind.exe
PATH_CGI_BIN_IAH_LILACS=iah/
PATH_DATA_IAH_LILACS=/iah/online/

[MEDLINE]
SERVER_MEDLINE=www.bireme.br
PATH_WXIS_MEDLINE=/cgi-bin/wxislind.exe
PATH_CGI_BIN_IAH_MEDLINE=iah/
PATH_DATA_IAH_MEDLINE=/iah/online/

[SCIELO]
SERVER_SCIELO=scielo.org.do
PATH_WXIS_SCIELO=/cgi-bin/wxis.exe
PATH_CGI_BIN_IAH_SCIELO=iah/
PATH_DATA_IAH_SCIELO=/iah/
STAT_SERVER_CITATION=http://statbiblio.scielo.br/
STAT_SERVER_COAUTH=http://statbiblio.scielo.br/

[ADOLEC]
SERVER_ADOLEC=www.bireme.br
PATH_WXIS_ADOLEC=/cgi-bin/wxislind.exe
PATH_CGI_BIN_IAH_ADOLEC=iah/
PATH_DATA_IAH_ADOLEC=/iah/online/

[PATH]
PATH_DATA=/
PATH_CGI-BIN=/cgi-bin/
PATH_SCRIPTS=ScieloXML/
PATH_GENIMG=/img/
PATH_SERIMG=/img/revistas/
PATH_SERIAL_HTML=/revistas/
PATH_XSL=/var/www/scielo/htdocs/xsl/
PATH_DATABASE=/var/www/scielo/bases/
PATH_SETTINGS=
PATH_PDF=/var/www/scielo/bases/pdf/
PATH_TRANSLATION=/var/www/scielo/bases/translation/
PATH_HTDOCS=/var/www/scielo/htdocs/
PATH_OAI=/var/www/scielo/htdocs/oai/
PATH_PROC=/var/www/scielo/proc/

[LOG]
ACTIVATE_LOG=0
ENABLE_STATISTICS_LINK=0
ENABLE_COAUTH_REPORTS_LINK=0
ENABLE_CITATION_REPORTS_LINK=0
PINGDOM_CODE=
GOOGLE_CODE=
GOOGLE_SAMPLE_RATE=100
ENABLE_ARTICLE_LANG_LINK=0

[CACHE]
ENABLED_CACHE=0
SERVER_CACHE=192.168.1.13
SERVER_PORT_CACHE=11211
MAX_DAYS = 1
MAX_SIZE = 9368709120 
PATH_CACHE=/var/www/scielo/bases/pages/
CHECK_EXPIRED = 0
CACHE_STATUS = off

[SCIELO_REGIONAL]
SCIELO_REGIONAL_DOMAIN=www.scielo.org

[LINKS]
show_home_scieloorg=1
show_home_journal_evaluation=1
show_home_help=1
show_home_about=1
show_home_scielo_news=1
show_home_scielo_team=1
show_home_scielo_signature=1

[services]
journal_manager=1
sci_artlangs="http://trigramas.bireme.br/cgi-bin/wxis.exe/?IsisScript=ScieloXML/sci_artlangs.xis&def=scielo.def&pid=PARAM_PID"
show_toolbox=1
show_datasus=0
show_reference=1
show_requests=1
show_send_by_email=1
show_cited_scielo=1
show_similar_in_scielo=1
show_article_references=1
show_scimago=0
show_article_wltranslation=1
show_fapesp_projects=0
show_press_releases=0
show_clinical_trials=0
show_ref_links=1
show_meta_citation_reference=1
show_ubio=1
show_new_article_link=0
show_altmetrics=0
show_readcube=0
show_readcube_epdf=0

[services_group]
show_group_article = 1
show_group_indicators = 1
show_group_related_links = 1
show_group_bookmark = 1

[FULLTEXT_SERVICES]
access="http://scielo.org.do/applications/scielo-org/pages/services/articleRequestGraphicPage.php?pid=PARAM_PID&caller=PARAM_SERVER"
cited_SciELO="http://scielo.org.do/scieloOrg/php/citedScielo.php?pid=PARAM_PID"
cited_SciELO_service="http://trigramas.bireme.br/cgi-bin/mx/cgi=@scielo/cited?pid=PARAM_PID"
similar_SciELO_service="http://trigramas.bireme.br/cgi-bin/mx/cgi=@1?xml&collection=SciELO.org.TiKwAb&minsim=0.30&maxrel=30&show=scielo1&text=PARAM_TEXT"
related="http://scielo.org.do/scieloOrg/php/related.php?pid=PARAM_PID"
related_service="http://trigramas.bireme.br/cgi-bin/mx/cgi=@scielo/related?pid=PARAM_PID"
send_mail="http://scielo.org.do/applications/scielo-org/pages/services/sendMail.php?pid=PARAM_PID&caller=PARAM_SERVER"
windows_live_translator="http://www.windowslivetranslator.com"
ubio="http://www.ubio.org/tools/linkit.php?url="

[mimetex]
mimetex=/cgi-bin/mimetex.cgi

[language]
client_charset = utf-8

[CrossRef]
DOI_PREFIX=
DEPOSITOR_NAME=
DEPOSITOR_MAIL=
DEPOSITOR_DOMAIN=

[XML_ERROR]
ENABLED_XML_ERROR=0
ENABLED_MAIL_ALERT=0
ENABLED_LOG_XML_ERROR=0
MAILTO_XML_ERROR=
NAMETO_XML_ERROR=SciELO
LOG_XML_ERROR_FILENAME=/var/www/scielo/logs/xml_error_log.txt

[PRESENTATION]
LICENSE=cc
CC_AND_VERSION=BY-NC-SA 4.0
show_issues_sorted_by_pubdate=0
BEFOREPRINT_ISSUES=splited
BEFOREPRINT_ISSUETOC=splited
NO_SCI_SERIAL=no
BLOCK_FUTURE_EPUB=0

[MAIL_CREDENTIALS]
sender=
username=
password=
host=smtp.gmail.com
port=465
secure=ssl

; */ ?>
