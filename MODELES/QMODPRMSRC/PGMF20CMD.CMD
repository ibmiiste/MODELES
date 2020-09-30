000100200930             CMD        PROMPT('Edition liste du personnel')
000200200930
000300200930             PARM       KWD(MATR) TYPE(*CHAR) LEN(10) +
000400200930                          RANGE('0000000001' '9999999999') MIN(0) +
000500200930                          ALWUNPRT(*NO) ALWVAR(*NO) +
000600200930                          CHOICE('Matricule ou totale') +
000700200930                          PROMPT('Edition liste du personnel' 1)
