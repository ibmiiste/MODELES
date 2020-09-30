000100200930     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000200200930     F*****************************************************
000300200930     F*                                                   *
000400200930     F* Invite sur fonction                               *
000500200930     F*                                                   *
000600200930     F*****************************************************
000700200930     FPGMI01FM  CF   E             WORKSTN
000800200930     F                                     SFILE(SFL01 :WRAN01)
000900200930     F                                     INFDS(DSSFL1)
001000200930     FFIF01L    IF   E           K DISK
001100200930     DPCDACT           S              2
001200200930     DPRET             S              1
001300200930     DPFCT             S              3
001400200930     D* la ds du programme, on pourrait s'en passer dans ce cas
001500200930     DDSPROG          SDS
001600200930     DWNPROG                   1     10
001700200930     DWSTATP                  11     15  0
001800200930     DWSTAPR                  16     20  0
001900200930     DWSQSRC                  21     28
002000200930     DWSBROU                  29     36
002100200930     DWNPARM                  37     39  0
002200200930     DWTYEXC                  40     42
002300200930     DWNMSGM                  40     46
002400200930     DWNMEXC                  43     46
002500200930     DWINSMC                  47     50
002600200930     DWZOMSG                  51     80
002700200930     DWLBPGM                  81     90
002800200930     DWSFDTA                  91    170
002900200930     DWCDERR                 171    174
003000200930     DWLSFIL                 201    208
003100200930     DWLSINF                 209    243
003200200930     DWJOB                   244    253
003300200930     DWUSER                  254    263
003400200930     DWNJOB                  264    269  0
003500200930     D* La DS du sous=fichier
003600200930     DDSSFL1           DS
003700200930     DWPOSC                  370    371B 0
003800200930     DWRRNG                  376    377B 0
003900200930     DWRNGP                  378    379B 0
004000200930     DWNBRSF                 380    381B 0
004100200930     C* les paramètres d'entrée
004200200930     C     *ENTRY        PLIST
004300200930     C                   PARM                    PCDACT
004400200930     C                   PARM                    PFCT
004500200930     C* c'est ici que ça commence
004600200930     C     KEYSF1        KLIST
004700200930     C                   KFLD                    MIFON
004800200930     C* la clé sert à trier par code
004900200930     C                   MOVEL     '*   '        WPGMQ
005000200930     C                   MOVEL     'CC01'        WMGKEY
005100200930     C                   MOVEL     WNPROG        ZPGM
005200200930     C* Initialisation des indicateurs
005300200930     C                   SETON                                        0910
005400200930     C                   SETON                                        5013
005500200930     C                   IF        PCDACT = 'GS'
005600200930     C* indicateur pour autoriser la saisie du choix & visu option
005700200930     C                   SETOFF                                       13
005800200930     C                   END
005900200930     C* Initialisation du sous fichier
006000200930     C                   EXSR      INITSF
006100200930     C* Boucle d'attente de sortie
006200200930     C                   DOW       *IN50 = '1'
006300200930     C                   EXSR      TRTSFL
006400200930     C                   END
006500200930     C* Indicateur de fin de programme
006600200930     C                   SETON                                        LR
006700200930     C* Les procédures
006800200930     C     TRTSFL        BEGSR
006900200930     C* Effacement du sous=fichier de messages
007000200930     C                   MOVEL     '3'           PTYP
007100200930     C                   MOVEL     *BLANK        PFIM
007200200930     C                   MOVEL     *BLANK        PMID
007300200930     C                   CALL      'PGM001CL'
007400200930     C                   PARM                    PTYP              1
007500200930     C                   PARM                    PFIM             10
007600200930     C                   PARM                    PMID              7
007700200930     C                   PARM                    PMDT             99
007800200930     C                   WRITE     WSFCTL
007900200930     C* Ecriture de l'écran
008000200930     C                   SETON                                        0405
008100200930     C                   IF        WRAN01 = 0
008200200930     C                   SETOFF                                       04
008300200930     C                   EndIf
008400200930     C                   WRITE     FORE1                                  70
008500200930     C                   WRITE     FORB1                                  70
008600200930     C* Attente lecture
008700200930     C                   READ      FORE1                                  70
008800200930     C                   READ      FORB1                                  70
008900200930     C                   IF        *IN02 = '1'
009000200930     C* pour mémoire, on est en chargement total
009100200930     C* c'est le système qui s'en occupe
009200200930     C                   END
009300200930     C                   IF        *INKC = '1' OR
009400200930     C                             *INKL = '1'
009500200930     C* on quitte sans rien faire
009600200930     C                   SETOFF                                       50
009700200930     C                   END
009800200930     C* en mode GS, si on ne quitte pas, on vérifie le choix
009900200930     C   50              IF        PCDACT = 'GS'
010000200930     C* en mode GS uniquement
010100200930     C                   EXSR      VERIF
010200200930     C* l'utilisateur a fait le bon choix, on quitte le programme
010300200930     C                   IF        *IN85 = '0'
010400200930     C                   SETOFF                                       50
010500200930     C                   END
010600200930     C                   END
010700200930     C* On recommence la boucle d'attente
010800200930     C                   ENDSR
010900200930     C* vérification si choix '1'
011000200930     C     VERIF         BEGSR
011100200930     C* indicateur de fin de boucle
011200200930     C                   SETON                                          85
011300200930     C                   Z-ADD     1             WRAN01
011400200930     C  N70              READC     SFL01                                7070
011500200930     C*
011600200930     C                   DOW       *IN70 = '0' AND *IN85 = '1'
011700200930     C                   IF        ZOPT = '1'
011800200930     C* saisie correcte, on quitte la boucle
011900200930     C                   MOVEL     ZFCT          PFCT
012000200930     C                   SETOFF                                         85
012100200930     C                   END
012200200930     C* en fait c'est un peu inutile, et pour bien faire on devrait
012300200930     C* signaler à l'utilisateur si son choix est différent de '1'
012400200930     C                   MOVEL     *BLANK        ZOPT
012500200930     C                   UPDATE    SFL01                                90
012600200930     C*
012700200930     C                   READC     SFL01                                7070
012800200930     C                   ENDDO
012900200930     C                   ENDSR
013000200930     C*********************************
013100200930     C     INITSF        BEGSR
013200200930     C* initialisation de la position de la fenetre ligne6
013300200930     C                   Z-ADD     6             WINLIG
013400200930     C*                                       colonne 32
013500200930     C                   Z-ADD     32            WINCOL
013600200930     C                   Z-ADD     0             WRAN01
013700200930     C* la partie sensible de l'initialisation
013800200930     C                   SETON                                        0607
013900200930     C                   SETOFF                                       0405
014000200930     C                   WRITE     FORE1
014100200930     C                   SETOFF                                       06
014200200930     C                   SETON                                        0405
014300200930     C* lecture de tout le fichier
014400200930     C                   READ      FIFF                                   70
014500200930     C* normalement on devrait tester si WRAN01 est inférieur à 9999
014600200930     C     *IN70         DOWEQ     '0'
014700200930     C* remplissage des zones
014800200930     C                   MOVEL     MIFON         ZFCT
014900200930     C                   MOVEL     MILIB         ZLIB
015000200930     C                   ADD       1             WRAN01
015100200930     C                   WRITE     SFL01
015200200930     C                   READ      FIFF                                   70
015300200930     C                   ENDDO
015400200930     C                   EVAL      WRAN01 = 1
015500200930     C                   ENDSR
