000100170421       //***************************************************************
000200170421       // PROGRAMME : BAMP306R                 Date Création : 03/11/2016
000300170421       // AUTEUR    : O.DRUBIGNY               Copyright C.I.Services
000400170421       //----------------------------------------------------------------
000500170421       // APPLICATION :
000600170421       //  AMM
000700170421       //----------------------------------------------------------------
000800170421       //  DESCRIPTION :
000900170421       //  L'objectif est de constituer un Fichier Excel informant le
001000170421       //  gestionnaire et les chauffagistes des températures des
001100170421       //  logements et de l'immeuble.
001200170421       //  Ces informations serviront de base pour vérifier la
001300170421       //  temprature dans les cas suivants :
001400170421       //        -	Réclamation des occupants quand ils déclarent avoir froid.
001500170421       //        -	Equilibrage du réseau de chauffage
001600170421       //        -	Détecter les appartements en anomalie de température
001700170421       //           (surchauffe, sous-chauffage etc...)
001800170421       //        -	Etc...
001900170421       //  Le programme BAMP306R gère les clients pour l'extraction des
002000170421       //  sondes de températures
002100170421       //----------------------------------------------------------------
002200170421       //  MAINTENANCE :
002300170421       //  N    AUTEUR                 OBJET                     DATE
002400170421       // ...  ...........  .................................  ../../....
002500170421       // ...  ...........  .................................  ../../....
002600170421       // ...  ...........  .................................  ../../....
002700170421       //----------------------------------------------------------------
002800170421       //  INDICATEURS :
002900170421       //  xx -> xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
003000170421       //****************************************************************
003100170421       // Option de compilation et de programme
003200170421      * >>PRE-COMPILER<<                                              */
003300170421      *   >>CRTCMD<<  CRTSQLRPGI SRCFILE(&SL/&SF) SRCMBR(&SM);        */
003400170421      *   >>IMPORTANT<<                                               */
003500170421      *     >>PARM<<  OBJ(&LI/&OB);                                   */
003600170421      *     >>PARM<<  COMMIT(*NONE);                                  */
003700170421      *     >>PARM<<  OBJTYPE(*PGM);                                  */
003800170421      *     >>PARM<<  OPTION(*EVENTF);                                */
003900170421      *     >>PARM<<  RPGPPOPT(*LVL2);                                */
004000170421      *     >>PARM<<  CLOSQLCSR(*ENDACTGRP);                          */
004100170421      *     >>PARM<<  DATFMT(*ISO);                                   */
004200170421      *     >>PARM<<  TIMFMT(*ISO);                                   */
004300170421      *     >>PARM<<  COMPILEOPT('OPTIMIZE(*NONE)');                  */
004400170421      *   >>END-IMPORTANT<<                                           */
004500170421      *   >>EXECUTE<<                                                 */
004600170421      * >>END-PRE-COMPILER<<                                          */
004700170421
004800170421       /If Defined(*CRTBNDRPG )
004900170421       ctl-opt actgrp(*caller);
005000170421       ctl-opt DftActGrp(*No);
005100170421       /endif
005200170421
005300170421       ctl-opt option(*nodebugio:*srcstmt:*nounref);
005400170421       ctl-opt bnddir('SERVICE') expropts(*resdecpos);
005500170421
005600170421       // déclaration des fichiers
005700170421       dcl-f bamp306e workstn sfile(sfl01:wran01) infds(dssfl1) indds(IndDS);
005800170421
005900170421
006000170421
006100170421       // main function prototype
006200170421       // prototype fonction principale
006300170421       dcl-pr parametrage_client extpgm('BAMP306R');
006400170421       END-PR;
006500170421
006600170421       dcl-pi parametrage_client;
006700170421       END-Pi;
006800170421
006900170421
007000170421
007100170421      // external functions prototypes
007200170421      // prototype fonctions externes
007300170421       /copy qcpysrc,prsmod000r
007400170421      // program status data structure
007500170421      // structure information programme
007600170421       /copy qcpysrc,psds
007700170421      // Procédure utilitaire BERGER
007800170421       /COPY QCPYSRC,UTIPROC        // procédures générales
007900170421
008000170421
008100170421
008200170421      // local functions prototypes
008300170421      // prototypes fonctions locales
008400170421       // Traitement des entrèes écran
008500170421       dcl-pr trtsfl
008600170421       End-Pr;
008700170421
008800170421       // Initialisation du sous-fichier de message
008900170421       dcl-pr RAZMSG;
009000170421       End-Pr;
009100170421
009200170421       //Initialisation du sous-fichier des clients paramétrés
009300170421       dcl-pr initsf;
009400170421       End-Pr;
009500170421
009600170421       // Gestion des options entrées par le gestionnaire
009700170421       dcl-pr trtopt;
009800170421       End-Pr;
009900170421
010000170421       // Chargement d'une page du sous-fichier
010100170421       dcl-pr chgpag;
010200170421       End-Pr;
010300170421
010400170421
010500170421
010600170421       // global variables
010700170421       // variables globales
010800170421       dcl-s g_snom like(r_nom_client);
010900170421       dcl-s g_wsnop like(r_nom_client);
011000170421
011100170421
011200170421       dcl-s g_nblis1 like(r_nblign);
011300170421       dcl-s g_lstlig like(r_nblign);
011400170421       dcl-s g_nbrlig like(r_nblign);
011500170421       dcl-s g_i packed(3:0);
011600170421       dcl-s g_xnom like(r_nom_client);
011700170421
011800170421       dcl-s g_codcli like( r_code_client);
011900170421       dcl-s g_oclien like(r_nom_client);
012000170421       dcl-s g_frequence char(1);
012100170421
012200170421
012300170421       // Compteurs
012400170421       dcl-s i packed(2:0);
012500170421
012600170421       // Indicateurs
012700170421       dcl-s g_sortie ind;
012800170421       dcl-s g_trt_opt ind;
012900170421       dcl-s g_selection ind;
013000170421       dcl-s g_alimsfl ind;
013100170421       dcl-s g_filtre ind;
013200170421       dcl-s g_erreur ind;
013300170421       dcl-s g_ctrl_dta ind;
013400170421
013500170421      // Touches de fonction
013600170421      /copy qcpysrc,fonction
013700170421
013800170421      // data-structures
013900170421      // structures de données
014000170421      // Indicateurs renommés avec Indara et INDDS
014100170421       Dcl-ds IndDS;
014200170421         ROLLUP ind pos(2);
014300170421         SFLDSP ind pos(4);
014400170421         SFLDSPCTL ind pos(5);
014500170421         SFLCLR ind pos(6);
014600170421         SFLEND ind pos(7);
014700170421         SFLNXTCHG ind pos(8);
014800170421         SFLENDMSG ind pos(9);
014900170421         SFLINZ ind pos(10);
015000170421         PROTECT ind pos(02);
015100170421         zcodclic_ri ind pos(03);
015200170421       end-ds;
015300170421
015400170421      // la ds du sous=fichier
015500170421       dcl-ds dssfl1;
015600170421         wposc bindec(2:0) pos(370);
015700170421         wrrng bindec(2:0) pos(376);
015800170421         wrngp bindec(2:0) pos(378);
015900170421         wnbrsf bindec(2:0) pos(380);
016000170421       end-ds;
016100170421
016200170421      // la ds du fichier
016300170421       dcl-ds fic;
016400170421         wnrc01 bindec(4:0) pos(397);
016500170421       end-ds;
016600170421
016700170421       dcl-ds wdsfic;
016800170421         wcdfil char(8) pos(1);
016900170421         wopenf char(1) pos(9);
017000170421         wstsfi packed(5:0) pos(11);
017100170421         wopcod char(6) pos(16);
017200170421         wrpgsq char(8) pos(30);
017300170421         wrpgnr char(8) pos(38);
017400170421         werrfi char(7) pos(46);
017500170421         wnfich char(10) pos(83);
017600170421         wnlibr char(10) pos(93);
017700170421         wspnam char(10) pos(103);
017800170421         wsplib char(10) pos(113);
017900170421         wspnum bindec(2:0) pos(123);
018000170421         wlimbr char(10) pos(129);
018100170421         wnbput bindec(4:0) pos(243);
018200170421         wnbget bindec(4:0) pos(247);
018300170421         wnbpg bindec(4:0) pos(251);
018400170421         wnbio bindec(4:0) pos(255);
018500170421         wrcdft char(4) pos(261);
018600170421         wnbrcd bindec(4:0) pos(283);
018700170421         wnrcfi bindec(4:0) pos(397);
018800170421       end-ds;
018900170421
019000170421
019100170421
019200170421      // inherited variables
019300170421      // héritage des types
019400170421     d/copy QcpySRC,INH32766
019500170421
019600170421      // constants
019700170421      // constantes
019800170421
019900170421      * main function
020000170421      * fonction principale
020100170421
020200170421       // --------------------------------------------------
020300170421       // Prototype for procedure: creation
020400170421       // --------------------------------------------------
020500170421       DCL-PR creation_sfl like(sqlcode);
020600170421         l_codcli LIKE(r_code_client) CONST;
020700170421         l_frequence LIKE(zfrequence) CONST;
020800170421         l_datesoum LIKE(zpchsoum) CONST;
020900170421       END-PR ;
021000170421
021100170421
021200170421       // --------------------------------------------------
021300170421       // Prototype for procedure: lect_list_client
021400170421       // --------------------------------------------------
021500170421       DCL-PR ouverture_curseur_client like(sqlcode);
021600170421       END-PR ;
021700170421
021800170421
021900170421       // --------------------------------------------------
022000170421       // Prototype for procedure: lect_list_client
022100170421       // --------------------------------------------------
022200170421       DCL-PR lecture_curseur_clients like(sqlcode);
022300170421       END-PR ;
022400170421
022500170421
022600170421       // --------------------------------------------------
022700170421       // Prototype for procedure: fermeture_curseur_clients
022800170421       // --------------------------------------------------
022900170421       DCL-PR fermeture_curseur_clients like(sqlcode);
023000170421       END-PR ;
023100170421
023200170421
023300170421       // --------------------------------------------------
023400170421       // Prototype for procedure: suppression
023500170421       // --------------------------------------------------
023600170421       DCL-PR suppression_sfl LIKE(sqlcode);
023700170421         p_codcli LIKE(r_code_client);
023800170421       END-PR ;
023900170421
024000170421
024100170421       // --------------------------------------------------
024200170421       // Prototype for procedure: mise_a_jour
024300170421       // --------------------------------------------------
024400170421       DCL-PR mise_a_jour LIKE(sqlcode);
024500170421         p_codcli LIKE(r_code_client);
024600170421         p_frequence CHAR(1) const;
024700170421         p_date_soumission DATE;
024800170421       END-PR ;
024900170421
025000170421
025100170421       // --------------------------------------------------
025200170421       // Prototype for procedure: Libelle_periode
025300170421       // --------------------------------------------------
025400170421       DCL-PR Libelle_periode CHAR(12);
025500170421         l_frequence CHAR(1);
025600170421       END-PR ;
025700170421
025800170421
025900170421       // --------------------------------------------------
026000170421       // Prototype for procedure: controle_data
026100170421       // --------------------------------------------------
026200170421       DCL-PR controle_data ;
026300170421       END-PR ;
026400170421
026500170421
026600170421       // --------------------------------------------------
026700170421       // Prototype for procedure: controle_exist_client
026800170421       // --------------------------------------------------
026900170421       DCL-PR controle_exist_client IND;
027000170421         p_cod_client LIKE(r_code_client);
027100170421       END-PR ;
027200170421
027300170421
027400170421       monitor;
027500170421       // le nombre de lignes affichables, déclaration à la volée
027600170421         g_nblis1=14;
027700170421         // initialisation des variables générales
027800170421         // Gestion des messages
027900170421
028000170421          msg_inz('BAMMSGF':'BPAMM':PROCEDURE); //initialisation du s-f de messages
028100170421
028200170421
028300170421         zdate=%dec(%date():*eur);
028400170421         zheur=%dec(%time():*eur);
028500170421         zuser=USER;
028600170421         zjob=JOB_NAME;
028700170421         // initialisation du sous fichier des messages
028800170421         wpgmq='*  ';
028900170421         wmgkey='CC01';
029000170421         sflendmsg = *on;
029100170421         sflinz = *on;
029200170421         // indicateur fin
029300170421         g_sortie = *off;
029400170421         // début du traitement,
029500170421         initsf();
029600170421         // boucle d'attente de sortie
029700170421         dow not g_sortie;
029800170421           trtsfl();
029900170421         enddo;
030000170421
030100170421         on-error;
030200170421           dump(a);
030300170421           gest_erreur();
030400170421         endmon;
030500170421
030600170421         fermeture_curseur_clients();
030700170421
030800170421       // indicateur de fin de programme
030900170421       *inlr = *on;
031000170421
031100170421       //--------------------------------------------------------------------//
031200170421       // les Sous-routines                                                  //
031300170421       //--------------------------------------------------------------------//
031400170421       // traitement de l'écran
031500170421       dcl-proc trtsfl;
031600170421
031700170421       dcl-pi trtsfl;
031800170421       End-Pi;
031900170421
032000170421         WRITE wsfctl;                          // Ecriture SFL message
032100170421
032200170421         write forb1;
032300170421
032400170421         // attente lecture
032500170421         exfmt fore1;
032600170421
032700170421         // effacement du sous=fichier de messages
032800170421         RAZMSG();
032900170421
033000170421         // une touche a été actionnée
033100170421         // chargement de l'heure
033200170421         zheur=%dec(%time());
033300170421         // indicateur pour ne pas tester d'autres actions
033400170421         g_trt_opt = *on;
033500170421         if rollup;
033600170421           // page suivante
033700170421           chgpag();
033800170421           g_trt_opt = *off;
033900170421         endif;
034000170421         //
034100170421         if g_wsnop <> ZSNOM
034200170421         and g_trt_opt;
034300170421         // test si selection/ si changé on initialise
034400170421           initsf();
034500170421           g_trt_opt = *off;
034600170421         endif;
034700170421         // touches f3 et f12
034800170421         if sortie or
034900170421               cancel;
035000170421           // on met l'indicateur à off = fin du programme
035100170421           g_sortie = *on;
035200170421           g_trt_opt = *off;
035300170421         endif;
035400170421         //
035500170421         if refresh;
035600170421           // f5 rafraichissement de l'écran
035700170421           initsf();
035800170421           g_trt_opt = *off;
035900170421         endif;
036000170421         //
036100170421
036200170421         // on ne fait ceci que s'il n'y a eu rien d'autre
036300170421         if g_trt_opt;
036400170421           trtopt();
036500170421         endif;
036600170421         // on recommence la boucle d'attente
036700170421       end-proc;
036800170421
036900170421       //------------------------------------------------
037000170421       // initialisation du sous-fichier
037100170421       //------------------------------------------------
037200170421       dcl-proc initsf;
037300170421       dcl-pi initsf;
037400170421       End-Pi;
037500170421         //    l'indicateur 20 conditionne la zone opt (protection)
037600170421         protect = *on;
037700170421         // initialisation de la variable de sélection
037800170421         g_wsnop=ZSNOM;
037900170421         g_snom=*blank;
038000170421         // initialisation de la clé pour positionnement
038100170421         g_codcli=*blank;
038200170421         g_oclien=*blank;
038300170421         g_selection = *off;
038400170421         g_filtre = *off;
038500170421
038600170421         clear zoptc;
038700170421         clear zpchsoumc;
038800170421
038900170421         if ZSNOM <> *blank;
039000170421           // si différent de blank il y a sélection
039100170421           g_selection = *on;
039200170421           g_i=0;
039300170421           g_i=%scan('*':ZSNOM);
039400170421
039500170421           if g_i > 0;
039600170421              g_filtre=*on;
039700170421              g_i=g_i-1;
039800170421              g_snom=%subst(ZSNOM:1:g_i);
039900170421              // on est dans le cas d'une sélection générique
040000170421             // on se positionnera juste au bon endroit dans le fichier
040100170421              g_oclien=g_snom;
040200170421           endif;
040300170421         endif;
040400170421         // la dernière ligne écrite
040500170421
040600170421         g_lstlig=0;
040700170421         // le compteur de ligne par page
040800170421         g_nbrlig=0;
040900170421         // le fameux wran01
041000170421         wran01=0;
041100170421         // effacement du sous=fichier
041200170421         sflclr = *on;
041300170421         sflend = *on;
041400170421         sfldsp = *off;
041500170421         sfldspctl = *off;
041600170421         write fore1;
041700170421         sflclr = *off;
041800170421         sfldsp = *on;
041900170421         sfldspctl = *on;
042000170421
042100170421         // positionnement en début de fichier
042200170421         sqlcode=ouverture_curseur_clients();
042300170421
042400170421
042500170421         //exec sql select oclien, oclicp
042600170421         //                 into :zoclien, :zoclicp
042700170421         //                 from bncltp
042800170421         //                where codcli=:zcodcli;
042900170421         // chargement de la première page
043000170421         chgpag();
043100170421       end-proc;
043200170421
043300170421       // traitement des options, on ne lit que les enregistrements modifiés
043400170421       dcl-proc trtopt;
043500170421       dcl-pi trtopt;
043600170421       End-Pi;
043700170421         // lecture des enregistrements modifiés
043800170421          wran01=1;
043900170421          g_alimsfl = *off;
044000170421          // top pour rafrachir l'écran, si besoin
044100170421         if (zoptc = 'H') or (zoptc = ' H')
044200170421         or (zoptc = 'M') or (zoptc = ' M');
044300170421           Creation_sfl(  zcodclic
044400170421                        : %trim(zoptc)
044500170421                        : ZPCHSOUMC);
044600170421           zoptc=*blank;
044700170421           g_alimsfl=*on;
044800170421         ENDIF;
044900170421
045000170421
045100170421         readc sfl01;
045200170421         dow not %eof;
045300170421             g_filtre = *on;
045400170421             // selection en fonction du choix saisi
045500170421             select;
045600170421             when (zopt = 'H') or (zopt = ' H')
045700170421               or (zopt = 'M') or (zopt = ' M');
045800170421                protect=*on;
045900170421
046000170421                mise_a_jour(  zcodcli
046100170421                            : %trim(zopt)
046200170421                            : ZPCHSOUM);
046300170421                g_alimsfl=*on;
046400170421                // nettoyage
046500170421                zopt=*blanks;
046600170421             when (zopt = '2') or (zopt = ' 2');
046700170421
046800170421             if HTUPDATE=*off;
046900170421                protect=*off;
047000170421                HTUPDATE=*on;
047100170421                sflnxtchg=*on;
047200170421             else;
047300170421                mise_a_jour(  zcodcli
047400170421                            : %trim(hfrequence)
047500170421                            : ZPCHSOUM);
047600170421                protect=*on;
047700170421                g_alimsfl=*on;
047800170421                // nettoyage
047900170421                zopt=*blanks;
048000170421             endif;
048100170421
048200170421             when (zopt = '4') or (zopt = ' 4');
048300170421                suppression_sfl(zcodcli);
048400170421                g_alimsfl=*on;
048500170421                // nettoyage
048600170421                zopt=*blanks;
048700170421             other;
048800170421             // la saisie ne correspond à rien
048900170421                g_filtre = *off;
049000170421             // envoyer un message pour dire que l'option n'existe pas
049100170421                msg_dsp('DSP0002');
049200170421
049300170421             endsl;
049400170421
049500170421             update(e) sfl01;
049600170421
049700170421             // on continue de boucler si autre option
049800170421           readc(e) sfl01;
049900170421         enddo;
050000170421         // potentiellement il y a eu mise à jour, on pourrait affiner
050100170421         if g_alimsfl;
050200170421            initsf();
050300170421         ENDIF;
050400170421       end-proc;
050500170421
050600170421
050700170421       // chargement d'une page
050800170421       dcl-proc chgpag;
050900170421       dcl-pi chgpag;
051000170421       End-Pi;
051100170421         dcl-s l_frequence char(1);
051200170421
051300170421
051400170421         // il faut positionner correctement les indicateurs et les variables
051500170421         sflnxtchg = *off;
051600170421         //                  seton                                        04
051700170421         wran01=g_lstlig;
051800170421         // lecture de l'enregistrement suivant
051900170421         sqlcode=lecture_curseur_clients();
052000170421
052100170421         // remise à zéro du compteur de ligne, mais on pourrait faire autrement
052200170421         g_nbrlig=0;
052300170421
052400170421         dow sqlcode=0
052500170421         and g_nbrlig < 14;
052600170421           // remplissage des zones écran
052700170421           g_alimsfl = *on;
052800170421           // test s'il y a sélection
052900170421           if g_selection or g_filtre;
053000170421             if g_selection and not g_filtre;
053100170421               // on recherche la stricte égalité de nom
053200170421               if g_OCLIEN <> zoclien;
053300170421                 g_alimsfl = *off;
053400170421               endif;
053500170421             else;
053600170421                // on recherche si le nom commence par la valeur avant le '*'
053700170421                g_xnom=%subst( g_OCLIEN:1:g_i);
053800170421                if g_xnom <> g_snom;
053900170421                 g_alimsfl = *off;
054000170421               endif;
054100170421             endif;
054200170421           endif;
054300170421
054400170421           // l'indicateur est à '1' si sélection ok ou pas de sélection
054500170421           if g_alimsfl;
054600170421              zoclien=g_oclien;
054700170421              zcodcli=g_codcli;
054800170421
054900170421              zfrequence=libelle_periode(g_frequence);
055000170421              hfrequence=g_frequence;
055100170421              HTUPDATE=*off;
055200170421
055300170421             // les compteurs, attention au wran01
055400170421             g_nbrlig+=1;
055500170421             g_lstlig+=1;
055600170421             wran01+=1;
055700170421             // ecriture de la ligne
055800170421             write sfl01;
055900170421           endif;
056000170421           // lecture du suivant
056100170421           sqlcode=lecture_curseur_clients();
056200170421
056300170421         enddo;
056400170421         // on quitte la boucle soit en fin de page
056500170421         //                     soit en fin de fichier
056600170421         if sqlcode=100;
056700170421           // le caractère de suite, on est en fin de fichier
056800170421           sflend = *on;
056900170421         else;
057000170421           sflend = *off;
057100170421         endif;
057200170421         // si le fichier est vide
057300170421         if wran01 = 0;
057400170421            g_nbrlig=1;
057500170421            g_lstlig=1;
057600170421            // un petit message
057700170421            wran01=1;
057800170421            // pas de saisie d'option
057900170421           protect = *on;
058000170421           if zsnom = *blank;
058100170421             zoclien = 'sélection vide';
058200170421           else;
058300170421             zoclien = 'Fichier vide';
058400170421           endif;
058500170421           // ne pas oublier de remettre  blanc
058600170421
058700170421           wdsfic=*blank;
058800170421           hnrec=0;
058900170421           // ecriture du message sur la première ligne
059000170421           write sfl01;
059100170421         endif;
059200170421       end-proc;
059300170421
059400170421       //====================================================*
059500170421       // INIT SF MESSAGE                                    I
059600170421       //====================================================*
059700170421       dcl-proc RAZMSG;
059800170421       dcl-pi RAZMSG;
059900170421       End-Pi;
060000170421
060100170421         msg_clrq();
060200170421
060300170421         *in49 = *on;  //SFLCLR
060400170421         write WSFCTL;
060500170421         *in49 = *off;
060600170421
060700170421         return;
060800170421
060900170421       end-proc;
061000170421
061100170421       //--------------------------------------------------
061200170421       // Liste des clients ISTA
061300170421       //--------------------------------------------------
061400170421
061500170421       dcl-proc ouverture_curseur_clients;
061600170421         dcl-pi ouverture_curseur_clients like(sqlcode) end-pi;
061700170421
061800170421           // Récupéaration des informations concernant le paramètrage de soumission
061900170421           // des extractions statistiques des sondes de températures
062000170421           EXEC SQL DECLARE list_client CURSOR FOR
062100170421                      select a.oclien,
062200170421                             a.codcli,
062300170421                             b.FREQUENCE,
062400170421                             b.PROCHAINE_SOUMISSION
062500170421                        from bncltp a, BPSNDTMP b
062600170421                       where a.codcli=b.CODE_CLIENT
062700170421                         and a.IENREG=''
062800170421                         and b.actif_inactif=''
062900170421                    ORDER BY a.oclien;
063000170421           EXEC SQL OPEN list_client;
063100170421
063200170421           if sqlcode=-502;
063300170421             fermeture_curseur_clients();
063400170421             ouverture_curseur_clients();
063500170421           endif;
063600170421           return sqlcode;
063700170421       End-Proc;
063800170421
063900170421
064000170421
064100170421       // --------------------------------------------------
064200170421       // Procedure name: lect_list_client
064300170421       // Purpose: Lecture de la liste des clients
064400170421       // Returns:
064500170421       // --------------------------------------------------
064600170421       DCL-PROC lecture_curseur_clients;
064700170421         dcl-pi lecture_curseur_clients like(sqlcode) end-pi;
064800170421
064900170421           EXEC SQL FETCH list_client
065000170421                     into :g_oclien,
065100170421                          :g_codcli,
065200170421                          :g_frequence,
065300170421                          :ZPCHSOUM;
065400170421
065500170421           return sqlcode;
065600170421       END-PROC ;
065700170421
065800170421
065900170421
066000170421       // --------------------------------------------------
066100170421       // Procedure name: fermeture_curseur_clients
066200170421       // Purpose:
066300170421       // Returns:
066400170421       // --------------------------------------------------
066500170421       DCL-PROC fermeture_curseur_clients;
066600170421         dcl-pi fermeture_curseur_clients  like(sqlcode) end-pi;
066700170421
066800170421           exec sql close list_client;
066900170421
067000170421         return sqlcode;
067100170421       END-PROC;
067200170421
067300170421
067400170421       // --------------------------------------------------
067500170421       // Procedure name: creation
067600170421       // Purpose:        Créer un paramètrage d'extraction des statistiques ...
067700170421       //                          de températures pour un client
067800170421       // Returns:
067900170421       // Parameter:      codcli => Code client
068000170421       // Parameter:      frequence => Fréquence d'envoi
068100170421       // Parameter:      datesoum => Date de prochaine soumission
068200170421       // --------------------------------------------------
068300170421       DCL-PROC creation_sfl;
068400170421         DCL-PI creation_sfl like(sqlcode);
068500170421           p_codcli LIKE(r_code_client) CONST;
068600170421           p_frequence LIKE(zfrequence) CONST;
068700170421           p_datesoum LIKE(zpchsoum) CONST;
068800170421         END-PI ;
068900170421           dcl-s l_code_client like(r_code_client);
069000170421
069100170421           exec sql select code_client
069200170421                     into :l_code_client
069300170421                     from bpsndtmp
069400170421                    where code_client=:p_codcli
069500170421                      and actif_inactif=' ';
069600170421           if sqlcode=0;
069700170421             msg_dsp('SND0010');
069800170421             zcodclic_ri=*on;
069900170421             g_erreur=*on;
070000170421
070100170421           ENDIF;
070200170421           // Insertion de la fréquence et de la prochaine soumission
070300170421           exec sql insert into bpsndtmp
070400170421             ( ACTIF_INACTIF, CODE_CLIENT, FREQUENCE, PROCHAINE_SOUMISSION,
070500170421             TIMESTAMP_CRT, USER_CRT, TIMESTAMP_UPD, USER_MDT)
070600170421             values ( '',
070700170421                      :p_codcli,
070800170421                      :p_frequence,
070900170421                      :p_datesoum,
071000170421                      current timestamp,
071100170421                      :user,
071200170421                      default,
071300170421                      :user);
071400170421
071500170421           return sqlcode;
071600170421       END-PROC ;
071700170421
071800170421
071900170421
072000170421       // --------------------------------------------------
072100170421       // Procedure name: suppression
072200170421       // Purpose:
072300170421       // Returns:
072400170421       // Parameter:      p_codcli => Code client
072500170421       // --------------------------------------------------
072600170421       DCL-PROC suppression_sfl;
072700170421         DCL-PI *N LIKE(sqlcode);
072800170421           p_codcli LIKE(r_code_client);
072900170421         END-PI ;
073000170421
073100170421         // Suppression logique de l'enregistrement
073200170421         exec sql update bpsndtmp
073300170421                       set actif_inactif='S',
073400170421                           USER_MDT=:user
073500170421                     where codcli=:zcodcli
073600170421                       and actif_inactif='';
073700170421         return sqlcode ;
073800170421
073900170421       END-PROC ;
074000170421
074100170421
074200170421       // --------------------------------------------------
074300170421       // Procedure name: mise_a_jour
074400170421       // Purpose:        Changer la fréquence et/ou la prochaine date de ré...
074500170421       //                          férence de soumission
074600170421       // Returns:
074700170421       // Parameter:      p_codcli => Code client
074800170421       // Parameter:      p_frequence => Fréquence de soumission D:Journalier...
074900170421       //                           W:Hebdomadaire M:Mensuel A:Annuel
075000170421       // Parameter:      p_date_soumission => Prochaine date de référence de...
075100170421       //                           soumission
075200170421       // --------------------------------------------------
075300170421       DCL-PROC mise_a_jour ;
075400170421         DCL-PI *N LIKE(sqlcode);
075500170421           p_codcli LIKE(r_code_client);
075600170421           p_frequence CHAR(1) const;
075700170421           p_date_soumission DATE;
075800170421         END-PI ;
075900170421
076000170421
076100170421         DCL-S retField LIKE(sqlcode);
076200170421
076300170421           exec sql update bpsndtmp
076400170421                       set FREQUENCE=:p_frequence,
076500170421                           PROCHAINE_SOUMISSION=:p_date_soumission,
076600170421                           USER_MDT=:user
076700170421                     where codcli=:zcodcli
076800170421                       and actif_inactif='';
076900170421
077000170421         return retField ;
077100170421       END-PROC ;
077200170421
077300170421
077400170421       // --------------------------------------------------
077500170421       // Procedure name: Libelle_periode
077600170421       // Purpose:        Récupérer le libelllé de la période à partir du code
077700170421       // Returns:        Libellé du code fréquence
077800170421       // Parameter:      l_frequence => Code fréquence H (hebdomadaire), M (...
077900170421       //                          mensuel)
078000170421       // --------------------------------------------------
078100170421       DCL-PROC Libelle_periode ;
078200170421         DCL-PI *N CHAR(12);
078300170421           l_frequence CHAR(1);
078400170421         END-PI ;
078500170421           dcl-ds *n;
078600170421             t_frequence char(1) dim(2);
078700170421             hebdomadaire char(1) pos(1) inz('H');
078800170421             Mensuel char(1) pos(2) inz('M');
078900170421           end-ds;
079000170421
079100170421           dcl-ds *n;
079200170421             t_lib_frequence char(12) dim(2);
079300170421             lib_hebdomadaire char(12) pos(1) inz('Hebdomadaire');
079400170421             lib_Mensuel char(12) pos(13) inz('Mensuelle');
079500170421           end-ds;
079600170421
079700170421
079800170421         DCL-S l_lib_frequence CHAR(12);
079900170421         // Recheche dans les tableaux de code
080000170421           i=%lookup(l_frequence:t_frequence);
080100170421
080200170421           monitor;
080300170421             l_lib_frequence=t_lib_frequence(i);
080400170421           on-error;
080500170421           endmon;
080600170421
080700170421         return  l_lib_frequence;
080800170421       END-PROC ;
080900170421
081000170421
081100170421       // --------------------------------------------------
081200170421       // Procedure name: controle_data
081300170421       // Purpose:
081400170421       // Returns:
081500170421       // --------------------------------------------------
081600170421       DCL-PROC controle_data_creation;
081700170421
081800170421         g_erreur = *off;
081900170421         if ZCODCLIC=*blank;
082000170421           msg_dsp('SND0001');
082100170421           zcodclic_ri=*on;
082200170421           g_erreur=*on;
082300170421
082400170421         else;
082500170421         if not controle_exist_client(ZCODCLIC);
082600170421             msg_dsp('SND0003');
082700170421             zcodclic_ri=*on;
082800170421             g_erreur=*on;
082900170421
083000170421           endif;
083100170421         ENDIF;
083200170421
083300170421         return ;
083400170421       END-PROC ;
083500170421
083600170421
083700170421       // --------------------------------------------------
083800170421       // Procedure name: controle_exist_client
083900170421       // Purpose:
084000170421       // Returns:        Booléen '0' Le client n'existe pas, '1' le client e...
084100170421       //                          xiste
084200170421       // Parameter:      p_cod_client => Code client
084300170421       // --------------------------------------------------
084400170421       DCL-PROC controle_exist_client ;
084500170421         DCL-PI *N IND;
084600170421           p_cod_client LIKE(r_code_client);
084700170421         END-PI ;
084800170421         // Your local fields go here
084900170421
085000170421         DCL-S retField IND;
085100170421         // Your calculation code goes here
085200170421
085300170421            exec sql select oclien
085400170421                       into :zoclien
085500170421                       from bncltp
085600170421                      where codcli=:p_cod_client;
085700170421         return retField ;
085800170421       END-PROC ;
085900170421
