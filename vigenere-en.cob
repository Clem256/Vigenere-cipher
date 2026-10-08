IDENTIFICATION DIVISION.
       PROGRAM-ID. VIGENERE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

           01 CHOICE           PIC 99.
           01 INPUT-TEXT       PIC X(50) VALUE SPACES.
           01 KEY-TEXT         PIC X(50) VALUE SPACES.
           01 TEXT-TRIM        PIC X(50) VALUE SPACES.
           01 KEY-TRIM         PIC X(50) VALUE SPACES.
           01 RES              PIC X(50) VALUE SPACES.

           01 I                PIC 99 VALUE 1.
           01 K                PIC 99 VALUE 1.
           01 TEXT-LEN         PIC 99.
           01 KEY-LEN          PIC 99.
           
           01 BASE-ASCII       PIC 999 VALUE 66. 
           01 CODE-TEXT        PIC S9(3).
           01 CODE-KEY         PIC S9(3).
           01 CODE-RESULT      PIC S9(3).

           01 CHAR-TEXT        PIC X.
           01 CHAR-KEY         PIC X.
           01 CHAR-RESULT      PIC X.

       PROCEDURE DIVISION.
           DISPLAY "=== Choose encryption or decryption ==="
           DISPLAY "1. Encrypt"
           DISPLAY "2. Decrypt"
           ACCEPT CHOICE

           EVALUATE CHOICE
               WHEN 1
                   PERFORM ENCRYPT
               WHEN 2
                   PERFORM DECRYPT
               WHEN OTHER
                   DISPLAY "Error: Invalid choice"
           END-EVALUATE

           STOP RUN.

       ENCRYPT.
           DISPLAY "=== VIGENERE ENCRYPTION ==="

           DISPLAY "Enter text: "
           ACCEPT INPUT-TEXT

           DISPLAY "Enter key: "
           ACCEPT KEY-TEXT
           
           MOVE FUNCTION TRIM(INPUT-TEXT) TO TEXT-TRIM
           MOVE FUNCTION UPPER-CASE(TEXT-TRIM) TO TEXT-TRIM

           MOVE FUNCTION TRIM(KEY-TEXT) TO KEY-TRIM
           MOVE FUNCTION UPPER-CASE(KEY-TRIM) TO KEY-TRIM

           COMPUTE TEXT-LEN = FUNCTION LENGTH(FUNCTION TRIM(TEXT-TRIM))
           COMPUTE KEY-LEN = FUNCTION LENGTH(FUNCTION TRIM(KEY-TRIM))

           IF KEY-LEN = 0
               DISPLAY "Error: Key cannot be empty."
               STOP RUN
           END-IF

           MOVE SPACES TO RES
           MOVE 1 TO K

           PERFORM VARYING I FROM 1 BY 1 UNTIL I > TEXT-LEN
               MOVE TEXT-TRIM(I:1) TO CHAR-TEXT

               IF CHAR-TEXT IS ALPHABETIC
                   MOVE KEY-TRIM(K:1) TO CHAR-KEY

                   COMPUTE CODE-TEXT = FUNCTION ORD(CHAR-TEXT) - BASE-ASCII
                   COMPUTE CODE-KEY  = FUNCTION ORD(CHAR-KEY)  - BASE-ASCII
                   COMPUTE CODE-RESULT = FUNCTION MOD(CODE-TEXT + CODE-KEY, 26)
                   COMPUTE CODE-RESULT = CODE-RESULT + BASE-ASCII
                   MOVE FUNCTION CHAR(CODE-RESULT) TO CHAR-RESULT

                   MOVE CHAR-RESULT TO RES(I:1)

                   ADD 1 TO K
                   IF K > KEY-LEN THEN
                       MOVE 1 TO K
                   END-IF
               ELSE
                   MOVE CHAR-TEXT TO RES(I:1)
               END-IF
           END-PERFORM

           DISPLAY "Encrypted text : " RES(1:TEXT-LEN)
           DISPLAY "Original text  : " TEXT-TRIM(1:TEXT-LEN)
           DISPLAY "Used key       : " KEY-TRIM(1:KEY-LEN)
           GOBACK.

       DECRYPT.
           DISPLAY "=== VIGENERE DECRYPTION ==="
           DISPLAY "Enter encrypted text: "
           ACCEPT INPUT-TEXT
               
           DISPLAY "Enter key: "
           ACCEPT KEY-TEXT

           MOVE FUNCTION TRIM(INPUT-TEXT) TO TEXT-TRIM
           MOVE FUNCTION UPPER-CASE(TEXT-TRIM) TO TEXT-TRIM

           MOVE FUNCTION TRIM(KEY-TEXT) TO KEY-TRIM
           MOVE FUNCTION UPPER-CASE(KEY-TRIM) TO KEY-TRIM

           COMPUTE TEXT-LEN = FUNCTION LENGTH(FUNCTION TRIM(TEXT-TRIM))
           COMPUTE KEY-LEN = FUNCTION LENGTH(FUNCTION TRIM(KEY-TRIM))

           IF KEY-LEN = 0
               DISPLAY "Error: Key cannot be empty."
               STOP RUN
           END-IF

           MOVE SPACES TO RES
           MOVE 1 TO K

           PERFORM VARYING I FROM 1 BY 1 UNTIL I > TEXT-LEN
               MOVE TEXT-TRIM(I:1) TO CHAR-TEXT

               IF CHAR-TEXT IS ALPHABETIC
                   MOVE KEY-TRIM(K:1) TO CHAR-KEY
                   
                   COMPUTE CODE-TEXT = FUNCTION ORD(CHAR-TEXT) - BASE-ASCII
                   COMPUTE CODE-KEY  = FUNCTION ORD(CHAR-KEY)  - BASE-ASCII
                   COMPUTE CODE-RESULT = FUNCTION MOD(CODE-TEXT + 26 - CODE-KEY, 26)
                   COMPUTE CODE-RESULT = CODE-RESULT + BASE-ASCII
                   MOVE FUNCTION CHAR(CODE-RESULT) TO CHAR-RESULT

                   MOVE CHAR-RESULT TO RES(I:1)

                   ADD 1 TO K
                   IF K > KEY-LEN THEN
                       MOVE 1 TO K
                   END-IF
               ELSE
                   MOVE CHAR-TEXT TO RES(I:1)
               END-IF
           END-PERFORM

           DISPLAY "Decrypted text : " RES(1:TEXT-LEN)
           DISPLAY "Encrypted text : " TEXT-TRIM(1:TEXT-LEN)
           DISPLAY "Used key       : " KEY-TRIM(1:KEY-LEN)
           GOBACK.