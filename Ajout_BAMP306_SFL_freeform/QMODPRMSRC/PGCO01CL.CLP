000100200930/******************************************************************************/
000200200930/*  COPIE D'UNE BIBLIOTHEQUE DANS UNE AUTRE (FICHIERS)                        */
000300200930/******************************************************************************/
000400200930             PGM        PARM(&BSRC &BDST)
000500200930
000600200930             DCL        VAR(&BSRC) TYPE(*CHAR) LEN(10)
000700200930             DCL        VAR(&BDST) TYPE(*CHAR) LEN(10)
000800200930             DCL        VAR(&CDRT) TYPE(*CHAR) LEN(1)
000900200930             DCL        VAR(&PCRT) TYPE(*CHAR) LEN(1)
001000200930             DCL        VAR(&PDLT) TYPE(*CHAR) LEN(1)
001100200930             DCL        VAR(&PLCK) TYPE(*CHAR) LEN(1)
001200200930             DCL        VAR(&PENV) TYPE(*CHAR) LEN(10)
001300200930             DCL        VAR(&PLEP) TYPE(*CHAR) LEN(10)
001400200930             DCL        VAR(&XEPU) TYPE(*CHAR) LEN(1)
001500200930             DCL        VAR(&NMPGM) TYPE(*CHAR) LEN(10)
001600200930             DCL        VAR(&NRCD) TYPE(*DEC) LEN(10 0)
001700200930  /* DECLARATION DU FICHIER                                 */
001800200930             DCLF       FILE(QSYS/QADSPOBJ) RCDFMT(QLIDOBJD)
001900200930  /* CHARGEMENT DU FICHIER                                  */
002000200930             DSPOBJD    OBJ(&BSRC/*ALL) OBJTYPE(*FILE) +
002100200930                          OUTPUT(*OUTFILE) OUTFILE(QTEMP/FTEMP)
002200200930  /* SUBSTITUTION                                          */
002300200930             OVRDBF     FILE(QADSPOBJ) TOFILE(QTEMP/FTEMP)
002400200930  /* LECTURE DU FICHIER                                    */
002500200930 LECT:       RCVF       RCDFMT(QLIDOBJD)
002600200930  /* EN FIN DE FICHIER ON TERMINE                           */
002700200930             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(CLOSE))
002800200930  /* ON NE TRAITE QUE LES FICHIERS PHYSIQUES                */
002900200930             IF         COND(&ODOBAT *NE 'PF') THEN(GOTO CMDLBL(LECT))
003000200930  /* ON VIDE LE FICHIER DESTINATION S'IL EXISTE             */
003100200930             CLRPFM     FILE(&BDST/&ODOBNM)
003200200930             MONMSG     MSGID(CPF0000)
003300200930  /* COPIE DU FICHIER SOURCE ET CREATION EVENTUELLE          */
003400200930             CPYF       FROMFILE(&BSRC/&ODOBNM) +
003500200930                          TOFILE(&BDST/&ODOBNM) MBROPT(*ADD) +
003600200930                          CRTFILE(*YES)
003700200930             MONMSG     MSGID(CPF0000)
003800200930  /* ON BOUCLE                                                */
003900200930             GOTO       CMDLBL(LECT)
004000200930CLOSE:       CLOF       OPNID(QADSPFFD)
004100200930             MONMSG CPF0000
004200200930  /* NETTOYAGE                                                */
004300200930             DLTF       FILE(QTEMP/FTEMP)
004400200930             ENDPGM
