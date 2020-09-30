000100200930       ctl-opt debug decedit('0,') datedit(*dmy.);
000200200930      //*********************************************************************
000300200930      // CC 01/01/2009
000400200930      // Liste du personnel
000500200930      //*********************************************************************
000600200930      // Déclaration des fichiers
000700200930       dcl-f PGMF01FM workstn sfile(sfl01 :wran01) infds(dssfl1);
000800200930       dcl-f FIC02L keyed infds(fic);
000900200930      // Déclaration des variables
001000200930       dcl-s WDAT char(8);
001100200930       dcl-s WHEU char(6);
001200200930       dcl-s W14 packed(14);
001300200930       dcl-s WSNOM char(35);
001400200930       dcl-s WSNOP char(35);
001500200930       dcl-s I packed(3);
001600200930      // La DS du programme, noter le S indispensable
001700200930       dcl-ds DSPROG PSDS;
001800200930        WNPROG char(10) pos(1);
001900200930        WSTATP zoned(5) pos(11);
002000200930        WSTAPR zoned(5) pos(16);
002100200930        WSQSRC char(8) pos(21);
002200200930        WSBROU char(8) pos(29);
002300200930        WNPARM zoned(3) pos(37);
002400200930        WTYEXC char(3) pos(40);
002500200930        WNMSGM char(7) pos(40);
002600200930        WNMEXC char(4) pos(43);
002700200930        WINSMC char(4) pos(47);
002800200930        WZOMSG char(30) pos(51);
002900200930        WLBPGM char(10) pos(81);
003000200930        WSFDTA char(80) pos(91);
003100200930        WCDERR char(4) pos(171);
003200200930        WLSFIL char(8) pos(201);
003300200930        WLSINF char(35) pos(209);
003400200930        WJOB char(10) pos(244);
003500200930        WUSER char(10) pos(254);
003600200930        WNJOB zoned(6) pos(264);
003700200930       end-ds;
003800200930      // La DS du sous=fichier
003900200930       dcl-ds DSSFL1;
004000200930        WPOSC int(5) pos(370);
004100200930        WRRNG int(5) pos(376);
004200200930        WRNGP int(5) pos(378);
004300200930        WNBRSF int(5) pos(380);
004400200930       end-ds;
004500200930      // La DS du fichier
004600200930       dcl-ds FIC;
004700200930        WNRC01 int(10) pos(397);
004800200930       end-ds;
004900200930       dcl-ds WDSFIC;
005000200930        WCDFIL char(8) pos(1);
005100200930        WOPENF char(1) pos(9);
005200200930        WSTSFI zoned(5) pos(11);
005300200930        WOPCOD char(6) pos(16);
005400200930        WRPGSQ char(8) pos(30);
005500200930        WRPGNR char(8) pos(38);
005600200930        WERRFI char(7) pos(46);
005700200930        WNFICH char(10) pos(83);
005800200930        WNLIBR char(10) pos(93);
005900200930        WSPNAM char(10) pos(103);
006000200930        WSPLIB char(10) pos(113);
006100200930        WSPNUM int(5) pos(123);
006200200930        WLIMBR char(10) pos(129);
006300200930        WNBPUT int(10) pos(243);
006400200930        WNBGET int(10) pos(247);
006500200930        WNBPG int(10) pos(251);
006600200930        WNBIO int(10) pos(255);
006700200930        WRCDFT char(10) pos(261);
006800200930        WNBRCD int(10) pos(283);
006900200930        WNRCFI int(10) pos(397);
007000200930       end-ds;
007100200930      // la clé d'accés au fichier
007200200930     C     KEY001        KLIST
007300200930     C                   KFLD                    FIFON
007400200930     C                   KFLD                    FINOM
007500200930      // le nombre de lignes afichables, déclaration a la volée
007600200930     C                   Z-ADD     14            NBLIS1            4 0
007700200930      // initialisation des variables générales
007800200930     C                   MOVEL     WNPROG        ZPGM
007900200930       EXSR DATHEU;
008000200930     C                   MOVE      WDAT          ZDATE
008100200930     C                   MOVE      WHEU          ZHEUR
008200200930     C                   MOVEL     WUSER         ZUSER
008300200930     C                   MOVEL     WJOB          ZJOB
008400200930      // Initialisation du sous=fichier des messages
008500200930     C                   MOVEL     '*  '         WPGMQ
008600200930     C                   MOVEL     'CC01'        WMGKEY
008700200930       *IN09 = *ON;
008800200930       *IN10 = *ON;
008900200930       // Indicateur fin
009000200930       *IN50 = *ON;
009100200930       // Debut du traitement,
009200200930       EXSR INITSF;
009300200930       // Boucle d'attente de sortie
009400200930       DOW *IN50 = '1';
009500200930         EXSR TRTSFL;
009600200930       ENDDO;
009700200930       // Indicateur de fin de programme
009800200930       *INLR = *ON;
009900200930       // Les procédures
010000200930       // Traitement de l'écran
010100200930       BEGSR TRTSFL;
010200200930         // Effacement du sous=fichier de messages
010300200930     C                   MOVEL     '3'           PTYP
010400200930     C                   MOVEL     *BLANK        PFIM
010500200930     C                   MOVEL     *BLANK        PMID
010600200930     C                   CALL      'PGM001CL'
010700200930     C                   PARM                    PTYP              1
010800200930     C                   PARM                    PFIM             10
010900200930     C                   PARM                    PMID              7
011000200930     C                   PARM                    PMDT             99
011100200930         WRITE WSFCTL;
011200200930         // Ecriture de l'écran
011300200930         *IN04 = *ON;
011400200930         *IN05 = *ON;
011500200930         WRITE FORE1;
011600200930         *IN70 = %EOF;
011700200930         WRITE FORB1;
011800200930         // Attente lecture
011900200930         READ FORE1;
012000200930         *IN70 = %EOF;
012100200930         // Une touche a été actionnée
012200200930         // Chargement de l'heure
012300200930     C                   TIME                    ZHEUR
012400200930      // Indicateur pour ne pas tester d'autres actions
012500200930         *IN51 = *ON;
012600200930         IF *IN02 = '1';
012700200930           // page suivante
012800200930           EXSR CHGPAG;
012900200930           *IN51 = *OFF;
013000200930         ENDIF;
013100200930         //
013200200930     C   51              IF        WSNOP <> ZSNOM
013300200930      // Test si selection/ si changé on initialise
013400200930           EXSR INITSF;
013500200930           *IN51 = *OFF;
013600200930         ENDIF;
013700200930         // touches F3 et F12
013800200930         IF *INKC = '1' OR
013900200930               *INKL = '1';
014000200930           // on met l'indicateur à Off = fin du programme
014100200930           *IN50 = *OFF;
014200200930           *IN51 = *OFF;
014300200930         ENDIF;
014400200930         //
014500200930         IF *INKE = '1';
014600200930           // F5 Rafraichissement de l'écran
014700200930           EXSR INITSF;
014800200930           *IN51 = *OFF;
014900200930         ENDIF;
015000200930         //
015100200930         IF *INKF = '1';
015200200930           // F6 création d'un nouveau matricule
015300200930     C                   MOVEL     'CR'          PCHX
015400200930     C                   MOVEL     *BLANK        NREC
015500200930     C                   CALL      'PGMF02'
015600200930     C                   PARM                    PCHX              2
015700200930     C                   PARM                    NREC             10
015800200930           EXSR INITSF;
015900200930           *IN51 = *OFF;
016000200930         ENDIF;
016100200930         IF *INKH = '1';
016200200930           // F8 impression du fichier
016300200930     C                   MOVEL     *BLANK        PMAT
016400200930      // On appelle le CL de routage sans soumission, sinon PGMF20CL
016500200930     C                   CALL      'PGMF2SCL'
016600200930     C                   PARM                    PMAT             10
016700200930           *IN51 = *OFF;
016800200930         ENDIF;
016900200930         // On ne fait ceci que s'il n'y a eu rien d'autre
017000200930         IF *IN51 = '1';
017100200930           EXSR TRTOPT;
017200200930         ENDIF;
017300200930         // On recommence la boucle d'attente
017400200930       ENDSR;
017500200930       // Initialisation du sous-fichier
017600200930       BEGSR INITSF;
017700200930         //    l'indicateur 20 conditionne la zone OPT (protection)
017800200930         *IN20 = *OFF;
017900200930         // Initialisation de la variable de sélection
018000200930     C                   MOVEL     ZSNOM         WSNOP
018100200930     C                   MOVEL     *BLANK        WSNOM
018200200930      // Initialisation de la clé pour positionnement
018300200930     C                   MOVEL     *BLANK        FIFON
018400200930     C                   MOVEL     *BLANK        FINOM
018500200930         *IN84 = *OFF;
018600200930         *IN85 = *OFF;
018700200930         IF ZSNOM <> *BLANK;
018800200930           // Si différent de blank il y a selection
018900200930           *IN84 = *ON;
019000200930     C                   Z-ADD     0             I
019100200930     C     '*'           SCAN      ZSNOM         I                      85
019200200930           IF I > 0;
019300200930     C     I             SUB       1             I
019400200930     C     I             SUBST (P) ZSNOM:1       WSNOM                  90
019500200930      // On est dans le cas d'une sélection générique
019600200930             *IN85 = *ON;
019700200930             // On se positionnera juste au bon endroit dans le fichier
019800200930     C                   MOVEL     WSNOM         FINOM
019900200930           ENDIF;
020000200930         ENDIF;
020100200930         // La dernière ligne écrite
020200200930     C                   Z-ADD     0             LSTLIG            4 0
020300200930      // Le compteur de ligne par page
020400200930     C                   Z-ADD     0             NBRLIG            4 0
020500200930      // Le fameux WRAN01
020600200930     C                   Z-ADD     0             WRAN01            4 0
020700200930      // Effacement du sous=fichier
020800200930         *IN06 = *ON;
020900200930         *IN07 = *ON;
021000200930         *IN04 = *OFF;
021100200930         *IN05 = *OFF;
021200200930         WRITE FORE1;
021300200930         *IN06 = *OFF;
021400200930         *IN04 = *ON;
021500200930         *IN05 = *ON;
021600200930         // Positionnement en début de fichier
021700200930         SETLL KEY001 FICF;
021800200930         *IN70 = %EQUAL;
021900200930         // Chargement de la première page
022000200930         EXSR CHGPAG;
022100200930       ENDSR;
022200200930       // Traitement des options, on ne lit que les enregistrements modifiés
022300200930       BEGSR TRTOPT;
022400200930         // Lecture des enregistrements modifiés
022500200930     C                   Z-ADD     1             WRAN01
022600200930      // Top pour rafraichir l'écran, si besoin
022700200930         *IN86 = *OFF;
022800200930     C  N70              READC     SFL01                                7070
022900200930      //
023000200930         DOW *IN70 = '0';
023100200930     C                   MOVE      HNREC         NREC
023200200930           IF HTOUT = '1';
023300200930             IF ZOPT='2' OR ZOPT='3' OR ZOPT='4' OR ZOPT='99';
023400200930               // Si l'employé à quitté on ne peut plus rien modifier
023500200930     C                   MOVE      '5 '          ZOPT
023600200930             ENDIF;
023700200930           ENDIF;
023800200930           *IN85 = *ON;
023900200930           // Selection en fonction du choix saisi
024000200930           SELECT;
024100200930           WHEN (ZOPT = '2') OR (ZOPT = ' 2');
024200200930     C                   MOVEL     'MO'          PCHX
024300200930           WHEN (ZOPT = '3') OR (ZOPT = ' 3');
024400200930     C                   MOVEL     'CO'          PCHX
024500200930           WHEN (ZOPT = '4') OR (ZOPT = ' 4');
024600200930     C                   MOVEL     'SU'          PCHX
024700200930           WHEN (ZOPT = '5') OR (ZOPT = ' 5');
024800200930     C                   MOVEL     'AF'          PCHX
024900200930           WHEN (ZOPT = '6') OR (ZOPT = ' 6');
025000200930     C                   MOVE      HMATR         PMAT
025100200930     C                   CALL      'PGMF2SCL'
025200200930     C                   PARM                    PMAT             10
025300200930             *IN85 = *OFF;
025400200930           WHEN (ZOPT = '99');
025500200930     C                   MOVEL     'PE'          PCHX
025600200930           OTHER;
025700200930             // La saisie ne correspond à rien
025800200930             *IN85 = *OFF;
025900200930             // Envoyer un message pour dire que l'option n'existe pas
026000200930     C                   MOVEL     '1'           PTYP
026100200930     C                   MOVEL     'FICMSG   '   PFIM
026200200930     C                   MOVEL     'MSG0002'     PMID
026300200930     C                   CALL      'PGM001CL'
026400200930     C                   PARM                    PTYP              1
026500200930     C                   PARM                    PFIM             10
026600200930     C                   PARM                    PMID              7
026700200930     C                   PARM                    PMDT             99
026800200930           ENDSL;
026900200930           IF HTOUT = '0';
027000200930             // Pour ne pas perdre l'attribut couleur
027100200930             *IN30 = *OFF;
027200200930           ELSE;
027300200930             *IN30 = *ON;
027400200930           ENDIF;
027500200930           // Nettoyage
027600200930     C                   MOVEL     *BLANK        ZOPT
027700200930           UPDATE(E) SFL01;
027800200930           *IN90 = %ERROR;
027900200930           // On aurait pu aussi faire IF..., en tout cas le choix est bon
028000200930     C   85              CALL      'PGMF02'
028100200930     C                   PARM                    PCHX              2
028200200930     C                   PARM                    NREC             10
028300200930     C   85              SETON                                        86
028400200930      // On continue de boucler si autre option
028500200930           READC(E) SFL01;
028600200930           *IN70 = %ERROR OR %EOF;
028700200930         ENDDO;
028800200930         // Potentiellement il y a eu mise à jour, on pourrait affiner
028900200930     C   86              EXSR      INITSF
029000200930       ENDSR;
029100200930       // Chargement d'une page
029200200930       BEGSR CHGPAG;
029300200930         // Il faut positionner correctement les indicateurs et les variables
029400200930         *IN08 = *OFF;
029500200930         //                  SETON                                        04
029600200930     C                   Z-ADD     LSTLIG        WRAN01
029700200930      // Lexture de l'enregistrement suivant
029800200930         READ FICF;
029900200930         *IN70 = %EOF;
030000200930         // Remise à zéro du compteur de ligne, mais on pourrait faire autrement
030100200930     C                   Z-ADD     0             NBRLIG            4 0
030200200930      //
030300200930         DOW *IN70 = '0'
030400200930         AND NBRLIG < 14;
030500200930           // Remplissage des zones écran
030600200930           *IN86 = *ON;
030700200930           // Test s'il y a selection
030800200930           IF *IN84 = '1' OR *IN85 = '1';
030900200930             IF *IN84 = '1' AND *IN85 = '0';
031000200930               // On recherche la stricte égalité de nom
031100200930               IF FINOM <> ZSNOM;
031200200930                 *IN86 = *OFF;
031300200930               ENDIF;
031400200930             ELSE;
031500200930               // On recherche si le nom commence par la valeur avant le '*'
031600200930     C     I             SUBST (P) FINOM:1       WXNOM            35    90
031700200930      // Petite entorse de flemmard WXNOM est déclarée au fil de l'eau
031800200930               IF WXNOM <> WSNOM;
031900200930                 *IN86 = *OFF;
032000200930               ENDIF;
032100200930             ENDIF;
032200200930           ENDIF;
032300200930           // L'indicateur est à '1' si sélection OK ou pas de sélection
032400200930           IF *IN86 = '1';
032500200930     C                   MOVEL     FINOM         ZNOM
032600200930     C                   MOVEL     FIPR1         ZPR1
032700200930     C                   MOVEL     FIFON         ZFONC
032800200930     C                   Z-ADD     FIMAT         ZMATR
032900200930     C                   MOVEL     FICPO         ZCPO
033000200930     C                   MOVEL     FIC           WDSFIC
033100200930     C                   Z-ADD     WNRCFI        HNREC
033200200930     C                   MOVE      FIMAT         HMATR
033300200930             IF FIDAS = 0;
033400200930               // Top salarié licencié
033500200930     C                   MOVE      '0'           HTOUT
033600200930               *IN30 = *OFF;
033700200930             ELSE;
033800200930     C                   MOVE      '1'           HTOUT
033900200930               *IN30 = *ON;
034000200930             ENDIF;
034100200930             // Les compteurs, attention au WRAN01
034200200930     C                   ADD       1             NBRLIG
034300200930     C                   ADD       1             LSTLIG
034400200930     C                   ADD       1             WRAN01
034500200930      // Ecriture de la ligne
034600200930             WRITE SFL01;
034700200930           ENDIF;
034800200930           // Lecture du suivant
034900200930           READ FICF;
035000200930           *IN70 = %EOF;
035100200930         ENDDO;
035200200930         // On quitte la boucle soit en fin de page
035300200930         //                     soit en fin de fichier
035400200930         IF *IN70 = '1';
035500200930           // Le caractère de suite, on est en fin de fichier
035600200930           *IN07 = *ON;
035700200930         ELSE;
035800200930           *IN07 = *OFF;
035900200930         ENDIF;
036000200930         // Si le fichier est vide
036100200930         IF WRAN01 = 0;
036200200930     C                   Z-ADD     1             NBRLIG
036300200930     C                   Z-ADD     1             LSTLIG            4 0
036400200930      // Un petit message
036500200930     C                   Z-ADD     1             WRAN01
036600200930      // Pas de saisie d'option
036700200930           *IN20 = *ON;
036800200930           IF ZSNOM = *BLANK;
036900200930             // Si on a un vieil AS400 du siècle dernier
037000200930     C                   MOVEL     'Fic. Vide'   ZNOM
037100200930           ELSE;
037200200930             // En RPG ILE
037300200930             ZNOM = 'Sélection Vide';
037400200930           ENDIF;
037500200930           // Ne pas oublier de remettre à blanc
037600200930     C                   MOVEL     *BLANK        ZPR1
037700200930     C                   MOVEL     *BLANK        ZFONC
037800200930     C                   Z-ADD     0             ZMATR
037900200930     C                   MOVEL     *BLANK        ZCPO
038000200930     C                   MOVEL     *BLANK        WDSFIC
038100200930     C                   Z-ADD     0             HNREC
038200200930      // Ecriture du message sur la première ligne
038300200930           WRITE SFL01;
038400200930         ENDIF;
038500200930         // le WRAN01 à 1 pour afficher le premier enregistrement
038600200930         //                  Z-ADD     LSTLIG        WRAN01
038700200930       ENDSR;
038800200930       // Lecture date et heure systeme
038900200930       BEGSR DATHEU;
039000200930     C                   TIME                    W14
039100200930     C                   MOVE      W14           WDAT
039200200930     C                   MOVEL     W14           WHEU
039300200930       ENDSR;
