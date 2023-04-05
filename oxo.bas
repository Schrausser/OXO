! /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
!           tic-tac-toe for Android                                                                                  //
!       © 2017-23 by Dietmar Schrausser
! //
_name$="OXO"
_ver$="v2.5.1"
CONSOLE.TITLE _name$
INCLUDE strg.txt
s1$="×" % //CHR$(9711)
s2$=CHR$(9673)
sf$=CHR$(9643)
swc=-1                                 % // Seitenschalter               //
sco1=0                                 % // Total Score                  // 
sco2=0                                 % //                              //
ssw=0
! // Auswahl Feld
ARRAY.LOAD set$[],"1,1","1,2","1,3","2,1","2,2","2,3","3,1","3,2","3,3"
st0: % // Start
DIM oxo[3,3]                           % // Spiel Feld, oxo[3,3,3]       //
DIM sumf[8]                            % // Summenvektor, sumf[3,8]      //
FOR i=1 TO 9                           % // Main                         //
 swc=swc*-1                            % // Seitenschalter               //
 CLS
 IF sco1<3|sco2<3                      % // Spielende                    //
  IF i=9 :GOSUB enp:GOTO enpn:ENDIF
  PAUSE 10
  SW.BEGIN swc 
   SW.CASE -1:GOSUB rot  :SW.BREAK
   SW.CASE 1 :GOSUB blau :SW.BREAK
  SW.END
 ENDIF
 enpn:
 GOSUB hc                              % // Display                      //
 GOSUB f                               % // Summationen                  //
 FOR sm=1 TO 8                         % // Sieg Abfrage                 //
  IF sumf[sm]=3:PRINT"YOU WON":sco1=sco1+1:PAUSE 2000:GOTO st0:ENDIF
  IF sumf[sm]=-3:PRINT"I WON":sco2=sco2+1:PAUSE 2000:GOTO st0:ENDIF
 NEXT sm
 IF i<9
  IF swc=-1 THEN PAUSE 4000
 ENDIF
 PAUSE 1000
NEXT % // Main End 
GOTO st0
ONBACKKEY:
GOSUB fin
BACK.RESUME
ONERROR:
GOSUB fin
END
! //
hc:                                     % // Display                     //
PRINT INT$(sco1)+":"+INT$(sco2)
IF sco1=3: PAUSE 500: PRINT"YOU WON!":GOSUB fin:ENDIF
IF sco2=3: PAUSE 500: PRINT"I WON!":GOSUB fin:ENDIF
FOR j=1 TO 3 
 f1$=sf$
 f2$=sf$
 f3$=sf$
 IF oxo[j,1]=1 THEN f1$=s2$
 IF oxo[j,2]=1 THEN f2$=s2$
 IF oxo[j,3]=1 THEN f3$=s2$
 IF oxo[j,1]=-1 THEN f1$=s1$
 IF oxo[j,2]=-1 THEN f2$=s1$
 IF oxo[j,3]=-1 THEN f3$=s1$
 PRINT f1$+CHR$(9)+CHR$(9)+CHR$(9)+CHR$(9)+f2$+CHR$(9)+CHR$(9)+CHR$(9)+CHR$(9)+f3$
NEXT
RETURN
! //
f:                                      % // Summationen                 //
FOR k=1 TO 3
 sumf[k]=  oxo[k,1]+oxo[k,2]+oxo[k,3]
 sumf[k+3]=oxo[1,k]+oxo[2,k]+oxo[3,k]
NEXT k
sumf[7]=oxo[1,1]+oxo[2,2]+oxo[3,3]
sumf[8]=oxo[1,3]+oxo[2,2]+oxo[3,1]
RETURN
blau: % // Spieler Zug
IF sco2<3
 DIALOG.SELECT set, set$[],"OXO Field …"
 IF set=1:bx=1:by=1:ENDIF
 IF set=2:bx=1:by=2:ENDIF
 IF set=3:bx=1:by=3:ENDIF
 IF set=4:bx=2:by=1:ENDIF
 IF set=5:bx=2:by=2:ENDIF
 IF set=6:bx=2:by=3:ENDIF
 IF set=7:bx=3:by=1:ENDIF
 IF set=8:bx=3:by=2:ENDIF
 IF set=9:bx=3:by=3:ENDIF
 IF oxo[bx,by]=0:oxo[bx,by]=1
 ELSE
  GOTO blau 
 ENDIF
ENDIF
RETURN
! //     
rot:                                    % // AI Zug Berechnung           //
FOR sm1=1to8
 IF ABS(sumf[sm1])>1 THEN ssw=1
NEXT
IF ssw=0
 IF oxo[3,1]=-1&oxo[1,2]=-1&oxo[3,2]=0:oxo[3,2]=-1:GOTO n1
 ENDIF
 IF oxo[3,1]=-1&oxo[1,2]=-1&oxo[1,1]=0:oxo[1,1]=-1:GOTO n1
 ENDIF
 IF oxo[3,3]=-1&oxo[1,2]=-1&oxo[3,2]=0:oxo[3,2]=-1:GOTO n1
 ENDIF
 IF oxo[3,3]=-1&oxo[1,2]=-1&oxo[1,3]=0:oxo[1,3]=-1:GOTO n1
 ENDIF
 IF oxo[1,1]=-1&oxo[3,2]=-1&oxo[3,1]=0:oxo[3,1]=-1:GOTO n1
 ENDIF
 IF oxo[1,1]=-1&oxo[3,2]=-1&oxo[1,2]=0:oxo[1,2]=-1:GOTO n1
 ENDIF
 IF oxo[1,3]=-1&oxo[3,2]=-1&oxo[3,3]=0:oxo[3,3]=-1:GOTO n1
 ENDIF
 IF oxo[1,3]=-1&oxo[3,2]=-1&oxo[1,2]=0:oxo[1,2]=-1:GOTO n1
 ENDIF
 IF oxo[2,2]=0
  IF (oxo[1,2]=-1&oxo[2,1]=-1)| (oxo[1,2]=-1&oxo[2,3]=-1)| (oxo[3,2]=-1&oxo[2,1]=-1)| (oxo[3,2]=-1&oxo[2,3]=-1)
   oxo[2,2]=-1
   GOTO n1
  ENDIF
 ENDIF
 rn:
 fx=INT(RND()*3)+1
 fy=INT(RND()*3)+1
 IF oxo[fx,fy]=0
  IF fx=1&fy=2&oxo[1,1]<>0&oxo[1,3]<>0 THEN GOTO rn
  IF fx=2&fy=1&oxo[1,1]<>0&oxo[3,1]<>0 THEN GOTO rn
  IF fx=3&fy=2&oxo[3,1]<>0&oxo[3,3]<>0 THEN GOTO rn
  IF fx=2&fy=3&oxo[1,3]<>0&oxo[3,3]<>0 THEN GOTO rn
  oxo[fx,fy]=-1
 ELSE
  GOTO rn
 ENDIF
ELSE 
 fg=-2
 fsl1:
 s=1
 fsln:
 IF oxo[s,1]=0&oxo[s,2]+oxo[s,3]=fg: oxo[s,1]=-1:GOTO n1:ENDIF
 IF oxo[s,2]=0&oxo[s,1]+oxo[s,3]=fg: oxo[s,2]=-1:GOTO n1:ENDIF
 IF oxo[s,3]=0&oxo[s,1]+oxo[s,2]=fg: oxo[s,3]=-1:GOTO n1:ENDIF
 IF oxo[1,s]=0&oxo[2,s]+oxo[3,s]=fg: oxo[1,s]=-1:GOTO n1:ENDIF
 IF oxo[3,s]=0&oxo[1,s]+oxo[2,s]=fg: oxo[3,s]=-1:GOTO n1:ENDIF
 IF oxo[2,s]=0&oxo[1,s]+oxo[3,s]=fg: oxo[2,s]=-1:GOTO n1:ENDIF
 s=s+1
 IF s<4 THEN GOTO fsln
 IF oxo[1,1]=0&oxo[2,2]+oxo[3,3]=fg: oxo[1,1]=-1:GOTO n1:ENDIF 
 IF oxo[2,2]=0&oxo[1,1]+oxo[3,3]=fg: oxo[2,2]=-1:GOTO n1:ENDIF 
 IF oxo[3,3]=0&oxo[1,1]+oxo[2,2]=fg: oxo[3,3]=-1:GOTO n1:ENDIF
 IF oxo[3,1]=0&oxo[2,2]+oxo[1,3]=fg: oxo[3,1]=-1:GOTO n1:ENDIF 
 IF oxo[2,2]=0&oxo[3,1]+oxo[1,3]=fg: oxo[2,2]=-1:GOTO n1:ENDIF 
 IF oxo[1,3]=0&oxo[3,1]+oxo[2,2]=fg: oxo[1,3]=-1:GOTO n1:ENDIF
 fg=fg+4 % // +1
 IF fg<5 THEN GOTO fsl1
ENDIF
n1:
ssw=0
RETURN
! //
enp:                                      % // Letzt Zug                   //                 
FOR in=1to3:FOR jn=1to3
  IF oxo[in,jn]=0 THEN oxo[in,jn]=swc
NEXT:NEXT
RETURN
! //
fin:                                      % // Ende                        //
PRINT _name$+" tic-tac-toe for Android "+_ver$
PRINT"Copyright "+_cr$+" 2017-23 by Dietmar Gerald Schrausser"
PRINT"http://github.com/Schrausser/OXO"
PRINT"DOI:10.5281/zenodo.7651859"
END
RETURN
! // END //
! //
