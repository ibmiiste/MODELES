000100200930/********************************************************************/
000200200930/* AFFICHAGE DES MESSAGES CC LE 15/01/2009                          */
000300200930/********************************************************************/
000400200930             PGM        PARM(&PTYP &PFICM &PMGID &PMGDT)
000500200930  /* DECLARATION DES VARIABLES                                      */
000600200930             DCL        VAR(&PTYP) TYPE(*CHAR) LEN(1)
000700200930             DCL        VAR(&PFICM) TYPE(*CHAR) LEN(10)
000800200930             DCL        VAR(&PMGID) TYPE(*CHAR) LEN(7)
000900200930             DCL        VAR(&PMGDT) TYPE(*CHAR) LEN(99)
001000200930  /* MESSAGE TYPE 1 = DEF = INFO                                */
001100200930             IF         COND(&PTYP = '1') THEN(DO)
001200200930             SNDPGMMSG  MSGID(&PMGID) MSGF(*LIBL/&PFICM) MSGDTA(&PMGDT)
001300200930             MONMSG     MSGID(CPF0000)
001400200930             GOTO       CMDLBL(FINI)
001500200930             ENDDO
001600200930  /* MESSAGE TYPE 2   *STATUS                                   */
001700200930             IF         COND(&PTYP = '2') THEN(DO)
001800200930             SNDPGMMSG  MSGID(&PMGID) MSGF(*LIBL/&PFICM) +
001900200930                          MSGDTA(&PMGDT) TOPGMQ(*EXT) MSGTYPE(*STATUS)
002000200930             MONMSG     MSGID(CPF0000)
002100200930             GOTO       CMDLBL(FINI)
002200200930             ENDDO
002300200930  /* NETTOYAGE VIEUX MESSAGES                                   */
002400200930             IF         COND(&PTYP = '3') THEN(DO)
002500200930             RMVMSG     PGMQ(*PRV) CLEAR(*OLD)
002600200930             MONMSG     MSGID(CPF0000)
002700200930             GOTO       CMDLBL(FINI)
002800200930             ENDDO
002900200930  /* NETTOYAGE TOTAL                                            */
003000200930             IF         COND(&PTYP = '4') THEN(DO)
003100200930             RMVMSG     PGMQ(*PRV) CLEAR(*ALL)
003200200930             MONMSG     MSGID(CPF0000)
003300200930             GOTO       CMDLBL(FINI)
003400200930             ENDDO
003500200930  /* LA FIN */
003600200930 FINI:       ENDPGM
