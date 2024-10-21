      *****************************************************************
      *                                                               *
      *          I D E N T I F I C A T I O N  D I V I S I O N         *
      *                                                               *
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.        PDACTSAL.
       AUTHOR.            JOSE LUIS MARTINEZ.
       DATE-WRITTEN.      21/10/2024.

      *****************************************************************
      *                                                               *
      *             E N V I R O N M E N T  D I V I S I O N            *
      *                                                               *
      *****************************************************************
       ENVIRONMENT DIVISION.

       CONFIGURATION SECTION.
       SOURCE-COMPUTER.   IBM-3090.
       OBJECT-COMPUTER.   IBM-3090.
       SPECIAL-NAMES.
      
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      
      *****************************************************************
      *                                                               *
      *                     D A T A  D I V I S I O N                  *
      *                                                               *
      *****************************************************************
       DATA DIVISION.
       FILE SECTION.
      
      *****************************************************************
      *                      WORKING-STORAGE SECTION                  *
      *****************************************************************
       WORKING-STORAGE SECTION.
      
      *****************************************************************
      *                                                               *
      *               P R O C E D U R E  D I V I S I O N              *
      *                                                               *
      *****************************************************************
       PROCEDURE DIVISION.