000100200930     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000200200930     F*****************************************************
000300200930     F*                                                   *
000400200930     F* Edition liste du personnel                        *
000500200930     F*                                                   *
000600200930     F*****************************************************
000700200930     FPGMF20PR  O    E             PRINTER OFLIND(*IN99)
000800200930     F                                     INFDS(WPRT)
000900200930     FFIC01L    IF   E           K DISK
001000200930     FFIF01L    IF   E           K DISK
001100200930     DTA1              S              1    DIM(10)
001200200930     DTA2              S              1    DIM(10)
001300200930     DWTXT1            C                   'Détail fiche employé'
001400200930     DWTXT2            C                   'Liste du personnel'
001500200930     DPMATR            S             10
001600200930     DW14              S             14  0
001700200930     DI                S              2  0
001800200930     DJ                S              2  0
001900200930     DD                S              2  0
002000200930     DF                S              2  0
002100200930     DWDI              DS
002200200930     DWSSAI                    1      4  0
002300200930     DWMI                      5      6  0
002400200930     DWJI                      7      8  0
002500200930     DWDATI                    1      8  0
002600200930     DWDE              DS
002700200930     DWJE                      1      2  0
002800200930     DWME                      3      4  0
002900200930     DWSSAE                    5      8  0
003000200930     DWDATE                    1      8  0
003100200930     DDSPROG          SDS
003200200930     DWNPROG                   1     10
003300200930     DWSTATP                  11     15  0
003400200930     DWSTAPR                  16     20  0
003500200930     DWSQSRC                  21     28
003600200930     DWSBROU                  29     36
003700200930     DWNPARM                  37     39  0
003800200930     DWTYEXC                  40     42
003900200930     DWNMSGM                  40     46
004000200930     DWNMEXC                  43     46
004100200930     DWINSMC                  47     50
004200200930     DWZOMSG                  51     80
004300200930     DWLBPGM                  81     90
004400200930     DWSFDTA                  91    170
004500200930     DWCDERR                 171    174
004600200930     DWLSFIL                 201    208
004700200930     DWLSINF                 209    243
004800200930     DWJOB                   244    253
004900200930     DWUSER                  254    263
005000200930     DWNJOB                  264    269  0
005100200930     DWPRT             DS
005200200930     DNUMLIG                 367    368I 0
005300200930     DNUMPAG                 369    372I 0
005400200930     C     *ENTRY        PLIST
005500200930     C                   PARM                    PMATR
005600200930     C* début du programme
005700200930     C     KEY001        KLIST
005800200930     C                   KFLD                    FIMAT
005900200930     C     KEY002        KLIST
006000200930     C                   KFLD                    FIFON
006100200930     C                   MOVEL     '1'           *IN85
006200200930     C* pour forcer le premier changement de page
006300200930     C                   MOVEL     '1'           *IN99
006400200930     C* les constantes
006500200930     C                   MOVEL     WNPROG        ZPGM
006600200930     C                   MOVEL     WUSER         ZUSR
006700200930     C                   TIME                    W14
006800200930     C                   MOVE      W14           ZDATE
006900200930     C                   IF        PMATR <> *BLANK
007000200930     C* il faut cadrer si mal saisi
007100200930     C                   MOVEA     PMATR         TA1
007200200930     C                   DOW       I < 10
007300200930     C     I             ADD       1             I
007400200930     C                   IF        D = 0
007500200930     C                   IF        TA1(I) <> ' ' AND TA1(I) <> '0'
007600200930     C                   Z-ADD     I             D
007700200930     C                   END
007800200930     C                   ELSE
007900200930     C                   IF        TA1(I) = ' '
008000200930     C     I             SUB       1             F
008100200930     C                   LEAVE
008200200930     C                   END
008300200930     C                   END
008400200930     C                   END
008500200930     C* on a le debut et la fin
008600200930     C                   Z-ADD     F             I
008700200930     C                   Z-ADD     10            J
008800200930     C                   IF        D > 0 AND F > 0
008900200930     C* on charge le deuxième tableau en commençant par la fin
009000200930     C                   DOW       I >= D
009100200930     C                   MOVEL     TA1(I)        TA2(J)
009200200930     C     J             SUB       1             J
009300200930     C     I             SUB       1             I
009400200930     C                   END
009500200930     C* et tout est cadré à droite
009600200930     C                   MOVEA     TA2           PMATR
009700200930     C                   END
009800200930     C                   MOVE      PMATR         FIMAT
009900200930     C* si n'importe quoi FIMAT = 0, la lecture n'aboutira pas
010000200930     C     KEY001        CHAIN     FICF                               7090
010100200930     C                   IF        *IN70 = '0'
010200200930     C                   MOVEL     '0'           *IN85
010300200930     C* edition 1 page
010400200930     C                   MOVEL     WTXT1         ZTITRE
010500200930     C* le détail
010600200930     C                   Z-ADD     FIMAT         ZMATR
010700200930     C                   MOVEL     FIFON         ZCODF
010800200930     C     KEY002        CHAIN     FIFF                               7090
010900200930     C                   MOVEL     MILIB         ZLIF
011000200930     C                   MOVEL     FINOM         ZNOM
011100200930     C                   MOVEL     FIPR1         ZPRE1
011200200930     C                   MOVEL     FIPR2         ZPRE2
011300200930     C                   MOVEL     FIAD1         ZAD1
011400200930     C                   MOVEL     FIAD2         ZAD2
011500200930     C                   MOVEL     FIAD3         ZAD3
011600200930     C                   MOVEL     FICPO         ZCPO
011700200930     C                   MOVEL     FIVIL         ZVIL
011800200930     C                   MOVEL     FITEL         ZTEL
011900200930     C                   MOVEL     FIPOR         ZPOR
012000200930     C                   Z-ADD     FIDAE         WDATI
012100200930     C                   EXSR      INVDAT
012200200930     C                   Z-ADD     WDATE         ZDAE
012300200930     C                   Z-ADD     FIDAS         WDATI
012400200930     C                   EXSR      INVDAT
012500200930     C                   Z-ADD     WDATE         ZDAS
012600200930     C                   Z-ADD     FIDAC         WDATI
012700200930     C                   EXSR      INVDAT
012800200930     C                   Z-ADD     WDATE         ZDAC
012900200930     C                   Z-ADD     FIHEC         ZHEC
013000200930     C                   MOVEL     FIUSC         ZUSC
013100200930     C                   Z-ADD     FIDAM         WDATI
013200200930     C                   EXSR      INVDAT
013300200930     C                   Z-ADD     WDATE         ZDAM
013400200930     C                   Z-ADD     FIHEM         ZHEM
013500200930     C                   MOVEL     FIUSM         ZUSM
013600200930     C   99              EXSR      CHGPAG
013700200930     C                   WRITE     DETGEN
013800200930     C                   Z-ADD     1             ZLIG
013900200930     C                   ELSE
014000200930     C                   MOVEL     '1'           *IN85
014100200930     C                   END
014200200930     C                   END
014300200930     C                   IF        *IN85 = '1'
014400200930     C                   MOVEL     WTXT2         ZTITRE
014500200930     C* on édite tout
014600200930     C                   READ      FICF                                 9070
014700200930     C                   DOW       *IN70 = '0'
014800200930     C* le détail
014900200930     C                   Z-ADD     FIMAT         ZMATR
015000200930     C                   MOVEL     FINOM         ZNOMC
015100200930     C                   MOVEL     FIPR1         ZPRE1C
015200200930     C                   MOVEL     FIAD1         ZADR1C
015300200930     C                   MOVEL     FICPO         ZCPO
015400200930     C                   MOVEL     FIVIL         ZVILC
015500200930     C   99              EXSR      CHGPAG
015600200930     C                   WRITE     DETLIG
015700200930     C     ZLIG          ADD       1             ZLIG
015800200930     C                   READ      FICF                                 9070
015900200930     C                   END
016000200930     C                   END
016100200930     C   99              EXSR      CHGPAG
016200200930     C                   WRITE     FIN
016300200930     C* fin du programme
016400200930     C                   SETON                                        LR
016500200930     C****** inversion de la date
016600200930     C     INVDAT        BEGSR
016700200930     C                   Z-ADD     WSSAI         WSSAE
016800200930     C                   Z-ADD     WMI           WME
016900200930     C                   Z-ADD     WJI           WJE
017000200930     C                   ENDSR
017100200930     C****** changement de page
017200200930     C     CHGPAG        BEGSR
017300200930     C                   SETOFF                                       99
017400200930     C****** un aurait pu utiliser la variable info splf
017500200930     C*                  Z-ADD     NUMPAG        ZPAG
017600200930     C     ZPAG          ADD       1             ZPAG
017700200930     C                   WRITE     ENTETE
017800200930     C                   IF        *IN85 = '1'
017900200930     C                   WRITE     COLON
018000200930     C                   END
018100200930     C                   ENDSR
