000100200930     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000200200930     F*****************************************************
000300200930     F*                                                   *
000400200930     F* Le compteur double                                *
000500200930     F*                                                   *
000600200930     F*****************************************************
000700200930     FFCP01L    UF A E           K DISK
000800200930     DPCOD             S              3
000900200930     DPCP1             S              6
001000200930     DPCP2             S             10
001100200930     DPCPT             S              1
001200200930     DW14              S             14  0
001300200930     DWDAT             S              8
001400200930     DWHEU             S              6
001500200930     DWDI              DS
001600200930     DWSSAI                    1      4  0
001700200930     DWMI                      5      6  0
001800200930     DWJI                      7      8  0
001900200930     DWDATI                    1      8  0
002000200930     DWDE              DS
002100200930     DWJE                      1      2  0
002200200930     DWME                      3      4  0
002300200930     DWSSAE                    5      8  0
002400200930     DWDATE                    1      8  0
002500200930     DDSPROG          SDS
002600200930     DWNPROG                   1     10
002700200930     DWSTATP                  11     15  0
002800200930     DWSTAPR                  16     20  0
002900200930     DWSQSRC                  21     28
003000200930     DWSBROU                  29     36
003100200930     DWNPARM                  37     39  0
003200200930     DWTYEXC                  40     42
003300200930     DWNMSGM                  40     46
003400200930     DWNMEXC                  43     46
003500200930     DWINSMC                  47     50
003600200930     DWZOMSG                  51     80
003700200930     DWLBPGM                  81     90
003800200930     DWSFDTA                  91    170
003900200930     DWCDERR                 171    174
004000200930     DWLSFIL                 201    208
004100200930     DWLSINF                 209    243
004200200930     DWJOB                   244    253
004300200930     DWUSER                  254    263
004400200930     DWNJOB                  264    269  0
004500200930     C* le debut du programme toujours
004600200930     C     *ENTRY        PLIST
004700200930     C                   PARM                    PCOD
004800200930     C                   PARM                    PCPT
004900200930     C                   PARM                    PCP1
005000200930     C                   PARM                    PCP2
005100200930     C* déclaration de la clé de lecture
005200200930     C     KKCL01        KLIST
005300200930     C                   KFLD                    PCOD
005400200930     C* Incremente le compteur souhaité
005500200930     C     KKCL01        CHAIN     FCPF                               7090
005600200930     C* le début
005700200930     C* au cas ou il serait utilisé ailleurs
005800200930     C                   DOW       *IN90 = '1'
005900200930     C     KKCL01        CHAIN     FCPF                               7090
006000200930     C* on boucle
006100200930     C                   END
006200200930     C                   IF        *IN70 = '0'
006300200930     C* le compteur existe
006400200930     C                   IF        PCPT = '1'
006500200930     C* on veut le compteur 1
006600200930     C     CPCP1         ADD       1             CPCP1
006700200930     C                   ELSE
006800200930     C* c'est le compteur 2
006900200930     C     CPCP2         ADD       1             CPCP2
007000200930     C                   END
007100200930     C                   EXSR      DATHEU
007200200930     C                   Z-ADD     WDATI         CPDAM
007300200930     C                   MOVE      WHEU          CPHEM
007400200930     C                   MOVEL     WUSER         CPUSM
007500200930     C                   UPDATE    FCPF
007600200930     C                   ELSE
007700200930     C* il y a un risque, c'est qu'un autre essaie de créer le même !!
007800200930     C                   MOVEL     PCOD          CPCOD
007900200930     C                   IF        PCPT = '1'
008000200930     C* on veut le compteur 1
008100200930     C                   Z-ADD     1             CPCP1
008200200930     C                   Z-ADD     0             CPCP2
008300200930     C                   ELSE
008400200930     C* c'est le compteur 2
008500200930     C                   Z-ADD     0             CPCP1
008600200930     C                   Z-ADD     1             CPCP2
008700200930     C                   END
008800200930     C                   EXSR      DATHEU
008900200930     C                   Z-ADD     WDATI         CPDAC
009000200930     C                   MOVE      WHEU          CPHEC
009100200930     C                   MOVEL     WUSER         CPUSC
009200200930     C                   Z-ADD     WDATI         CPDAM
009300200930     C                   MOVE      WHEU          CPHEM
009400200930     C                   MOVEL     WUSER         CPUSM
009500200930     C                   WRITE     FCPF
009600200930     C                   END
009700200930     C* et on retourne les valeurs
009800200930     C                   MOVEL     CPCP1         PCP1
009900200930     C                   MOVEL     CPCP2         PCP2
010000200930     C* c'est fini il faut mettre LR à *ON
010100200930     C                   SETON                                        LR
010200200930     C     DATHEU        BEGSR
010300200930     C                   TIME                    W14
010400200930     C                   MOVE      W14           WDAT
010500200930     C                   MOVEL     W14           WHEU
010600200930     C                   MOVE      WDAT          WDATE
010700200930     C                   Z-ADD     WSSAE         WSSAI
010800200930     C                   Z-ADD     WME           WMI
010900200930     C                   Z-ADD     WJE           WJI
011000200930     C                   ENDSR
