 REM
 REM --- HEXAPAWN, for the CBM Amiga ---
 REM --- 2024 by Isaac Garcia Peveri ---
 REM --- VERSION 1.0
 REM --- Date written:  10 April 2024
 REM --- Date Compiled: 17 April 2024
 REM

winner% = 0
DefInt boxNumber: boxNumber = 0
DefStr wMove(2)

Dim SHARED strGrid$(9)
DIM SHARED gameGrid%(9)
DIM matchBox$(32)

DIM SHARED sbx1$(5)
DIM SHARED sbx2$(5)
DIM SHARED sbx3$(5)
DIM SHARED sbx4$(5)
DIM SHARED sbx5$(5)
DIM SHARED sbx6$(5)
DIM SHARED sbx7$(5)
DIM SHARED sbx8$(5)
DIM SHARED sbx9$(5)
DIM SHARED sbx10$(5)
DIM SHARED sbx11$(5)
DIM SHARED sbx12$(5)
DIM SHARED sbx13$(5)
DIM SHARED sbx14$(5)
DIM SHARED sbx15$(5)
DIM SHARED sbx16$(5)
DIM SHARED sbx17$(5)
DIM SHARED sbx18$(5)
DIM SHARED sbx19$(5)
DIM SHARED sbx20$(5)
DIM SHARED sbx21$(5)
DIM SHARED sbx22$(5)
DIM SHARED sbx23$(5)
DIM SHARED sbx24$(5)
DIM SHARED sbx25$(5)
DIM SHARED sbx26$(5)
DIM SHARED sbx27$(5)
DIM SHARED sbx28$(5)
DIM SHARED sbx29$(5)
DIM SHARED sbx30$(5)
DIM SHARED sbx31$(5)
DIM SHARED sbx32$(5)
'--------------------------------------'

'Main Logic
GOSUB InitPgm
GOSUB DrawGrid
GOSUB InitMatchBoxes
GOSUB DrawBoxes
GoSub OpenObjects
GoSub PawnCoords
GOSUB PlacePawns
GOSUB SetGrid
GoSub DrawButtonNext
GoSub DrawButtonReset
GoSub DrawBoxStatistics
'--------------------------------------'

'Main Thread
WHILE -1
   COLOR 3,0: locate 10,36: Print strGrid$
   COLOR 3,0: locate 10,20: Print "BOX: ";boxNumber

   GOSUB CheckWinner

   COLOR 2,0
   LOCATE 13,19 : ? cpuWins%
   LOCATE 17,19 : ? playerWins%

   IF winner% <> 0 THEN
      COLOR 2,0

      LOCATE 21,30: PRINT  "     GAME ENDED        "

      IF winner% = 1 THEN
         LOCATE 22,30: PRINT "      YOU WIN         "
      ELSE
          IF winner% = 2 THEN
             LOCATE 22,30: PRINT "     YOU LOST !!!         "
          END IF
      End If
   End If

Wend
'--------------------------------------'

DrawBoxStatistics:
   z1(1)=WINDOW(4)+60
   t1(1)=WINDOW(5)-50
   z2(1)=WINDOW(4)+180
   t2(1)=WINDOW(5)-34

   LINE (z1(1),t1(1))-(z2(1),t2(1)),1,b
   COLOR 1,0
   LOCATE 13,9
   PRINT "CPU WINS: "

   p1(1)=WINDOW(4)+60
   q1(1)=WINDOW(5)+13
   p2(1)=WINDOW(4)+180
   q2(1)=WINDOW(5)+29

   LINE (p1(1),q1(1))-(p2(1),q2(1)),1,b
   COLOR 1,0
   LOCATE 17,9
   PRINT "PLY WINS: "

RETURN
'--------------------------------------'

DrawButtonNext:
   x1(1)=WINDOW(4)+444
   y1(1)=WINDOW(5)+24
   x2(1)=WINDOW(4)+565
   y2(1)=WINDOW(5)+36

   LINE (x1(1),y1(1))-(x2(1),y2(1)),1,bf
   COLOR 0,1
   LOCATE 13,59
   PRINT "Next Round"

RETURN
'--------------------------------------'

DrawButtonReset:
   a1(1)=WINDOW(4)+444
   b1(1)=WINDOW(5)+15
   a2(1)=WINDOW(4)+565
   b2(1)=WINDOW(5)+27

   LINE (a1(1),b1(1))-(a2(1),b2(1)),1,bf
   COLOR 0,1
   LOCATE 17,59
   PRINT "Reset Game"

RETURN
'--------------------------------------'

InitMatchBoxes:
   matchBox$(0)  = "222100011"
   matchBox$(1)  = "222010101"
   matchBox$(2)  = "202210001"
   matchBox$(3)  = "022120001"
   matchBox$(4)  = "202110010"
   matchBox$(5)  = "220101001"
   matchBox$(6)  = "022021100"
   matchBox$(7)  = "022211100"
   matchBox$(8)  = "202201010"
   matchBox$(9)  = "220112001"
   matchBox$(10) = "022010001"
   matchBox$(11) = "022010100"
   matchBox$(12) = "202100001"
   matchBox$(13) = "002221000"
   matchBox$(14) = "200111000"
   matchBox$(15) = "020211000"
   matchBox$(16) = "020112000"
   matchBox$(17) = "200221000"
   matchBox$(18) = "002122000"
   matchBox$(19) = "002210000"
   matchBox$(20) = "020120000"
   matchBox$(21) = "020012000"
   matchBox$(22) = "200210000"
   matchBox$(23) = "002012000"
   matchBox$(24) = "222001110"
   matchBox$(25) = "022210110"
   matchBox$(26) = "202001100"
   matchBox$(27) = "202102010"
   matchBox$(28) = "202012100"
   matchBox$(29) = "022101100"
   matchBox$(30) = "200122000"
   matchBox$(31) = "020021000"

   sbx1$(0) = "c"
   sbx1$(1) = "y"
   sbx1$(2) = "m"
   sbx1$(3) = " "
   sbx1$(4) = " "

   sbx2$(0) = "c"
   sbx2$(1) = "y"
   sbx2$(2) = " "
   sbx2$(3) = " "
   sbx2$(4) = " "

   sbx3$(0) = "c"
   sbx3$(1) = "y"
   sbx3$(2) = "m"
   sbx3$(3) = "k"
   sbx3$(4) = " "

   sbx4$(0) = "c"
   sbx4$(1) = "y"
   sbx4$(2) = "m"
   sbx4$(3) = "k"
   sbx4$(4) = " "

   sbx5$(0) = "c"
   sbx5$(1) = "y"
   sbx5$(2) = "m"
   sbx5$(3) = " "
   sbx5$(4) = " "

   sbx6$(0) = "c"
   sbx6$(1) = "y"
   sbx6$(2) = "m"
   sbx6$(3) = " "
   sbx6$(4) = " "

   sbx7$(0) = "c"
   sbx7$(1) = "y"
   sbx7$(2) = "m"
   sbx7$(3) = " "
   sbx7$(4) = " "

   sbx8$(0) = "c"
   sbx8$(1) = "y"
   sbx8$(2) = " "
   sbx8$(3) = " "
   sbx8$(4) = " "

   sbx9$(0) = "c"
   sbx9$(1) = "y"
   sbx9$(2) = " "
   sbx9$(3) = " "
   sbx9$(4) = " "

   sbx10$(0) = "c"
   sbx10$(1) = "y"
   sbx10$(2) = " "
   sbx10$(3) = " "
   sbx10$(4) = " "

   sbx11$(0) = "c"
   sbx11$(1) = "y"
   sbx11$(2) = " "
   sbx11$(3) = " "
   sbx11$(4) = " "

   sbx12$(0) = "c"
   sbx12$(1) = "y"
   sbx12$(2) = " "
   sbx12$(3) = " "
   sbx12$(4) = " "

   sbx13$(0) = "c"
   sbx13$(1) = " "
   sbx13$(2) = " "
   sbx13$(3) = " "
   sbx13$(4) = " "

   sbx14$(0) = "c"
   sbx14$(1) = "y"
   sbx14$(2) = " "
   sbx14$(3) = " "
   sbx14$(4) = " "

   sbx15$(0) = "c"
   sbx15$(1) = " "
   sbx15$(2) = " "
   sbx15$(3) = " "
   sbx15$(4) = " "

   sbx16$(0) = "c"
   sbx16$(1) = "y"
   sbx16$(2) = " "
   sbx16$(3) = " "
   sbx16$(4) = " "

   sbx17$(0) = "c"
   sbx17$(1) = "y"
   sbx17$(2) = " "
   sbx17$(3) = " "
   sbx17$(4) = " "

   sbx18$(0) = "c"
   sbx18$(1) = "y"
   sbx18$(2) = " "
   sbx18$(3) = " "
   sbx18$(4) = " "

   sbx19$(0) = "c"
   sbx19$(1) = "y"
   sbx19$(2) = " "
   sbx19$(3) = " "
   sbx19$(4) = " "

   sbx20$(0) = "c"
   sbx20$(1) = "y"
   sbx20$(2) = "m"
   sbx20$(3) = " "
   sbx20$(4) = " "

   sbx21$(0) = "c"
   sbx21$(1) = "y"
   sbx21$(2) = " "
   sbx21$(3) = " "
   sbx21$(4) = " "

   sbx22$(0) = "c"
   sbx22$(1) = "y"
   sbx22$(2) = " "
   sbx22$(3) = " "
   sbx22$(4) = " "

   sbx23$(0) = "c"
   sbx23$(1) = "y"
   sbx23$(2) = " "
   sbx23$(3) = " "
   sbx23$(4) = " "

   sbx24$(0) = "c"
   sbx24$(1) = "y"
   sbx24$(2) = " "
   sbx24$(3) = " "
   sbx24$(4) = " "

   sbx25$(0) = "c"
   sbx25$(1) = "y"
   sbx25$(2) = "m"
   sbx25$(3) = " "
   sbx25$(4) = " "

   sbx26$(0) = "c"
   sbx26$(1) = "y"
   sbx26$(2) = " "
   sbx26$(3) = " "
   sbx26$(4) = " "

   sbx27$(0) = "c"
   sbx27$(1) = " "
   sbx27$(2) = " "
   sbx27$(3) = " "
   sbx27$(4) = " "

   sbx28$(0) = "c"
   sbx28$(1) = "y"
   sbx28$(2) = "m"
   sbx28$(3) = "k"
   sbx28$(4) = " "

   sbx29$(0) = "c"
   sbx29$(1) = "y"
   sbx29$(2) = " "
   sbx29$(3) = " "
   sbx29$(4) = " "

   sbx30$(0) = "c"
   sbx30$(1) = "y"
   sbx30$(2) = "m"
   sbx30$(3) = " "
   sbx30$(4) = " "

   sbx31$(0) = "c"
   sbx31$(1) = "y"
   sbx31$(2) = " "
   sbx31$(3) = " "
   sbx31$(4) = " "

   sbx32$(0) = "c"
   sbx32$(1) = " "
   sbx32$(2) = " "
   sbx32$(3) = " "
   sbx32$(4) = " "

RETURN
'--------------------------------------'

DrawGrid:
   b1(1)=WINDOW(4)+226
   b2(1)=WINDOW(5)+13
   c1(1)=WINDOW(4)+395
   c2(1)=WINDOW(5)+(29*3)-2
   LINE (b1(1),b2(1))-(c1(1),c2(1)),2,B

   l1(1)=b1(1)
   l2(1)=WINDOW(5)+(13*3)-1
   e1(1)=WINDOW(4)+395
   e2(1)=WINDOW(5)+29*3
   LINE (l1(1),l2(1))-(e1(1),e2(1)),2,B

   s1(1)=b1(1)
   s2(1)=WINDOW(5)+(13*5)-4
   d1(1)=WINDOW(4)+395
   d2(1)=WINDOW(5)+(29*3)
   LINE (s1(1),s2(1))-(d1(1),d2(1)),2,B

   v1(1)=b1(1)
   v2(1)=WINDOW(5)+13
   ve1(1)=WINDOW(4)+283
   ve2(1)=WINDOW(5)+87
   LINE (v1(1),v2(1))-(ve1(1),ve2(1)),2,B

   v1(1)=b1(1)
   v2(1)=WINDOW(5)+13
   ve1(1)=WINDOW(4)+338
   ve2(1)=WINDOW(5)+87
   LINE (v1(1),v2(1))-(ve1(1),ve2(1)),2,B

RETURN
'--------------------------------------'

DrawBoxes:
   x11(1)=WINDOW(4)+230
   y11(1)=WINDOW(5)+15
   x21(1)=WINDOW(4)+280
   y21(1)=WINDOW(5)+36
   LINE (x11(1),y11(1))-(x21(1),y21(1)),2,BF

   x12(1)=x11(1)+55
   y12(1)=y11(1)
   x22(1)=x21(1)+55
   y22(1)=y21(1)
   LINE (x12(1),y12(1))-(x22(1),y22(1)),1,BF

   x13(1)=x12(1)+55
   y13(1)=y12(1)
   x23(1)=x22(1)+55
   y23(1)=y22(1)
   LINE (x13(1),y13(1))-(x23(1),y23(1)),2,BF

   x14(1)=x11(1)
   y14(1)=y11(1)+24
   x24(1)=x21(1)
   y24(1)=y21(1)+24
   LINE (x14(1),y14(1))-(x24(1),y24(1)),1,BF

   x15(1)=x14(1)+55
   y15(1)=y14(1)
   x25(1)=x24(1)+55
   y25(1)=y24(1)
   LINE (x15(1),y15(1))-(x25(1),y25(1)),2,BF

   x16(1)=x15(1)+55
   y16(1)=y15(1)
   x26(1)=x25(1)+55
   y26(1)=y25(1)
   LINE (x16(1),y16(1))-(x26(1),y26(1)),1,BF

   x17(1)=x14(1)
   y17(1)=y14(1)+24
   x27(1)=x24(1)
   y27(1)=y24(1)+24
   LINE (x17(1),y17(1))-(x27(1),y27(1)),2,BF

   x18(1)=x17(1)+55
   y18(1)=y17(1)
   x28(1)=x27(1)+55
   y28(1)=y27(1)
   LINE (x18(1),y18(1))-(x28(1),y28(1)),1,BF

   x19(1)=x18(1)+55
   y19(1)=y18(1)
   x29(1)=x28(1)+55
   y29(1)=y28(1)
   LINE (x19(1),y19(1))-(x29(1),y29(1)),2,BF

RETURN
'--------------------------------------'

OpenObjects:
  OPEN "ball"  FOR INPUT AS 1
  OPEN "ball2" FOR INPUT AS 11

  OBJECT.SHAPE 1,INPUT$(LOF(1),1)
  OBJECT.SHAPE 11,INPUT$(LOF(1),11)

  CLOSE 1
  CLOSE 11

Return
'--------------------------------------'

PawnCoords:
  OBJECT.X 1,WINDOW(4)+245 : OBJECT.X 11,WINDOW(4)+245
  OBJECT.Y 1,92            : OBJECT.Y 11,92

  OBJECT.SHAPE 2, 1        : OBJECT.SHAPE 12, 11
  OBJECT.X 2,WINDOW(4)+300 : OBJECT.X 12,WINDOW(4)+300
  OBJECT.Y 2,92            : OBJECT.Y 12,92

  OBJECT.SHAPE 3, 1        : OBJECT.SHAPE 13, 11
  OBJECT.X 3,WINDOW(4)+355 : OBJECT.X 13,WINDOW(4)+355
  OBJECT.Y 3,92            : OBJECT.Y 13,92

  OBJECT.SHAPE 4, 1        : OBJECT.SHAPE 14, 11
  OBJECT.X 4,WINDOW(4)+245 : OBJECT.X 14,WINDOW(4)+245
  OBJECT.Y 4,115           : OBJECT.Y 14,115

  OBJECT.SHAPE 5, 1        : OBJECT.SHAPE 15, 11
  OBJECT.X 5,WINDOW(4)+300 : OBJECT.X 15,WINDOW(4)+300
  OBJECT.Y 5,115           : OBJECT.Y 15,115

  OBJECT.SHAPE 6, 1        : OBJECT.SHAPE 16, 11
  OBJECT.X 6,WINDOW(4)+355 : OBJECT.X 16,WINDOW(4)+355
  OBJECT.Y 6,115           : OBJECT.Y 16,115

  OBJECT.SHAPE 7, 1        : OBJECT.SHAPE 17, 11
  OBJECT.X 7,WINDOW(4)+245 : OBJECT.X 17,WINDOW(4)+245
  OBJECT.Y 7,141           : OBJECT.Y 17,141

  OBJECT.SHAPE 8, 1        : OBJECT.SHAPE 18, 11
  OBJECT.X 8,WINDOW(4)+300 : OBJECT.X 18,WINDOW(4)+300
  OBJECT.Y 8,141           : OBJECT.Y 18,141

  OBJECT.SHAPE 9, 1        : OBJECT.SHAPE 19, 11
  OBJECT.X 9,WINDOW(4)+355 : OBJECT.X 19,WINDOW(4)+355
  OBJECT.Y 9,141           : OBJECT.Y 19,141

Return
'--------------------------------------'

PlacePawns:
  OBJECT.ON  1             : OBJECT.OFF 11
  OBJECT.ON  2             : OBJECT.OFF 12
  OBJECT.ON  3             : OBJECT.OFF 13
  OBJECT.OFF 4             : OBJECT.OFF 14
  OBJECT.OFF 5             : OBJECT.OFF 15
  OBJECT.OFF 6             : OBJECT.OFF 16
  OBJECT.OFF 7             : OBJECT.ON 17
  OBJECT.OFF 8             : OBJECT.ON 18
  OBJECT.OFF 9             : OBJECT.ON 19

  gameGrid%(0) = 2
  gameGrid%(1) = 2
  gameGrid%(2) = 2
  gameGrid%(3) = 0
  gameGrid%(4) = 0
  gameGrid%(5) = 0
  gameGrid%(6) = 1
  gameGrid%(7) = 1
  gameGrid%(8) = 1

RETURN
'--------------------------------------'

setGrid:
   strGrid$ = ""

   FOR idx = 0 TO 8
      strGrid$ = strGrid$ + MID$(STR$(gameGrid%(idx)),2,1)
   NEXT

RETURN
'--------------------------------------'

OnMouseDownEvent:
  While MOUSE(0)<>0

    mouseX=MOUSE(1)
    mouseY=MOUSE(2)

    If mouseX > x11(1) AND mouseX < x21(1) THEN
      IF mouseY > y11(1) AND mouseY < y21(1) Then
         cell$ = "a1"
      End if
    End If

    If mouseX > x12(1) AND mouseX < x22(1) THEN
      IF mouseY > y12(1) AND mouseY < y22(1) Then
         cell$ = "a2"
      End if
    End If

    If mouseX > x13(1) AND mouseX < x23(1) THEN
      IF mouseY > y13(1) AND mouseY < y23(1) Then
         cell$ = "a3"
      End if
    End If

    If mouseX > x14(1) AND mouseX < x24(1) THEN
      IF mouseY > y14(1) AND mouseY < y24(1) THEN
         cell$ = "b1"
      End if
    End If

    If mouseX > x15(1) AND mouseX < x25(1) THEN
      IF mouseY > y15(1) AND mouseY < y25(1) Then
         cell$ = "b2"
      End if
    End If

    If mouseX > x16(1) AND mouseX < x26(1) THEN
      IF mouseY > y16(1) AND mouseY < y26(1) Then
         cell$ = "b3"
      End if
    End If

    If mouseX > x17(1) AND mouseX < x27(1) THEN
      IF mouseY > y17(1) AND mouseY < y27(1) Then
         cell$ = "c1"
      End if
    End If

    If mouseX > x18(1) AND mouseX < x28(1) THEN
      IF mouseY > y18(1) AND mouseY < y28(1) THEN
         cell$ = "c2"
      End if
    End If

    If mouseX > x19(1) AND mouseX < x29(1) THEN
      IF mouseY > y19(1) AND mouseY < y29(1) THEN
         cell$ = "c3"
      End if
    End If

    If wMove(0) = "" Then
        wMove(0) = cell$
    Else
        wMove(1) = cell$
    End If

    'button Next Round
    IF mouseX > x1(1) AND mouseX < x2(1) THEN
      IF mouseY > y1(1) AND mouseY < y2(1) THEN
        If winner% <> 0 Then
          IF winner% = 1 THEN
             GOSUB RemoveSphere
             playerWins% = playerWins% + 1
          END If

          If winner% = 2 Then
              cpuWins% = cpuWins% + 1
          End If

          GOSUB PlacePawns
          GOSUB SetGrid
          GOSUB ClearMsg
        End If

        boxNumber = 0: pBox = 0: sphereNum% = 0: winner% = 0
      END IF
    END If

    'button Reset Game
    IF mouseX > a1(1) AND mouseX < a2(1) THEN
      IF mouseY > b1(1) AND mouseY < b2(1) THEN
         winner% = 0
         boxNumber = 0: pBox = 0: sphereNum% = 0
         GoSub InitMatchBoxes
         GoSub PlacePawns
         GoSub SetGrid
         GoSub ClearMsg
         cell$ = "": wMove(0) = "": wMove(1) = "": boxNumber = 0: pBox = 0
         cpuWins% = 0: playerWins% = 0: sphereNum% = 0
         COLOR 3,0: locate 10,50: Print "SPHERE: ";sphereNum%
      END IF
    END If

  Wend

  GoSub PerformPlayerMove

Return
'--------------------------------------'

PerformPlayerMove:
    If winner% = 0 Then
       If wMove(0) = "b1" And wMove(1) = "a2" Then
          IF gameGrid%(3) = 1 AND gameGrid%(1) = 2 THEN
             OBJECT.OFF 14
             OBJECT.OFF 4
             OBJECT.OFF 2
             OBJECT.ON  12
             gameGrid%(3) = 0
             gameGrid%(1) = 1
             GOSUB SetGrid
             GOSUB CpuMove
          END IF
       End If

       If wMove(0) = "b3" And wMove(1) = "a2" Then
          IF gameGrid%(5) = 1 AND gameGrid%(1) = 2 THEN
             OBJECT.OFF 2
             OBJECT.ON  12
             OBJECT.OFF 16
             OBJECT.OFF 6
             gameGrid%(2) = 1
             gameGrid%(5) = 0
             GOSUB SetGrid
             GOSUB CpuMove
          END IF
       End If

       If wMove(0) = "b3" And wMove(1) = "a3" Then
          IF gameGrid%(5) = 1 AND gameGrid%(2) = 0 THEN
             OBJECT.OFF 6
             OBJECT.ON  13
             OBJECT.OFF 16
             OBJECT.OFF 6
             gameGrid%(0) = 1
             gameGrid%(5) = 0
             GOSUB SetGrid
             GOSUB CpuMove
          END IF
       End If

       If wMove(0) = "b2" And wMove(1) = "a1" Then
          IF gameGrid%(0) = 2 AND gameGrid%(4) = 1 THEN
             OBJECT.OFF 1
             OBJECT.ON  11
             OBJECT.OFF 15
             OBJECT.OFF 5
             gameGrid%(0) = 1
             gameGrid%(4) = 0
             GOSUB SetGrid
             GOSUB CpuMove
          END IF
       End If

       If wMove(0) = "b1" And wMove(1) = "a1" Then
          IF gameGrid%(0) = 0 AND gameGrid%(3) = 1 THEN
             OBJECT.OFF 1
             OBJECT.ON  11
             OBJECT.OFF 14
             OBJECT.OFF 4
             gameGrid%(0) = 1
             gameGrid%(3) = 0
             GOSUB SetGrid
             GOSUB CpuMove
          END IF
       End IF

       If wMove(0) = "c2" And wMove(1) = "b2" Then
          IF gameGrid%(7) = 1 AND gameGrid%(4) = 0
              OBJECT.OFF 8
              OBJECT.OFF 5
              OBJECT.OFF 18
              OBJECT.ON  15
              gameGrid%(7) = 0
              gameGrid%(4) = 1
              GOSUB SetGrid
              GOSUB CpuMove
          End If
       End If

       If wMove(0) = "b2" And wMove(1) = "a1" Then
          IF gameGrid%(4) = 1 AND gameGrid%(1) = 0
              OBJECT.OFF 5
              OBJECT.OFF 15
              OBJECT.OFF 2
              OBJECT.ON  12
              gameGrid%(4) = 0
              gameGrid%(1) = 1
              GOSUB SetGrid
              GOSUB CpuMove
          END IF
       End IF

       If wMove(0) = "c2" And wMove(1) = "a3" Then
          If gameGrid%(4) = 1 And gameGrid%(2) = 2 Then
             OBJECT.OFF 3
             OBJECT.OFF 15
             OBJECT.OFF 5
             OBJECT.ON  13
             gameGrid%(4) = 0
             gameGrid%(2) = 1
             GOSUB SetGrid
             GOSUB CpuMove
          End If
       End If

       If wMove(0) = "b2" And wMove(1) = "a3" Then
          If gameGrid%(4) = 1 And gameGrid%(2) = 2 Then
             OBJECT.OFF 3
             OBJECT.OFF 15
             OBJECT.OFF 5
             OBJECT.ON  13
             gameGrid%(4) = 0
             gameGrid%(2) = 1
             GOSUB SetGrid
             GOSUB CpuMove
          End If
       End IF

       If wMove(0) = "c1" And wMove(1) = "b1" Then
          IF gameGrid%(6) = 1 AND gameGrid%(3) = 0 THEN
             OBJECT.OFF 4
             OBJECT.OFF 7
             OBJECT.OFF 17
             OBJECT.ON  14
             gameGrid%(3) = 1
             gameGrid%(6) = 0
             GOSUB SetGrid
             GOSUB CpuMove
          END IF
       END IF

       If wMove(0) = "c1" And wMove(1) = "b2" Then
          IF gameGrid%(4) = 2 AND gameGrid%(6) = 1 THEN
             OBJECT.OFF 5
             OBJECT.ON 15
             OBJECT.OFF 7
             OBJECT.OFF 17
             gameGrid%(4) = 1
             gameGrid%(6) = 0
             GOSUB SetGrid
             GOSUB CpuMove
          END IF
       END If

       If wMove(0) = "c2" And wMove(1) = "b1" Then
          IF gameGrid%(7) = 1 AND gameGrid%(3) = 2 THEN
             OBJECT.OFF 4
             OBJECT.OFF 18
             OBJECT.OFF 8
             OBJECT.ON  14
             gameGrid%(7) = 0
             gameGrid%(3) = 1
             GOSUB SetGrid
             GOSUB CpuMove
          END IF
       END If

       If wMove(0) = "b2" And wMove(1) = "a1" Then
          IF gameGrid%(3) = 1 AND gameGrid%(1) = 2 THEN
             OBJECT.OFF 4
             OBJECT.OFF 14
             OBJECT.OFF 2
             OBJECT.ON  12
             gameGrid%(3) = 0
             gameGrid%(1) = 1
             GOSUB SetGrid
             GOSUB CpuMove
          END IF
       End IF

       If wMove(0) = "b2" And wMove(1) = "a2" Then
          IF gameGrid%(1) = 0 AND gameGrid%(4) = 1 THEN
             gameGrid%(4) = 0
             gameGrid%(1) = 1
             OBJECT.OFF 2
             OBJECT.ON 12
             OBJECT.OFF 15
             OBJECT.OFF 5
             GOSUB SetGrid
             GOSUB CpuMove
          END IF
       End If

       If wMove(0) = "c2" And wMove(1) = "b1" Then
          IF gameGrid%(7) = 1 AND gameGrid%(4) = 0 THEN
             gameGrid%(4) = 1
             gameGrid%(7) = 0
             OBJECT.OFF 5
             OBJECT.ON 15
             OBJECT.OFF 18
             OBJECT.OFF 8
             GOSUB SetGrid
             GOSUB CpuMove
          END IF
       End If

       If wMove(0) = "b2" And wMove(1) = "a3" Then
          IF gameGrid%(4) = 1 AND gameGrid%(2)
             gameGrid%(4) = 0
             gameGrid%(2) = 1
             OBJECT.OFF 15
             OBJECT.ON 13
             OBJECT.OFF 5
             OBJECT.OFF 3
             GOSUB SetGrid
             GOSUB CpuMove
          END IF
       END IF

       If wMove(0) = "c1" And wMove(1) = "b2" Then
          IF gameGrid%(4) = 2 AND gameGrid%(6) = 1 THEN
             OBJECT.OFF 7
             OBJECT.OFF 17
             OBJECT.ON  15
             OBJECT.OFF 5
             gameGrid%(6) = 0
             gameGrid%(4) = 1
             GOSUB SetGrid
             GOSUB CpuMove
          END IF
       END IF

       If wMove(0) = "c3" And wMove(1) = "b2" Then
          IF gameGrid%(8) = 1 AND gameGrid%(4) = 2 THEN
             OBJECT.ON 15
             OBJECT.OFF 5
             OBJECT.OFF 19
             OBJECT.OFF 9
             gameGrid%(4) = 1
             gameGrid%(8) = 0
             GOSUB SetGrid
             GOSUB CpuMove
          END IF
       END If

       If wMove(0) = "c3" And wMove(1) = "b3" Then
          IF gameGrid%(8) = 1 AND gameGrid%(5) = 0 THEN
             OBJECT.ON 16
             OBJECT.OFF 6
             OBJECT.OFF 19
             OBJECT.OFF 9
             gameGrid%(5) = 1
             gameGrid%(8) = 0
             GOSUB SetGrid
             GOSUB CpuMove
          END IF
       End If

       If wMove(0) = "c2" And wMove(1) = "b2" Then
          IF gameGrid%(6) = 1 AND gameGrid%(4) = 0 THEN
             gameGrid%(6) = 0
             gameGrid%(4) = 1
             OBJECT.OFF 8
             OBJECT.OFF 18
             OBJECT.OFF 5
             OBJECT.ON 5
             GOSUB SetGrid
             GOSUB CpuMove
          END IF
       End If

       If wMove(0) = "c2" And wMove(1) = "b3" Then
          IF gameGrid%(7) = 1 AND gameGrid%(5) = 2 THEN
             gameGrid%(7) = 0
             gameGrid%(5) = 1
             OBJECT.OFF 6
             OBJECT.OFF 18
             OBJECT.OFF 8
             OBJECT.ON 16
             GOSUB SetGrid
             GOSUB CpuMove
          END IF
       END If
    End If

    wMove(0) = "": wMove(1) = "": cell$ = ""

Return
'--------------------------------------'

ClearMsg:
   COLOR 1,0
   LOCATE 21,5: Print "                                                    "
   LOCATE 22,5: Print "                                                    "

Return
'--------------------------------------'

CpuMove:
   IF strGrid$ = matchBox$(0) Then
      boxNumber = 1
   END IF

   IF strGrid$ = matchBox$(1) THEN
      boxNumber = 2
   END IF

   IF strGrid$ = matchBox$(2) THEN
      boxNumber = 3
   END IF

   IF strGrid$ = matchBox$(3) THEN
      boxNumber = 4
   END IF

   IF strGrid$ = matchBox$(4) THEN
      boxNumber = 5
   END IF

   IF strGrid$ = matchBox$(5) THEN
      boxNumber = 6
   END IF

   IF strGrid$ = matchBox$(6) THEN
      boxNumber = 7
   END IF

   IF strGrid$ = matchBox$(7) THEN
      boxNumber = 8
   END IF

   IF strGrid$ = matchBox$(8) THEN
      boxNumber = 9
   END IF

   IF strGrid$ = matchBox$(9) THEN
      boxNumber = 10
   END IF

   IF strGrid$ = matchBox$(10) THEN
      boxNumber = 11
   END IF

   IF strGrid$ = matchBox$(11) THEN
      boxNumber = 12
   END IF

   IF strGrid$ = matchBox$(12) THEN
      boxNumber = 13
   END IF

   IF strGrid$ = matchBox$(13) THEN
      boxNumber = 14
   END IF

   IF strGrid$ = matchBox$(14) THEN
      boxNumber = 15
   END IF

   IF strGrid$ = matchBox$(15) THEN
      boxNumber = 16
   END IF

   IF strGrid$ = matchBox$(16) THEN
      boxNumber = 17
   END IF

   IF strGrid$ = matchBox$(17) THEN
      boxNumber = 18
   END IF

   IF strGrid$ = matchBox$(18) THEN
      boxNumber = 19
   END IF

   IF strGrid$ = matchBox$(19) THEN
      boxNumber = 20
   END IF

   IF strGrid$ = matchBox$(20) THEN
      boxNumber = 21
   END IF

   IF strGrid$ = matchBox$(21) THEN
      boxNumber = 22
   END IF

   IF strGrid$ = matchBox$(22) THEN
      boxNumber = 23
   END IF

   IF strGrid$ = matchBox$(23) THEN
      boxNumber = 24
   END If

   IF strGrid$ = matchBox$(24) THEN
      boxNumber = 25
   END If

   IF strGrid$ = matchBox$(25) THEN
      boxNumber = 26
   END If

   IF strGrid$ = matchBox$(26) THEN
      boxNumber = 27
   END If

   IF strGrid$ = matchBox$(27) THEN
      boxNumber = 28
   END If

   IF strGrid$ = matchBox$(28) THEN
      boxNumber = 29
   END If

   IF strGrid$ = matchBox$(29) THEN
      boxNumber = 30
   END If

   IF strGrid$ = matchBox$(30) THEN
      boxNumber = 31
   END If

   IF strGrid$ = matchBox$(31) THEN
      boxNumber = 32
   END If

   CALL ExtractSphere(boxNumber)
   GOSUB SetGrid

RETURN
'--------------------------------------'

InitPgm:
  COLOR 1
  LOCATE 3,28
  PRINT "      HEXAPAWN  1.0       "

  LOCATE 4,28
  PRINT "2024 ISAAC GARCIA PEVERI"

  COLOR 2,3
  LOCATE 6,24
  PRINT " Youtube Channel: IGP Tech Blog "

  COLOR 1,0
  LOCATE 8,28
  PRINT "   use Mouse to play!"

  ON MOUSE GOSUB OnMouseDownEvent
  MOUSE ON

RETURN
'--------------------------------------'

CheckWinner:
    winner% = 0

    IF gameGrid%(0) = 1 Or gameGrid%(1) = 1 Or gameGrid%(2) = 1 Then
       winner% = 1
    End If

    If gameGrid%(6) = 2 Or gameGrid%(7) = 2 Or gameGrid%(8) = 2 THEN
       winner% = 2
    End If

    isWhitePawnFound% = 0

    If gameGrid%(0) = 1 _
    Or gameGrid%(1) = 1 _
    Or gameGrid%(2) = 1 _
    Or gameGrid%(3) = 1 _
    Or gameGrid%(4) = 1 _
    Or gameGrid%(5) = 1 _
    Or gameGrid%(6) = 1 _
    Or gameGrid%(7) = 1 _
    Or gameGrid%(8) = 1 Then
       isWhitePawnFound% = 1
    End If

    If isWhitePawnFound% = 0 THEN
       winner% = 2
    End IF

    IF  gameGrid%(0) = 2 AND gameGrid%(1) = 0 AND gameGrid%(2) = 0 _
    AND gameGrid%(3) = 1 AND gameGrid%(4) = 0 AND gameGrid%(5) = 2 _
    AND gameGrid%(6) = 0 AND gameGrid%(7) = 0 AND gameGrid%(8) = 1 THEN
        winner% = 2
    END IF

    IF  gameGrid%(0) = 2 AND gameGrid%(1) = 0 AND gameGrid%(2) = 0 _
    AND gameGrid%(3) = 1 AND gameGrid%(4) = 2 AND gameGrid%(5) = 0 _
    AND gameGrid%(6) = 0 AND gameGrid%(7) = 1 AND gameGrid%(8) = 0 THEN
        winner% = 2
    END If

    IF  gameGrid%(0) = 0 AND gameGrid%(1) = 2 AND gameGrid%(2) = 0 _
    AND gameGrid%(3) = 0 AND gameGrid%(4) = 1 AND gameGrid%(5) = 0 _
    AND gameGrid%(6) = 0 AND gameGrid%(7) = 0 AND gameGrid%(8) = 0 THEN
        winner% = 1
    END IF

    IF  gameGrid%(0) = 0 AND gameGrid%(1) = 2 AND gameGrid%(2) = 0 _
    AND gameGrid%(3) = 0 AND gameGrid%(4) = 1 AND gameGrid%(5) = 2 _
    AND gameGrid%(6) = 0 AND gameGrid%(7) = 0 AND gameGrid%(8) = 1 THEN
        winner% = 2
    END IF

    IF  gameGrid%(0) = 0 AND gameGrid%(1) = 2 AND gameGrid%(2) = 0 _
    AND gameGrid%(3) = 2 AND gameGrid%(4) = 1 AND gameGrid%(5) = 0 _
    AND gameGrid%(6) = 1 AND gameGrid%(7) = 0 AND gameGrid%(8) = 0 THEN
        winner% = 2
    END IF

    IF  gameGrid%(0) = 0 AND gameGrid%(1) = 0 AND gameGrid%(2) = 2 _
    AND gameGrid%(3) = 2 AND gameGrid%(4) = 0 AND gameGrid%(5) = 1 _
    AND gameGrid%(6) = 1 AND gameGrid%(7) = 0 AND gameGrid%(8) = 0 THEN
        winner% = 2
    END IF

    IF  gameGrid%(0) = 0 AND gameGrid%(1) = 0 AND gameGrid%(2) = 2 _
    AND gameGrid%(3) = 0 AND gameGrid%(4) = 2 AND gameGrid%(5) = 1 _
    AND gameGrid%(6) = 0 AND gameGrid%(7) = 1 AND gameGrid%(8) = 0 THEN
        winner% = 2
    END If

    IF  gameGrid%(0) = 2 AND gameGrid%(1) = 0 AND gameGrid%(2) = 2 _
    AND gameGrid%(3) = 1 AND gameGrid%(4) = 2 AND gameGrid%(5) = 1 _
    AND gameGrid%(6) = 0 AND gameGrid%(7) = 1 AND gameGrid%(8) = 0 THEN
        winner% = 1
    END If

RETURN
'--------------------------------------'

RemoveSphere:
       If boxNumber = 25 Then
           IF sbx25$(4) = "c" THEN
              sbx25$(0) = " "
           End If
           IF sbx25$(4) = "y" THEN
              sbx25$(1) = " "
           End If
       End If

       If boxNumber = 31 Then
           IF sbx31$(4) = "c" THEN
              sbx31$(0) = " "
           End If
           IF sbx31$(4) = "y" THEN
              sbx31$(1) = " "
           End If
       End If

       If boxNumber = 27 Then
           IF sbx27$(4) = "c" THEN
              sbx27$(0) = " "
           End If
       End If

       If boxNumber = 32 Then
           IF sbx32$(4) = "c" THEN
              sbx32$(0) = " "
           End If
       End If

       If boxNumber = 29 Then
           IF sbx29$(4) = "c" THEN
              sbx29$(0) = " "
           End If
           IF sbx29$(4) = "y" THEN
              sbx29$(1) = " "
           End If
           IF sbx29$(4) = "m" THEN
              sbx29$(2) = " "
           End If
           IF sbx29$(4) = "k" THEN
              sbx29$(3) = " "
           End If
       End If

       If boxNumber = 28 Then
           If sbx28$(2) = "c" Then
              sbx28$(0) = " "
           End If
           If sbx28$(2) = "y" Then
              sbx28$(1) = " "
           End If
       End If

       If boxNumber = 1 Then
           If sbx1$(4) = "c" Then
              sbx1$(0) = " "
           End If
           If sbx1$(4) = "y" Then
              sbx1$(1) = " "
           End If
           If sbx1$(4) = "m" Then
              sbx1$(2) = " "
           End If
       End If

       If boxNumber = 30 Then
           If sbx30$(4) = "c" Then
              sbx30$(0) = " "
           End If
           If sbx30$(4) = "y" Then
              sbx30$(1) = " "
           End If
           If sbx30$(4) = "m" Then
              sbx30$(2) = " "
           End If
       End If

       If boxNumber = 2 Then
           If sbx2$(4) = "c" Then
              sbx2$(0) = " "
           End If
           If sbx2$(4) = "y" Then
              sbx2$(1) = " "
           End If
       End If

       If boxNumber = 3 Then
           If sbx3$(4) = "c" Then
              sbx3$(0) = " "
           End If
           If sbx3$(4) = "y" Then
              sbx3$(1) = " "
           End If
           If sbx3$(4) = "m" Then
              sbx3$(2) = " "
           End If
           If sbx3$(4) = "k" Then
              sbx3$(3) = " "
           End If
       End If

       If boxNumber = 4 Then
           If sbx4$(4) = "c" Then
              sbx4$(0) = " "
           End If
           If sbx4$(4) = "y" Then
              sbx4$(1) = " "
           End If
           If sbx4$(4) = "m" Then
              sbx4$(2) = " "
           End If
           If sbx4$(4) = "k" Then
              sbx4$(3) = " "
           End If
       End If

       If boxNumber = 5 Then
           If sbx5$(4) = "c" Then
              sbx5$(0) = " "
           End If
           If sbx5$(4) = "y" Then
              sbx5$(1) = " "
           End If
           If sbx5$(4) = "m" Then
              sbx5$(2) = " "
           End If
       End If

       If boxNumber = 6 Then
           If sbx6$(4) = "c" Then
              sbx6$(0) = " "
           End If
           If sbx6$(4) = "y" Then
              sbx6$(1) = " "
           End If
           If sbx6$(4) = "m" Then
              sbx6$(2) = " "
           End If
       End If

       If boxNumber = 7 Then
           If sbx7$(4) = "c" Then
              sbx7$(0) = " "
           End If
           If sbx7$(4) = "y" Then
              sbx7$(1) = " "
           End If
           If sbx7$(4) = "m" Then
              sbx7$(2) = " "
           End If
       End If

       If boxNumber = 8 Then
           If sbx8$(4) = "c" Then
              sbx8$(0) = " "
           End If
           If sbx8$(4) = "y" Then
              sbx8$(1) = " "
           End If
       End If

       If boxNumber = 9 Then
           If sbx9$(4) = "c" Then
              sbx9$(0) = " "
           End If
           If sbx9$(4) = "y" Then
              sbx9$(1) = " "
           End If
       End If

       If boxNumber = 10 Then
           If sbx10$(4) = "c" Then
              sbx10$(0) = " "
           End If
           If sbx10$(4) = "y" Then
              sbx10$(1) = " "
           End If
       End If

       If boxNumber = 11 Then
           If sbx11$(4) = "c" Then
              sbx11$(0) = " "
           End If
           If sbx11$(4) = "y" Then
              sbx11$(1) = " "
           End If
       End If

       If boxNumber = 12 Then
           If sbx12$(4) = "c" Then
              sbx12$(0) = " "
           End If
           If sbx12$(4) = "y" Then
              sbx12$(1) = " "
           End If
       End If

       If boxNumber = 13 Then
           If sbx13$(4) = "c" Then
              sbx13$(0) = " "
           End If
       End If

       If boxNumber = 14 Then
           If sbx14$(4) = "c" Then
              sbx14$(0) = " "
           End If
           If sbx14$(4) = "y" Then
              sbx14$(1) = " "
           End If
       End If

       If boxNumber = 15 Then
           If sbx15$(4) = "c" Then
              sbx15$(0) = " "
           End If
       End If

       If boxNumber = 16 Then
           If sbx16$(4) = "c" Then
              sbx16$(0) = " "
           End If
           If sbx16$(4) = "y" Then
              sbx16$(1) = " "
           End If
       End If

       If boxNumber = 17 Then
           If sbx17$(4) = "c" Then
              sbx17$(0) = " "
           End If
           If sbx17$(4) = "y" Then
              sbx17$(1) = " "
           End If
       End If

       If boxNumber = 18 Then
           If sbx18$(4) = "c" Then
              sbx18$(0) = " "
           End If
           If sbx18$(4) = "y" Then
              sbx18$(1) = " "
           End If
       End If

       If boxNumber = 19 Then
           If sbx19$(4) = "c" Then
              sbx19$(0) = " "
           End If
           If sbx19$(4) = "y" Then
              sbx19$(1) = " "
           End If
       End If

       If boxNumber = 20 Then
           If sbx20$(4) = "c" Then
              sbx20$(0) = " "
           End If
           If sbx20$(4) = "y" Then
              sbx20$(1) = " "
           End If
           If sbx20$(4) = "m" Then
              sbx20$(2) = " "
           End If
       End If

       If boxNumber = 21 Then
           If sbx21$(4) = "c" Then
              sbx21$(0) = " "
           End If
           If sbx21$(4) = "y" Then
              sbx21$(1) = " "
           End If
       End If

       If boxNumber = 22 Then
           If sbx22$(4) = "c" Then
              sbx22$(0) = " "
           End If
           If sbx22$(4) = "y" Then
              sbx22$(1) = " "
           End If
       End If

       If boxNumber = 23 Then
           If sbx23$(4) = "c" Then
              sbx23$(0) = " "
           End If
           If sbx23$(4) = "y" Then
              sbx23$(1) = " "
           End If
       End If

       If boxNumber = 24 Then
           If sbx24$(4) = "c" Then
              sbx24$(0) = " "
           End If
           If sbx24$(4) = "y" Then
              sbx24$(1) = " "
           End If
       End If

       If boxNumber = 29 Then
           If sbx29$(4) = "c" Then
              sbx29$(0) = " "
           End If
           If sbx29$(4) = "y" Then
              sbx29$(1) = " "
           End If
           If sbx29$(4) = "m" Then
              sbx29$(2) = " "
           End If
           If sbx29$(4) = "k" Then
              sbx29$(3) = " "
           End If
       End If

   GoSub ClearSelectedSpheres

   boxNumber = 0
Return
' -------------------------------------------------------------

' *** IF PLAYER WINS, CLEARS SELETCED SPHERE FROM BUFFER
ClearSelectedSpheres:
   sbx1$(4) = " "
   sbx2$(4) = " "
   sbx3$(4) = " "
   sbx4$(4) = " "
   sbx5$(4) = " "
   sbx6$(4) = " "
   sbx7$(4) = " "
   sbx8$(4) = " "
   sbx9$(4) = " "
   sbx10$(4) = " "
   sbx11$(4) = " "
   sbx12$(4) = " "
   sbx13$(4) = " "
   sbx14$(4) = " "
   sbx15$(4) = " "
   sbx16$(4) = " "
   sbx17$(4) = " "
   sbx18$(4) = " "
   sbx19$(4) = " "
   sbx20$(4) = " "
   sbx21$(4) = " "
   sbx22$(4) = " "
   sbx23$(4) = " "
   sbx24$(4) = " "
   sbx25$(4) = " "
   sbx27$(4) = " "
   sbx28$(4) = " "
   sbx29$(4) = " "
   sbx30$(4) = " "
   sbx31$(4) = " "
   sbx32$(4) = " "

Return
' -------------------------------------------------------------

SUB ExtractSphere(pbox%) STATIC
     RANDOMIZE Timer

     sphereNum% = 1

'*-- BOX 1
     IF pbox% = 1
        If (sphereNum% = 1 AND sbx1$(0) <> " ") THEN
           IF gameGrid%(3) = 1 AND gameGrid%(1) = 2 THEN
              gameGrid%(1) = 0
              gameGrid%(3) = 2
              OBJECT.OFF 12
              OBJECT.OFF 2
              OBJECT.OFF 14
              OBJECT.ON 4
              sbx1$(4) = sbx1$(0)
              Exit Sub
           END If
        ELSE
            sphereNum% = 2
            locate 1,1: ? "PASSO ALLA SFERA 2"
        END IF

        IF (sphereNum% = 2 AND sbx1$(1) <> " ") THEN
           IF gameGrid%(4) = 0 AND gameGrid%(1) = 2 THEN
              gameGrid%(1) = 0
              gameGrid%(4) = 2
              OBJECT.OFF 2
              OBJECT.OFF 12
              OBJECT.OFF 15
              OBJECT.ON 5
              sbx1$(4) = sbx1$(1)
              Exit Sub
           END If
        ELSE
           sphereNum% = 3
            locate 1,1: ? "PASSO ALLA SFERA 3"
        END If

        IF (sphereNum% = 3 AND sbx1$(2) <> " ") THEN
           IF gameGrid%(5) = 0 AND gameGrid%(2) = 2 THEN
              gameGrid%(2) = 0
              gameGrid%(5) = 2
              OBJECT.OFF 3
              OBJECT.OFF 13
              OBJECT.OFF 16
              OBJECT.ON 6
              sbx1$(4) = sbx1$(2)
              Exit Sub
           END IF
        END IF
     END IF

'*-- BOX 2
     IF pbox% = 2
        If sphereNum% = 1 AND sbx2$(0) <> " " Then
           IF gameGrid%(3) = 0 AND gameGrid%(0) = 2 THEN
              gameGrid%(0) = 0
              gameGrid%(3) = 2
              OBJECT.OFF 1
              OBJECT.OFF 11
              OBJECT.OFF 14
              OBJECT.ON 4
              sbx2$(4) = sbx2$(0)
              Exit Sub
           END If
        Else
           sphereNum% = 2
        End If

        IF sphereNum% = 2 AND sbx2$(1) <> " " THEN
           IF gameGrid%(4) = 1 AND gameGrid%(0) = 2 THEN
              gameGrid%(0) = 0
              gameGrid%(4) = 2
              OBJECT.OFF 1
              OBJECT.OFF 11
              OBJECT.OFF 15
              OBJECT.ON 5
              sbx2$(4) = sbx2$(1)
              Exit Sub
           END IF
        END IF
     END If

'*-- BOX 3
     IF pbox% = 3
        If (sphereNum% = 1 AND sbx3$(0) <> " ") THEN
           IF gameGrid%(6) = 0 AND gameGrid%(3) = 2 THEN
              gameGrid%(3) = 0
              gameGrid%(6) = 2
              OBJECT.ON 7
              OBJECT.OFF 14
              OBJECT.OFF 4
              OBJECT.OFF 17
              sbx3$(4) = sbx3$(0)
              Exit Sub
           END If
        Else
           sphereNum% = 2
        End If

        IF (sphereNum% = 2 AND sbx3$(1) <> " ") THEN
           IF gameGrid%(4) = 1 AND gameGrid%(0) = 2 THEN
              gameGrid%(0) = 0
              gameGrid%(4) = 2
              OBJECT.OFF 1
              OBJECT.OFF 11
              OBJECT.ON 5
              OBJECT.OFF 15
              sbx3$(4) = sbx3$(1)
              Exit Sub
           END IF
        Else
           sphereNum% = 3
        END If

        IF (sphereNum% = 3 AND sbx3$(2) <> " ") THEN
           IF gameGrid%(4) = 1 AND gameGrid%(2) = 2 THEN
              gameGrid%(2) = 0
              gameGrid%(4) = 2
              OBJECT.OFF 1
              OBJECT.OFF 11
              OBJECT.OFF 15
              OBJECT.ON 5
              sbx3$(4) = sbx3$(2)
              Exit Sub
           END IF
        Else
           sphereNum% = 4
        END If

        If (sphereNum% = 4 AND sbx3$(3) <> " ") THEN
           IF gameGrid%(5) = 1 AND gameGrid%(2) = 2 THEN
              gameGrid%(2) = 0
              gameGrid%(5) = 2
              OBJECT.OFF 3
              OBJECT.OFF 13
              OBJECT.OFF 16
              OBJECT.ON 6
              sbx3$(4) = sbx3$(3)
              Exit Sub
           END IF
        END IF
     END IF

'*-- BOX 4
     IF pbox% = 4
        If (sphereNum% = 1 AND sbx4$(0) <> " ") THEN
           IF gameGrid%(3) = 1 AND gameGrid%(1) = 2 THEN
              gameGrid%(1) = 0
              gameGrid%(3) = 2
              OBJECT.OFF 2
              OBJECT.OFF 12
              OBJECT.ON 4
              OBJECT.OFF 14
              sbx4$(4) = sbx4$(0)
              Exit Sub
           END If
        Else
           sphereNum% = 2
        End If

        IF (sphereNum% = 2 AND sbx4$(1) <> " ") THEN
           IF gameGrid%(7) = 0 AND gameGrid%(4) = 2 THEN
              gameGrid%(4) = 0
              gameGrid%(7) = 2
              OBJECT.OFF 5
              OBJECT.OFF 15
              OBJECT.OFF 17
              OBJECT.ON 7
              sbx4$(4) = sbx4$(1)
              Exit Sub
           END IF
        Else
           sphereNum% = 3
        END IF

        IF (sphereNum% = 3 AND sbx4$(2) <> " ") THEN
           IF gameGrid%(8) = 1 AND gameGrid%(4) = 2 THEN
              gameGrid%(4) = 0
              gameGrid%(8) = 2
              OBJECT.OFF 5
              OBJECT.OFF 15
              OBJECT.OFF 19
              OBJECT.ON 9
              sbx4$(4) = sbx4$(2)
              Exit Sub
           END IF
        Else
           sphereNum% = 4
        END IF

        IF (sphereNum% = 3 AND sbx4$(3) <> " ") THEN
           IF gameGrid%(5) = 0 AND gameGrid%(2) = 2 THEN
             gameGrid%(2) = 0
             gameGrid%(5) = 2
             OBJECT.OFF 3
             OBJECT.OFF 13
             OBJECT.ON 6
             OBJECT.OFF 16
             sbx4$(4) = sbx4$(3)
             Exit Sub
           END IF
        END IF
     END IF

'*-- BOX 5
     IF pbox% = 5
        If (sphereNum% = 1 AND sbx5$(0) <> " ") THEN
           IF gameGrid%(4) = 1 AND gameGrid%(0) = 2 THEN
              gameGrid%(0) = 0
              gameGrid%(4) = 2
              OBJECT.OFF 1
              OBJECT.OFF 11
              OBJECT.ON 5
              OBJECT.OFF 15
              sbx5$(4) = sbx5$(0)
              Exit Sub
           END IF
        Else
           sphereNum% = 2
        End If

        IF (sphereNum% = 2 AND sbx5$(1) <> " ") THEN
           IF gameGrid%(4) = 1 AND gameGrid%(2) = 2 THEN
              gameGrid%(2) = 0
              gameGrid%(4) = 2
              OBJECT.OFF 3
              OBJECT.OFF 13
              OBJECT.OFF 15
              OBJECT.ON 5
              sbx5$(4) = sbx5$(1)
              Exit Sub
           END IF
        Else
            sphereNum% = 3
        END IF

        IF (sphereNum% = 3 AND sbx5$(2) <> " ") THEN
           IF gameGrid%(5) = 0 AND gameGrid%(2) = 2 THEN
              gameGrid%(2) = 0
              gameGrid%(5) = 2
              OBJECT.OFF 3
              OBJECT.OFF 13
              OBJECT.OFF 16
              OBJECT.ON 6
              sbx5$(4) = sbx5$(2)
              Exit Sub
           END IF
        END IF
     END IF

'*-- BOX 6
     IF pbox% = 6
        If (sphereNum% = 1 AND sbx6$(0) <> " ") THEN
           IF gameGrid%(1) = 2 AND gameGrid%(3) = 1 THEN
              gameGrid%(1) = 0
              gameGrid%(3) = 2
              OBJECT.OFF 2
              OBJECT.OFF 12
              OBJECT.OFF 14
              OBJECT.ON 4
              sbx6$(4) = sbx6$(0)
              Exit Sub
           END If
        Else
          sphereNum% = 2
        End If

        IF (sphereNum% = 2 AND sbx6$(1) <> " ") THEN
           IF gameGrid%(1) = 2 AND gameGrid%(5) = 0 THEN
              gameGrid%(1) = 0
              gameGrid%(5) = 2
              OBJECT.OFF 2
              OBJECT.OFF 12
              OBJECT.OFF 16
              OBJECT.ON 6
              sbx6$(4) = sbx6$(1)
              Exit Sub
           End If
        Else
           sphereNum% = 3
        END IF

        IF (sphereNum% = 3 AND sbx6$(2) <> " ") THEN
           IF gameGrid%(1) = 2 AND gameGrid%(4) = 1 THEN
              gameGrid%(1) = 0
              gameGrid%(4) = 2
              OBJECT.OFF 2
              OBJECT.OFF 12
              OBJECT.OFF 15
              OBJECT.ON 5
              sbx6$(4) = sbx6$(2)
              Exit Sub
           END IF
        END IF
     END IF

'*-- BOX 7
     IF pbox% = 7
        If (sphereNum% = 1 AND sbx7$(0) <> " ") THEN
           IF gameGrid%(4) = 2 AND gameGrid%(6) = 1 THEN
              gameGrid%(4) = 0
              gameGrid%(6) = 2
              OBJECT.OFF 5
              OBJECT.OFF 15
              OBJECT.OFF 17
              OBJECT.ON 7
              sbx7$(4) = sbx7$(0)
              Exit Sub
           END If
        Else
           sphereNum% = 2
        End If

        IF (sphereNum% = 2 AND sbx7$(1) <> " ") THEN
           IF gameGrid%(4) = 2 AND gameGrid%(7) = 0 THEN
              gameGrid%(4) = 0
              gameGrid%(7) = 2
              OBJECT.OFF 5
              OBJECT.OFF 15
              OBJECT.OFF 18
              OBJECT.ON 8
              sbx7$(4) = sbx7$(1)
              Exit Sub
           Else
             sphereNum% = 3
           END IF
        END IF

        IF (sphereNum% = 3 AND sbx7$(2) <> " ") THEN
           IF gameGrid%(1) = 2 AND gameGrid%(5) = 1 THEN
              gameGrid%(1) = 0
              gameGrid%(5) = 2
              OBJECT.OFF 2
              OBJECT.OFF 12
              OBJECT.OFF 16
              OBJECT.ON 6
              sbx7$(4) = sbx7$(2)
              Exit Sub
           END IF
        END IF
     END IF

'*-- BOX 8
     IF pbox% = 8
        If (sphereNum% = 1 AND sbx8$(0) <> " ") THEN
           IF gameGrid%(1) = 2 AND gameGrid%(5) = 1 THEN
              gameGrid%(1) = 0
              gameGrid%(5) = 2
              OBJECT.OFF 2
              OBJECT.OFF 12
              OBJECT.OFF 16
              OBJECT.ON 6
              sbx8$(4) = sbx8$(0)
              Exit Sub
           END If
        Else
           sphereNum% = 2
        End If

        IF (sphereNum% = 2 AND sbx8$(1) <> " ") THEN
           IF gameGrid%(2) = 2 AND gameGrid%(4) = 1 THEN
              gameGrid%(2) = 0
              gameGrid%(4) = 2
              OBJECT.OFF 3
              OBJECT.OFF 13
              OBJECT.OFF 15
              OBJECT.ON 5
              sbx8$(4) = sbx8$(1)
              Exit Sub
           END IF
        END IF
     END IF

'*-- BOX 9
     IF pbox% = 9
        If (sphereNum% = 1 AND sbx9$(0) <> " ") THEN
           IF gameGrid%(3) = 2 AND gameGrid%(6) = 0 THEN
              gameGrid%(3) = 0
              gameGrid%(6) = 2
              OBJECT.OFF 14
              OBJECT.OFF 4
              OBJECT.OFF 17
              OBJECT.ON 7
              sbx9$(4) = sbx9$(0)
              Exit Sub
           END If
        Else
           sphereNum% = 2
        End If

        IF (sphereNum% = 2 AND sbx9$(1) <> " ") THEN
           IF gameGrid%(3) = 2 AND gameGrid%(7) = 1 THEN
              gameGrid%(3) = 0
              gameGrid%(7) = 2
              OBJECT.OFF 4
              OBJECT.OFF 14
              OBJECT.OFF 18
              OBJECT.ON 8
              sbx9$(4) = sbx9$(1)
              Exit Sub
           END IF
        END IF
     END IF

'*-- BOX 10
     If pbox% = 10
        If (sphereNum% = 1 AND sbx10$(0) <> " ") THEN
           IF gameGrid%(4) = 1 AND gameGrid%(0) = 2 THEN
              gameGrid%(0) = 0
              gameGrid%(4) = 2
              OBJECT.OFF 1
              OBJECT.OFF 11
              OBJECT.OFF 14
              OBJECT.ON 4
              sbx10$(4) = sbx10$(0)
              Exit Sub
           END IF
        Else
           sphereNum% = 2
        END IF

        IF (sphereNum% = 2 AND sbx10$(1) <> " ") THEN
           IF gameGrid%(1) = 2 AND gameGrid%(3) = 1 THEN
              gameGrid%(1) = 0
              gameGrid%(3) = 2
              OBJECT.OFF 1
              OBJECT.OFF 11
              OBJECT.OFF 14
              OBJECT.ON 4
              sbx10$(4) = sbx10$(1)
              Exit Sub
           END IF
        END IF
     End If

'*-- BOX 11
     IF pbox% = 11
        IF (sphereNum% = 1 AND sbx11$(0) <> " ") THEN
           IF gameGrid%(2) = 2 AND gameGrid%(4) = 1 THEN
              gameGrid%(2) = 0
              gameGrid%(4) = 2
              OBJECT.OFF 3
              OBJECT.OFF 13
              OBJECT.OFF 15
              OBJECT.ON 5
              sbx11$(4) = sbx11$(0)
              Exit Sub
           END IF
        Else
           sphereNum% = 2
        END IF

        If (sphereNum% = 2 AND sbx11$(1) <> " ") THEN
           IF gameGrid%(2) = 2 AND gameGrid%(5) = 0 THEN
              gameGrid%(2) = 0
              gameGrid%(5) = 2
              OBJECT.OFF 3
              OBJECT.OFF 13
              OBJECT.OFF 16
              OBJECT.ON 6
              sbx11$(4) = sbx11$(1)
              Exit Sub
           END If
        End If
     END IF

'*-- BOX 12
     IF pbox% = 12
        IF (sphereNum% = 1 AND sbx12$(0) <> " ") THEN
           IF gameGrid%(2) = 2 AND gameGrid%(4) = 1 THEN
              gameGrid%(2) = 0
              gameGrid%(4) = 2
              OBJECT.OFF 3
              OBJECT.OFF 13
              OBJECT.OFF 15
              OBJECT.ON 5
              sbx12$(4) = sbx12$(0)
              Exit Sub
           END IF
        Else
           sphereNum% = 2
        END IF

        IF (sphereNum% = 2 AND sbx12$(1) <> " ") THEN
           IF gameGrid%(2) = 2 AND gameGrid%(5) = 0 THEN
              gameGrid%(2) = 0
              gameGrid%(5) = 2
              OBJECT.OFF 3
              OBJECT.OFF 13
              OBJECT.OFF 16
              OBJECT.ON 6
              sbx12$(4) = sbx12$(1)
              Exit Sub
           END IF
        END If
     End If

'*-- BOX 13
     IF pbox% = 13 AND sbx13$(0) <> " "  THEN
        IF gameGrid%(2) = 2 AND gameGrid%(5) = 0 THEN
           gameGrid%(2) = 0
           gameGrid%(5) = 2
           OBJECT.OFF 3
           OBJECT.OFF 12
           OBJECT.OFF 16
           OBJECT.ON 6
           sbx13$(4) = sbx13$(0)
           Exit Sub
        END IF
     END If

'*-- BOX 14
     IF pbox% = 14
        IF (sphereNum% = 1 AND sbx14$(0) <> " ") THEN
           IF gameGrid%(3) = 2 AND gameGrid%(6) = 0 THEN
              gameGrid%(3) = 0
              gameGrid%(6) = 2
              OBJECT.OFF 4
              OBJECT.OFF 14
              OBJECT.OFF 17
              OBJECT.ON 7
              sbx14$(4) = sbx14$(0)
              Exit Sub
           END IF
        Else
           sphereNum% = 2
        END IF

        IF (sphereNum% = 2 AND sbx14$(1) <> " ") THEN
           IF gameGrid%(4) = 2 AND gameGrid%(7) = 1 THEN
              gameGrid%(4) = 0
              gameGrid%(7) = 2
              OBJECT.OFF 5
              OBJECT.OFF 15
              OBJECT.OFF 18
              OBJECT.ON 8
              sbx14$(4) = sbx14$(1)
              Exit Sub
           END IF
        END IF
     End If

'*-- BOX 15
     IF pbox% = 15 AND sbx15$(0) <> " "  THEN
        IF gameGrid%(2) = 2 AND gameGrid%(4) = 1 THEN
           gameGrid%(2) = 0
           gameGrid%(4) = 2
           OBJECT.OFF 3
           OBJECT.OFF 13
           OBJECT.OFF 14
           OBJECT.ON 4
           sbx15$(4) = sbx15$(0)
           Exit Sub
        END IF
     END IF

'*-- B0OX 16
     IF pbox% = 16
        If (sphereNum% = 1 AND sbx16$(0) <> " ") THEN
           IF gameGrid%(3) = 2 AND gameGrid%(6) = 0 THEN
              gameGrid%(3) = 0
              gameGrid%(6) = 2
              OBJECT.OFF 4
              OBJECT.OFF 14
              OBJECT.OFF 17
              OBJECT.ON 7
              sbx16$(4) = sbx16$(0)
              Exit Sub
           END IF
        Else
           sphereNum% = 2
        END IF

        IF (sphereNum% = 2 AND sbx16$(1) <> " ") THEN
           IF gameGrid%(1) = 2 AND gameGrid%(5) = 0 THEN
              gameGrid%(1) = 0
              gameGrid%(5) = 2
              OBJECT.OFF 3
              OBJECT.OFF 13
              OBJECT.OFF 16
              OBJECT.ON 6
              sbx16$(4) = sbx16$(1)
              Exit Sub
           END IF
        END If
     End If

'*-- BOX 17
     IF pbox% = 17
        If (sphereNum% = 1 AND sbx17$(0) <> " ") THEN
           IF gameGrid%(1) = 2 AND gameGrid%(3) = 1 THEN
              gameGrid%(1) = 0
              gameGrid%(3) = 2
              OBJECT.OFF 2
              OBJECT.OFF 12
              OBJECT.OFF 14
              OBJECT.ON 4
              sbx17$(4) = sbx17$(0)
              Exit Sub
           END If
        Else
           sphereNum% = 2
        END IF

        IF (sphereNum% = 2 AND sbx17$(1) <> " ") THEN
           IF gameGrid%(5) = 2 AND gameGrid%(8) = 0 THEN
              gameGrid%(5) = 0
              gameGrid%(8) = 2
              OBJECT.OFF 6
              OBJECT.OFF 16
              OBJECT.OFF 19
              OBJECT.ON 9
              sbx17$(4) = sbx17$(1)
              Exit Sub
           END IF
        END IF
     End If

'*-- BOX 18
     IF pbox% = 18
        If (sphereNum% = 1 AND sbx18$(0) <> " ") THEN
           IF gameGrid%(3) = 2 AND gameGrid%(6) = 0 THEN
              gameGrid%(3) = 0
              gameGrid%(6) = 2
              OBJECT.OFF 4
              OBJECT.OFF 14
              OBJECT.OFF 17
              OBJECT.ON 7
              sbx18$(4) = sbx18$(0)
              Exit Sub
           END If
        Else
           sphereNum% = 2
        End If

        IF (sphereNum% = 2 AND sbx18$(1) <> " ") THEN
           IF gameGrid%(4) = 2 AND gameGrid%(7) = 0 THEN
              gameGrid%(4) = 0
              gameGrid%(7) = 2
              OBJECT.OFF 5
              OBJECT.OFF 15
              OBJECT.OFF 18
              OBJECT.ON 8
              sbx18$(4) = sbx18$(1)
              Exit Sub
           END IF
        END IF
     END IF

'*-- BOX 19
     IF pbox% = 19
        If  (sphereNum% = 1 AND sbx19$(0) <> " ") THEN
           IF gameGrid%(4) = 2 AND gameGrid%(7) = 0 THEN
              gameGrid%(4) = 0
              gameGrid%(7) = 2
              OBJECT.OFF 5
              OBJECT.OFF 15
              OBJECT.OFF 1
              OBJECT.ON 8
              sbx19$(4) = sbx19$(0)
              Exit Sub
           END If
        Else
           sphereNum% = 2
        END If

        IF (sphereNum% = 2 AND sbx19$(1) <> " ") THEN
           IF gameGrid%(5) = 2 AND gameGrid%(8) = 0 THEN
              gameGrid%(5) = 0
              gameGrid%(8) = 2
              OBJECT.OFF 6
              OBJECT.OFF 16
              OBJECT.OFF 19
              OBJECT.ON 9
              sbx19$(4) = sbx19$(1)
              Exit Sub
           END IF
        END IF
     End If

'*-- BOX 20
     IF pbox% = 20
        If (sphereNum% = 1 AND sbx20$(0) <> " ") THEN
           IF gameGrid%(3) = 2 AND gameGrid%(6) = 0 THEN
              gameGrid%(3) = 0
              gameGrid%(6) = 2
              OBJECT.OFF 4
              OBJECT.OFF 14
              OBJECT.OFF 17
              OBJECT.ON 7
              sbx20$(4) = sbx20$(0)
              Exit Sub
           END If
        Else
           sphereNum% = 2
        END IF

        IF (sphereNum% = 2 AND sbx20$(1) <> " ") THEN
           IF gameGrid%(2) = 2 AND gameGrid%(4) = 1 THEN
              gameGrid%(2) = 0
              gameGrid%(4) = 2
              OBJECT.ON  5
              OBJECT.OFF 15
              OBJECT.OFF 12
              OBJECT.OFF 2
              sbx20$(4) = sbx20$(1)
              Exit Sub
           END If
        Else
           sphereNum% = 3
        END IF

        IF (sphereNum% = 3 AND sbx20$(2) <> " ") THEN
           IF gameGrid%(2) = 2 AND gameGrid%(5) = 0 THEN
              gameGrid%(2) = 0
              gameGrid%(5) = 2
              OBJECT.OFF 3
              OBJECT.OFF 13
              OBJECT.OFF 16
              OBJECT.ON 6
              sbx20$(4) = sbx20$(2)
              Exit Sub
           END IF
        END If
     End If

'*-- BOX 21
     IF pbox% = 21
        If (sphereNum% = 1 AND sbx21$(0) <> " ") THEN
           IF gameGrid%(1) = 2 AND gameGrid%(3) = 1 THEN
              gameGrid%(1) = 0
              gameGrid%(3) = 2
              OBJECT.OFF 2
              OBJECT.OFF 12
              OBJECT.OFF 14
              OBJECT.ON 4
              sbx21$(4) = sbx21$(0)
              Exit Sub
           END If
        Else
            sphereNum% = 2
        END IF

        IF (sphereNum% = 2 AND sbx21$(1) <> " ") THEN
           IF gameGrid%(4) = 2 AND gameGrid%(7) = 0 THEN
              gameGrid%(4) = 0
              gameGrid%(7) = 2
              OBJECT.OFF 5
              OBJECT.OFF 15
              OBJECT.OFF 17
              OBJECT.ON 7
              sbx21$(4) = sbx21$(1)
              Exit Sub
           END IF
        END IF
     End If

'*-- BOX 22
     IF pbox% = 22
        If (sphereNum% = 1 AND sbx22$(0) <> " ") THEN
           IF gameGrid%(4) = 2 AND gameGrid%(7) = 0 THEN
              gameGrid%(4) = 0
              gameGrid%(7) = 2
              OBJECT.OFF 5
              OBJECT.OFF 15
              OBJECT.OFF 18
              OBJECT.ON 8
              sbx22$(4) = sbx22$(0)
              Exit Sub
           END If
        Else
            sphereNum% = 2
        END IF

        IF (sphereNum% = 2 AND sbx22$(1) <> " ") THEN
           IF gameGrid%(1) = 2 AND gameGrid%(5) = 1 THEN
              gameGrid%(1) = 0
              gameGrid%(5) = 2
              OBJECT.OFF 2
              OBJECT.OFF 12
              OBJECT.OFF 16
              OBJECT.ON 6
              sbx22$(4) = sbx22$(1)
              Exit Sub
           END IF
        END If
    End If

'*-- BOX 23
     IF pbox% = 23
        If (sphereNum% = 1 AND sbx23$(0) <> " ") THEN
           IF gameGrid%(6) = 0 AND gameGrid%(3) = 2 THEN
              gameGrid%(3) = 0
              gameGrid%(6) = 2
              OBJECT.OFF 4
              OBJECT.OFF 14
              OBJECT.OFF 16
              OBJECT.ON 6
              sbx23$(4) = sbx23$(0)
              Exit Sub
           END If
        Else
           sphereNum% = 2
        END IF

        IF (sphereNum% = 2 AND sbx23$(1) <> " ") THEN
           IF gameGrid%(4) = 1 AND gameGrid%(0) = 2 THEN
              gameGrid%(0) = 0
              gameGrid%(4) = 2
              OBJECT.OFF 1
              OBJECT.OFF 11
              OBJECT.OFF 15
              OBJECT.ON 5
              sbx23$(4) = sbx23$(1)
              Exit Sub
           END IF
        END IF
     End If

'*-- BOX 24
     IF pbox% = 24
        If (sphereNum% = 1 AND sbx24$(0) <> " ") THEN
           IF gameGrid%(2) = 2 AND gameGrid%(4) = 1 THEN
              gameGrid%(2) = 0
              gameGrid%(4) = 2
              OBJECT.OFF 2
              OBJECT.OFF 12
              OBJECT.OFF 14
              OBJECT.ON 4
              sbx24$(4) = sbx24$(0)
              Exit Sub
           End If
        Else
           sphereNum% = 2
        END IF

        IF (sphereNum% = 2 AND sbx24$(1) <> " ") THEN
           IF gameGrid%(5) = 2 AND gameGrid%(8) = 0 THEN
              gameGrid%(5) = 0
              gameGrid%(8) = 2
              OBJECT.OFF 6
              OBJECT.OFF 16
              OBJECT.OFF 19
              OBJECT.ON 9
              sbx24$(4) = sbx24$(1)
              Exit Sub
           END IF
        END If
    End If

'*-- BOX 31
     IF pbox% = 31
        If sphereNum% = 1 AND sbx31$(0) <> " " Then
           IF gameGrid%(4) = 2 AND gameGrid%(7) = 0 THEN
              gameGrid%(4) = 0
              gameGrid%(7) = 2
              OBJECT.OFF 15
              OBJECT.OFF 5
              OBJECT.OFF 8
              OBJECT.ON 18
              sbx31$(4) = sbx31$(0)
              Exit Sub
           END If
        Else
           sphereNum% = 2
        End If

        IF sphereNum% = 2 AND sbx31$(1) <> " " THEN
           IF gameGrid%(5) = 1 AND gameGrid%(8) = 0 THEN
              gameGrid%(5) = 0
              gameGrid%(8) = 2
              OBJECT.OFF 5
              OBJECT.OFF 15
              OBJECT.OFF 18
              OBJECT.ON 8
              sbx31$(4) = sbx31$(1)
              Exit Sub
           END IF
        END IF
     END If

'*-- BOX 28
     IF pbox% = 28
        If sphereNum% = 1 AND sbx28$(0) <> " " Then
           IF gameGrid%(5) = 2 AND gameGrid%(7) = 1 THEN
              gameGrid%(5) = 0
              gameGrid%(7) = 2
              OBJECT.OFF 16
              OBJECT.OFF 6
              OBJECT.OFF 18
              OBJECT.ON 8
              sbx28$(4) = sbx28$(0)
              Exit Sub
           END If
        Else
           sphereNum% = 2
        End If

        IF sphereNum% = 2 AND sbx31$(1) <> " " THEN
           IF gameGrid%(5) = 2 AND gameGrid%(8) = 0 THEN
              gameGrid%(5) = 0
              gameGrid%(8) = 2
              OBJECT.OFF 5
              OBJECT.OFF 15
              OBJECT.OFF 18
              OBJECT.ON 8
              sbx28$(4) = sbx28$(1)
              Exit Sub
           END IF
        END IF
     END If

'*-- BOX 27
     IF pbox% = 27
        If sphereNum% = 1 AND sbx28$(0) <> " " Then
           IF gameGrid%(3) = 0 AND gameGrid%(0) = 2 THEN
              gameGrid%(0) = 0
              gameGrid%(3) = 2
              OBJECT.OFF 11
              OBJECT.OFF 1
              OBJECT.OFF 14
              OBJECT.ON 4
              sbx27$(4) = sbx27$(0)
              Exit Sub
           END If
        End If
     End If

'*-- BOX 25
     IF pbox% = 25
        If (sphereNum% = 1 AND sbx25$(0) <> " ") THEN
           IF gameGrid%(5) = 1 AND gameGrid%(1) = 2 THEN
              gameGrid%(1) = 0
              gameGrid%(5) = 2
              OBJECT.OFF 2
              OBJECT.OFF 12
              OBJECT.OFF 16
              OBJECT.ON 6
              sbx25$(4) = sbx25$(0)
              Exit Sub
           END If
        Else
           sphereNum% = 2
        END IF

        IF (sphereNum% = 2 AND sbx25$(1) <> " ") THEN
           IF gameGrid%(3) = 2 AND gameGrid%(0) = 2 THEN
              gameGrid%(0) = 0
              gameGrid%(3) = 2
              OBJECT.ON  3
              OBJECT.OFF 1
              OBJECT.OFF 11
              OBJECT.OFF 13
              sbx25$(4) = sbx25$(1)
              Exit Sub
           END If
        Else
           sphereNum% = 3
        END IF

        IF (sphereNum% = 3 AND sbx20$(2) <> " ") THEN
           IF gameGrid%(5) = 0 AND gameGrid%(2) = 2 THEN
              gameGrid%(2) = 0
              gameGrid%(5) = 2
              OBJECT.OFF 1
              OBJECT.OFF 12
              OBJECT.OFF 16
              OBJECT.ON 6
              sbx25$(4) = sbx25$(2)
              Exit Sub
           END IF
        END If
     End If

'*-- BOX 29
     IF pbox% = 29
        If (sphereNum% = 1 AND sbx29$(0) <> " ") THEN
           IF gameGrid%(8) = 0 AND gameGrid%(5) = 2 THEN
              gameGrid%(5) = 0
              gameGrid%(8) = 2
              OBJECT.ON 9
              OBJECT.OFF 16
              OBJECT.OFF 6
              OBJECT.OFF 19
              sbx29$(4) = sbx29$(0)
              Exit Sub
           END If
        Else
           sphereNum% = 2
        End If

        IF (sphereNum% = 2 AND sbx29$(1) <> " ") THEN
           IF gameGrid%(2) = 2 AND gameGrid%(4) = 1 THEN
              gameGrid%(2) = 0
              gameGrid%(4) = 2
              OBJECT.OFF 13
              OBJECT.OFF 3
              OBJECT.ON 6
              OBJECT.OFF 16
              sbx29$(4) = sbx29$(1)
              Exit Sub
           END IF
        Else
           sphereNum% = 3
        END If

        IF (sphereNum% = 3 AND sbx29$(2) <> " ") THEN
           IF gameGrid%(0) = 2 AND gameGrid%(4) = 1 THEN
              gameGrid%(0) = 0
              gameGrid%(4) = 2
              OBJECT.OFF 1
              OBJECT.OFF 11
              OBJECT.OFF 15
              OBJECT.ON 5
              sbx29$(4) = sbx29$(2)
              Exit Sub
           END IF
        Else
           sphereNum% = 4
        END If

        If (sphereNum% = 4 AND sbx29$(3) <> " ") THEN
           IF gameGrid%(0) = 2 AND gameGrid%(3) = 0 THEN
              gameGrid%(0) = 0
              gameGrid%(3) = 2
              OBJECT.OFF 1
              OBJECT.OFF 11
              OBJECT.OFF 14
              OBJECT.ON 4
              sbx3$(4) = sbx3$(3)
              Exit Sub
           END IF
        END IF
     END If

'*-- BOX 30
     IF pbox% = 30
        If (sphereNum% = 1 AND sbx30$(0) <> " ") THEN
           IF gameGrid%(1) = 2 AND gameGrid%(5) = 1 THEN
              gameGrid%(1) = 0
              gameGrid%(5) = 2
              OBJECT.ON 6
              OBJECT.OFF 1
              OBJECT.OFF 11
              OBJECT.OFF 16
              sbx30$(4) = sbx30$(0)
              Exit Sub
           END If
        Else
           sphereNum% = 2
        End If

        IF (sphereNum% = 2 AND sbx30$(1) <> " ") THEN
           IF gameGrid%(1) = 2 AND gameGrid%(4) = 0 THEN
              gameGrid%(1) = 0
              gameGrid%(4) = 2
              OBJECT.OFF 12
              OBJECT.OFF 2
              OBJECT.ON 5
              OBJECT.OFF 15
              sbx30$(4) = sbx30$(1)
              Exit Sub
           END IF
        Else
           sphereNum% = 3
        END If

        IF (sphereNum% = 3 AND sbx30$(2) <> " ") THEN
           IF gameGrid%(1) = 2 AND gameGrid%(3) = 1 THEN
              gameGrid%(1) = 0
              gameGrid%(3) = 2
              OBJECT.OFF 2
              OBJECT.OFF 12
              OBJECT.OFF 14
              OBJECT.ON 4
              sbx30$(4) = sbx30$(2)
              Exit Sub
           END IF
        END If
     END If

'*-- BOX 26
     IF pbox% = 26
        If (sphereNum% = 1 AND sbx26$(0) <> " ") THEN
           IF gameGrid%(1) = 2 AND gameGrid%(5) = 1 THEN
              gameGrid%(1) = 0
              gameGrid%(5) = 2
              OBJECT.ON 6
              OBJECT.OFF 1
              OBJECT.OFF 11
              OBJECT.OFF 16
              sbx26$(4) = sbx26$(0)
              Exit Sub
           END If
        Else
           sphereNum% = 2
        End If

        IF (sphereNum% = 2 AND sbx26$(1) <> " ") THEN
           IF gameGrid%(1) = 2 AND gameGrid%(4) = 0 THEN
              gameGrid%(1) = 0
              gameGrid%(4) = 2
              OBJECT.OFF 12
              OBJECT.OFF 2
              OBJECT.ON 5
              OBJECT.OFF 15
              sbx26$(4) = sbx26$(1)
              Exit Sub
           END IF
        END If
     END If

'*-- BOX 32
     IF pbox% = 32
        If (sphereNum% = 1 AND sbx32$(0) <> " ") THEN
           IF gameGrid%(7) = 0 AND gameGrid%(4) = 2 THEN
              gameGrid%(7) = 2
              gameGrid%(4) = 0
              OBJECT.ON 8
              OBJECT.OFF 15
              OBJECT.OFF 5
              OBJECT.OFF 18
              sbx32$(4) = sbx32$(0)
              Exit Sub
           END If
        End If
     End If

    COLOR 3,0: locate 10,50: Print "SPHERE: ";sphereNum%
    COLOR 3,0: locate 1,1: Print "SPHERE BOX 8: ";sbx8$(4)
End SUB
'--------------------------------------'
