000100200930/********************************************************************/
000200200930/* ROUTAGE D'UN SPOULE VERS UNE OUTQ                                */
000300200930/********************************************************************/
000400200930             PGM        PARM(&PMAT)
000500200930/* DECLARATION DES VARIABLES                                        */
000600200930             DCL        VAR(&PMAT) TYPE(*CHAR) LEN(10)
000700200930             DCL        VAR(&PUSR) TYPE(*CHAR) LEN(10)
000800200930             DCL        VAR(&PNREC) TYPE(*DEC) LEN(10)
000900200930/* LE FICHIER D'IMPRESSION                                          */
001000200930             DCLF       FILE(FIO00P) OPNID(A1)
001100200930             DCLF       FILE(QTEMP/FIO00P) OPNID(A2)
001200200930/* LE PROFIL UTILISATEUR                                            */
001300200930             RTVJOBA    USER(&PUSR)
001400200930/* METHODE PAR LECTURE DU FICHIER DES OUTQ                          */
001500200930 LECT:       RCVF       OPNID(A1)
001600200930 /* TEST SI FIN DE FICHIER DONC PAS DE ROUTAGE                      */
001700200930             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(APPEL))
001800200930             IF         COND((&PUSR = &A1_FOUSR) *AND (&A1_FODOC = +
001900200930                          'PGMF20PR')) THEN(DO)
002000200930 /* ON A TROUVE L'UTILISATEUR DANS FICHIER                          */
002100200930             OVRPRTF    FILE(PGMF20PR) TOFILE(PGMF20PR) +
002200200930                          OUTQ(*LIBL/&A1_FOOUQ)
002300200930             GOTO       CMDLBL(COPIE)
002400200930
002500200930             ENDDO
002600200930 /* PAS TROUVE ON RECOMMENCE                                        */
002700200930             GOTO       CMDLBL(LECT)
002800200930 /* AUTRE METHODE NON UTILISEE                                      */
002900200930 COPIE:      CPYF       FROMFILE(FIO00P) TOFILE(QTEMP/FIO00P) +
003000200930                          MBROPT(*REPLACE) CRTFILE(*YES) +
003100200930                          INCREL((*IF FOUSR *EQ &PUSR) (*AND FODOC +
003200200930                          *EQ 'PGMF20PR'))
003300200930             RTVMBRD    FILE(QTEMP/FIO00P) NBRCURRCD(&PNREC)
003400200930             IF         COND(&PNREC *NE 0) THEN(DO)
003500200930 /* ON A TROUVE L'UTILISATEUR DANS FICHIER                          */
003600200930             RCVF       OPNID(A2)
003700200930
003800200930             OVRPRTF    FILE(PGMF20PR) TOFILE(PGMF20PR) +
003900200930                          OUTQ(*LIBL/&A2_FOOUQ)
004000200930             ENDDO
004100200930
004200200930 APPEL:      CALL       PGM(PGMF20) PARM(&PMAT)
004300200930     ENDPGM
