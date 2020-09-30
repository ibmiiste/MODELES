000100200930       /Copy Qcpysrc,cpyctlstm
000200200930      //****************************************************
000300200930      //                                                   *
000400200930      // Détail personnel                                  *
000500200930      //                                                   *
000600200930      //****************************************************
000700200930      * >>PRE-COMPILER<<
000800200930      *   >>CRTCMD<<  CRTSQLRPGI SRCFILE(&SL/&SF) SRCMBR(&SM);
000900200930      *   >>IMPORTANT<<
001000200930      *     >>PARM<<  OBJ(&LI/&OB);
001100200930      *     >>PARM<<  COMMIT(*NONE);
001200200930      *     >>PARM<<  OBJTYPE(*PGM);
001300200930      *     >>PARM<<  OPTION(*EVENTF);
001400200930      *     >>PARM<<  RPGPPOPT(*LVL2);
001500200930      *     >>PARM<<  CLOSQLCSR(*ENDACTGRP);
001600200930      *     >>PARM<<  DATFMT(*ISO);
001700200930      *     >>PARM<<  TIMFMT(*ISO);
001800200930      *   >>END-IMPORTANT<<
001900200930      *   >>EXECUTE<<
002000200930      * >>END-PRE-COMPILER<<
002100200930
002200200930       dcl-f PGMF02FM workstn infds(PGM02FM_INFDS) Indds(IndDs);
002300200930
002400200930
002500200930       // External procedure Prototypes
002600200930       // Programme gérant les compteurs
002700200930       Dcl-pr compteur_double Extpgm('PGMC01');
002800200930         PCOD Char(3);
002900200930         PCPT Char(1);
003000200930         PCP1 Char(6);
003100200930         PMAT Char(10);
003200200930       End-Pr;
003300200930
003400200930       // Programme de gestion des messages et du sous-fichier de message
003500200930       Dcl-pr Gestion_message Extpgm('PGM001CL');
003600200930         PTYP Char(1);
003700200930         PFICM Char(10);
003800200930         PMGID Char(7);
003900200930         PMGDT Char(99);
004000200930       End-pr;
004100200930
004200200930       // Programme d'invite des fonctions
004300200930       Dcl-pr Invite_fonction Extpgm('PGMI01');
004400200930         PACT Char(2);
004500200930         PGFCT Char(2);
004600200930       End-pr;
004700200930
004800200930       dcl-c WTXT1 '         Modification         ';
004900200930       dcl-c WTXT2 '             Copie            ';
005000200930       dcl-c WTXT3 '         Suppression          ';
005100200930       dcl-c WTXT4 '           Affichage          ';
005200200930       dcl-c WTXT5 '           Création           ';
005300200930       dcl-c WTXT6 '        Fin de contrat        ';
005400200930       dcl-s WDAT char(8);
005500200930       dcl-s WHEU char(6);
005600200930       dcl-s W14 packed(14);
005700200930       dcl-s WNREC packed(10);
005800200930       dcl-s PACT char(2);
005900200930       dcl-s PGFCT char(3);
006000200930
006100200930       // Indicateurs utilisés dans le programme
006200200930       Dcl-s g_Confirmation_suppression Ind;
006300200930       Dcl-s g_Anomalie Ind;
006400200930       Dcl-s g_Fin_traitement Ind;
006500200930       Dcl-s g_Traitement_donnees Ind;
006600200930
006700200930       //Constante SQLCODE
006800200930       Dcl-c c_trouve 0;
006900200930       Dcl-c c_non_trouve 100;
007000200930
007100200930
007200200930       // Paramètres appel programme compteur double
007300200930       Dcl-s PCOD Char(3);
007400200930       Dcl-s PCPT Char(1);
007500200930       Dcl-s PCP1 Char(6);
007600200930       Dcl-s PMAT Char(10);
007700200930
007800200930       // Paramètres d'appel du programme de gestion des messages
007900200930       Dcl-s PTYP Char(1);
008000200930       Dcl-s PFICM Char(10);
008100200930       Dcl-s PMGID Char(7);
008200200930       Dcl-s PMGDT Char(99);
008300200930
008400200930       // Renommage des touches de fonction
008500200930       /Copy Qcpysrc,Fonction
008600200930
008700200930       // Copy de déclaration de la PROGRAM STATUS DATA STRUCTURE
008800200930       /Copy Qcpysrc,Psds
008900200930
009000200930       // Héritage de la data structure info fichier
009100200930       /Copy Qcpysrc,Cpy_infds
009200200930
009300200930       // Data structure du fichier PGM02FM
009400200930       Dcl-ds PGM02FM_INFDS likeDS(FichierDS);
009500200930
009600200930       // Le DS des indicateurs de l'écran
009700200930       Dcl-ds IndDs;
009800200930         Code_PR_UL Ind Pos(14);
009900200930         Nom_PR_UL Ind Pos(15);
010000200930         PR_UL Ind Pos(16);
010100200930         Date_entree_PR_UL Ind Pos(17);
010200200930         Date_depart_PR_UL Ind Pos(18);
010300200930         Sflinz_Msgf Ind Pos(10);
010400200930         Sflend_Msgf Ind Pos(09);
010500200930       End-ds;
010600200930
010700200930       // DS table du personnel
010800200930       Dcl-ds DS_FIC00P Extname('FIC00P') End-ds;
010900200930
011000200930       // DS table des fonction
011100200930       Dcl-ds DS_FIF00P Extname('FIF00P') End-ds;
011200200930
011300200930       Dcl-pi Personnal_detail Extpgm('PGMF02');
011400200930         Pchx Char(2);
011500200930         Pnrec Char(10);
011600200930       End-Pi;
011700200930
011800200930       // --------------------------------------------------
011900200930       // Prototype for procedure: Lecture_FIC00P
012000200930       // --------------------------------------------------
012100200930       DCL-PR Lecture_FIC00P LIKE(sqlcode);
012200200930         l_nrec PACKED(10:0);
012300200930       END-PR ;
012400200930
012500200930       // --------------------------------------------------
012600200930       // Prototype for procedure: Lecture_FIC00P_MAT
012700200930       // --------------------------------------------------
012800200930       DCL-PR Lecture_FIC00P_MAT LIKE(sqlcode);
012900200930         l_Mat PACKED(10:0);
013000200930       END-PR ;
013100200930
013200200930       // --------------------------------------------------
013300200930       // Prototype for procedure: Lecture_FIF00P
013400200930       // --------------------------------------------------
013500200930       DCL-PR Lecture_FIF00P LIKE(sqlcode);
013600200930         l_fifon CHAR(3);
013700200930       END-PR ;
013800200930
013900200930
014000200930      // début du programme
014100200930       ZPGM=PROCEDURE;
014200200930       ZDATE=%DATE();
014300200930       ZHEUR=%TIME();
014400200930       ZUSER=USER;
014500200930       ZJOB=JOB_NAME;
014600200930       WPGMQ='*  ';
014700200930       WMGKEY='CC01';
014800200930
014900200930       Sflend_Msgf = *ON;
015000200930       Sflinz_Msgf = *ON;
015100200930       Code_PR_UL = *ON;
015200200930       Nom_PR_UL = *ON;
015300200930       PR_UL = *ON;
015400200930       Date_entree_PR_UL = *ON;
015500200930       Date_depart_PR_UL = *ON;
015600200930       g_Confirmation_suppression = *OFF;
015700200930       g_Anomalie = *OFF;
015800200930       // constantes pour ce programme
015900200930       PTYP='1';
016000200930       PFICM='FICMSG    ';
016100200930
016200200930       SELECT;
016300200930       WHEN (PCHX = 'MO');
016400200930         // modification
016500200930         ZMODE=WTXT1;
016600200930      // on ne peut modifier que ces zones
016700200930         Code_PR_UL = *OFF;
016800200930         Nom_PR_UL = *OFF;
016900200930         PR_UL = *OFF;
017000200930       WHEN (PCHX = 'CO');
017100200930         // copie
017200200930         ZMODE=WTXT2;
017300200930       // toutes les zones sont autorisées
017400200930         Code_PR_UL = *OFF;
017500200930         Nom_PR_UL = *OFF;
017600200930         PR_UL = *OFF;
017700200930         Date_entree_PR_UL = *OFF;
017800200930         Date_depart_PR_UL = *OFF;
017900200930       WHEN (PCHX = 'SU');
018000200930         // suppression
018100200930         ZMODE=WTXT3;
018200200930       // aucune zone n'est saisisable
018300200930       WHEN (PCHX = 'AF');
018400200930         // affichage
018500200930         ZMODE=WTXT4;
018600200930      // aucune zone n'est saisisable
018700200930       WHEN (PCHX = 'CR');
018800200930         // création
018900200930         ZMODE=WTXT5;
019000200930      // tout est saisisable sauf date de sortie
019100200930         Code_PR_UL = *OFF;
019200200930         Nom_PR_UL = *OFF;
019300200930         PR_UL = *OFF;
019400200930         Date_entree_PR_UL = *OFF;
019500200930       WHEN (PCHX = 'PE');
019600200930         // direction Ple Emploi
019700200930         ZMODE=WTXT6;
019800200930         // on saisit simplement la date de fin
019900200930         Date_depart_PR_UL = *OFF;
020000200930       ENDSL;
020100200930       // Initialisation de l'écran si on un numéro d'enregistrement
020200200930       IF PNREC <> *BLANK;
020300200930         WNREC=%Dec(PNREC:10:0);
020400200930         sqlcode=Lecture_Fic00p(Wnrec);
020500200930
020600200930         IF PCHX = 'CR' OR PCHX = 'CO';
020700200930           // en création ou copie zone non renseignée
020800200930           ZMATR=0;
020900200930         ELSE;
021000200930           ZMATR=FIMAT;
021100200930         ENDIF;
021200200930
021300200930         ZFCOD=FIFON;
021400200930      // fichier des fonctions => libellé
021500200930         SQlcode=Lecture_FIF00P(Zfcod);
021600200930
021700200930         ZFLIB=MILIB;
021800200930         ZNOM=FINOM ;
021900200930         ZPR1=FIPR1;
022000200930         ZPR2=FIPR2;
022100200930         ZAD1=FIAD1;
022200200930         ZAD2=FIAD2;
022300200930         ZAD3=FIAD3;
022400200930         ZCPO=FICPO;
022500200930         ZVIL=FIVIL;
022600200930         ZTEL=FITEL;
022700200930         ZPOR=FIPOR;
022800200930         ZDAE=FIDAE;
022900200930
023000200930        IF PCHX = 'PE';
023100200930          ZDATE=ZDAS;
023200200930        ELSE;
023300200930          ZDAS=FIDAS;
023400200930        ENDIF;
023500200930        // zones d'audit
023600200930        ZDAC=FIDAC;
023700200930        ZHEC=FIHEC;
023800200930        ZUSC=FIUSC;
023900200930        ZDAM=FIDAM;
024000200930        ZHEM=FIHEM;
024100200930        ZUSM=FIUSM;
024200200930       ELSE;
024300200930         // pas grand chose, la date du jour
024400200930         ZDAE=%Date();
024500200930       ENDIF;
024600200930       // Boucle d'attente de fin
024700200930       g_Fin_traitement = *ON;
024800200930       DOW g_Fin_traitement = '1';
024900200930         EXSR TRTSCR;
025000200930       ENDDO;
025100200930       //
025200200930       *INLR = *ON;
025300200930       // Les procédures
025400200930       BEGSR TRTSCR;
025500200930         WRITE WMGCTL;
025600200930         // On écrit l'écran
025700200930         WRITE FORE1;
025800200930         // On attend l'appui sur une touche
025900200930         READ FORE1;
026000200930         *IN70 = %EOF;
026100200930         g_Traitement_donnees = *ON;
026200200930         // F3 ou F12 on termine
026300200930         IF Sortie OR
026400200930               Precedent;
026500200930           g_Fin_traitement = *OFF;
026600200930           g_Traitement_donnees = *OFF;
026700200930         ENDIF;
026800200930         // on met à jour l'heure
026900200930         If g_Traitement_donnees;
027000200930           ZHEUR=%Time();
027100200930         Endif;
027200200930         If Guide
027300200930         And g_Traitement_donnees;
027400200930           IF WZOCUR = 'ZFCOD';
027500200930             PACT = 'GS';
027600200930             Invite_fonction( PACT
027700200930                             :PGFCT);
027800200930             IF PGFCT <> *BLANK;
027900200930               ZFCOD =PGFCT;
028000200930             ENDIF;
028100200930           ENDIF;
028200200930           g_Traitement_donnees = *OFF;
028300200930         ENDIF;
028400200930
028500200930         //
028600200930         IF PCHX = 'SU';
028700200930           g_Traitement_donnees = *OFF;
028800200930           IF g_Confirmation_suppression = '1';
028900200930             IF Confirmer = '1';
029000200930               // touche F15 on supprime si indicateur l_Confirmation_suppression
029100200930               Sqlcode=Lecture_FIC00P(Wnrec);
029200200930               If Sqlcode=c_trouve;
029300200930                 EXEC SQL DELETE fic00p
029400200930                           WHERE RRN( fic00p) = :wnrec;
029500200930               endif;
029600200930               g_Fin_traitement = *OFF;
029700200930               g_Traitement_donnees = *OFF;
029800200930             ENDIF;
029900200930           ELSE;
030000200930             PMGID='MSG0004';
030100200930             PMGDT=*BLANK;
030200200930             EXSR ENVMSG;
030300200930             g_Confirmation_suppression = *ON;
030400200930           ENDIF;
030500200930         ENDIF;
030600200930         // contrle des données saisies
030700200930         IF g_Traitement_donnees = '1';
030800200930           EXSR CTLDTA;
030900200930           IF g_Anomalie = '1';
031000200930             // anomalie
031100200930             EXSR ENVMSG;
031200200930             g_Anomalie = *OFF;
031300200930           ELSE;
031400200930             // confirmation  pour suppression
031500200930             EXSR VALID1;
031600200930           ENDIF;
031700200930         ENDIF;
031800200930       ENDSR;
031900200930       // controle des données/si suppression demande de confirmation
032000200930       BEGSR CTLDTA;
032100200930         g_Anomalie=*Off;
032200200930         // on vérifie que tout est bon
032300200930         IF PCHX = 'SU';
032400200930           // on demande confirmation
032500200930         ELSE;
032600200930           // vérification du code fonction
032700200930           SQlcode=Lecture_FIF00P(Zfcod);
032800200930
032900200930           IF Sqlcode=c_Non_trouve;
033000200930             g_Anomalie=*Off;
033100200930             PMGID='MSG0003' ;
033200200930             PMGDT = '&1'+ ZFCOD;
033300200930             g_Anomalie=*Off;
033400200930           ENDIF;
033500200930         ENDIF;
033600200930       ENDSR;
033700200930       //** Création suppression et MJ selon le cas
033800200930       BEGSR VALID1;
033900200930         IF PCHX = 'SU';
034000200930           // La suppression se fait par la touche F15
034100200930         ELSE;
034200200930           SQlcode=Lecture_FIC00P_MAT(ZMATR);
034300200930
034400200930           IF PCHX = 'CR' OR PCHX = 'CO';
034500200930             // On ne crée le matricule qu'en copie ou création
034600200930             PCOD='MAT';
034700200930             PCPT='2';
034800200930             compteur_double( PCOD
034900200930                             :PCPT
035000200930                             :PCP1
035100200930                             :PMAT);
035200200930             FIMAT=%Int(PMAT);
035300200930             *IN71 = *ON;
035400200930           ENDIF;
035500200930
035600200930           FIFON=ZFCOD;
035700200930           FINOM=ZNOM;
035800200930           FIPR1=ZPR1;
035900200930           FIPR2=ZPR2;
036000200930           FIAD1=ZAD1;
036100200930           FIAD2=ZAD2;
036200200930           FIAD3=ZAD3;
036300200930           FICPO=ZCPO;
036400200930           FIVIL=ZVIL;
036500200930           FITEL=ZTEL;
036600200930           FIPOR=ZPOR;
036700200930           // traitement des dates
036800200930           FIDAE=ZDAE;
036900200930
037000200930           FIDAS=ZDAS;
037100200930
037200200930          // zones d'audit
037300200930          FIDAM=%Date();
037400200930          FIHEM=%Time();
037500200930          FIUSM=USER;
037600200930          IF *IN71 = '0';
037700200930            // on met  jour directement
037800200930            EXEC SQL UPDATE fic00p
037900200930                        SET fifon=:fifon,
038000200930                            finom=:finom,
038100200930                            fipr1=:fipr1,
038200200930                            fipr2=:fipr2,
038300200930                            fiad1=:fiad1,
038400200930                            fiad2=:fiad2,
038500200930                            fiad3=:fiad3,
038600200930                            ficpo=:ficpo,
038700200930                            fivil=:fivil,
038800200930                            fitel=:fitel,
038900200930                            fipor=:fipor,
039000200930                            fidae=:fidae,
039100200930                            fidas=:fidas,
039200200930                            fidam=:fidam,
039300200930                            fihem=:fihem,
039400200930                            fiusm=:fiusm
039500200930                      WHERE fimat=:zmatr;
039600200930          ELSE;
039700200930             // création
039800200930            FIDAC=%Date();
039900200930            FIHEC=%Time();
040000200930            FIUSC=USER;
040100200930            EXEC SQL INSERT INTO fic00p
040200200930                          ( fifon,
040300200930                            finom,
040400200930                            fipr1,
040500200930                            fipr2,
040600200930                            fiad1,
040700200930                            fiad2,
040800200930                            fiad3,
040900200930                            ficpo,
041000200930                            fivil,
041100200930                            fitel,
041200200930                            fipor,
041300200930                            fidae,
041400200930                            fidas,
041500200930                            fidam,
041600200930                            fihem,
041700200930                            fiusm,
041800200930                            fidac,
041900200930                            fihec,
042000200930                            fiusc,
042100200930                            fimat)
042200200930                    VALUES( :fifon,
042300200930                            :finom,
042400200930                            :fipr1,
042500200930                            :fipr2,
042600200930                            :fiad1,
042700200930                            :fiad2,
042800200930                            :fiad3,
042900200930                            :ficpo,
043000200930                            :fivil,
043100200930                            :fitel,
043200200930                            :fipor,
043300200930                            :fidae,
043400200930                            :fidas,
043500200930                            :fidam,
043600200930                            :fihem,
043700200930                            :fiusm,
043800200930                            :fidac,
043900200930                            :fihec,
044000200930                            :fiusc,
044100200930                            :fimat);
044200200930           endif;
044300200930         ENDIF;
044400200930         g_Fin_traitement = *OFF;
044500200930       ENDSR;
044600200930
044700200930       //****Envoi d'un message programme
044800200930       BEGSR ENVMSG;
044900200930         Gestion_message( PTYP
045000200930                         :PFICM
045100200930                         :PMGID
045200200930                         :PMGDT);
045300200930       ENDSR;
045400200930
045500200930
045600200930       // --------------------------------------------------
045700200930       // Procedure name: Lecture_FIC00P
045800200930       // Purpose:        Lecture d'un enregistrement de FIC00P avec comme cl...
045900200930       //                          ef le numéro relatif d'enregistrement
046000200930       // Returns:
046100200930       // Parameter:      l_nrec => Numréro relatif d'enregistrement
046200200930       // --------------------------------------------------
046300200930       DCL-PROC Lecture_FIC00P ;
046400200930         DCL-PI *N LIKE(sqlcode);
046500200930           l_nrec PACKED(10:0);
046600200930         END-PI ;
046700200930         // Your local fields go here
046800200930
046900200930         DCL-S retField LIKE(sqlcode);
047000200930         // Your calculation code goes here
047100200930         EXEC SQL SELECT fimat,
047200200930                         fifon,
047300200930                         finom,
047400200930                         fipr1,
047500200930                         fipr2,
047600200930                         fiad1,
047700200930                         fiad2,
047800200930                         fiad3,
047900200930                         ficpo,
048000200930                         fivil,
048100200930                         fitel,
048200200930                         fipor,
048300200930                         fidae,
048400200930                         fidas,
048500200930                         fidac,
048600200930                         fihec,
048700200930                         fiusc,
048800200930                         fidam,
048900200930                         fihem,
049000200930                         fiusm
049100200930                    INTO :fimat,
049200200930                         :fifon,
049300200930                         :finom,
049400200930                         :fipr1,
049500200930                         :fipr2,
049600200930                         :fiad1,
049700200930                         :fiad2,
049800200930                         :fiad3,
049900200930                         :ficpo,
050000200930                         :fivil,
050100200930                         :fitel,
050200200930                         :fipor,
050300200930                         :fidae,
050400200930                         :fidas,
050500200930                         :fidac,
050600200930                         :fihec,
050700200930                         :fiusc,
050800200930                         :fidam,
050900200930                         :fihem,
051000200930                         :fiusm
051100200930                     FROM fic00p
051200200930                    WHERE RRN( fic00p ) = :l_nrec;
051300200930
051400200930         retField=sqlcode;
051500200930
051600200930         return retField ;
051700200930       END-PROC ;
051800200930
051900200930       // --------------------------------------------------
052000200930       // Procedure name: Lecture_FIC00P
052100200930       // Purpose:        Lecture d'un enregistrement de FIC00P avec comme cl...
052200200930       //                          ef le numéro de matricule
052300200930       // Returns:
052400200930       // Parameter:      l_nrec => Numréro relatif d'enregistrement
052500200930       // --------------------------------------------------
052600200930       DCL-PROC Lecture_FIC00P_MAT ;
052700200930         DCL-PI *N LIKE(sqlcode);
052800200930           l_MAT PACKED(10:0);
052900200930         END-PI ;
053000200930         // Your local fields go here
053100200930
053200200930         DCL-S retField LIKE(sqlcode);
053300200930         // Your calculation code goes here
053400200930         EXEC SQL SELECT fimat,
053500200930                         fifon,
053600200930                         finom,
053700200930                         fipr1,
053800200930                         fipr2,
053900200930                         fiad1,
054000200930                         fiad2,
054100200930                         fiad3,
054200200930                         ficpo,
054300200930                         fivil,
054400200930                         fitel,
054500200930                         fipor,
054600200930                         fidae,
054700200930                         fidas,
054800200930                         fidac,
054900200930                         fihec,
055000200930                         fiusc,
055100200930                         fidam,
055200200930                         fihem,
055300200930                         fiusm
055400200930                    INTO :fimat,
055500200930                         :fifon,
055600200930                         :finom,
055700200930                         :fipr1,
055800200930                         :fipr2,
055900200930                         :fiad1,
056000200930                         :fiad2,
056100200930                         :fiad3,
056200200930                         :ficpo,
056300200930                         :fivil,
056400200930                         :fitel,
056500200930                         :fipor,
056600200930                         :fidae,
056700200930                         :fidas,
056800200930                         :fidac,
056900200930                         :fihec,
057000200930                         :fiusc,
057100200930                         :fidam,
057200200930                         :fihem,
057300200930                         :fiusm
057400200930                     FROM fic00p
057500200930                    WHERE fimat = :l_mat;
057600200930
057700200930         retField=sqlcode;
057800200930
057900200930         return retField ;
058000200930       END-PROC ;
058100200930
058200200930
058300200930       // --------------------------------------------------
058400200930       // Procedure name: Lecture_FIF00P
058500200930       // Purpose:        Lecture d'un enregistrement de FIF00P avec la clé FIFON
058600200930       // Returns:
058700200930       // Parameter:      l_fifon => Fonction
058800200930       // --------------------------------------------------
058900200930       DCL-PROC Lecture_FIF00P ;
059000200930         DCL-PI *N LIKE(sqlcode);
059100200930           l_fifon CHAR(3);
059200200930         END-PI ;
059300200930         // Your local fields go here
059400200930
059500200930         DCL-S retField LIKE(sqlcode);
059600200930         // Your calculation code goes here
059700200930         EXEC SQL SELECT mifon,
059800200930                         milib,
059900200930                         mitsc,
060000200930                         miusc,
060100200930                         mitsm,
060200200930                         miusm
060300200930                    INTO :mifon,
060400200930                         :milib,
060500200930                         :mitsc,
060600200930                         :miusc,
060700200930                         :mitsm,
060800200930                         :miusm
060900200930                     FROM fif00p
061000200930                    WHERE mifon = :l_fifon;
061100200930
061200200930         Retfield=Sqlcode;
061300200930         return retField ;
061400200930
061500200930       END-PROC ;
061600200930
