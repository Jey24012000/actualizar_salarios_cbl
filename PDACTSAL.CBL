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
           ORGANIZATION IS LINE SEQUENTIAL
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
      *                         VARIABLES                             *
      *****************************************************************
       01  VARIABLES.
           05 RESULTADO                     PIC 9(09)V99.
           05 PORCENTAJE                    PIC 9(02) VALUE 05.

      *****************************************************************
      *                                                               *
      *               P R O C E D U R E  D I V I S I O N              *
      *                                                               *
      *****************************************************************
       PROCEDURE DIVISION.
           PERFORM 1000-INICIO
           PERFORM 2000-PROCESO
                   UNTIL WS-FIN-ENTRADA1 EQUAL 'S'
           PERFORM 3000-FINAL.
      *****************************************************************
      *                           INICIO                              *
      *****************************************************************
       1000-INICIO.
           PERFORM 1100-ABRIR-ARCHIVOS
           PERFORM 1200-LEER-ENTRADA1.

      *****************************************************************
      *                      ABRIR ARCHIVOS                           *
      *****************************************************************
       1100-ABRIR-ARCHIVOS.

           OPEN INPUT ENTRADA1
                OUTPUT SALIDA1

           IF WFS-ENTRADA1 EQUAL '00' AND
              WFS-SALIDA1 EQUAL '00'
              DISPLAY '****************************************'
              DISPLAY 'LOS ARCHIVOS SE ABRIERON CORRECTAMENTE'
              DISPLAY '****************************************'
              CONTINUE
           ELSE
              DISPLAY 'ERROR EN ARCHIVO ENTRADA1' WFS-ENTRADA1
              DISPLAY 'ERROR EN ARCHIVO SALIDA1' WFS-SALIDA1
              PERFORM 3110-FIN-PROGRAMA
           END-IF.

      *****************************************************************
      *                        LEER ENTRADA1                          *
      *****************************************************************
       1200-LEER-ENTRADA1.
           READ ENTRADA1 INTO WRE-REG-ENT1
           IF WFS-ENTRADA1 EQUAL '00'
              ADD 1             TO WA-LEIDO-ENTRADA1
           ELSE
              IF WFS-ENTRADA1 EQUAL '10'
                 MOVE 'S' TO WS-FIN-ENTRADA1
                 DISPLAY 'FIN DE LECTURA'
      *           PERFORM 1110-FIN-PROGRAMA
              END-IF
           END-IF.

      *****************************************************************
      *                          PROCESO                              *
      *****************************************************************
       2000-PROCESO.
           PERFORM 2100-MOVER-SAL
           PERFORM 2200-GRABAR-SAL
           PERFORM 1200-LEER-ENTRADA1.

      *****************************************************************
      *              MOVER VARIABLES DE ENTRADA1 A SALIDA1            *
      *****************************************************************
       2100-MOVER-SAL.
           MOVE ENT1-ID-EMP              TO SAL1-ID-EMP
           MOVE ENT1-NOMBRE              TO SAL1-NOMBRE
           COMPUTE RESULTADO = (ENT1-SALARIO * PORCENTAJE)/100 +
      -                          ENT1-SALARIO.
           MOVE RESULTADO                TO SAL1-SALARIO.

      *****************************************************************
      *                    GRABAR VARIABLES EN SALIDA1                *
      *****************************************************************
       2200-GRABAR-SAL.
           WRITE REG-SALIDA1 FROM WRE-REG-SAL1.
           IF WFS-SALIDA1 EQUAL '00'
              DISPLAY 'REGISTRO AGREGADO'
              DISPLAY '------------------'
              ADD 1                      TO WA-LEIDO-SALIDA1
              CONTINUE
           ELSE
              DISPLAY 'HUBO UN ERROR AL GRABAR EL ARCHIVO' WFS-SALIDA1
              PERFORM 3110-FIN-PROGRAMA
           END-IF.

      *****************************************************************
      *                            FINAL                              *
      *****************************************************************
       3000-FINAL.
           PERFORM 3100-CERRAR-ARCHIVOS
           PERFORM 3200-CIFRAS-CONTROL
           PERFORM 3110-FIN-PROGRAMA.

      *****************************************************************
      *                         CERRAR ARCHIVOS                       *
      *****************************************************************
       3100-CERRAR-ARCHIVOS.
           CLOSE ENTRADA1
                 SALIDA1

           IF WFS-ENTRADA1 EQUAL '00' AND
              WFS-SALIDA1 EQUAL '00'
              DISPLAY '****************************************'
              DISPLAY 'LOS ARCHIVOS SE CERRARON CORRECTAMENTE'
              DISPLAY '****************************************'
              CONTINUE
           ELSE
              DISPLAY 'ERROR AL CERRAR ARCHIVO ENTRADA1' WFS-ENTRADA1
              DISPLAY 'ERROR AL CERRAR ARCHIVO SALIDA1' WFS-SALIDA1
              PERFORM 3110-FIN-PROGRAMA
           END-IF.

       3200-CIFRAS-CONTROL.
           DISPLAY 'LEIDOS ENTRADA1 ' WA-LEIDO-ENTRADA1.
           DISPLAY 'LEIDOS SALIDA1 ' WA-LEIDO-SALIDA1.

       3110-FIN-PROGRAMA.
           STOP RUN.
