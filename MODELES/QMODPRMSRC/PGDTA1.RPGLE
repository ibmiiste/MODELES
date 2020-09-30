000100200930     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000200200930     F*****************************************************
000300200930     F*                                                   *
000400200930     F* Pour test DTAARA                                  *
000500200930     F*                                                   *
000600200930     F*****************************************************
000700200930     DPSOC             S             10
000800200930     DWLIB             S             10
000900200930     DWSOC1            S           2000
001000200930     DWSOC2            S           2000
001100200930     DWSOC3            S           2000
001200200930     C* définition de la LDA, la variable contiendra la totalité de la zone
001300200930     DLDA             UDS
001400200930     DWLDA                     1   1024
001500200930     C     *ENTRY        PLIST
001600200930     C                   PARM                    PSOC
001700200930     C* déclaration des DTAARA
001800200930     C     *DTAARA       DEFINE    SOC1          WSOC1
001900200930     C     *DTAARA       DEFINE    SOC2          WSOC2
002000200930     C     *DTAARA       DEFINE    SOC3          WSOC3
002100200930     C* le fait d'avoir déclaré LDA en UDS fait la lecture
002200200930     C     *DTAARA       DEFINE    *LDA          LDA
002300200930     C* lecture et sélection
002400200930     C                   SELECT
002500200930     C                   WHEN      PSOC = 'SOC1'
002600200930     C                   IN        WSOC1
002700200930     C                   eval      WLIB = WSOC1
002800200930     C                   WHEN      PSOC = 'SOC2'
002900200930     C                   IN        WSOC2
003000200930     C                   eval      WLIB = WSOC2
003100200930     C                   WHEN      PSOC = 'SOC3'
003200200930     C                   IN        WSOC3
003300200930     C                   eval      WLIB = WSOC3
003400200930     C                   END
003500200930     C* La LDA, est écrite juste après
003600200930     C                   SETON                                        LR
