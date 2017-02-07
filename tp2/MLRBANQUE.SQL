DROP TABLE IF EXISTS CarteBanquaire;

DROP TABLE IF EXISTS CompteCourant;

DROP TABLE IF EXISTS Operation;

DROP TABLE IF EXISTS CompteEpargne;

DROP TABLE IF EXISTS TypeCB;

DROP TABLE IF EXISTS Client;

DROP TABLE IF EXISTS Compte;

DROP TABLE IF EXISTS SoldeCCDebutMois;

# -----------------------------------------------------------------------------
#       TABLE : CarteBanquaire
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CarteBanquaire
 (
   numCB VARCHAR(16) NOT NULL  ,
   numClientDetenteur VARCHAR(6) NOT NULL  ,
   codeTypeCB VARCHAR(2) NOT NULL  ,
   numCCSupport VARCHAR(10) NOT NULL  ,
   dateExpiration DATE NOT NULL  
   , PRIMARY KEY (numCB) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : CompteCourant
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CompteCourant
 (
   numCompte VARCHAR(10) NOT NULL  ,
   decouvert DECIMAL(10,2) NOT NULL  ,
   dateOuverture DATE NOT NULL  ,
   depotInitial DECIMAL(10,2) NOT NULL  
   , PRIMARY KEY (numCompte) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : Operation
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Operation
 (
   codeOperation VARCHAR(30) NOT NULL  ,
   numCB VARCHAR(16)   ,
   numComptePivot VARCHAR(10) NOT NULL  ,
   dateOperation DATE NOT NULL  ,
   libelleOperation VARCHAR(32) NOT NULL  ,
   montantOperation DECIMAL(10,2) NOT NULL  ,
   typeOperation VARCHAR(32) NOT NULL  
   , PRIMARY KEY (codeOperation) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : CompteEpargne
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CompteEpargne
 (
   numCompte VARCHAR(10) NOT NULL  ,
   tauxInteret DECIMAL(4,2) NOT NULL  ,
   soldePlancher DECIMAL(10,2) NOT NULL  ,
   dateOuverture DATE NOT NULL  ,
   depotInitial DECIMAL(10,2) NOT NULL  
   , PRIMARY KEY (numCompte) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : TypeCB
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS TypeCB
 (
   codeTypeCB VARCHAR(2) NOT NULL  ,
   libelleTypeCB VARCHAR(32)   
   , PRIMARY KEY (codeTypeCB) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : Client
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Client
 (
   numClient VARCHAR(6) NOT NULL  ,
   nomClient VARCHAR(32) NOT NULL  ,
   prenomClient VARCHAR(32)   ,
   adresse VARCHAR(128) NOT NULL  ,
   numTelephone VARCHAR(10)   
   , PRIMARY KEY (numClient) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : Compte
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Compte
 (
   numCompte VARCHAR(10) NOT NULL  ,
   numClient VARCHAR(6) NOT NULL  ,
   dateOuverture DATE NOT NULL  ,
   depotInitial DECIMAL(10,2) NOT NULL  
   , PRIMARY KEY (numCompte) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : SoldeCCDebutMois
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS SoldeCCDebutMois
 (
   numCompte VARCHAR(10) NOT NULL  ,
   debutMois INTEGER NOT NULL  ,
   soldeAReporter DECIMAL(10,2)   
   , PRIMARY KEY (numCompte,debutMois) 
 ) 
 comment = "";


# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------


ALTER TABLE CarteBanquaire 
  ADD FOREIGN KEY FK_CarteBanquaire_Client (numClientDetenteur)
      REFERENCES Client (numClient) ;


ALTER TABLE CarteBanquaire 
  ADD FOREIGN KEY FK_CarteBanquaire_TypeCB (codeTypeCB)
      REFERENCES TypeCB (codeTypeCB) ;


ALTER TABLE CarteBanquaire 
  ADD FOREIGN KEY FK_CarteBanquaire_CompteCourant (numCCSupport)
      REFERENCES CompteCourant (numCompte) ;


ALTER TABLE CompteCourant 
  ADD FOREIGN KEY FK_CompteCourant_Compte (numCompte)
      REFERENCES Compte (numCompte) ;


ALTER TABLE Operation 
  ADD FOREIGN KEY FK_Operation_CarteBanquaire (numCB)
      REFERENCES CarteBanquaire (numCB) ;


ALTER TABLE Operation 
  ADD FOREIGN KEY FK_Operation_Compte (numComptePivot)
      REFERENCES Compte (numCompte) ;


ALTER TABLE CompteEpargne 
  ADD FOREIGN KEY FK_CompteEpargne_Compte (numCompte)
      REFERENCES Compte (numCompte) ;


ALTER TABLE Compte 
  ADD FOREIGN KEY FK_Compte_Client (numClient)
      REFERENCES Client (numClient) ;


ALTER TABLE SoldeCCDebutMois 
  ADD FOREIGN KEY FK_SoldeCCDebutMois_CompteCourant (numCompte)
      REFERENCES CompteCourant (numCompte) ;

