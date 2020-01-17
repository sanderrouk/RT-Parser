import Foundation

struct RTAbbreviationListStubs {

    static let listWithFourLaws =
"""
<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="et" xml:lang="et" xmlns="http://www.w3.org/1999/xhtml">

<head>
    <title>Lühendid ja nende vasted – Riigi Teataja</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="imagetoolbar" content="false" />
    <meta name="Author" content="Webmedia" />
    <meta name="Keywords" content="Riigi Teataja" />
    <meta name="Description" content="Riigi Teataja" />

    <link rel="shortcut icon" type="image/ico" href="/favicon.ico" />

    <link rel="stylesheet" type="text/css" href="/gfx/_styles.css" media="all" />
    <link rel="stylesheet" type="text/css" href="/gfx/_styles_screen.css" media="screen, projection" title="Styles" />
    <link rel="stylesheet" type="text/css" href="/gfx/_styles_screen_akt.css" media="screen, projection"
        title="Styles" />
    <link rel="stylesheet" type="text/css" href="/cal/css/jquery.datepick.css" media="screen, projection" />
    <link rel="stylesheet" type="text/css" href="/gfx/_styles_print.css" media="print" />
    <link rel="stylesheet" type="text/css" href="/gfx/_styles_print_akt.css" media="print" />
    <link rel="stylesheet" type="text/css" href="/gfx/_styles_tinymce.css" media="all" />
    <script type="text/javascript"
        src="/skriptid.html?src=js%2fjquery.min.js%2cjs%2fjquery-ui.min.js%2cjs%2fjquery.cookie.js%2cjs%2fjquery.outerclick.js%2cjs%2fjquery.example.min.js%2cjs%2fjquery.bgiframe.min.js%2cjs%2fjquery.popupWindow.js%2cjs%2fjquery.tooltip.min.js%2ccal%2fjs%2fjquery.plugin.min.js%2ccal%2fjs%2fjquery.datepick.min.js%2ccal%2fjs%2fjquery.datepick-et.js%2cjs%2f_scripts.js%2cjs%2fskriptid.js%2cjs%2fjquery.autocomplete.min.js%2cjs%2ffilter.js%2cjs%2fjquery.jqprint.js&amp;versioon=1">
    </script>
    <script type="text/javascript" src="/js/login-vorm.js"></script>
    <script type="text/javascript" src="/js/google-analytics-init.js"></script>
</head>

<body>

    <div id="wrap">

        <div id="header">
            <p id="logo"><a href="/index.html" title="Avalehele">Riigi Teataja</a></p>
            <div id="search">
                <p class="label">
                    <label for="search-field">Lihtne otsing seaduste ja üleriigiliste määruste terviktekstide pealkirjadest</label>
                </p>
                <div class="search-form">
                    <form method="get" action="/otsingu_tulemus.html" id="otsinguVorm" accept-charset="UTF-8">
                        <input type="hidden" name="sakk" value="kehtivad"/>
                        <p class="field clear">
                            <input type="text" class="text" name="otsisona" id="search-field" title="Sisesta akti nimi, märksõna või ametlik lühend" value=""/>
                            <span class="button"><input type="submit" value="Otsi" /></span>
                        </p>
                    </form>
                </div>
            </div>
        </div>

        <div id="nav">
            <ul class="nav">
                <li><a href="/tervikteksti_otsing.html">Täpne otsing</a></li>
                <li><a href="#">Liigitus</a>
                    <ul>
                        <li><a href="/jaotused.html?jaotus=S%C3%9CSTJAOT">Süstemaatiline liigitus</a></li>
                        <li><a href="/kronoloogia.html">Kronoloogia</a></li>
                        <li><a href="/jaotused.html?jaotus=0">Eurovoc</a></li>
                        <li><a href="/jaotused.html?jaotus=KOV">KOV määruste valdkondlik liigitus</a></li>
                        <li><a href="/jaotused.html?jaotus=RIIGID">Välislepingute liigitus poolte alusel</a></li>
                        <li><a href="/kohtulahendite_liigitus.html">Kohtulahendite liigitus</a></li>
                    </ul>
                </li>

                <li><a href="#">Statistika</a>
                    <ul>
                        <li><a href="/enim_vaadatud.html">Enim vaadatud</a></li>
                        <li><a href="/statistika.html">Üldine statistika</a></li>
                    </ul>
                </li>

                <li><a href="#">Viited</a>
                    <ul>
                        <li><a href="/lyhendid.html">Õigusaktide lühendid</a></li>
                        <li><a href="/viited.html">Üldised viited</a></li>
                        <li><a href="/viitedLeht.html?id=1">Riikluse rajamist kajastavad dokumendid</a></li>
                        <li><a href="/viitedLeht.html?id=2">Põhiseadused</a></li>
                        <li><a href="/viitedLeht.html?id=3">Eesti suhtes tehtud EIK otsuste tõlked</a></li>
                        <li><a href="/viitedLeht.html?id=4">PS kommenteeritud väljaanne</a></li>
                        <li><a href="/viitedLeht.html?id=5">Vandetõlkide jaotus valdkonniti</a></li>
                        <li><a href="/viitedLeht.html?id=6">KOV loetelu määruste kehtivusest 1.06.2014 seisuga</a></li>
                    </ul>
                </li>

                <li><a href="/eelnoud/otsing.html">Eelnõud</a></li>
                <li><a href="#">Kohtuteave</a>
                    <ul>
                        <li><a href="/kohtulahendid/koik_menetlused.html">Kohtulahendite otsing</a></li>
                        <li><a href="/kohtuteave/kohtuistungid_otsing.html">Kohtuistungi aja ja koha otsing</a></li>
                        <li><a href="/kohtuteave/kohtulahendite_analyysid.html">Kohtulahendite kokkuvõtted</a></li>
                        <li><a href="/kohtuteave/oigusakti_viide_kohtulahendile.html">Kokkuvõtete seosed
                                õigusaktidega</a></li>
                        <li><a href="/kohtulahendite_liigitus.html">Kohtulahendite liigitus</a></li>
                        <li><a href="/kohtuteave/eik_liigitus.html">Euroopa Inimõiguste Kohtu liigitused</a></li>
                    </ul>
                </li>

                <li><a href="#">Õigusuudised</a>
                    <ul>
                        <li><a href="/oigusuudised/kohtuuudiste_nimekiri.html">Kohtu-uudised</a></li>

                        <li><a href="/oigusuudised/seadusteUudisteNimekiri.html">Seadusuudised</a></li>

                        <li><a href="/oigusuudised/muuOigusuudisteNimekiri.html">Muud õigusuudised</a></li>
                    </ul>
                </li>

                <li><a href="#">Abi</a>
                    <ul>
                        <li><a href="/kkk.html">KKK</a></li>
                        <li><a href="/abiLeht.html?id=1">Riigi Teataja võrguväljaandest</a></li>
                        <li><a href="/abiLeht.html?id=2">Terviktekstide otsimine</a></li>
                        <li><a href="/abiLeht.html?id=3">Algtekstide otsimine</a></li>
                        <li><a href="/abiLeht.html?id=4">Lihtne otsing</a></li>
                        <li><a href="/abiLeht.html?id=5">Eelnõude otsing</a></li>
                        <li><a href="/tagasiside.html">Tagasiside</a></li>
                    </ul>
                </li>

                <li>
                    <a href="/en/">English</a>
                </li>

            </ul>
            <p id="myrt-link"><a href="#">Minu RT</a></p>
            <div id="myrt">
                <div class="a clear">
                    <div class="col1"><input value="979fb690-6984-4187-9b68-d54611042a0c" name="_csrf" type="hidden"/>
                        <p class="form">
                            <label for="myrt01">Kasutajanimi:</label><input autocomplete="off" name="j_username" id="myrt01" class="text" type="text"/></p>
                            <p class="form">
                                <label for="myrt02">Parool:</label><input autocomplete="new-password" name="j_password" id="myrt02" class="text" type="password"/></p>
                                <p class="check">
                                    <input value="true" name="remember-me" id="myrt-check01" type="checkbox"/><label for="myrt-check01">Jäta mind meelde</label>
                                </p>
                                <p class="action">
                                    <button id="submit-login"><span><strong>Sisene</strong></span></button></p>
                    </div>
                    <div class="col2">
                        <h2>Miks minu RT?<br/>
Minu RT võimaldab:</h2>
                            <ul>
                                <li> Töötada oma aktidega</li>
                                <li>Tellida akte, kohtukokkuvõtteid ja õigusuudiseid e-postile</li>
                                <li>Seadistada RT endale sobivaks</li>
                            </ul>
                            <p class="meta"><a href="/registreeru.html">Registreeru</a><span>|</span><a
                                    href="/parooli_tellimine.html">Unustasid parooli?</a></p>
                    </div>
                </div>
            </div>
        </div>
        <noscript>
            <div class="info">
                Sinu veebilehitsejal pole JavaScript tuge või on see välja
                lülitatud.<br/><br/>Täieliku funktsionaalsuse ja mugavama kasutuskogemuse tagamiseks soovitame võimalusel JavaScripti toe sisse lülitada.</div>
        </noscript>

        <div class="clear" id="content">
            <h1>Lühendid ja nende vasted</h1>
            <p>Siit leiad aktide lühendite nimekirja, mille järgi saad ka otsinguid teostada.</p>
            <script type="text/javascript" src="/js/sorteeriv-pealdis.js"></script>

            <form id="filterForm" action="/lyhendid.html" method="get" accept-charset="utf-8">
                <table class="data">
                    <thead>
                        <tr>
                            <th width="80%" class="sort  " id="th-pealkiri">
                                <a title="Sorteeri" data-path="pealkiri" data-ascending="true" data-prefiks=""
                                    class="sorteeri-ilma" href="#">Pealkiri</a>
                            </th>
                            <th width="20%" class="sort  " id="th-lyhend">
                                <a title="Sorteeri" data-path="lyhend" data-ascending="true" data-prefiks=""
                                    class="sorteeri-ilma" href="#">Lühend</a>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <a href="akt/123122019021">2020. aasta riigieelarve seadus</a>
                            </td>
                            <td>
                                <a href="akt/RES2020">RES2020</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="akt/113032019027">Abieluvararegistri seadus</a>
                            </td>
                            <td>
                                <a href="akt/AVRS">AVRS</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="akt/113032019029">Abipolitseiniku seadus</a>
                            </td>
                            <td>
                                <a href="akt/APolS">APolS</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="akt/119032019051">Advokatuuriseadus</a>
                            </td>
                            <td>
                                <a href="akt/AdvS">AdvS</a>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <input value="" name="sorteeri" type="hidden" id="sorteeri"/><input value="true" name="kasvav" type="hidden" id="kasvav"/></form>
        </div>
        <div id="footer" class="clear">
            <div class="col1">
                <p class="euro">Lehe valmimist toetas Euroopa Liit</p>
            </div>
            <div class="col2">
                <p class="copy"><a
                        href="https://www.facebook.com/pages/Riigi-Teataja/446473188771945"><img src="/failid/ico-facebook.gif" alt="Facebooki logo" /> Facebook</a>
                          <a href="https://twitter.com/RT_RiigiTeataja"><img src="/failid/ico-twitter.gif" alt="Twitteri logo" /> Twitter</a>                   ©
                            Riigikantselei 2010<br/>© Justiitsministeerium 2012</p>
                            <p class="meta">Riigi Teataja otsinguabi: 620 8148 <br/>Tagasiside: <a
                                    href="https://www.riigiteataja.ee/tagasiside.html">e-kiri</a> </p>
                            <div>Versioon 11.4.0</div>
            </div>
        </div>

    </div>
    <p id="otsingu-soovitused-url" class="elem-hidden">/otsingu_soovitused.json</p>
    <script type="text/javascript" src="/js/otsingu-soovitused.js"></script>
</body>

</html>
""".data(using: .utf8)!

        static let listWithZeroLaws =
    """
    <!DOCTYPE html
        PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html lang="et" xml:lang="et" xmlns="http://www.w3.org/1999/xhtml">

    <head>
        <title>Lühendid ja nende vasted – Riigi Teataja</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="imagetoolbar" content="false" />
        <meta name="Author" content="Webmedia" />
        <meta name="Keywords" content="Riigi Teataja" />
        <meta name="Description" content="Riigi Teataja" />

        <link rel="shortcut icon" type="image/ico" href="/favicon.ico" />

        <link rel="stylesheet" type="text/css" href="/gfx/_styles.css" media="all" />
        <link rel="stylesheet" type="text/css" href="/gfx/_styles_screen.css" media="screen, projection" title="Styles" />
        <link rel="stylesheet" type="text/css" href="/gfx/_styles_screen_akt.css" media="screen, projection"
            title="Styles" />
        <link rel="stylesheet" type="text/css" href="/cal/css/jquery.datepick.css" media="screen, projection" />
        <link rel="stylesheet" type="text/css" href="/gfx/_styles_print.css" media="print" />
        <link rel="stylesheet" type="text/css" href="/gfx/_styles_print_akt.css" media="print" />
        <link rel="stylesheet" type="text/css" href="/gfx/_styles_tinymce.css" media="all" />
        <script type="text/javascript"
            src="/skriptid.html?src=js%2fjquery.min.js%2cjs%2fjquery-ui.min.js%2cjs%2fjquery.cookie.js%2cjs%2fjquery.outerclick.js%2cjs%2fjquery.example.min.js%2cjs%2fjquery.bgiframe.min.js%2cjs%2fjquery.popupWindow.js%2cjs%2fjquery.tooltip.min.js%2ccal%2fjs%2fjquery.plugin.min.js%2ccal%2fjs%2fjquery.datepick.min.js%2ccal%2fjs%2fjquery.datepick-et.js%2cjs%2f_scripts.js%2cjs%2fskriptid.js%2cjs%2fjquery.autocomplete.min.js%2cjs%2ffilter.js%2cjs%2fjquery.jqprint.js&amp;versioon=1">
        </script>
        <script type="text/javascript" src="/js/login-vorm.js"></script>
        <script type="text/javascript" src="/js/google-analytics-init.js"></script>
    </head>

    <body>

        <div id="wrap">

            <div id="header">
                <p id="logo"><a href="/index.html" title="Avalehele">Riigi Teataja</a></p>
                <div id="search">
                    <p class="label">
                        <label for="search-field">Lihtne otsing seaduste ja üleriigiliste määruste terviktekstide pealkirjadest</label>
                    </p>
                    <div class="search-form">
                        <form method="get" action="/otsingu_tulemus.html" id="otsinguVorm" accept-charset="UTF-8">
                            <input type="hidden" name="sakk" value="kehtivad"/>
                            <p class="field clear">
                                <input type="text" class="text" name="otsisona" id="search-field" title="Sisesta akti nimi, märksõna või ametlik lühend" value=""/>
                                <span class="button"><input type="submit" value="Otsi" /></span>
                            </p>
                        </form>
                    </div>
                </div>
            </div>

            <div id="nav">
                <ul class="nav">
                    <li><a href="/tervikteksti_otsing.html">Täpne otsing</a></li>
                    <li><a href="#">Liigitus</a>
                        <ul>
                            <li><a href="/jaotused.html?jaotus=S%C3%9CSTJAOT">Süstemaatiline liigitus</a></li>
                            <li><a href="/kronoloogia.html">Kronoloogia</a></li>
                            <li><a href="/jaotused.html?jaotus=0">Eurovoc</a></li>
                            <li><a href="/jaotused.html?jaotus=KOV">KOV määruste valdkondlik liigitus</a></li>
                            <li><a href="/jaotused.html?jaotus=RIIGID">Välislepingute liigitus poolte alusel</a></li>
                            <li><a href="/kohtulahendite_liigitus.html">Kohtulahendite liigitus</a></li>
                        </ul>
                    </li>

                    <li><a href="#">Statistika</a>
                        <ul>
                            <li><a href="/enim_vaadatud.html">Enim vaadatud</a></li>
                            <li><a href="/statistika.html">Üldine statistika</a></li>
                        </ul>
                    </li>

                    <li><a href="#">Viited</a>
                        <ul>
                            <li><a href="/lyhendid.html">Õigusaktide lühendid</a></li>
                            <li><a href="/viited.html">Üldised viited</a></li>
                            <li><a href="/viitedLeht.html?id=1">Riikluse rajamist kajastavad dokumendid</a></li>
                            <li><a href="/viitedLeht.html?id=2">Põhiseadused</a></li>
                            <li><a href="/viitedLeht.html?id=3">Eesti suhtes tehtud EIK otsuste tõlked</a></li>
                            <li><a href="/viitedLeht.html?id=4">PS kommenteeritud väljaanne</a></li>
                            <li><a href="/viitedLeht.html?id=5">Vandetõlkide jaotus valdkonniti</a></li>
                            <li><a href="/viitedLeht.html?id=6">KOV loetelu määruste kehtivusest 1.06.2014 seisuga</a></li>
                        </ul>
                    </li>

                    <li><a href="/eelnoud/otsing.html">Eelnõud</a></li>
                    <li><a href="#">Kohtuteave</a>
                        <ul>
                            <li><a href="/kohtulahendid/koik_menetlused.html">Kohtulahendite otsing</a></li>
                            <li><a href="/kohtuteave/kohtuistungid_otsing.html">Kohtuistungi aja ja koha otsing</a></li>
                            <li><a href="/kohtuteave/kohtulahendite_analyysid.html">Kohtulahendite kokkuvõtted</a></li>
                            <li><a href="/kohtuteave/oigusakti_viide_kohtulahendile.html">Kokkuvõtete seosed
                                    õigusaktidega</a></li>
                            <li><a href="/kohtulahendite_liigitus.html">Kohtulahendite liigitus</a></li>
                            <li><a href="/kohtuteave/eik_liigitus.html">Euroopa Inimõiguste Kohtu liigitused</a></li>
                        </ul>
                    </li>

                    <li><a href="#">Õigusuudised</a>
                        <ul>
                            <li><a href="/oigusuudised/kohtuuudiste_nimekiri.html">Kohtu-uudised</a></li>

                            <li><a href="/oigusuudised/seadusteUudisteNimekiri.html">Seadusuudised</a></li>

                            <li><a href="/oigusuudised/muuOigusuudisteNimekiri.html">Muud õigusuudised</a></li>
                        </ul>
                    </li>

                    <li><a href="#">Abi</a>
                        <ul>
                            <li><a href="/kkk.html">KKK</a></li>
                            <li><a href="/abiLeht.html?id=1">Riigi Teataja võrguväljaandest</a></li>
                            <li><a href="/abiLeht.html?id=2">Terviktekstide otsimine</a></li>
                            <li><a href="/abiLeht.html?id=3">Algtekstide otsimine</a></li>
                            <li><a href="/abiLeht.html?id=4">Lihtne otsing</a></li>
                            <li><a href="/abiLeht.html?id=5">Eelnõude otsing</a></li>
                            <li><a href="/tagasiside.html">Tagasiside</a></li>
                        </ul>
                    </li>

                    <li>
                        <a href="/en/">English</a>
                    </li>

                </ul>
                <p id="myrt-link"><a href="#">Minu RT</a></p>
                <div id="myrt">
                    <div class="a clear">
                        <div class="col1"><input value="979fb690-6984-4187-9b68-d54611042a0c" name="_csrf" type="hidden"/>
                            <p class="form">
                                <label for="myrt01">Kasutajanimi:</label><input autocomplete="off" name="j_username" id="myrt01" class="text" type="text"/></p>
                                <p class="form">
                                    <label for="myrt02">Parool:</label><input autocomplete="new-password" name="j_password" id="myrt02" class="text" type="password"/></p>
                                    <p class="check">
                                        <input value="true" name="remember-me" id="myrt-check01" type="checkbox"/><label for="myrt-check01">Jäta mind meelde</label>
                                    </p>
                                    <p class="action">
                                        <button id="submit-login"><span><strong>Sisene</strong></span></button></p>
                        </div>
                        <div class="col2">
                            <h2>Miks minu RT?<br/>
    Minu RT võimaldab:</h2>
                                <ul>
                                    <li> Töötada oma aktidega</li>
                                    <li>Tellida akte, kohtukokkuvõtteid ja õigusuudiseid e-postile</li>
                                    <li>Seadistada RT endale sobivaks</li>
                                </ul>
                                <p class="meta"><a href="/registreeru.html">Registreeru</a><span>|</span><a
                                        href="/parooli_tellimine.html">Unustasid parooli?</a></p>
                        </div>
                    </div>
                </div>
            </div>
            <noscript>
                <div class="info">
                    Sinu veebilehitsejal pole JavaScript tuge või on see välja
                    lülitatud.<br/><br/>Täieliku funktsionaalsuse ja mugavama kasutuskogemuse tagamiseks soovitame võimalusel JavaScripti toe sisse lülitada.</div>
            </noscript>

            <div class="clear" id="content">
                <h1>Lühendid ja nende vasted</h1>
                <p>Siit leiad aktide lühendite nimekirja, mille järgi saad ka otsinguid teostada.</p>
                <script type="text/javascript" src="/js/sorteeriv-pealdis.js"></script>

                <form id="filterForm" action="/lyhendid.html" method="get" accept-charset="utf-8">
                    <table class="data">
                        <thead>
                            <tr>
                                <th width="80%" class="sort  " id="th-pealkiri">
                                    <a title="Sorteeri" data-path="pealkiri" data-ascending="true" data-prefiks=""
                                        class="sorteeri-ilma" href="#">Pealkiri</a>
                                </th>
                                <th width="20%" class="sort  " id="th-lyhend">
                                    <a title="Sorteeri" data-path="lyhend" data-ascending="true" data-prefiks=""
                                        class="sorteeri-ilma" href="#">Lühend</a>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>

                    <input value="" name="sorteeri" type="hidden" id="sorteeri"/><input value="true" name="kasvav" type="hidden" id="kasvav"/></form>
            </div>
            <div id="footer" class="clear">
                <div class="col1">
                    <p class="euro">Lehe valmimist toetas Euroopa Liit</p>
                </div>
                <div class="col2">
                    <p class="copy"><a
                            href="https://www.facebook.com/pages/Riigi-Teataja/446473188771945"><img src="/failid/ico-facebook.gif" alt="Facebooki logo" /> Facebook</a>
                              <a href="https://twitter.com/RT_RiigiTeataja"><img src="/failid/ico-twitter.gif" alt="Twitteri logo" /> Twitter</a>                   ©
                                Riigikantselei 2010<br/>© Justiitsministeerium 2012</p>
                                <p class="meta">Riigi Teataja otsinguabi: 620 8148 <br/>Tagasiside: <a
                                        href="https://www.riigiteataja.ee/tagasiside.html">e-kiri</a> </p>
                                <div>Versioon 11.4.0</div>
                </div>
            </div>

        </div>
        <p id="otsingu-soovitused-url" class="elem-hidden">/otsingu_soovitused.json</p>
        <script type="text/javascript" src="/js/otsingu-soovitused.js"></script>
    </body>

    </html>
    """.data(using: .utf8)!
}
