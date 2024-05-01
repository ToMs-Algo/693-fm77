
      PROGRAM TEST
C                                                           3-21-90
C
C  This is a small test driver for the FM package.  Several constants
C  are computed and printed to 40 decimal accuracy.  FM numbers are
C  stored in packed format in the main program and calls are to the
C  packed version of each function (e.g., CALL FPADD instead of
C  CALL FMADD).
C
C  The output from this program should be:
C
C  SQRT(3) =
C        1.7320508075688772935274463415058723669428
C
C  2**(1/3) =
C        1.2599210498948731647672106072782283505703
C
C  LN(2) =
C        .6931471805599453094172321214581765680755
C
C  PI =
C        3.1415926535897932384626433832795028841972
C
C  SQRT(PI) =
C        1.7724538509055160272981674833411451827975
C
C  EXP(1) =
C        2.7182818284590452353602874713526624977572
C
C  LN(PI) =
C        1.1447298858494001741434273513530587116473
C
C  EXP(PI/4) =
C        2.1932800507380154565597696592787382234616
C
C  SIN(1) =
C        .8414709848078965066525023216302989996226
C
C  PHI =
C        1.6180339887498948482045868343656381177203
C
C  LN(PHI) =
C        .4812118250596034474977589134243684231352
C
C
      PARAMETER ( MXNDIG=256 , NBITS=32 ,
     *          LPACK  = (MXNDIG+1)/2 + 1 , LUNPCK = (6*MXNDIG)/5 + 20,
     *          LMWA   = 2*LUNPCK         , LJSUMS = 8*LUNPCK,
     *          LMBUFF = ((LUNPCK+3)*(NBITS-1)*301)/2000 + 6  )
C
      CHARACTER *80 RESULT
      DIMENSION MX(LPACK),MY(LPACK),MZ(LPACK)
C
      COMMON /FMUSER/ NDIG,JBASE,JFORM1,JFORM2,KRAD,
     *                KW,NTRACE,LVLTRC,KFLAG,KWARN,KROUND
C
      DOUBLE PRECISION DPMAX
C
      COMMON /FM/ MWA(LMWA),NCALL,MXEXP,MXEXP2,KARGSW,KEXPUN,KEXPOV,
     *            KUNKNO,IUNKNO,RUNKNO,MXBASE,MXNDG2,KSTACK(19),
     *            MAXINT,SPMAX,DPMAX
C
      COMMON /FMSAVE/ NDIGPI,NJBPI,NDIGE,NJBE,NDIGLB,NJBLB,NDIGLI,NJBLI,
     *                MPISAV(LUNPCK),MESAV(LUNPCK),MLBSAV(LUNPCK),
     *                MLN1(LUNPCK),MLN2(LUNPCK),MLN3(LUNPCK),
     *                MLN4(LUNPCK)
C
      NOGOOD = 0
C
C             Set precision to give at least 40 significant digits, and
C             initialize all FM parameters.  Set the print format to
C             give fixed point output with 40 places after the decimal.
C
      CALL FPSET(40)
      JFORM1 = 2
      JFORM2 = 40
C
      KW = 11
      OPEN(KW,FILE='TEST.OUT')
C
      CALL FPI2M(3,MX)
      CALL FPSQRT(MX,MY)
      WRITE (KW,110)
  110 FORMAT(/' SQRT(3) =')
      CALL FPPRNT(MY)
      RESULT = ' 1.7320508075688772935274463415058723669428'
      CALL CHECK(RESULT,MY,NOGOOD,KW)
C
      CALL FPI2M(1,MY)
      CALL FPDIV(MY,MX,MY)
      CALL FPI2M(2,MX)
      CALL FPPWR(MX,MY,MZ)
      WRITE (KW,120)
  120 FORMAT(/' 2**(1/3) =')
      CALL FPPRNT(MZ)
      RESULT = ' 1.2599210498948731647672106072782283505703'
      CALL CHECK(RESULT,MZ,NOGOOD,KW)
C
      CALL FPLN(MX,MZ)
      WRITE (KW,130)
  130 FORMAT(/' LN(2) =')
      CALL FPPRNT(MZ)
      RESULT = ' .6931471805599453094172321214581765680755'
      CALL CHECK(RESULT,MZ,NOGOOD,KW)
C
      CALL FPPI(MZ)
      WRITE (KW,140)
  140 FORMAT(/' PI =')
      CALL FPPRNT(MZ)
      RESULT = ' 3.1415926535897932384626433832795028841972'
      CALL CHECK(RESULT,MZ,NOGOOD,KW)
C
      CALL FPSQRT(MZ,MZ)
      WRITE (KW,150)
  150 FORMAT(/' SQRT(PI) =')
      CALL FPPRNT(MZ)
      RESULT = ' 1.7724538509055160272981674833411451827975'
      CALL CHECK(RESULT,MZ,NOGOOD,KW)
C
      CALL FPI2M(1,MX)
      CALL FPEXP(MX,MZ)
      WRITE (KW,160)
  160 FORMAT(/' EXP(1) =')
      CALL FPPRNT(MZ)
      RESULT = ' 2.7182818284590452353602874713526624977572'
      CALL CHECK(RESULT,MZ,NOGOOD,KW)
C
      CALL FPPI(MX)
      CALL FPLN(MX,MZ)
      WRITE (KW,170)
  170 FORMAT(/' LN(PI) =')
      CALL FPPRNT(MZ)
      RESULT = ' 1.1447298858494001741434273513530587116473'
      CALL CHECK(RESULT,MZ,NOGOOD,KW)
C
      CALL FPDIVI(MX,4,MY)
      CALL FPEXP(MY,MZ)
      WRITE (KW,180)
  180 FORMAT(/' EXP(PI/4) =')
      CALL FPPRNT(MZ)
      RESULT = ' 2.1932800507380154565597696592787382234616'
      CALL CHECK(RESULT,MZ,NOGOOD,KW)
C
      CALL FPI2M(1,MX)
      CALL FPSIN(MX,MZ)
      WRITE (KW,190)
  190 FORMAT(/' SIN(1) =')
      CALL FPPRNT(MZ)
      RESULT = ' .8414709848078965066525023216302989996226'
      CALL CHECK(RESULT,MZ,NOGOOD,KW)
C
      CALL FPI2M(5,MX)
      CALL FPSQRT(MX,MX)
      CALL FPI2M(1,MY)
      CALL FPADD(MX,MY,MY)
      CALL FPDIVI(MY,2,MZ)
      WRITE (KW,200)
  200 FORMAT(/' PHI =')
      CALL FPPRNT(MZ)
      RESULT = ' 1.6180339887498948482045868343656381177203'
      CALL CHECK(RESULT,MZ,NOGOOD,KW)
C
      CALL FPLN(MZ,MZ)
      WRITE (KW,210)
  210 FORMAT(/' LN(PHI) =')
      CALL FPPRNT(MZ)
      RESULT = ' .4812118250596034474977589134243684231352'
      CALL CHECK(RESULT,MZ,NOGOOD,KW)
C
      IF (NOGOOD.EQ.0) THEN
          WRITE (KW,220)
  220     FORMAT(//' TEST COMPLETED.  NO ERRORS.'//)
      ELSE IF(NOGOOD.EQ.1) THEN
          WRITE (KW,230)
  230     FORMAT(//' TEST COMPLETED.  1 ERROR.'//)
      ELSE
          WRITE (KW,240) NOGOOD
  240     FORMAT(//' TEST COMPLETED.',I4,' ERRORS.'//)
      ENDIF
C
      STOP
      END
      SUBROUTINE CHECK(RESULT,MX,NOGOOD,KW)
C
C  Check to see that the computed result MX agrees with the
C  correct output RESULT.
C
C  NOGOOD counts the number of cases where errors were found.
C
      PARAMETER ( MXNDIG=256 , NBITS=32 ,
     *          LPACK  = (MXNDIG+1)/2 + 1 , LUNPCK = (6*MXNDIG)/5 + 20,
     *          LMWA   = 2*LUNPCK         , LJSUMS = 8*LUNPCK,
     *          LMBUFF = ((LUNPCK+3)*(NBITS-1)*301)/2000 + 6  )
C
      CHARACTER *80 RESULT
      CHARACTER LINE(80)
      DIMENSION MX(LPACK)
C
      CALL FPOUT(MX,LINE,80)
      DO 120 J = 1, 80
         IF (LINE(J).NE.RESULT(J:J)) THEN
             NOGOOD = NOGOOD + 1
             WRITE (KW,110) RESULT
  110        FORMAT(/' ERROR IN ROOTS.  THE CORRECT RESULT SHOULD BE:'
     *              //6X,A/)
             RETURN
         ENDIF
  120 CONTINUE
      RETURN
      END