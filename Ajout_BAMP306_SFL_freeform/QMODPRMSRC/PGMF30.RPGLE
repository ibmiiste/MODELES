000100200930     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000200200930     F*****************************************************
000300200930     F*                                                   *
000400200930     F* Liste outq                                        *
000500200930     F*                                                   *
000600200930     F*****************************************************
000700200930     FPGMF30FM  CF   E             WORKSTN
000800200930     F                                     SFILE(SFL01 :WRAN01)
000900200930     F                                     INFDS(DSSFL1)
001000200930     FFIO01L    IF A E           K DISK
001100200930     F                                     INFDS(WDSFIC)
001200200930     FFIO00P    UF   E             DISK
001300200930     F                                     RENAME(FIOF      :FIOFP)
001400200930     DWTXT1            C                   'DSPOBJD OBJ('
001500200930     DWTXT2            C                   ') OBJTYPE(*USRPRF) OUTPUT(*PRINT)'
001600200930     DWTXT3            C                   ') OBJTYPE(*OUTQ) OUTPUT(*PRINT)'
001700200930     DW14              S             14  0
001800200930     DWDAT             S              8
001900200930     DWHEU             S              6
002000200930     DWCMD             S            256
002100200930     DWLNG             S             15  5
002200200930     DPNREC            S             10
002300200930     DW10              S             10
002400200930     DWSUSR            S             10
002500200930     DWSDOC            S             10
002600200930     DWSPRT            S             10
002700200930     DDSPROG          SDS
002800200930     DWNPROG                   1     10
002900200930     DWSTATP                  11     15  0
003000200930     DWSTAPR                  16     20  0
003100200930     DWSQSRC                  21     28
003200200930     DWSBROU                  29     36
003300200930     DWNPARM                  37     39  0
003400200930     DWTYEXC                  40     42
003500200930     DWNMSGM                  40     46
003600200930     DWNMEXC                  43     46
003700200930     DWINSMC                  47     50
003800200930     DWZOMSG                  51     80
003900200930     DWLBPGM                  81     90
004000200930     DWSFDTA                  91    170
004100200930     DWCDERR                 171    174
004200200930     DWLSFIL                 201    208
004300200930     DWLSINF                 209    243
004400200930     DWJOB                   244    253
004500200930     DWUSER                  254    263
004600200930     DWNJOB                  264    269  0
004700200930     DDSSFL1           DS
004800200930     DWPOSC                  370    371B 0
004900200930     DWRRNG                  376    377B 0
005000200930     DWRNGP                  378    379B 0
005100200930     DWNBRSF                 380    381B 0
005200200930     DWNLIGF                 382    383B 0
005300200930     DWNRCME                 403    404B 0
005400200930     DWDSFIC           DS
005500200930     DWCDFIL                   1      8
005600200930     DWOPENF                   9      9
005700200930     DWSTSFI                  11     15  0
005800200930     DWOPCOD                  16     21
005900200930     DWRPGSQ                  30     37
006000200930     DWRPGNR                  38     45
006100200930     DWERRFI                  46     52
006200200930     DWNFICH                  83     92
006300200930     DWNLIBR                  93    102
006400200930     DWSPNAM                 103    112
006500200930     DWSPLIB                 113    122
006600200930     DWSPNUM                 123    124B 0
006700200930     DWLIMBR                 129    138
006800200930     DWNBPUT                 243    246B 0
006900200930     DWNBGET                 247    250B 0
007000200930     DWNBPG                  251    254B 0
007100200930     DWNBIO                  255    258B 0
007200200930     DWRCDFT                 261    270
007300200930     DWNBRCD                 283    286B 0
007400200930     DWNRCFI                 397    400B 0
007500200930     C     SKEY01        KLIST
007600200930     C                   KFLD                    FOUSR
007700200930     C     KEY001        KLIST
007800200930     C                   KFLD                    ZMUSR
007900200930     C                   KFLD                    ZMDOC
008000200930     C                   KFLD                    ZMPRT
008100200930     C                   Z-ADD     14            NBLIS1            4 0
008200200930     C                   MOVEL     '*   '        WPGMQ
008300200930     C                   MOVEL     'CC01'        WMGKEY
008400200930     C* Programme Liste des Outq
008500200930     C* initialisations générales
008600200930     C                   Z-ADD     256           WLNG
008700200930     C                   MOVEL     WNPROG        ZPGM
008800200930     C                   EXSR      DATHEU
008900200930     C                   MOVE      WDAT          ZDATE
009000200930     C                   MOVE      WHEU          ZHEUR
009100200930     C                   MOVEL     WUSER         ZUSER
009200200930     C                   MOVEL     WJOB          ZJOB
009300200930     C                   SETON                                        091050
009400200930     C* Debut du traitement,
009500200930     C                   EXSR      INITSF
009600200930     C* Boucle d'attente de sortie
009700200930     C                   DOW       *IN50 = '1'
009800200930     C                   EXSR      TRTSFL
009900200930     C                   END
010000200930     C                   SETON                                        LR
010100200930     C* traitement ecran
010200200930     C     TRTSFL        BEGSR
010300200930     C********************************
010400200930     C                   MOVEL     '3'           PTYP
010500200930     C                   MOVEL     *BLANK        PFIM
010600200930     C                   MOVEL     *BLANK        PMID
010700200930     C                   CALL      'PGM001CL'
010800200930     C                   PARM                    PTYP              1
010900200930     C                   PARM                    PFIM             10
011000200930     C                   PARM                    PMID              7
011100200930     C                   PARM                    PMDT             99
011200200930     C* mise à blanc du sous fichier de messages
011300200930     C                   WRITE     WSFCTL
011400200930     C                   SETON                                        0405
011500200930     C* ecriture de l'écran
011600200930     C                   WRITE     FORE1                                  70
011700200930     C                   WRITE     FORB1
011800200930     C* attente lecture
011900200930     C                   READ      FORE1                                  70
012000200930     C* chargement de l'heure
012100200930     C                   EXSR      DATHEU
012200200930     C                   MOVE      WDAT          ZDATE
012300200930     C                   MOVE      WHEU          ZHEUR
012400200930     C                   SETON                                          5185
012500200930     C                   IF        WSUSR <> ZSUSR OR
012600200930     C                             WSDOC <> ZSDOC OR
012700200930     C                             WSPRT <> ZSPRT
012800200930     C                   EXSR      INITSF
012900200930     C                   SETOFF                                         51
013000200930     C                   END
013100200930     C* touches F3 et F12
013200200930     C   51              IF        *INKC = '1' OR
013300200930     C                             *INKL = '1'
013400200930     C* on met l'indicateur à Off
013500200930     C                   SETOFF                                       5051
013600200930     C                   END
013700200930     C* la suite n'est exécutée que si indicateur 51 = '1'
013800200930     C   51              IF        *IN02 = '1'
013900200930     C* page suivante
014000200930     C                   EXSR      CHGPAG
014100200930     C                   SETOFF                                       51
014200200930     C                   END
014300200930     C*
014400200930     C   51              IF        *INKF = '1'
014500200930     C* fonction création
014600200930     C     LSTLIG        ADD       1             LSTLIG
014700200930     C                   Z-ADD     LSTLIG        WRAN01
014800200930     C                   MOVEL     *BLANK        ZMUSR
014900200930     C                   MOVEL     *BLANK        ZMPRT
015000200930     C                   MOVEL     *BLANK        ZMDOC
015100200930     C* on rajoute une ligne à saisir dans le sous fichier
015200200930     C                   WRITE     SFL01
015300200930     C*                  SETON                                          13
015400200930     C                   SETOFF                                         51
015500200930     C                   ENDIF
015600200930     C   51              IF        *INKP = '1'
015700200930     C* ménage profils et outq inconnus
015800200930     C                   Z-ADD     0             HNREC
015900200930     C                   READ      FIOFP                                9070
016000200930     C                   DOW       *IN70 = '0'
016100200930     C                   EVAL      W10 = FOUSR
016200200930     C                   SETOFF                                         86
016300200930     C                   EXSR      EXECMD
016400200930     C                   IF        *IN90 = '1'
016500200930     C                   DELETE    FIOFP
016600200930     C                   SETON                                        85
016700200930     C                   ELSE
016800200930     C                   EVAL      W10 = FOOUQ
016900200930     C                   SETON                                          86
017000200930     C                   EXSR      EXECMD
017100200930     C                   IF        *IN90 = '1'
017200200930     C                   DELETE    FIOFP
017300200930     C                   SETON                                        85
017400200930     C                   END
017500200930     C                   END
017600200930     C                   READ      FIOFP                                9070
017700200930     C                   ENDDO
017800200930     C                   END
017900200930     C* vérification saisie/choix
018000200930     C   51              EXSR      CTLDTA
018100200930     C* en cas de modification on rafraichit l'écran
018200200930     C   85              EXSR      INITSF
018300200930     C* on recommence la boucle d'attente
018400200930     C                   ENDSR
018500200930     C* initialisation du sous fichier
018600200930     C     INITSF        BEGSR
018700200930     C                   eval      WSUSR = ZSUSR
018800200930     C                   eval      WSDOC = ZSDOC
018900200930     C                   eval      WSPRT = ZSPRT
019000200930     C* La dernière ligne écrite
019100200930     C                   Z-ADD     0             LSTLIG            4 0
019200200930     C* Le compteur de ligne par page
019300200930     C                   Z-ADD     0             NBRLIG            4 0
019400200930     C* Le fameux WRAN01
019500200930     C                   Z-ADD     0             WRAN01            4 0
019600200930     C* Effacement du sous=fichier
019700200930     C                   SETON                                        0607
019800200930     C                   SETOFF                                       0405
019900200930     C                   WRITE     FORE1
020000200930     C                   SETOFF                                       06
020100200930     C                   SETON                                        0405
020200200930     C* Positionnement en début de fichier
020300200930     C                   MOVEL     *LOVAL        FOUSR
020400200930     C     SKEY01        SETLL     FIOF
020500200930     C* Chargement de la première page
020600200930     C                   EXSR      CHGPAG
020700200930     C                   ENDSR
020800200930     C* vérification des données
020900200930     C     CTLDTA        BEGSR
021000200930     C********************
021100200930     C* lecture des enregistrements modifiés
021200200930     C                   Z-ADD     1             WRAN01
021300200930     C* Top pour rafraichir l'écran, si besoin
021400200930     C                   SETOFF                                       86
021500200930     C  N70              READC     SFL01                                7070
021600200930     C* boucle de lecture
021700200930     C     *IN70         DOWEQ     '0'
021800200930     C                   MOVEL     '1'           *IN85
021900200930     C* si les trois champs sont remis à blank = suppression
022000200930     C                   IF        ZMUSR = *BLANK AND
022100200930     C                             ZMPRT = *BLANK AND
022200200930     C                             ZMDOC = *BLANK
022300200930     C     HNREC         CHAIN     FIOFP                              7190
022400200930     C                   IF        *IN71  = '0'
022500200930     C                   DELETE    FIOFP
022600200930     C                   END
022700200930     C                   ELSE
022800200930     C     KEY001        CHAIN     FIOF                               7190
022900200930     C                   IF        *IN71 = '0'
023000200930     C* pas bon du tout
023100200930     C                   MOVEL     '0'           *IN85
023200200930     C                   ELSE
023300200930     C* le user doit exister
023400200930     C                   EVAL      W10 = ZMUSR
023500200930     C                   EXSR      EXECMD
023600200930     C                   IF        *IN90 = '1'
023700200930     C                   MOVEL     '0'           *IN85
023800200930     C                   MOVEL     'MSG0005'     WMGID            10
023900200930     C                   END
024000200930     C* et la outq aussi
024100200930     C                   IF        *IN85 = '1'
024200200930     C                   EVAL      W10  =  ZMPRT
024300200930     C                   SETON                                          86
024400200930     C                   EXSR      EXECMD
024500200930     C                   IF        *IN90 = '1'
024600200930     C                   MOVEL     '0'           *IN85
024700200930     C                   MOVEL     'MSG0006'     WMGID            10
024800200930     C                   END
024900200930     C                   END
025000200930     C                   END
025100200930     C* si c'est ok
025200200930     C                   IF        *IN85 = '1'
025300200930     C                   MOVEL     ZMUSR         FOUSR
025400200930     C                   MOVEL     ZMDOC         FODOC
025500200930     C                   MOVEL     ZMPRT         FOOUQ
025600200930     C                   WRITE     FIOF
025700200930     C                   ELSE
025800200930     C* message d'erreur
025900200930     C                   END
026000200930     C                   END
026100200930     C* mise à jour du sous fichier
026200200930     C                   UPDATE    SFL01                                90
026300200930     C* lecture du suivant
026400200930     C                   READC     SFL01                                7070
026500200930     C                   END
026600200930     C                   ENDSR
026700200930     C**********************************
026800200930     C     CHGPAG        BEGSR
026900200930     C*  chargement de la page
027000200930     C                   SETOFF                                       08
027100200930     C*                  SETON                                        04
027200200930     C                   Z-ADD     LSTLIG        WRAN01
027300200930     C                   READ      FIOF                                   70
027400200930     C                   Z-ADD     0             NBRLIG            4 0
027500200930     C*
027600200930     C     *IN70         DOWEQ     '0'
027700200930     C     NBRLIG        ANDLT     14
027800200930     C* remplissage des zones écran
027900200930     C                   SETON                                        86
028000200930     C                   IF        ( FOUSR = ZSUSR OR
028100200930     C                             ZSUSR = *BLANK) AND
028200200930     C                             ( FODOC = ZSDOC OR
028300200930     C                             ZSDOC = *BLANK) AND
028400200930     C                             ( FOOUQ = ZSPRT OR
028500200930     C                             ZSPRT = *BLANK)
028600200930     C* On recherche la stricte égalité
028700200930     C                   MOVEL     FOUSR         ZMUSR
028800200930     C                   MOVEL     FODOC         ZMDOC
028900200930     C                   MOVEL     FOOUQ         ZMPRT
029000200930     C                   Z-ADD     WNRCFI        HNREC
029100200930     C                   ADD       1             NBRLIG
029200200930     C                   ADD       1             WRAN01
029300200930     C                   ADD       1             LSTLIG            4 0
029400200930     C                   WRITE     SFL01
029500200930     C                   END
029600200930     C* lecture du suivant
029700200930     C                   READ      FIOF                                   70
029800200930     C                   END
029900200930     C* on quitte la boucle soit en fin de page
030000200930     C*                     soit en fin de fichier
030100200930     C     *IN70         IFEQ      '1'
030200200930     C* le caractère de suite
030300200930     C                   SETON                                        07
030400200930     C                   END
030500200930     C* si le fichier est vide
030600200930     C     WRAN01        IFEQ      0
030700200930     C                   Z-ADD     1             NBRLIG
030800200930     C                   Z-ADD     1             LSTLIG            4 0
030900200930     C* un petit message
031000200930     C                   Z-ADD     1             WRAN01
031100200930     C* pas de saisie d'option
031200200930     C                   SETON                                        20
031300200930     C                   eval      ZMDOC = 'vide      '
031400200930     C                   IF        ZMUSR = *BLANK AND ZMDOC = *BLANK AND
031500200930     C                             ZMPRT = *BLANK
031600200930     C                   eval      ZMUSR = 'Fichier   '
031700200930     C                   ELSE
031800200930     C                   eval      ZMUSR = 'Sélection '
031900200930     C                   END
032000200930     C                   MOVEL     *BLANK        ZMPRT
032100200930     C                   MOVEL     *BLANK        WDSFIC
032200200930     C                   Z-ADD     0             HNREC
032300200930     C                   WRITE     SFL01
032400200930     C                   END
032500200930     C* le WRAN01 à 1 pour afficher le premier enregistrement
032600200930     C                   Z-ADD     1             WRAN01
032700200930     C                   ENDSR
032800200930     C* execution de commande, puisqu'on le fait plusieurs fois
032900200930     C     EXECMD        BEGSR
033000200930     C* On nettoie la variable
033100200930     C                   MOVEL     *BLANK        WCMD
033200200930     C* ça on le fait dans les deux cas
033300200930     C                   EVAL      WCMD = WTXT1+ W10
033400200930     C* selon le cas on teste user ou outq
033500200930     C                   IF        *IN86 = '0'
033600200930     C                   EVAL      WCMD = %TRIMR(WCMD) +  WTXT2
033700200930     C                   ELSE
033800200930     C                   EVAL      WCMD = %TRIMR(WCMD) +  WTXT3
033900200930     C                   END
034000200930     C* execution commande, WLNG = longueur de WCMD (init au début)
034100200930     C                   CALL      'QCMDEXC'                            90
034200200930     C                   PARM                    WCMD
034300200930     C                   PARM                    WLNG
034400200930     C                   ENDSR
034500200930     C* procédure pour la date
034600200930     C     DATHEU        BEGSR
034700200930     C                   TIME                    W14
034800200930     C                   MOVE      W14           WDAT
034900200930     C                   MOVEL     W14           WHEU
035000200930     C                   ENDSR
