000100200930     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000200200930     F*****************************************************
000300200930     F*                                                   *
000400200930     F* Edition simple                                    *
000500200930     F*                                                   *
000600200930     F*****************************************************
000700200930     FFIC00P    IF   E             DISK
000800200930     FQPRINT    O    F  132        PRINTER OFLIND(IN99)
000900200930     C* Listing clair et simple pas de paramètres
001000200930     C* Edition en tete
001100200930     C                   EXCEPT    ENTETE
001200200930     C* Lecture du fichier, sans aucun classement
001300200930     C                   SETOFF                                       99
001400200930     C                   READ      FIC00P                               9070
001500200930     C     *IN70         DOWEQ     '0'
001600200930     C* Edition ligne
001700200930     C                   EXCEPT    DETAIL
001800200930     C* Fin de page nouvel en tete
001900200930     C   99              EXCEPT    ENTETE
002000200930     C   99              SETOFF                                       99
002100200930     C* On boucle jusqu'à fin de fichier
002200200930     C                   READ      FIC00P                               9070
002300200930     C                   ENDDO
002400200930     C                   SETON                                        LR
002500200930     C* Le fichier de sortie d'impression
002600200930     OQPRINT    E            ENTETE      2  3
002700200930     O                                           35 'Liste du Personnel'
002800200930     O          E            ENTETE      1  1
002900200930     O                                            9 'Matricule'
003000200930     O                                           14 'Fct'
003100200930     O                                           18 'Nom'
003200200930     O                                           57 'Prénom'
003300200930     O          E            DETAIL      1
003400200930     O                       FIMAT               10
003500200930     O                       FIFON               14
003600200930     O                       FINOM               50
003700200930     O                       FIPR1               86
