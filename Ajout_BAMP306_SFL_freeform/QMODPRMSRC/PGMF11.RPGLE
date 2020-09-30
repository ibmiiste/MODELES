000100200930     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000200200930     F*****************************************************
000300200930     F*                                                   *
000400200930     F* Détail fonction                                   *
000500200930     F*                                                   *
000600200930     F*****************************************************
000700200930     FPGMF11FM  CF   E             WORKSTN
000800200930     F                                     INFDS(WDSECR)
000900200930     FFIF00P    UF A E             DISK
001000200930     FFIF01L    IF   E           K DISK
001100200930     F                                     RENAME(FIFF      :FIFF1   )
001200200930     DWTXT1            C                   '         Modification         '
001300200930     DWTXT2            C                   '             Copie            '
001400200930     DWTXT3            C                   '           Création           '
001500200930     DWTXT4            C                   '         Suppression          '
001600200930     DWTXT5            C                   '           Affichage          '
001700200930     DPOPT             S              2
001800200930     DW14              S             14  0
001900200930     DW8               S              8
002000200930     DWDAT             S              8
002100200930     DWHEU             S              6
002200200930     DWHS              S               Z
002300200930     DPNREC            S             10
002400200930     DWNREC            S             10  0
002500200930     DW6               S              6
002600200930     DWS               DS
002700200930     DWSA                      1      4
002800200930     DWMA                      6      7
002900200930     DWJA                      9     10
003000200930     DWHA                     12     13
003100200930     DWIA                     15     16
003200200930     DWKA                     18     19
003300200930     DWMU                     21     26
003400200930     DWASTA                    1     26
003500200930     DWDSPGM          SDS
003600200930     DWNMPGM                   1     10
003700200930     DWSTATU                  11     15  0
003800200930     DWSTPRE                  16     20  0
003900200930     DWSRCSQ                  21     28
004000200930     DWNMROU                  29     36
004100200930     DWNBPAR                  37     39  0
004200200930     DWTYEXC                  40     42
004300200930     DWLICPF                  40     46
004400200930     DWNUEXC                  43     46
004500200930     DWMIODT                  47     50
004600200930     DWZOMES                  51     80
004700200930     DWBIPGM                  81     90
004800200930     DWRTDTA                  91    170
004900200930     DWCOERR                 171    174
005000200930     DWDERFI                 201    208
005100200930     DWFIINF                 209    243
005200200930     DWJOB                   244    253
005300200930     DWUSER                  254    263
005400200930     DWJOBNM                 264    269  0
005500200930     DWDSECR           DS
005600200930     DWNLIG                  370    371B 0
005700200930     DWRANP                  378    379B 0
005800200930     DWNBRS                  380    381B 0
005900200930     DWNULC                  382    383B 0
006000200930     DWRECMI                 403    404B 0
006100200930     C     *ENTRY        PLIST
006200200930     C                   PARM                    POPT
006300200930     C                   PARM                    PNREC
006400200930     C* Début du programme
006500200930     C     KEY001        KLIST
006600200930     C                   KFLD                    ZFCOD
006700200930     C                   MOVEL     '*   '        WPGMQ
006800200930     C                   MOVEL     'CC01'        WMGKEY
006900200930     C                   SETON                                        0910
007000200930     C                   SETOFF                                       1213
007100200930     C* cette DS découpe automatiquement le time stamp
007200200930     C                   MOVEL     WNMPGM        ZPGM
007300200930     C                   EXSR      DATHEU
007400200930     C                   MOVE      WDAT          ZDATE
007500200930     C                   MOVE      WHEU          ZHEUR
007600200930     C                   MOVEL     WUSER         ZUSER
007700200930     C                   MOVEL     WJOB          ZJOB
007800200930     C* constantes pour ce programme
007900200930     C                   MOVE      '1'           PTYP
008000200930     C                   MOVEL     'FICMSG    '  PFICM
008100200930     C                   SELECT
008200200930     C                   WHEN      (POPT = 'MO')
008300200930     C* modification, forcement du libellé
008400200930     C                   MOVEL     WTXT1         ZMODE
008500200930     C                   SETON                                          13
008600200930     C                   WHEN      (POPT = 'CO')
008700200930     C* tout est saisissable
008800200930     C                   MOVEL     WTXT2         ZMODE
008900200930     C                   SETON                                        1213
009000200930     C                   WHEN      (POPT = 'CR')
009100200930     C* tout est saisissable
009200200930     C                   MOVEL     WTXT3         ZMODE
009300200930     C                   SETON                                        1213
009400200930     C                   WHEN      (POPT = 'SU')
009500200930     C* rien n'est saisissable
009600200930     C                   MOVEL     WTXT4         ZMODE
009700200930     C                   WHEN      (POPT = 'AF')
009800200930     C* rien n'est saisissable
009900200930     C                   MOVEL     WTXT5         ZMODE
010000200930     C                   ENDSL
010100200930     C*
010200200930     C                   MOVE      PNREC         WNREC
010300200930     C                   IF        WNREC <> 0
010400200930     C* sauf si c'est de la création l'enregistrement doit exister
010500200930     C     WNREC         CHAIN (N) FIFF                               7090
010600200930     C                   IF        *IN70 = '0'
010700200930     C* et dans ce cas on renseigne les valeurs, sinon
010800200930     C* les variables sont initialisées à zéro
010900200930     C                   MOVEL     MIFON         ZFCOD
011000200930     C                   MOVEL     MILIB         ZFLIB
011100200930     C* date et heure création
011200200930     C                   TEST (Z)                MITSC                  90
011300200930     C     *IN90         IFEQ      '1'
011400200930     C                   MOVEL     *LOVAL        WHS
011500200930     C                   ELSE
011600200930     C                   MOVEL     MITSC         WHS
011700200930     C                   END
011800200930     C                   EXSR      CVTDAT
011900200930     C* il ne reste plus qu'a charger dans la zone écran
012000200930     C                   MOVE      W8            ZDAC
012100200930     C                   MOVE      W6            ZHEC
012200200930     C                   MOVEL     MIUSC         ZUSC
012300200930     C* date et heure de modif
012400200930     C                   TEST (Z)                MITSM                  90
012500200930     C     *IN90         IFEQ      '1'
012600200930     C                   MOVEL     *LOVAL        WHS
012700200930     C                   ELSE
012800200930     C                   MOVEL     MITSM         WHS
012900200930     C                   END
013000200930     C                   EXSR      CVTDAT
013100200930     C                   MOVE      W8            ZDAM
013200200930     C                   MOVE      W6            ZHEM
013300200930     C                   MOVEL     MIUSM         ZUSM
013400200930     C                   END
013500200930     C                   END
013600200930     C*
013700200930     C                   SETON                                        50
013800200930     C                   DOW       *IN50 = '1'
013900200930     C                   EXSR      TRTSCR
014000200930     C                   ENDDO
014100200930     C*
014200200930     C                   SETON                                        LR
014300200930     C********* les procédures
014400200930     C     TRTSCR        BEGSR
014500200930     C                   WRITE     WMGCTL
014600200930     C* On écrit l'écran
014700200930     C                   WRITE     FORE1
014800200930     C* On attend l'appui sur une touche
014900200930     C                   READ      FORE1                                  70
015000200930     C                   SETON                                          51
015100200930     C*
015200200930     C                   EXSR      DATHEU
015300200930     C                   IF        *INKC = '1' OR
015400200930     C                             *INKL = '1'
015500200930     C                   SETOFF                                       5051
015600200930     C                   END
015700200930     C*                  IF        POPT = 'SU'
015800200930     C*                  SETOFF                                         51
015900200930     C*                  END
016000200930     C                   IF        *IN85 = '1'
016100200930     C     *INKP         IFEQ      '1'
016200200930     C* touche F15 on supprime si indicateur *IN85
016300200930     C     WNREC         CHAIN     FIFF                               7090
016400200930     C  N70              DELETE    FIFF
016500200930     C                   SETOFF                                       5051
016600200930     C                   END
016700200930     C                   END
016800200930     C* contrôle des données saisies
016900200930     C                   IF        *IN51 = '1'
017000200930     C                   EXSR      CTLDTA
017100200930     C                   IF        *IN88 = '1'
017200200930     C* anomalie
017300200930     C                   EXSR      ENVMSG
017400200930     C                   SETOFF                                       88
017500200930     C                   ELSE
017600200930     C* pas d'anomalie, on valide
017700200930     C                   EXSR      VALID
017800200930     C                   SETOFF                                       5051
017900200930     C                   END
018000200930     C                   END
018100200930     C* fin procedure
018200200930     C                   ENDSR
018300200930     C******************
018400200930     C     CTLDTA        BEGSR
018500200930     C                   SETOFF                                       8885
018600200930     C* dans ce cas la seule vérification est en création/copie
018700200930     C                   IF         (POPT = 'CR' OR POPT = 'CO')
018800200930     C     KEY001        CHAIN     FIFF1                              7090
018900200930     C* pour éviter de s'auto verrouiller
019000200930     C                   IF        *IN70 = '0'
019100200930     C* le code fonction existe                           ZFCOD
019200200930     C                   SETON                                        12
019300200930     C                   MOVEL     'MSG0007'     PMGID
019400200930     C                   MOVEL     *BLANK        PMGDT
019500200930     C* top anomalie
019600200930     C                   SETON                                        88
019700200930     C                   END
019800200930     C                   END
019900200930     C* On ne fait la suite que si indicateur 88 à zéro
020000200930     C  N88              IF          POPT = 'SU'
020100200930     C* Suppression on prévient avant de supprimer
020200200930     C                   MOVEL     'MSG0004'     PMGID
020300200930     C                   MOVEL     *BLANK        PMGDT
020400200930     C                   SETON                                        8885
020500200930     C                   END
020600200930     C                   ENDSR
020700200930     C*
020800200930     C     VALID         BEGSR
020900200930     C* il n'y a eu aucune erreur on charge les zones communes
021000200930     C                   TIME                    WHS
021100200930     C     WNREC         CHAIN     FIFF                               7090
021200200930     C* c'est pas joli joli, on ne devrait le faire qu'en cas de modif.
021300200930     C                   MOVEL     ZFLIB         MILIB
021400200930     C                   MOVEL     WHS           MITSM
021500200930     C                   MOVEL     WUSER         MIUSM
021600200930     C                   IF        (POPT = 'MO')
021700200930     C* et on met à jour
021800200930     C                   UPDATE    FIFF
021900200930     C                   END
022000200930     C                   IF        (POPT = 'CO') OR
022100200930     C                             (POPT = 'CR')
022200200930     C* on rajoute le reste pour la création
022300200930     C                   MOVEL     ZFCOD         MIFON
022400200930     C                   MOVEL     MITSM         MITSC
022500200930     C                   MOVEL     WUSER         MIUSC
022600200930     C                   WRITE     FIFF
022700200930     C                   END
022800200930     C                   ENDSR
022900200930     C* mise à jour date et heure système
023000200930     C     DATHEU        BEGSR
023100200930     C                   TIME                    W14
023200200930     C                   MOVE      W14           WDAT
023300200930     C                   MOVEL     W14           WHEU
023400200930     C                   ENDSR
023500200930     C* conversion de la date
023600200930     C     CVTDAT        BEGSR
023700200930     C                   MOVEL     WHS           WASTA
023800200930     C* la DS découpe les valeurs que l'on concatène
023900200930     C                   EVAL      W8 = WJA+ WMA+ WSA
024000200930     C                   EVAL      W6 = WHA+ WIA+ WKA
024100200930     C                   ENDSR
024200200930     C*****Envoi d'un message programme
024300200930     C     ENVMSG        BEGSR
024400200930     C                   CALL      'PGM001CL'
024500200930     C                   PARM                    PTYP              1
024600200930     C                   PARM                    PFICM            10
024700200930     C                   PARM                    PMGID             7
024800200930     C                   PARM                    PMGDT            99
024900200930     C                   ENDSR
