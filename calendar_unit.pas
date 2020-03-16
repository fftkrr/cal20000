unit calendar_unit;

interface

uses sysutils;

const
  montharray : array[0..24] of integer =
               (0,21355,42843,64498,86335,108366,130578,152958,
                175471,198077,220728,243370,265955,288432,310767,332928,
                354903,376685,398290,419736,441060,462295,483493,504693,525949);
  { ����������� 24������ ���������� ���� - �� }
  {  yearmin := 525948.75 ; - ���� 1����� (��)
     yearmini := 525949 ; - �ٻ�ġ (���� 3456�⿡ 1��)}

{  solorlat : array[0..24] of smallint =
              (315,330,345,0,15,30,45,60,75,90,105,120,135,150,165,180,195,210,
               225,240,255,270,285,300,315); }

  monthst : array[0..24] of string =
          ('����','���','��Ĩ','���','û��','���',
           '����','�Ҹ�','����','����','�Ҽ�','�뼭',
           '����','ó��','���','�ߺ�','�ѷ�','��',
           '�Ե�','�Ҽ�','�뼳','����','����','����','����');
  gan : array[0..9] of string =
          ('ˣ','��','ܰ','��','��','��','��','��','��','ͤ');
  ji : array[0..11] of string =
          ('�','��','��','��','��','��','��','ڱ','��','�','��','��');
  ganji : array[0..59] of string =
       ('ˣ�','����','ܰ��','����','����',
        '����','����','��ڱ','����','ͤ�',
        'ˣ��','����','ܰ�','����','����',

        '����','����','����','����','ͤڱ',
        'ˣ��','���','ܰ��','����','���',
        '����','����','����','����','ͤ��',

        'ˣ��','��ڱ','ܰ��','���','����',
        '����','���','����','����','ͤ��',
        'ˣ��','����','ܰ��','��ڱ','����',

        '���','����','����','���','ͤ��',
        'ˣ��','����','ܰ��','����','����',
        '��ڱ','����','���','����','ͤ��');

  weekday : array[0..6] of string =
               ('�Ͽ���','������','ȭ����','������','�����','�ݿ���','�����');

  s28day : array[0..27] of string =
             ('��','��','��','ۮ','��','ڭ','ѹ',
              '��','��','��','��','��','��','��',
              'Х','��','��','��','��','��','߳',
              '��','С','��','��','��','��','��');

  {���ڳ� ���ο� �Ź��� ���ؽ� - ���� }
  unityear  : integer = 1996;
  unitmonth : byte = 2;
  unitday   : byte = 4;
  unithour  : byte = 22;
  unitmin   : byte = 8;
  unitsec   : byte = 0;

 {1996�� ���� 1�� 1�� �ջ� �Ͻ� }
  unitmyear : integer =1996;
  unitmmonth : byte=2;
  unitmday : byte=19;
  unitmhour : byte=8;
  unitmmin : byte=30;
  unitmsec : byte=0;
  moonlength : cardinal= 42524 ; { =42524�� 2.9�� }

{ var }


// solor - �׷����� ����Ͻú�
// so24 - 60���� ���, so24year
// so24year,so24month,so24day,so24hour - 60������ ��ȣ
// �׷����� ����Ͻú� --->  60���� ���,����,����(�¾��),����,����
procedure sydtoso24yd(const soloryear:integer;const solormonth,solorday,solorhour,solormin:smallint;
                      var so24:integer;var so24year,so24month,so24day,so24hour:shortint );

// �׷����� ����Ͻú��� ����ִ� ������ �̸���ȣ,����Ͻú��� ����
procedure SolortoSo24(const soloryear:integer;const solormonth,solorday,solorhour,solormin : smallint;
                      var inginame:smallint; var ingiyear:integer; var ingimonth,ingiday,ingihour,ingimin : smallint;
                      var midname:smallint;var midyear:integer;var midmonth,midday,midhour,midmin : smallint;
                      var outginame:smallint;var outgiyear:integer;var outgimonth,outgiday,outgihour,outgimin : smallint);


//  �׷����� �����--> ���� �����,����,���
{procedure solortolunar(const solyear,solmon,solday:smallint;
                       var lyear,lmonth,lday:smallint;
                       var lmoonyun,largemonth:boolean); }

procedure solortolunar(const solyear:integer;solmon,solday:smallint;
                       var lyear:integer;var lmonth,lday:smallint;
                       var lmoonyun,largemonth:boolean);

//  ���� ���������-->�׷����� �����
//procedure lunartosolar(const lyear,lmonth,lday:smallint;const moonyun:boolean;var syear,smonth,sday:smallint);

procedure lunartosolar(const lyear:integer;lmonth,lday:smallint;
                       const moonyun:boolean;
                       var syear:integer;var smonth,sday:smallint);


// �׷����� ������� ����ִ� �������� �����ջ�����,���Ͻ�,���ջ��Ͻ� IP-����Ȳ��
procedure getlunarfirst(const syear:integer;const smonth,sday:smallint;
                        var year:integer;var month,day,hour,min:smallint;var ip:extended;
                        var yearm:integer;var monthm,daym,hourm,minm:smallint;var ipm:extended;
                        var year1:integer;var month1,day1,hour1,min1:smallint;var ip1:extended);


// �׷����� ��¥->����
// function getweekday(const syear,smonth,sday:smallint):smallint;
function getweekday(const syear:integer; const smonth,sday:smallint):smallint;

// �׷����³�¥->28�� ����
//function get28sday(const syear,smonth,sday:smallint):smallint;
function get28sday(const syear:integer;const smonth,sday:smallint):smallint;

// uyear,umonth,uday,uhour,umin���κ��� tmin(��)������ ������ ����Ͻú�(�¾��)
procedure getdatebymin(const tmin : int64;
                       const uyear:integer;const umonth,uday,uhour,umin:smallint;
                       var y1:integer;var mo1,d1,h1,mi1 : smallint );


// uy,umm,ud,uh,umin�� y1,mo1,d1,h1,mm1������ �ð�(��)
function  getminbytime(const uy:integer;const umm,ud,uh,umin:smallint;const y1:integer; const mo1,d1,h1,mm1:smallint):int64 ;

function getjuliandate(const syear:integer; const smonth,sday:smallint):integer;
function getjuliandate_point(const syear:integer; const smonth,sday,shour,smin:smallint):Extended  ;

implementation

function  disptimeday(const year:integer;month,day:smallint):smallint;
{ year�� 1�� 1�Ϻ��� year�� month��, day�ϱ����� ������� }
var
  i,e : smallint;
begin
  e := 0 ;
  for i := 1 to month - 1 do
  begin
    e := e + 31;
    if (i=2) or (i=4) or (i=6) or (i=9) or (i=11) then e:=e-1;
    if i=2 then
    begin
      e:=e-2 ;
      if year mod 4 = 0 then e := e + 1;
      if year mod 100 = 0 then e := e - 1;
      if year mod 400 = 0 then e := e + 1;
      if year mod 4000 = 0 then e := e - 1
    end
  end;
  disptimeday:=e + day
end;

function disp2days(const y1:integer;m1,d1:smallint;y2:integer;m2,d2:smallint):integer;
{y1,m1,d1�Ϻ��� y2,m2,d2������ �ϼ� ��� }
var
  p1,p2,p1n,pp1,pp2,pr,i,dis,ppp1,ppp2 : integer ;
begin
  if y2 > y1 then
  begin
    p2 := disptimeday(y2,m2,d2);
    p1 := disptimeday(y1,m1,d1);
    p1n := disptimeday(y1,12,31);
    pp1 := y1 ; pp2 := y2 ;
    pr := -1
  end
  else
  begin
    p1 := disptimeday(y2,m2,d2);
    p1n := disptimeday(y2,12,31);
    p2 := disptimeday(y1,m1,d1);
    pp1 := y2 ; pp2 := y1;
    pr := +1
  end;
  if y2 = y1 then dis := p2-p1
  else
  begin
    dis := p1n-p1 ;
    ppp1 := pp1 + 1 ;
    ppp2 := pp2 - 1 ;

    i:=dis;
(*  ppp2 := 1990 ;
    i := 0;   *)

(*  for k := ppp1 to ppp2 do  { �ӵ������κ� }
    begin
      dis := dis + disptimeday(k,12,31);
{     i :=  i + disptimeday(k,12,31); }
    end;  *)

    while ppp1 <= ppp2 do
    begin

      if (ppp1=-9000) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 4014377
      end;
      if (ppp1=-8000) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 3649135
      end;
      if (ppp1=-7000) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 3283893
      end;
      if (ppp1=-6000) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 2918651
      end;
      if (ppp1=-5000) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 2553408
      end;
      if (ppp1=-4000) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 2188166
      end;
      if (ppp1=-3000) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 1822924
      end;


      if (ppp1=-2000) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 1457682
      end;
      if (ppp1=-1750) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 1366371
      end;
      if (ppp1=-1500) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 1275060
      end;
      if (ppp1=-1250) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 1183750
      end;
      if (ppp1=-1000) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 1092439
      end;
      if (ppp1=-750) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 1001128
      end;
      if (ppp1=-500) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 909818
      end;
      if (ppp1=-250) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 818507
      end;
      if (ppp1=0) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 727197
      end;
      if (ppp1=250) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 635887
      end;
      if (ppp1=500) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 544576
      end;
      if (ppp1=750) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 453266
      end;
      if (ppp1=1000) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 361955
      end;
      if (ppp1=1250) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 270644
      end;
      if (ppp1=1500) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 179334
      end;
      if (ppp1=1750) and (ppp2>1990) then
      begin
        ppp1 := 1991 ;
        i := i + 88023
      end;

      i := i + disptimeday(ppp1,12,31);
      ppp1 := ppp1 + 1
    end ;
    dis := i;

    dis := dis + p2 ;
    dis := dis * pr
  end;
  disp2days := dis
end;

{Ư���������� Ư������������ �� }
function  getminbytime(const uy:integer;const umm,ud,uh,umin:smallint;const y1:integer; const mo1,d1,h1,mm1:smallint):int64 ;
var
  dispday,t : int64 ;
begin
  dispday:=disp2days(uy,umm,ud,y1,mo1,d1);
  t := dispday * 24 * 60 + (uh-h1)* 60 + (umin-mm1) ;
  getminbytime :=t
end;


procedure getdatebymin(const tmin : int64;
                       const uyear:integer;const umonth,uday,uhour,umin:smallint;
                       var y1:integer;var mo1,d1,h1,mi1 : smallint );
{1996�� 2�� 4�� 22�� 8�к��� tmin�� ������ ���ڿ� �ð��� ���ϴ� ���ν���
 Ư������(udate)���κ��� tmin�� ������ ��¥�� ���ϴ� ���ν��� }
var
  t: int64;
begin
  y1 := uyear - tmin div 525949 ;
  if tmin >= 0 then
  begin
    y1 := y1 + 2 ;
    repeat
      y1 := y1 - 1 ;
      t := getminbytime(uyear,umonth,uday,uhour,umin,y1,1,1,0,0);
    until t >= tmin ;
    mo1 := 13 ;
    repeat
      mo1 := mo1 - 1 ;
      t := getminbytime(uyear,umonth,uday,uhour,umin,y1,mo1,1,0,0);
    until t >= tmin  ;
    d1 := 32;
    repeat
      d1 := d1 - 1 ;
      t := getminbytime(uyear,umonth,uday,uhour,umin,y1,mo1,d1,0,0);
    until t >= tmin ;
    h1 := 24 ;
    repeat
      h1 := h1 - 1 ;
      t := getminbytime(uyear,umonth,uday,uhour,umin,y1,mo1,d1,h1,0);
    until t >= tmin ;
    t := getminbytime(uyear,umonth,uday,uhour,umin,y1,mo1,d1,h1,0);
    mi1 :=  t - tmin
  end
  else
  begin
    y1 := y1 - 2 ;
    repeat
      y1 := y1 + 1;
      t := getminbytime(uyear,umonth,uday,uhour,umin,y1,1,1,0,0);
    until t < tmin;
    y1 := y1 - 1 ;
    mo1 := 0;
    repeat
      mo1 := mo1 + 1;
      t := getminbytime(uyear,umonth,uday,uhour,umin,y1,mo1,1,0,0);
    until t < tmin ;
    mo1 := mo1 - 1;
    d1 := 0;
    repeat
      d1 := d1 + 1;
      t := getminbytime(uyear,umonth,uday,uhour,umin,y1,mo1,d1,0,0);
    until t < tmin ;
    d1 := d1 - 1 ;
    h1 := -1 ;
    repeat
      h1 := h1 + 1;
      t := getminbytime(uyear,umonth,uday,uhour,umin,y1,mo1,d1,h1,0);
    until t < tmin ;
    h1 := h1 - 1;
    t := getminbytime(uyear,umonth,uday,uhour,umin,y1,mo1,d1,h1,0) ;
    mi1 := t - tmin
  end
end;

procedure sydtoso24yd(const soloryear:integer;const solormonth,solorday,solorhour,solormin:smallint;
                      var so24:integer; var so24year,so24month,so24day,so24hour:shortint );
var
  displ2min : int64;
  displ2day,monthmin100,j,t : integer ;
  i : integer;
begin
  displ2min := getminbytime(unityear,unitmonth,unitday,unithour,unitmin,
                            soloryear,solormonth,solorday,solorhour,solormin);
  displ2day := disp2days(unityear,unitmonth,unitday,soloryear,solormonth,solorday) ;
  so24 :=  displ2min div 525949  ; { ���γ�(1996)����������� �ش��Ͻñ��� ������ }

  if displ2min >= 0  then so24 := so24 + 1;
  so24year := -1 * (so24 mod 60) ;
  so24year := so24year + 12 ;
  if so24year < 0 then so24year := so24year + 60 ;
  if so24year > 59 then so24year := so24year - 60 ;  { ���� ���� �� }

  monthmin100 := displ2min mod 525949 ;
  monthmin100 := 525949 - monthmin100 ;

  if monthmin100 <  0 then monthmin100 := monthmin100 + 525949 ;
  if monthmin100 >= 525949 then monthmin100 := monthmin100 - 525949   ;

  for i := 0 to 11 do
  begin
    j := i * 2 ;
    if  (montharray[j] <= monthmin100) and (monthmin100 < montharray[j+2]) then
    begin
      so24month := i;
    end
  end;

  i := so24month;
  t := so24year mod 10 ;
  t := t mod 5 ;
  t := t * 12 + 2 + i;
  so24month := t ;  { ���� ���� �� }
  if so24month > 59 then so24month := so24month - 60 ;

  so24day := displ2day mod 60 ;
  so24day := -1 * so24day  ;
  so24day := so24day + 7;

  if so24day < 0 then so24day := so24day + 60 ;
  if so24day > 59 then so24day :=so24day - 60 ; { ���� ���� ��}

  if ( solorhour=0 ) or ((solorhour=1) and (solormin < 30)) then i:= 0;

  if ((solorhour=1) and (solormin >= 30 )) or (solorhour=2) or
     ((solorhour=3) and (solormin<30)) then i:=1;

  if (( solorhour=3) and (solormin >= 30 )) or (solorhour=4) or
     ((solorhour=5) and (solormin<30 )) then i:=2;

  if (( solorhour=5) and (solormin >= 30 )) or (solorhour=6) or
     ((solorhour=7) and (solormin<30 )) then i:=3;

  if (( solorhour=7) and (solormin >= 30 )) or (solorhour=8) or
     ((solorhour=9) and (solormin<30)) then i:=4;

  if (( solorhour=9) and (solormin >= 30 )) or (solorhour=10) or
     ((solorhour=11) and (solormin<30 )) then i:=5;

  if (( solorhour=11) and (solormin >= 30 )) or (solorhour=12) or
     ((solorhour=13) and (solormin<30 )) then i:=6;

  if (( solorhour=13) and (solormin >= 30 )) or (solorhour=14) or
     ((solorhour=15) and (solormin<30 )) then i:=7;

  if (( solorhour=15) and (solormin >= 30 )) or (solorhour=16) or
     ((solorhour=17) and (solormin<30 )) then i:=8;

  if (( solorhour=17) and (solormin >= 30 )) or (solorhour=18) or
     ((solorhour=19) and (solormin<30 )) then i:=9;

  if (( solorhour=19) and (solormin >= 30 )) or (solorhour=20) or
     ((solorhour=21) and (solormin<30 )) then i:=10;

  if (( solorhour=21) and (solormin >= 30 )) or (solorhour=22) or
     ((solorhour=23) and (solormin<30 )) then i:=11;

  if ( solorhour=23) and (solormin >= 30 ) then
  begin
    so24day := so24day + 1;
    if so24day = 60 then so24day:=0;
    i := 0
  end;

  t := so24day mod 10 ;
  t := t mod 5 ;
  t := t * 12 + i;
  so24hour := t    {���� ���� �� }
end;

procedure SolortoSo24(const soloryear:integer;const solormonth,solorday,solorhour,solormin : smallint;
                      var inginame:smallint; var ingiyear:integer; var ingimonth,ingiday,ingihour,ingimin : smallint;
                      var midname:smallint;var midyear:integer;var midmonth,midday,midhour,midmin : smallint;
                      var outginame:smallint;var outgiyear:integer;var outgimonth,outgiday,outgihour,outgimin : smallint);
var
  i,monthmin100,j : integer;
  tmin,displ2min : int64;
  y1:integer;
  mo1,d1,h1,mi1 : smallint;
  so24 : integer;
  so24year,so24month,so24day,so24hour:shortint;
begin
  sydtoso24yd(soloryear,solormonth,solorday,solorhour,solormin,
              so24,so24year,so24month,so24day,so24hour);
  displ2min := getminbytime(unityear,unitmonth,unitday,unithour,unitmin,
                            soloryear,solormonth,solorday,solorhour,solormin);

  monthmin100 := displ2min mod 525949 ;
  monthmin100 := 525949 - monthmin100 ;

  if monthmin100 <  0 then monthmin100 := monthmin100 + 525949 ;
  if monthmin100 >= 525949 then monthmin100 := monthmin100 - 525949   ;

  i := so24month mod 12 - 2 ;
  if i=-2 then i := 10  ;
  if i=-1 then i := 11 ;

  inginame :=i*2;
  midname :=i*2+1;
  outginame :=i*2+2;

  j := i * 2 ;
  tmin :=  displ2min +  ( monthmin100 - montharray[j]);
  getdatebymin(tmin,unityear,unitmonth,unitday,unithour,unitmin,y1,mo1,d1,h1,mi1);

  ingiyear:=y1;
  ingimonth:=mo1;
  ingiday:=d1;
  ingihour:=h1;
  ingimin :=mi1;

  tmin :=  displ2min + monthmin100 - montharray[j+1];
  getdatebymin(tmin,unityear,unitmonth,unitday,unithour,unitmin,y1,mo1,d1,h1,mi1);

  midyear:=y1;
  midmonth:=mo1;
  midday:=d1;
  midhour:=h1;
  midmin :=mi1;

  tmin :=  displ2min + monthmin100 - montharray[j+2];
  getdatebymin(tmin,unityear,unitmonth,unitday,unithour,unitmin,y1,mo1,d1,h1,mi1);

  outgiyear:=y1;
  outgimonth:=mo1;
  outgiday:=d1;
  outgihour:=h1;
  outgimin :=mi1
end;

function degreelow(const d:extended):extended;
var
  i : int64 ;
  di : extended ;
begin
  di := d;
  i := trunc(di);
  i := i div 360 ;
  di := di - ( 360 * i );

  while ((di >= 360) or (di < 0))  do
  begin
    if di > 0 then di:=di-360
              else di:=di+360
  end;
  degreelow := di
end;

// �¾�Ȳ��� ��Ȳ���� ����
// = 0 : �ջ�
// =180 : ��
function moonsundegree(day:extended):extended;
var
  sl,smin,sminangle,sd,sreal,ml,mmin,mminangle,msangle,msdangle,md,mreal : extended;
begin { 1996�� ���� }
  sl:=day*0.98564736+278.956807;  { ��� Ȳ�� }
  smin:=282.869498+0.00004708*day; {������ Ȳ�� }
  sminangle := Pi*(sl-smin)/180 ; {�����̰� }
  sd := 1.919*SIN(sminangle)+0.02*SIN(2*sminangle); { Ȳ���� }
  sreal := degreelow(sl + sd) ; { ��Ȳ�� }

  ml := 27.836584+13.17639648*day; { ���Ȳ�� }
  mmin :=280.425774+0.11140356*day; { ������ Ȳ�� }
  mminangle :=Pi*(ml-mmin)/180; { �����̰� }
  msangle := 202.489407-0.05295377*day; { ����Ȳ�� }
  msdangle := Pi*(ml-msangle)/180; { �����̰� }
  md := 5.068889*SIN(mminangle)+0.146111*SIN(2*mminangle)+0.01*SIN(3*mminangle)
       -0.238056*SIN(sminangle)-0.087778*SIN(mminangle+sminangle)  { Ȳ���� }
       +0.048889*SIN(mminangle-sminangle)-0.129722*SIN(2*msdangle)
       -0.011111*SIN(2*msdangle-mminangle)-0.012778*SIN(2*msdangle+mminangle);
  mreal := degreelow(ml + md) ; { ��Ȳ�� }
  moonsundegree := degreelow(mreal-sreal)
end;


// ����Ȳ��� ���� Ȳ����� ����
// �Ͻ� : �ջ��϶� �� ���̰� 15.3�� �̳��̸� �Ͻ�Ȯ��
//                           18.5�� �̳��̸� �Ͻİ���
// ���� : ���϶� �� ���̰� 9.5�� �̳��̸� �Ͻ�Ȯ��
//                        12.2�� �̳��̸� �Ͻİ���
function interpointdisp(day:extended):extended ;
var
  sl,smin,sminangle,ml,mmin,mminangle,msangle,msdangle,md,mreal,
  ir : extended;

begin
  sl:=day*0.98564736+278.956807;  { ��� Ȳ�� }
  smin:=282.869498+0.00004708*day; {������ Ȳ�� }
  sminangle := Pi*(sl-smin)/180 ; {�����̰� }

  ml := 27.836584+13.17639648*day; { ���Ȳ�� }
  mmin :=280.425774+0.11140356*day; { ������ Ȳ�� }
  mminangle :=Pi*(ml-mmin)/180; { �����̰� }
  msangle := 202.489407-0.05295377*day; { ����Ȳ�� }
  msdangle := Pi*(ml-msangle)/180; { �����̰� }
  md := 5.068889*SIN(mminangle)+0.146111*SIN(2*mminangle)+0.01*SIN(3*mminangle)
       -0.238056*SIN(sminangle)-0.087778*SIN(mminangle+sminangle)  { Ȳ���� }
       +0.048889*SIN(mminangle-sminangle)-0.129722*SIN(2*msdangle)
       -0.011111*SIN(2*msdangle-mminangle)-0.012778*SIN(2*msdangle+mminangle);
  mreal := degreelow(ml + md) ; { ��Ȳ�� }

  ir:=degreelow(mreal-msangle);
  if ir > 90 then ir := ir-180;
  if ir > 90 then ir := ir-180;
  interpointdisp := ir
end;

{ syear,smonth,sday�� ���� �ջ��Ͻ�,���Ͻ� �� �ջ��Ͻ��� ����Ȳ�� }
procedure getlunarfirst(const syear:integer;const smonth,sday:smallint;
                        var year:integer;var month,day,hour,min:smallint;var ip:extended;
                        var yearm:integer;var monthm,daym,hourm,minm:smallint;var ipm:extended;
                        var year1:integer;var month1,day1,hour1,min1:smallint;var ip1:extended);
var
  dm,dem,
  d,de,pd: extended;
  i : int64;
begin
  dm:=disp2days(syear,smonth,sday,1995,12,31);
  dem :=moonsundegree(dm);

  d:=dm;
  de :=dem;

  while (de>13.5) do
  begin
    d := d - 1;
    de := moonsundegree(d);
  end;

  while (de>1) do
  begin
    d := d - 0.04166666666;
    de := moonsundegree(d);
  end;

  while (de<359.99) do
  begin
    d := d - 0.000694444;
    de := moonsundegree(d);
  end;

  ip:=interpointdisp(d);

  d := d+0.375;

  d := d*1440 ;
  i := -1*trunc(d);
  getdatebymin(i,1995,12,31,0,0,year,month,day,hour,min);

  d:=dm;
  de :=dem;

  while (de<346.5) do
  begin
    d := d + 1;
    de := moonsundegree(d);
  end;

  while (de<359) do
  begin
    d := d + 0.04166666666;
    de := moonsundegree(d);
  end;

  while (de>0.01) do
  begin
    d := d + 0.000694444;
    de := moonsundegree(d);
  end;

  ip1:=interpointdisp(d);
  pd := d ;

  d := d+0.375;

  d := d*1440 ;
  i := -1*trunc(d);
  getdatebymin(i,1995,12,31,0,0,year1,month1,day1,hour1,min1);

  if (smonth=month1) and (sday=day1) then
  begin
    year := year1;
    month := month1;
    day :=day1 ;
    hour := hour1;
    min := min1;

    d:=pd;
    ip := ip1;

    while (de<347) do
    begin
      d := d + 1;
      de := moonsundegree(d);
    end;
    while (de<359) do
    begin
      d := d + 0.04166666666;
      de := moonsundegree(d);
    end;
    while (de>0.01) do
    begin
      d := d + 0.000694444;
      de := moonsundegree(d);
    end;
    ip1:=interpointdisp(d);

    d := d+0.375;
    d := d*1440 ;
    i := -1*trunc(d);
    getdatebymin(i,1995,12,31,0,0,year1,month1,day1,hour1,min1)
  end;

  d:=disp2days(year,month,day,1995,12,31); // ���� ���Ϸ�
  d:=d+12; //���� 12��
  de :=moonsundegree(d);

  while (de<166.5) do
  begin
    d := d + 1;
    de := moonsundegree(d);
  end;

  while (de<179) do
  begin
    d := d + 0.04166666666;
    de := moonsundegree(d);
  end;

  while (de<179.99) do
  begin
    d := d + 0.000694444;
    de := moonsundegree(d);
  end;

  ipm:=interpointdisp(d);

  d := d+0.375;

  d := d*1440 ;
  i := -1*trunc(d);
  getdatebymin(i,1995,12,31,0,0,yearm,monthm,daym,hourm,minm);

end;

procedure solortolunar(const solyear:integer;solmon,solday:smallint;
                       var lyear:integer;var lmonth,lday:smallint;
                       var lmoonyun,largemonth:boolean);
var
  s0:int64 ;
  i : shortint;
  lnp,lnp2 : boolean;
  ingiyear,midyear1,midyear2,outgiyear:integer;
  inginame,ingimonth,ingiday,ingihour,ingimin,
  midname1,midmonth1,midday1,midhour1,midmin1,
  midname2,midmonth2,midday2,midhour2,midmin2,
  outginame,outgimonth,outgiday,outgihour,outgimin : smallint;
  smomonth,smoday,smohour,smomin :smallint;
  smoyear,y0,y1:integer;
  mo0,d0,h0,mi0,
  mo1,d1,h1,mi1 : smallint;
  ip,ip0,ip1:extended;

begin;

  getlunarfirst(solyear,solmon,solday,
                smoyear,smomonth,smoday,smohour,smomin,ip,
                y0,mo0,d0,h0,mi0,ip0,
                y1,mo1,d1,h1,mi1,ip1);

  lday:=disp2days(solyear,solmon,solday,smoyear,smomonth,smoday) + 1;

  i := abs(disp2days(smoyear,smomonth,smoday,y1,mo1,d1));
  if i=30 then largemonth := true ;
  if i=29 then largemonth := false ;

  SolortoSo24(smoyear,smomonth,smoday,smohour,smomin, {true,i,lnp, }
              inginame,ingiyear,ingimonth,ingiday,ingihour,ingimin,
              midname1,midyear1,midmonth1,midday1,midhour1,midmin1,
              outginame,outgiyear,outgimonth,outgiday,outgihour,outgimin);

  midname2:=midname1+2;
  if midname2 > 24 then midname2 := 1;
  s0 := montharray[midname2]-montharray[midname1];
  if s0 < 0 then s0:=s0 + 525949 ;
  s0 := -1 * s0 ;

  getdatebymin(s0, midyear1,midmonth1,midday1,midhour1,midmin1,
                   midyear2,midmonth2,midday2,midhour2,midmin2 ) ;

  if ( (midmonth1=smomonth) and (midday1>=smoday) ) or
     ( (midmonth1=mo1) and (midday1<d1)) then
  begin
    lmonth:=(midname1-1) div 2+1;
    lmoonyun:=false
  end
  else
    if ((midmonth2=mo1) and (midday2<d1)) or ((midmonth2=smomonth) and (midday2>=smoday)) then
    begin
      lmonth:=(midname2-1) div 2 + 1;
      lmoonyun:=false
    end
    else
    begin
      if (smomonth<midmonth2) and (midmonth2<mo1) then
      begin
        lmonth :=(midname2-1) div 2 + 1;
        lmoonyun := false
      end
      else
      begin
        lmonth:=(midname1-1) div 2 + 1;
        lmoonyun:=true
      end
    end;

  lyear := smoyear;
  if (lmonth=12) and (smomonth=1) then lyear:=lyear-1;

  if ((lmonth=11) and lmoonyun) or (lmonth=12) or (lmonth<6) then
  begin
    getdatebymin(2880, smoyear,smomonth,smoday,smohour,smomin,
                       midyear1,midmonth1,midday1,midhour1,midmin1 ) ;

    solortolunar(midyear1,midmonth1,midday1,
                 outgiyear,outgimonth,outgiday,
                 lnp,lnp2);
    outgiday := lmonth-1;
    if outgiday=0 then outgiday:=12;

    if outgiday=outgimonth then
    begin
      if lmoonyun then lmoonyun:=false
    end
    else
    begin
      if lmoonyun then
      begin
        if lmonth<>outgimonth then
        begin
          lmonth := lmonth-1;
          if lmonth=0 then lyear := lyear-1;
          if lmonth=0 then lmonth:=12;
          lmoonyun := false
        end
      end
      else
      begin
        if lmonth=outgimonth then
        begin
          lmoonyun := true;
        end
        else
        begin
          lmonth:=lmonth-1;
          if lmonth=0 then lyear := lyear-1;
          if lmonth=0 then lmonth:=12
        end
      end
    end
  end
end;

{
procedure lunartosolar(const lyear:integer;lmonth,lday:smallint;
                       const moonyun:boolean;
                       var syear:integer;smonth,sday:smallint);
var
  lnp,lnp2 : boolean;
  inginame,ingimonth,ingiday,ingihour,ingimin : smallint;
  midname,midmonth,midday,midhour,midmin : smallint;
  outginame,outgimonth,outgiday,outgihour,outgimin : smallint   ;
  tmin : int64 ;
  year0,year1,lyear2,ingiyear,midyear,outgiyear:integer;
  month0,day0,hour0,min0 :smallint;
  month1,day1,hour1,min1 :smallint;
  lmonth2,lday2,hour,min:smallint;
  ip,ip0,ip1 : extended;
begin
  SolortoSo24(lyear,2,15,0,0,
              inginame,ingiyear,ingimonth,ingiday,ingihour,ingimin,
              midname,midyear,midmonth,midday,midhour,midmin,
              outginame,outgiyear,outgimonth,outgiday,outgihour,outgimin);
  midname := lmonth * 2 - 1 ;
  tmin := -1*montharray[midname];
  getdatebymin(tmin,ingiyear,ingimonth,ingiday,ingihour,ingimin,
               midyear,midmonth,midday,midhour,midmin ) ;

  getlunarfirst(midyear,midmonth,midday,
                outgiyear,outgimonth,outgiday,hour,min,ip,
                year0,month0,day0,hour0,min0,ip0,
                year1,month1,day1,hour1,min1,ip1);

  solortolunar(outgiyear,outgimonth,outgiday,
               lyear2,lmonth2,lday2,
               lnp,lnp2);

  if (lyear2=lyear) and (lmonth=lmonth2) then
  begin  // ���,����
    tmin := lday * 1440 - 2780 ;
    getdatebymin(tmin,outgiyear,outgimonth,outgiday,0,0,
                 syear,smonth,sday,hour,min);
    if moonyun then
    begin
      solortolunar(year1,month1,day1,
                   lyear2,lmonth2,lday2,
                   lnp,lnp2);
      if (lyear2=lyear) and (lmonth=lmonth2) then
      begin
        tmin := lday * 1440 - 2780;
        getdatebymin(tmin,year1,month1,day1,0,0,
                     syear,smonth,sday,hour,min);
      end
    end
  end
  else
  begin  // �߱Ⱑ �ι��� ���� ����
    solortolunar(year1,month1,day1,
                 lyear2,lmonth2,lday2,
                 lnp,lnp2);
    if (lyear2=lyear) and (lmonth=lmonth2) then
    begin
      tmin := lday * 1440 - 2780;
      getdatebymin(tmin,year1,month1,day1,0,0,
                   syear,smonth,sday,hour,min);
    end
  end
end; }

procedure lunartosolar(const lyear:integer;lmonth,lday:smallint;
                       const moonyun:boolean;
                       var syear:integer;var smonth,sday:smallint);
var
  lnp,lnp2 : boolean;
  inginame,ingimonth,ingiday,ingihour,ingimin : smallint;
  midname,midmonth,midday,midhour,midmin : smallint;
  outginame,outgimonth,outgiday,outgihour,outgimin : smallint   ;
  tmin : int64 ;
  year0,year1,lyear2,ingiyear,midyear,outgiyear:integer;
  month0,day0,hour0,min0 :smallint;
  month1,day1,hour1,min1 :smallint;
  lmonth2,lday2,hour,min:smallint;
  ip,ip0,ip1 : extended;
begin
  SolortoSo24(lyear,2,15,0,0,
              inginame,ingiyear,ingimonth,ingiday,ingihour,ingimin,
              midname,midyear,midmonth,midday,midhour,midmin,
              outginame,outgiyear,outgimonth,outgiday,outgihour,outgimin);
  midname := lmonth * 2 - 1 ;
  tmin := -1*montharray[midname];
  getdatebymin(tmin,ingiyear,ingimonth,ingiday,ingihour,ingimin,
               midyear,midmonth,midday,midhour,midmin ) ;

  getlunarfirst(midyear,midmonth,midday,
                outgiyear,outgimonth,outgiday,hour,min,ip,
                year0,month0,day0,hour0,min0,ip0,
                year1,month1,day1,hour1,min1,ip1);

  solortolunar(outgiyear,outgimonth,outgiday,
               lyear2,lmonth2,lday2,
               lnp,lnp2);

  if (lyear=lyear2) and (lmonth=lmonth2) then
  begin  { ���,���� }
    tmin := -1440 * lday+10 ;
    getdatebymin(tmin,outgiyear,outgimonth,outgiday,0,0,
                 syear,smonth,sday,hour,min);

    if moonyun then
    begin
      solortolunar(year1,month1,day1,
                   lyear2,lmonth2,lday2,
                   lnp,lnp2);
      if (lyear2=lyear) and (lmonth=lmonth2) then
      begin
        tmin := -1440 * lday + 10;
        getdatebymin(tmin,year1,month1,day1,0,0,
                     syear,smonth,sday,hour,min);
      end
    end
  end
  else
  begin   {�߱Ⱑ �ι��� ���� ���� }
    solortolunar(year1,month1,day1,
                 lyear2,lmonth2,lday2,
                 lnp,lnp2);
    if (lyear2=lyear) and (lmonth=lmonth2) then
    begin
      tmin := -1440 * lday + 10;
      getdatebymin(tmin,year1,month1,day1,0,0,
                   syear,smonth,sday,hour,min);
    end
  end
end;

function getweekday(const syear:integer; const smonth,sday:smallint):smallint;
var
  d,i : integer ;
begin
  d := disp2days(syear,smonth,sday,unityear,unitmonth,unitday);
  i := d div 7 ;
  d := d - ( i * 7 );

  while ((d > 6) or (d < 0))  do
  begin
    if d > 6 then d:=d-7
             else d:=d+7;
  end;
  if d < 0  then d:= d+7;
  result := d
end;

function get28sday(const syear:integer;const smonth,sday:smallint):smallint;
var
  d,i : integer ;
begin
  d := disp2days(syear,smonth,sday,unityear,unitmonth,unitday);
  i := d div 28 ;
  d := d - ( i * 28 );

  while ((d > 27) or (d < 0))  do
  begin
    if d > 27 then d:=d-28
              else d:=d+28
  end;
  d := d - 11;
  if d < 0  then d:= d+28;
  result := d
end;

{function solorlattitude(day:extended):extended;
var
  sl,smin,sminangle,sd : extended;
begin  { 1996�� ���� }
{  sl:=day*0.98564736+278.956807; {�¾���հ浵  }
{  smin:=282.869498+0.00004708*day; {�¾�������浵}
{  sminangle := Pi*(sl-smin)/180 ; {�¾���ձ����̰� - ���� }
{  sd := 1.919*SIN(sminangle)+0.02*SIN(2*sminangle); { �߽��� }
{  result := degreelow(sl + sd) { �¾�����浵 }
// end;

{procedure getjulgidate(const sunlat:int64; kiday : extended ;
                       var giyear:integer;gimonth,giday,gihour,gimin : smallint);
var
  i : int64;
  d,sreal : extended ;
begin
  i := trunc(kiday);
  d := kiday-i;
  if i < 0 then
  begin
    i := i -1 ;
    d := d + 1 ;
  end
  else i := i + 1 ;

  i :=-1* i * 1440 ;
  getdatebymin(i,1995,12,31,0,0,giyear,gimonth,giday,gihour,gimin);
  sreal := d * 24 ;
  gihour := trunc(sreal) ;
  d := sreal-gihour;
  gimin := trunc(d * 60) ;

  sreal := Pi*sunlat/180;
  d := -106.8*sin(sreal)+596.1*sin(2*sreal)+4.4*sin(3*sreal)-12.7*sin(4*sreal)
       - 428.7*cos(sreal)-2.1*cos(2*sreal)+19.3*cos(3*sreal);
  i := round( d / 60 );
  gimin := gimin - i ;

  if gimin < 0 then
  begin
    gimin := gimin + 60 ;
    gihour := gihour - 1 ;
    if gihour < 0 then
    begin
      gihour := gihour + 24 ;
      giday := giday - 1 ;
    end;
  end;

  if gimin > 59 then
  begin
    gimin := gimin - 60 ;
    gihour := gihour + 1;
    if gihour > 23 then
    begin
      gihour := gihour - 24 ;
      giday := giday + 1
    end;
  end
end;

function getjulgidays(const sunlat : int64 ;
                      const ki : extended ):extended;
var
  d,sreal,k : extended;
begin
  d:=ki;
  sreal:=solorlattitude(d);
  k := sunlat-sreal ;
  if k<0 then k:=k+360;

  while ( k > 1 ) do
  begin
    d := d + 1 ;
    sreal := solorlattitude(d) ;
    k := sunlat-sreal ;
    if k<0 then k:=k+360;
  end;

  while ( k > 0.05 ) do
  begin
    d := d + 0.0416666 ;
    sreal := solorlattitude(d) ;
    k := sunlat-sreal ;
    if k<0 then k:=k+360
  end;

  while (k > 0.0008 ) do
  begin
    d := d + 0.00069444444 ;
    sreal := solorlattitude(d) ;
    k := sunlat-sreal ;
    if k<0 then k:=k+360
  end;
  result := d
end;

procedure SolortoSo24NEW(const soloryear,solormonth,solorday,solorhour,solormin : smallint;
                      var inginame:smallint;ingiyear:integer;ingimonth,ingiday,ingihour,ingimin : smallint;
                      var midname:smallint;midyear:integer;midmonth,midday,midhour,midmin : smallint;
                      var outginame:smallint;outgiyear:integer;outgimonth,outgiday,outgihour,outgimin : smallint);
var
  i,yearmini : int64;
  yearmin : real ;
  displ2day,displ2min,monthmin100, tmin,td,th,tm,t,t1,j,k : int64 ;
  y1,mo1,d1,h1,mi1 : smallint;
  ist, ost,y1str,mo1str,d1str,h1str,mi1str, tdst,thst,tmst,jst : string ;
  s1,s2,s3,s4 : shortint ;
  so24 : int64;
  so24year,so24month,so24day,so24hour:shortint;
  d,ki,km,ko,sreal : extended;
  kil,kml,kol : int64 ;
begin
  displ2day := disp2days(soloryear,solormonth,solorday,1995,12,31) ;
  sreal:=solorlattitude(displ2day);
  i:=0;
  j:=15;
  k:=3;
  mo1:=0;
  while ( i = 0 ) do
  begin
    if (345<=sreal) or (sreal<15) then i:=2;
    if (j<=sreal) and (sreal<(j+30)) then i:=k;
    j:=j+30;
    k:=k+1;
    if k=13 then k:=1;
    mo1 := i
  end;

  i := solorlat[mo1*2-2];
  j := solorlat[mo1*2];

  inginame := mo1*2-2;
  midname := mo1*2-1;
  outginame := mo1*2 ;

  ki := displ2day - 35 ;
  kil := i ;
  ki :=  getjulgidays(kil,ki);

  km := ki ;
  kml := i + 15 ;
  if kml=360 then kml:=0;
  km := getjulgidays(kml,km);

  ko := km ;
  kol := j ;
  ko := getjulgidays(kol,ko);

  ki := ki + 0.375 ;
  km := km + 0.375 ;
  ko := ko + 0.375 ;

  getjulgidate(kil,ki,ingiyear,ingimonth,ingiday,ingihour,ingimin) ;
  getjulgidate(kml,km,midyear,midmonth,midday,midhour,midmin);
  getjulgidate(kol,ko,outgiyear,outgimonth,outgiday,outgihour,outgimin)

end; }

function getjuliandate(const syear:integer; const smonth,sday:smallint):integer;
var
  d : integer;
begin
  d := disp2days(syear,smonth,sday,1899,12,31);
  //d := disp2days(1899,12,31,syear,smonth,sday);
  d :=d+2415020;
  result:=d;
end;

function getjuliandate_point(const syear:integer; const smonth,sday,shour,smin:smallint):Extended  ;
var
  d : integer;
  df: Extended;
  tmin : integer ;
begin
  d := disp2days(syear,smonth,sday,1899,12,31);
  //d := disp2days(1899,12,31,syear,smonth,sday);
  d :=d+2415020;
  tmin:=getminbytime(syear,smonth,sday,shour,smin,syear,smonth,sday,21,0);
  df := d+(trunc((tmin/1440)*1000))/1000;
  //result:=d*1000+trunc((tmin/1440)*1000);
  result := df;
end;

end.
