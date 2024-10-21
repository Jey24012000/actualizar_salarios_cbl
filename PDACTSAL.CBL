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
      *                       ARCHIVO DE ENTRADA                      *
      *****************************************************************
           SELECT ENTRADA1
           ASSIGN TO '../ENTRADA1.TXT'
           ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS WFS-ENTRADA1.

      *****************************************************************
      *                       ARCHIVO DE SALIDA                       *
      *****************************************************************
           SELECT SALIDA1
           ASSIGN TO '../SALIDA1.TXT'
           ORGANIZATION IS SEQUENTIAL
           FILE STATUS IS WFS-SALIDA1.

      *****************************************************************
      *                                                               *
      *                     D A T A  D I V I S I O N                  *
      *                                                               *
      *****************************************************************
       DATA DIVISION.
       FILE SECTION.

       FD  ENTRADA1 
           RECORDING MODE IS F
           LABEL RECORDS ARE STANDARD
           BLOCK CONTAINS 0 RECORDS
           DATA RECORD IS REG-ENTRADA1.
       01  REG-ENTRADA1                     PIC X(36).

       FD  SALIDA1 
           RECORDING MODE IS F
           LABEL RECORDS ARE STANDARD
           BLOCK CONTAINS 0 RECORDS
           DATA RECORD IS REG-SALIDA1.
       01  REG-SALIDA1                      PIC X(36).
      
      *****************************************************************
      *                      WORKING-STORAGE SECTION                  *
      *****************************************************************
       WORKING-STORAGE SECTION.

      *****************************************************************
      *                      ESTRUCTURA ENTRADA1                      *
      *****************************************************************
       01  WRE-REG-ENT1.
           05 ENT1-ID-EMP                   PIC X(05).
           05 ENT1-NOMBRE                   PIC X(20).
           05 ENT1-SALARIO                  PIC 9(09)V99.

      *****************************************************************
      *                      ESTRUCTURA SALIDA1                       *
      *****************************************************************
       01  WRE-REG-SAL1.
           05 SAL1-ID-EMP                   PIC X(05).
           05 SAL1-NOMBRE                   PIC X(20).
           05 SAL1-SALARIO                  PIC 9(09)V99.

      *****************************************************************
      *                    VARIABLES FILE STATUS                      *
      *****************************************************************
       01  W-FILE-STATUS.
           05 WFS-ENTRADA1                  PIC X(02) VALUE SPACES.
           05 WFS-SALIDA1                   PIC X(02) VALUE SPACES.
      
      *****************************************************************
      *                           SWTICHES                            *
      *****************************************************************
       01  W-SWITCHES.
           05 WS-FIN-ENTRADA1               PIC X(02) VALUE SPACES.

      *****************************************************************
      *                         ACUMULADORES                          *
      *****************************************************************
       01  W-ACUMULADOR.
           05 WA-LEIDO-ENTRADA1             PIC 9(06) VALUE ZEROES.
           05 WA-LEIDO-SALIDA1              PIC 9(06) VALUE ZEROES.
      *****************************************************************
      *                                                               *
      *               P R O C E D U R E  D I V I S I O N              *
      *                                                               *
      *****************************************************************
       PROCEDURE DIVISION.