000100200930     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000200200930     F*****************************************************
000300200930     F*                                                   *
000400200930     F* Liste fonction                                    *
000500200930     F*                                                   *
000600200930     F*****************************************************
000700200930     FPGMF10FM  CF   E             WORKSTN
000800200930     F                                     SFILE(SFL01 :WRAN01)
000900200930     F                                     INFDS(WDSFL1)
001000200930     FFIF01L    IF   E           K DISK
001100200930     F                                     INFDS(WDSFIF)
001200200930     FFIC02L    IF   E           K DISK
001300200930     DW14              S             14  0
001400200930     DWDAT             S              8
001500200930     DWHEU             S              6
001600200930     DPOPT             S              2
001700200930     DW8               S              8
001800200930     DWHS              S               Z
001900200930     DPNREC            S             10
002000200930     DWS               DS
002100200930     DWSA                      1      4
002200200930     DWMA                      6      7
002300200930     DWJA                      9     10
002400200930     DWHA                     12     13
002500200930     DWIA                     15     16
002600200930     DWKA                     18     19
002700200930     DWMU                     21     26
002800200930     DWASTA                    1     26
002900200930     DWDSPGM          SDS
003000200930     DWLIPGM                   1     10
003100200930     DWSTATU                  11     15  0
003200200930     DWSTPRE                  16     20  0
003300200930     DWSRCSQ                  21     28
003400200930     DWNMROU                  29     36
003500200930     DWNBPAR                  37     39  0
003600200930     DWTYEXC                  40     42
003700200930     DWLICPF                  40     46
003800200930     DWNUEXC                  43     46
003900200930     DWMIODT                  47     50
004000200930     DWZOMES                  51     80
004100200930     DWBIPGM                  81     90
004200200930     DWRTDTA                  91    170
004300200930     DWCOERR                 171    174
004400200930     DWDERFI                 201    208
004500200930     DWFIINF                 209    243
004600200930     DWJOB                   244    253
004700200930     DWUSER                  254    263
004800200930     DWJBNUM                 264    269  0
004900200930     DWDSFL1           DS
005000200930     DWPOSC                  370    371B 0
005100200930     DWRRNG                  376    377B 0
005200200930     DWRNGP                  378    379B 0
005300200930     DWNBRSF                 380    381B 0
005400200930     DWLIGCF                 382    383B 0
005500200930     DWRCMIE                 403    404B 0
005600200930     DWDSFIF           DS
005700200930     DWNRC01                 397    400B 0
005800200930     DWDSFI1           DS
005900200930     DWCDFIL                   1      8
006000200930     DWOPNF                    9      9
006100200930     DWSTFIL                  11     15  0
006200200930     DWOPCOD                  16     21
006300200930     DWRPGSQ                  30     37
006400200930     DWRPGNR                  38     45
006500200930     DWERRFI                  46     52
006600200930     DWNMFIC                  83     92
006700200930     DWNMBIB                  93    102
006800200930     DWSPNOM                 103    112
006900200930     DWSPLIB                 113    122
007000200930     DWSPNBR                 123    124B 0
007100200930     DWLIMBR                 129    138
007200200930     DWNBPUT                 243    246B 0
007300200930     DWNBGET                 247    250B 0
007400200930     DWNBPG                  251    254B 0
007500200930     DWNBIO                  255    258B 0
007600200930     DWRCDFT                 261    270
007700200930     DWNBRCD                 283    286B 0
007800200930     DWNRCFI                 397    400B 0
007900200930     C     KEYSF1        KLIST
008000200930     C                   KFLD                    MIFON
008100200930     C     KEY001        KLIST
008200200930     C                   KFLD                    MIFON
008300200930     C* initialisations générales
008400200930     C                   MOVEL     WLIPGM        ZPGM
008500200930     C                   SETON                                        0910
008600200930     C                   EXSR      DATHEU
008700200930     C                   MOVE      WDAT          ZDATE
008800200930     C                   MOVE      WHEU          ZHEUR
008900200930     C                   MOVEL     WUSER         ZUSER
009000200930     C                   MOVEL     WJOB          ZJOB
009100200930     C                   MOVEL     '*  '         WPGMQ
009200200930     C                   MOVEL     'CC01'        WMGKEY
009300200930     C                   SETON                                        0910
009400200930     C* Indicateur fin
009500200930     C                   SETON                                        50
009600200930     C* Debut du traitement,
009700200930     C                   EXSR      INITSF
009800200930     C* Boucle d'attente de sortie
009900200930     C                   DOW       *IN50 = '1'
010000200930     C                   EXSR      TRTSFL
010100200930     C                   END
010200200930     C                   SETON                                        LR
010300200930     C* traitement de l'écran
010400200930     C     TRTSFL        BEGSR
010500200930     C*
010600200930     C                   MOVEL     '3'           PTYP
010700200930     C                   MOVEL     *BLANK        PFIM
010800200930     C                   MOVEL     *BLANK        PMID
010900200930     C                   CALL      'PGM001CL'
011000200930     C                   PARM                    PTYP              1
011100200930     C                   PARM                    PFIM             10
011200200930     C                   PARM                    PMID              7
011300200930     C                   PARM                    PMDT             99
011400200930     C                   WRITE     WSFCTL
011500200930     C                   SETON                                        0405
011600200930     C                   WRITE     FORE1                                  70
011700200930     C                   WRITE     FORB1
011800200930     C* attente lecture
011900200930     C                   READ      FORE1                                  70
012000200930     C* chargement de l'heure
012100200930     C                   TIME                    ZHEUR
012200200930     C*
012300200930     C                   SETON                                        51
012400200930     C                   IF        *IN02 = '1'
012500200930     C* page suivante
012600200930     C                   EXSR      CHGPAG
012700200930     C                   SETOFF                                       51
012800200930     C                   END
012900200930     C*
013000200930     C* touches F3 et F12
013100200930     C                   IF        *INKC = '1' OR
013200200930     C                             *INKL = '1'
013300200930     C* on met l'indicateur à Off
013400200930     C                   SETOFF                                       5051
013500200930     C                   END
013600200930     C*
013700200930     C                   IF        *INKE = '1'
013800200930     C* F5 Rafraichissement de l'écran
013900200930     C                   EXSR      INITSF
014000200930     C                   SETOFF                                       51
014100200930     C                   END
014200200930     C*
014300200930     C                   IF        *INKF = '1'
014400200930     C* F6 création d'une nouvelle fonction
014500200930     C                   MOVEL     'CR'          PCHX
014600200930     C                   MOVEL     *BLANK        NREC
014700200930     C                   CALL      'PGMF11'
014800200930     C                   PARM                    PCHX              2
014900200930     C                   PARM                    NREC             10
015000200930     C                   EXSR      INITSF
015100200930     C                   SETOFF                                       51
015200200930     C                   END
015300200930     C*
015400200930     C                   IF        *IN51 = '1'
015500200930     C                   EXSR      TRTOPT
015600200930     C                   END
015700200930     C* on recommence la boucle d'attente
015800200930     C                   ENDSR
015900200930     C* Les Sub Routines
016000200930     C*****************************************
016100200930     C*  Initialisation du sous-fichier
016200200930     C*****************************************
016300200930     C     INITSF        BEGSR
016400200930     C*    l'indicateur 20 conditionne la zone OPT (protection)
016500200930     C                   SETOFF                                       20
016600200930     C*    dernière ligne écrite
016700200930     C                   Z-ADD     0             LSTLIG            4 0
016800200930     C*    compteur de ligne par page
016900200930     C                   Z-ADD     0             NBRLIG            4 0
017000200930     C*    la fameux WRAN01
017100200930     C                   Z-ADD     0             WRAN01            4 0
017200200930     C                   SETON                                        0607
017300200930     C                   SETOFF                                       0405
017400200930     C                   WRITE     FORE1
017500200930     C                   SETOFF                                       06
017600200930     C                   SETON                                        0405
017700200930     C     *LOVAL        SETLL     FIFF                                   70
017800200930     C                   READ      FIFF                                   70
017900200930     C                   EXSR      CHGPAG
018000200930     C*
018100200930     C                   ENDSR
018200200930     C******************************
018300200930     C     TRTOPT        BEGSR
018400200930     C*  Lecture des enregistrements modifiés
018500200930     C                   Z-ADD     1             WRAN01
018600200930     C* top pour rafraichir l'écran
018700200930     C                   SETOFF                                       86
018800200930     C  N70              READC     SFL01                                7070
018900200930     C*
019000200930     C     *IN70         DOWEQ     '0'
019100200930     C                   MOVE      HNREC         NREC
019200200930     C                   SETON                                        85
019300200930     C                   SELECT
019400200930     C                   WHEN      (ZOPT = ' ')
019500200930     C                   SETOFF                                       85
019600200930     C                   WHEN      (ZOPT = '2')
019700200930     C                   MOVEL     'MO'          PCHX
019800200930     C                   WHEN      (ZOPT = '3')
019900200930     C                   MOVEL     'CO'          PCHX
020000200930     C                   WHEN      (ZOPT = '4')
020100200930     C                   MOVEL     'SU'          PCHX
020200200930     C                   WHEN      (ZOPT = '5')
020300200930     C                   MOVEL     'AF'          PCHX
020400200930     C                   OTHER
020500200930     C                   SETOFF                                       85
020600200930     C* envoyer un message pour dire que l'option n'existe pas
020700200930     C                   MOVEL     '1'           PTYP
020800200930     C                   MOVEL     'FICMSG   '   PFIM
020900200930     C                   MOVEL     'MSG0002'     PMID
021000200930     C                   CALL      'PGM001CL'
021100200930     C                   PARM                    PTYP              1
021200200930     C                   PARM                    PFIM             10
021300200930     C                   PARM                    PMID              7
021400200930     C                   PARM                    PMDT             99
021500200930     C                   ENDSL
021600200930     C                   MOVEL     *BLANK        ZOPT
021700200930     C                   UPDATE    SFL01                                90
021800200930     C* on aurait pu aussi faire IF ....
021900200930     C   85              CALL      'PGMF11'
022000200930     C                   PARM                    PCHX              2
022100200930     C                   PARM                    NREC             10
022200200930     C   85              SETON                                        86
022300200930     C                   READC     SFL01                                7070
022400200930     C                   END
022500200930     C   86              EXSR      INITSF
022600200930     C                   ENDSR
022700200930     C*************************************
022800200930     C     CHGPAG        BEGSR
022900200930     C*  chargement de la page
023000200930     C                   SETOFF                                       08
023100200930     C*                  SETON                                        04
023200200930     C                   Z-ADD     LSTLIG        WRAN01
023300200930     C                   Z-ADD     0             NBRLIG            4 0
023400200930     C*
023500200930     C     *IN70         DOWEQ     '0'
023600200930     C     NBRLIG        ANDLT     15
023700200930     C* remplissage des zones écran
023800200930     C                   MOVEL     MIFON         ZCOD
023900200930     C* on tronque à l'affichage
024000200930     C                   MOVEL     MILIB         ZLIB
024100200930     C* conversion de la date
024200200930     C                   TEST (Z)                MITSC                  90
024300200930     C     *IN90         IFEQ      '1'
024400200930     C                   MOVEL     *LOVAL        WHS
024500200930     C                   ELSE
024600200930     C                   MOVEL     MITSC         WHS
024700200930     C                   END
024800200930     C                   EXSR      CVTDAT
024900200930     C                   MOVE      W8            ZDAC
025000200930     C                   TEST (Z)                MITSM                  90
025100200930     C     *IN90         IFEQ      '1'
025200200930     C                   MOVEL     *LOVAL        WHS
025300200930     C                   ELSE
025400200930     C                   MOVEL     MITSM         WHS
025500200930     C                   END
025600200930     C                   EXSR      CVTDAT
025700200930     C                   MOVE      W8            ZDAM
025800200930     C* la on met une petite complication qui ralentit fortement le traitement
025900200930     C                   Z-ADD     0             ZNBEM
026000200930     C     KEY001        CHAIN     FICF                               7190
026100200930     C* la clé est la code fonction lu dans le fichier des codes
026200200930     C                   DOW       *IN71 = '0'
026300200930     C* lecture de tous les employés ayant le même code
026400200930     C     ZNBEM         ADD       1             ZNBEM
026500200930     C     KEY001        READE     FICF                                 9071
026600200930     C                   ENDDO
026700200930     C* pour récupérer le numéro d'enregistrement
026800200930     C                   MOVEL     WDSFIF        WDSFI1
026900200930     C                   Z-ADD     WNRCFI        HNREC
027000200930     C                   ADD       1             NBRLIG
027100200930     C                   ADD       1             WRAN01
027200200930     C                   ADD       1             LSTLIG            4 0
027300200930     C                   WRITE     SFL01
027400200930     C* lecture du suivant
027500200930     C                   READ      FIFF                                   70
027600200930     C                   END
027700200930     C* on quitte la boucle soit en fin de page
027800200930     C*                     soit en fin de fichier
027900200930     C     *IN70         IFEQ      '1'
028000200930     C* le caractère de suite
028100200930     C                   SETON                                        07
028200200930     C                   ELSE
028300200930     C                   SETOFF                                       07
028400200930     C                   ENDIF
028500200930     C* si le fichier est vide
028600200930     C     WRAN01        IFEQ      0
028700200930     C                   Z-ADD     1             NBRLIG
028800200930     C                   Z-ADD     1             LSTLIG            4 0
028900200930     C* un petit message
029000200930     C                   Z-ADD     1             WRAN01
029100200930     C* pas de saisie d'option
029200200930     C                   SETON                                        20
029300200930     C                   eval      ZLIB = 'Sélection Vide                      '
029400200930     C                   MOVEL     *BLANK        ZCOD
029500200930     C                   Z-ADD     0             HNREC
029600200930     C                   WRITE     SFL01
029700200930     C                   END
029800200930     C* le WRAN01 à 1 pour afficher le premier enregistrement
029900200930     C*                  Z-ADD     1             WRAN01
030000200930     C                   ENDSR
030100200930     C* chargement de la date et heure système
030200200930     C     DATHEU        BEGSR
030300200930     C                   TIME                    W14
030400200930     C                   MOVE      W14           WDAT
030500200930     C                   MOVEL     W14           WHEU
030600200930     C                   ENDSR
030700200930     C* conversion de la date
030800200930     C     CVTDAT        BEGSR
030900200930     C                   MOVEL     WHS           WASTA
031000200930     C* la DS découpe les valeurs que l'on concatène
031100200930     C                   EVAL      W8 = WJA+ WMA+ WSA
031200200930     C* il ne reste plus qu'a charger dans la zone écran
031300200930     C                   ENDSR
