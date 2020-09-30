000100200930             CMD        PROMPT('Appel envoi message')
000200200930
000300200930             PARM       KWD(TYPE) TYPE(*CHAR) LEN(1) RANGE('1' '4') +
000400200930                          MIN(1) CHOICE('Type') PROMPT('Type de +
000500200930                          message' 1)
000600200930             PARM       KWD(FIC_MSG) TYPE(*CHAR) LEN(10) DFT(ERRMSG) +
000700200930                          MIN(0) CHOICE('Choisir') PROMPT('Fichier +
000800200930                          des messages' 1)
000900200930             PARM       KWD(MSGID) TYPE(*CHAR) LEN(7) DFT(CPF0001) +
001000200930                          MIN(0) CHOICE('ID message') PROMPT('ID du +
001100200930                          message' 1)
001200200930             PARM       KWD(TEXT) TYPE(*CHAR) LEN(99) MIN(0) +
001300200930                          CHOICE('Message') PROMPT('Valeurs +
001400200930                          complémentaires' 1)
