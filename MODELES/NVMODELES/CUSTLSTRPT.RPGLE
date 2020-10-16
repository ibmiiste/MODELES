**Free
// -------------------------------------------------------------------------------------------------
//
// Modèle simple de l'édition d'un listing de clients
//
// -------------------------------------------------------------------------------------------------

// ---------------------------------------------------------------------------- Options de contrôles
Ctl-opt Option(*Nodebugio);

// ----------------------------------------------------------------------- Déclarations des fichiers
Dcl-f Customers Disk Usage(*Input);
Dcl-f Custlist Printer Usage(*Output) Oflind(Findepage);

// ---------------------------------------------------------------------- Déclarations des variables
Dcl-s Findepage Ind Inz(*On);

// ---------------------------------------------------------------------------- Procédure principale
Read Customers;

Dow Not %Eof(Customers);

  If Findepage;
    Write Entete;                      // Entete est un des formats du fichier Custlist
    Findepage = *Off;
  ENDIF;

  Count += 1;                          // Count est une variable définit dans le fichier Custlist
  Write Detail;                        // Detail est un des formats du fichier Custlist
  Read Customers;

ENDDO;

If Findepage;
  Write Entete;
ENDIF;
                                       // Total est un des formats du fichier Custlist
Write Total;

*Inlr = *on;
Return;

