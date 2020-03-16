unit cal20000_f;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ComCtrls, StdCtrls, ExtCtrls, calendar_unit;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
  private
    { Private declarations }
  public
    date : array[1..6,1..7] of Tpanel  ;
    mess : array[1..42,1..4] of Tlabel ;
    { Public declarations }
  end;

var
  Form1: TForm1;
  edita,editb : Tedit ;
  updowna : Tupdown ;
  labela : Tlabel ;
  labelb : Tlabel ;
  starti : int64 ;
  start : boolean;
  preyear,premonth:int64;

implementation

{$R *.DFM}


procedure TForm1.FormCreate(Sender: TObject);
var
  i,j,f1: integer;
  fday,fd : int64 ;
  k,l,m : int64 ;
  present : tdatetime ;
  year,month,day, hour,min,sec,msec : int64;
  pyear,pmonth,pday,phour,pmin,psec,pmsec : word;

  y1,ym,y2,lyear,ingiyear,midyear,outgiyear:integer;
  mo1,d1,h1,mi1 : smallint ;
  mom,dm,hm,mim : smallint ;
  mo2,d2,h2,mi2 : smallint ;
  ip,ipm,ip1 : extended;

  lmonth,lday:smallint;
  lmoonyun,largemonth:boolean;
  st : string ;
  so24:integer;
  so24year,so24month,so24day,so24hour:shortint;
  largenumber:shortint;
  lnp : boolean;
  inginame,ingimonth,ingiday,ingihour,ingimin : smallint;
  midname,midmonth,midday,midhour,midmin : smallint;
  outginame,outgimonth,outgiday,outgihour,outgimin : smallint;
begin
  k:=form1.clientheight div 12 ;
  l:=form1.clientwidth div 20 ;
  starti := 1;
  start :=true;

  present := now ;
  decodedate(present,pyear,pmonth,pday);
  decodetime(present,phour,pmin,psec,pmsec);

  year:=pyear;
  month:=pmonth;
  day:=pday;
  hour:=phour;
  min:=pmin;
  sec:=psec;
  msec:=pmsec;

  edita := tedit.create(self);
  with edita do
  begin
    parent := self ;
    Left := l * 8 -15;
    Top := k ;
    Width := 60 ;
    Height := 24 ;
    Text := inttostr(year);
    Onexit :=Edit1Enter
  end;

  editb := tedit.create(self);
  with editb do
  begin
    parent := self ;
    height := 24;
    Left := edita.left + 80  ;
    Top := k   ;
    Width := 25 ;
    Onexit := Edit1Enter ;
    OnChange := Edit1Enter
  end;

  updowna := tupdown.create(self);
  with updowna do
  begin
    parent := self ;
    Width := 15 ;
    Height := 24 ;
    Associate := Editb ;
    TabOrder := 1;
    Min := 0 ;
    max := 13 ;
    position := month
  end;

  labela := tlabel.create(self);
  with labela do
  begin
    parent := self ;
    caption := '년'
{   top := k+3 ; }
{   left := edita.left + 76; }
  end;

  labelb := tlabel.create(self);
  with labelb do
  begin
    parent := self;
    caption :='월'
{   top := k+3 ;  }
  end ;

  fday:=getweekday(year,month,1)+1;
  fd := 0 ;

  k:=form1.clientheight div 16 ;
  l:=form1.clientwidth div 16 ;
  for i:=1 to 6 do
    for j:=1 to 7 do
    begin
      date[i,j]:=tpanel.create(self);
      with date[i,j] do
      begin
        parent :=self ;
        ParentBackground := False;
        color := clwhite;
        height := form1.clientheight div 8  ;
        width := form1.clientwidth div 8 ;
        left := (j-1)*width + l;
        top := (i-1)*height + 3*k;
        m :=(i-1)*7+j;
        OnClick:=Panel1Click;
        if (j=fday) then
        begin
          fd:=1;
          fday := 8
        end;
        if fd = 0 then visible := false ;
        if year >=0 then hint := '+'
                    else hint := '-';
        if abs(year) < 10 then hint := hint + '0';
        if abs(year) < 100 then hint := hint + '0';
        if abs(year) < 1000 then hint := hint + '0';

        hint := hint + inttostr(year)+'y'  ;

        if month < 10 then hint := hint+'0'+inttostr(month)
                      else hint := hint + inttostr(month);
        if fd < 10 then hint :=hint +'0'+inttostr(fd)
                   else hint := hint + inttostr(fd);
        if m<> 42 then
        begin
          for f1 := 1 to 4 do
          begin
            if fd=0 then break ;
            mess[m,f1] := tlabel.create(self);
            with mess[m,f1] do
            begin
              parent := date[i,j];
              if f1=1 then
              begin
                if fd < 10 then caption := ' '+inttostr(fd)
                           else caption := inttostr(fd);
                left := date[i,j].width div 2 ;
                top := (date[i,j].width div 6)*(f1-1) + 1  ;
                font.size := 15 ;
                if j=1 then Font.Color := clRed;
              end;
              if f1=2 then
              begin
                left := date[i,j].width div 2 * 0 + 1;
                top := (date[i,j].width div 6)*f1 + 1  ;
                font.size := 10 ;
                solortolunar(year,month,fd,lyear,lmonth,lday,lmoonyun,largemonth);
                if (lday=1) or (fd=1) then
                begin
                  if lmoonyun then st := '윤'+inttostr(lmonth)+'.'+inttostr(lday)
                              else st :=inttostr(lmonth)+'.'+inttostr(lday);
                  Font.Color := clBlue
                end
                else
                begin
                  if lday < 10 then st := ' '+ inttostr(lday)
                               else st :=inttostr(lday);
                end;
                if lday=1 then
                begin
                  getlunarfirst(year,month,fd,
                                y1,mo1,d1,h1,mi1,ip,
                                ym,mom,dm,hm,mim,ipm,
                                y2,mo2,d2,h2,mi2,ip1);

                  if abs(ip)<15.3 then st := st + ' 일식'
                                else if abs(ip)<18.5 then st := st + ' 일식가능';
                end;
                if fd=dm then
                begin
                  Font.Color:= clBlue;
                  st:=st + ' 망';
                  if abs(ipm)<9.5 then st:=st+' 월식'
                  else
                  begin
                    if abs(ipm)<12.2 then st:=st+' 월식가능'
                  end;
                end;
                caption := st
              end;

              if f1=3 then
              begin
                left := date[i,j].width div 2 * 0 + 1;
                top := (date[i,j].width div 6)*f1 + 1  ;
                font.size := 10 ;
                if fd=1 then sydtoso24yd(year,month,fd,1,0,so24,so24year,so24month,so24day,so24hour);

                if fd<>0 then
                begin
                  caption := ganji[so24day];
                  so24day := so24day + 1;
                  if so24day=0 then font.Color:=clGreen;
                  if so24day=60 then so24day := 0 ;
                end;

              end;

              if f1=4 then
              begin
                left := date[i,j].width div 2 * 1 + 1;
                top := (date[i,j].width div 6)*(f1-1) + 1  ;
                font.size := 10 ;
                SolortoSo24(year,month,fd,1,0,
                            inginame,ingiyear,ingimonth,ingiday,ingihour,ingimin,
                            midname,midyear,midmonth,midday,midhour,midmin,
                            outginame,outgiyear,outgimonth,outgiday,outgihour,outgimin);

                caption := '' ;
                if (ingimonth=month) and (fd=ingiday) then caption := monthst[inginame];
                if (midmonth=month) and (fd=midday) then caption := monthst[midname];
                if (outgimonth=month) and (fd=outgiday) then caption := monthst[outginame];
                if caption <> '' then Font.color := clFuchsia

              end
            end  { with }
          end { for f1 }
        end
        else
        begin
          visible := true ;
          hint := '42';
          caption := '안내'
        end;

        if fd <> 0 then fd := fd+1;
        mo2 := month+1;
        y2 := year ;
        if mo2=13 then
        begin
          y2 := year + 1;
          mo2 := 1
        end ;
        getdatebymin(200,y2,mo2,1,0,0,y1,mo1,d1,h1,mi1);
        if fd>d1 then fd:=0

      end {with}
    end; { for j }
  premonth := month

end;

procedure TForm1.FormResize(Sender: TObject);
var
  i,j,k,l : integer ;
begin
  if form1.clientheight < 400 then form1.clientheight := 400;
  if form1.clientwidth  < 478 then form1.clientwidth := 478;

  k:=form1.clientheight div 12 ;
  l:=form1.clientwidth div 20 ;

  edita.Left := l * 8-10 ;
  edita.Top := k ;

  editb.Left := edita.left + 80 ;
  editb.top := k ;

  labela.Left := edita.left + 62;
  labela.top := k + 4;

  labelb.Left := edita.left + 120;
  labelb.top :=k+4;

  updowna.Associate := Editb ;

  k:=form1.clientheight div 16 ;
  l:=form1.clientwidth div 16 ;
  for i:=1 to 6 do
    for j:=1 to 7 do
    begin
      with date[i,j] do
      begin
        height := form1.clientheight div 8  ;
        width := form1.clientwidth div 8 ;
        left := (j-1)*width + l;
        top := (i-1)*height + 3*k
      end
    end
end;

procedure TForm1.Panel1Click(Sender: TObject);
var
//  msgcode : word ;
  year:integer;
  month,day:smallint;
  wd: int64 ;
  lyear:integer;
  lmonth,lday:smallint;
  lmoonyun,largemonth:boolean;
  so24:integer;
  so24year,so24month,so24day,so24hour:shortint;
  ingiyear,midyear,outgiyear,year1,yearm,year2:integer;

  inginame,ingimonth,ingiday,ingihour,ingimin : smallint;
  midname,midmonth,midday,midhour,midmin : smallint;
  outginame,outgimonth,outgiday,outgihour,outgimin : smallint;
  month1,day1,hour1,min1:smallint;
  monthm,daym,hourm,minm:smallint;
  month2,day2,hour2,min2:smallint;
  ip,ipm,ip1:extended;
  st : string ;
begin
  st := (sender as tpanel).hint ;
  if st <> '42' then
  begin
    //year := strtoint(copy(st,1,5));      { 8글자가 안되거나 음수 일때 에러 있음 }
    //month := strtoint(copy(st,6,2));
    //day := strtoint(copy(st,8,2));

    year :=strtoint(Copy(st,1,pos('y',st)-1));
    month :=strtoint(Copy(st,pos('y',st)+1,2));
    day :=strtoint(Copy(st,pos('y',st)+3,2));


    wd :=getweekday(year,month,day);
    solortolunar(year,month,day,
                 lyear,lmonth,lday,
                 lmoonyun,largemonth);
    sydtoso24yd(year,month,day,23,25,
                so24,so24year,so24month,so24day,so24hour);

    SolortoSo24(year,month,day,23,25,
                inginame,ingiyear,ingimonth,ingiday,ingihour,ingimin,
                midname,midyear,midmonth,midday,midhour,midmin,
                outginame,outgiyear,outgimonth,outgiday,outgihour,outgimin);

    st := '진짜만세력 V0.95'+#13+#13;
    st := st + '양력 ' + inttostr(year)+'년 ' +inttostr(month)+'월 '+inttostr(day)+'일 '+weekday[wd];
    st := st + ' '+ s28day[get28sday(year,month,day)];

    st := st + #13 + '음력 ' + inttostr(lyear)+'년 '+inttostr(lmonth)+'월 '+ inttostr(lday)+'일';
    if largemonth then st := st + ' 대월' else st := st +' 소월';
    if lmoonyun then st :=st + ' 윤달' else st := st + ' 평달';
    st := st + #13 + 'Julian Date : '+IntToStr(getjuliandate(year,month,day))+'.00(KST 21시)';
    st := st + #13 + ganji[so24year]+'년 '+ganji[so24month]+'월 '+ganji[so24day]+'일';
    st := st + #13#13 + '이번달 절입 : '+monthst[inginame]+' 양력' + inttostr(ingiyear)+'년 ';
    st := st + inttostr(ingimonth)+'월 '+inttostr(ingiday)+'일 '+inttostr(ingihour)+'시 ' + inttostr(ingimin)+'분 ';
    st := st +FloatToStr(getjuliandate_point(ingiyear,ingimonth,ingiday,ingihour,ingimin));
    st := st + #13 + '이번달 중기 : '+monthst[midname]+' 양력' + inttostr(midyear)+'년 ';
    st := st + inttostr(midmonth)+'월 '+inttostr(midday)+'일 '+inttostr(midhour)+'시 ' + inttostr(midmin)+'분 ';
    st := st +FloatToStr(getjuliandate_point(midyear,midmonth,midday,midhour,midmin));
    st := st + #13 + '다음달 절입 : '+monthst[outginame]+' 양력' + inttostr(outgiyear)+'년 ';
    st := st + inttostr(outgimonth)+'월 '+inttostr(outgiday)+'일 '+inttostr(outgihour)+'시 ' + inttostr(outgimin)+'분 ';
    st := st +FloatToStr(getjuliandate_point(outgiyear,outgimonth,outgiday,outgihour,outgimin));

    getlunarfirst(year,month,day,
                  year1,month1,day1,hour1,min1,ip,
                  yearm,monthm,daym,hourm,minm,ipm,
                  year2,month2,day2,hour2,min2,ip1);
    st := st + #13 + '이번달 합삭일시 : 양력 ' + inttostr(year1)+'년 '+inttostr(month1)+'월 '+ inttostr(day1)+'일 ';
    st := st + inttostr(hour1)+'시 '+ inttostr(min1)+'분 ' ;
    if abs(ip)<15.3 then st := st + ' 일식 '   // 일식 < 15.3
                  else if abs(ip)<18.5 then st := st + ' 일식가능 ';  //일식가능 < 18.5
    st := st + format('%7.2f %13.3f',[ip,getjuliandate_point(year1,month1,day1,hour1,min1)]);


    st := st + #13 + '이번달    망일시 : 양력 ' + inttostr(yearm)+'년 '+inttostr(monthm)+'월 '+ inttostr(daym)+'일 ';
    st := st + inttostr(hourm)+'시 '+ inttostr(minm)+'분 ' ;
    if abs(ipm)<9.5 then st := st + ' 월식 '   //월식 < 9.5;
                  else if abs(ipm)<12.2 then st := st + ' 월식가능 '; //월식가능<12.2;
    //st := st + format('%7.2f ',[ipm]);
    st := st + format('%7.2f %13.3f',[ipm,getjuliandate_point(yearm,monthm,daym,hourm,minm)]);


    st := st + #13 + '다음달 합삭일시 : 양력 ' + inttostr(year2)+'년 '+inttostr(month2)+'월 '+ inttostr(day2)+'일 ';
    st := st + inttostr(hour2)+'시 '+ inttostr(min2)+'분 '  ;
    if abs(ip1)<15.3 then st := st + ' 일식 '
                   else if abs(ip1)<18.5 then st := st + ' 일식가능 ';
//    st := st + format('%7.2f ',[ip1]);
      st := st + format('%7.2f %13.3f',[ip1,getjuliandate_point(year2,month2,day2,hour2,min2)]);

    // msgcode:=messagedlg(st ,mtinformation,[mbok],0)
    messagedlg(st ,mtinformation,[mbok],0)

  end
  else
  begin
    st := '진짜만세력 V0.95 안내' + #13+#13;
    st := st + '유효기간 : -10,000년~10,000년(이만년)' + #13;
    st := st + '그레고리력,태음태양력,일진,24절기,합삭시간,28수,일식,월식,율리우스적일 표시'+#13+#13;

    st := st + '팁 : 날짜칸의 빈곳을 누르면 그날의 자세한 사항이 나옵니다.'+#13+#13;
    st := st + '만든날짜 : 2008년 12월 18일(음력 11월 21일, 戊子年 甲子月 壬辰日)'+#13;
    st := st + '만세력 홈페이지 : http://afnmp3.homeip.net/~kohyc/calendar/index.cgi'+#13;
    st := st + '              Email : fftkrr@gmail.com';
    //msgcode:=messagedlg(st ,mtinformation,[mbok],0)
    messagedlg(st ,mtinformation,[mbok],0)
  end
end;

procedure TForm1.Edit1Enter(Sender: TObject);
var
//  msgcode : word ;
  i,j,f1 : integer;
  fday,fd : int64 ;
  k,l,m : int64 ;
  year,month : int64 ;
  mo1,d1,h1,mi1 : smallint ;
  mom,dm,hm,mim : smallint ;
  mo2,d2,h2,mi2 : smallint ;
  ip,ipm,ip1 : extended;

  y1,ym,y2,lyear,ingiyear,midyear,outgiyear:integer;

  lmonth,lday:smallint;
  lmoonyun,largemonth:boolean;
  st : string ;
  so24:integer;
  so24year,so24month,so24day,so24hour:shortint;
  cond : boolean;
  inginame,ingimonth,ingiday,ingihour,ingimin : smallint;
  midname,midmonth,midday,midhour,midmin : smallint;
  outginame,outgimonth,outgiday,outgihour,outgimin : smallint;
  progress : Tprogressbar;
begin
  cond := true ;
  if edita.text='' then cond := false ;
  year := strtointdef(edita.text,1998);
//  if (year < -2085) or (year > 6077) then
  if (year < -327290) or (year > 327400) then
  begin
    edita.text := inttostr(preyear);
    cond := false;
    //msgcode := messagedlg('년의 범위는 -2085~6077입니다',mtwarning,[mbok],0)
    messagedlg('년의 범위는 -20000~20000입니다',mtwarning,[mbok],0);
  end;

  month := strtointdef(editb.text,1);
  if (month < 0) or (month >13) then
  begin
    editb.text :=inttostr(premonth);
    cond := false ;
    //msgcode := messagedlg('월의 범위는 1~12입니다',mtwarning,[mbok],0)
    messagedlg('월의 범위는 1~12입니다',mtwarning,[mbok],0);
  end;

  if not start and cond then
  begin
    year :=strtointdef(edita.text,1998);
    month:=strtointdef(editb.text,1);
    editb.text := inttostr(month);
    if month = 13 then
    begin
      year := year + 1 ;
      month := 1 ;
      if year > 30000 then year := 30000 ;
      edita.text := inttostr(year);
      editb.text := inttostr(month)
    end;
    if month= 0 then
    begin
      year := year -1 ;
      month := 12 ;
      if year < -30000 then year := -30000 ;
      edita.text := inttostr(year);
      editb.text := inttostr(month)
    end;
    editb.selectall;

    if (premonth<>month) or (preyear<>year) then
    begin
      edita.text := inttostr(year);
      fday:=getweekday(year,month,1)+1;
      fd := 0 ;

      k:=form1.clientheight div 16 ;
      l:=form1.clientwidth div 16 ;
      progress := Tprogressbar.create(self);
      with progress do
      begin
        parent := self ;
        max := 42 ;
        min := 1 ;
        step := 1 ;
        top := k* 15 ;
        left := l
      end;
      solortolunar(year,month,1,lyear,lmonth,lday,
                   lmoonyun,largemonth);
      getlunarfirst(year,month,1,
                    y1,mo1,d1,h1,mi1,ip,
                    ym,mom,dm,hm,mim,ipm,
                    y2,mo2,d2,h2,mi2,ip1);
      sydtoso24yd(year,month,1,1,0,so24,so24year,so24month,so24day,so24hour);
      SolortoSo24(year,month,20,1,0,
                  inginame,ingiyear,ingimonth,ingiday,ingihour,ingimin,
                  midname,midyear,midmonth,midday,midhour,midmin,
                  outginame,outgiyear,outgimonth,outgiday,outgihour,outgimin);

      for i:=1 to 6 do
        for j:=1 to 7 do
        begin
          with date[i,j] do
          begin
            m :=(i-1)*7+j;
            progress.position := m ;
            if (j=fday) then
            begin
              fd:=1;
              fday := 8
            end;
            if fd = 0 then visible := false
                      else visible := true ;
            if year >=0 then hint := '+'
                        else hint := '-';
            if abs(year) < 10 then hint := hint + '0';
            if abs(year) < 100 then hint := hint + '0';
            if abs(year) < 1000 then hint := hint + '0';

//          hint := hint + inttostr(abs(year))  ;
            hint := hint + inttostr(abs(year))+'y'  ;

            if month < 10 then hint := hint+'0'+inttostr(month)
                          else hint := hint + inttostr(month);
            if fd < 10 then hint :=hint +'0'+inttostr(fd)
                       else hint := hint + inttostr(fd);
            color := clWhite ;
            if m<>42 then
            begin
              for f1 := 1 to 4 do
              begin
                mess[m,f1].free;
                mess[m,f1] := tlabel.create(self);
                with mess[m,f1] do
                begin
                  parent := date[i,j];
                  if f1=1 then
                  begin
                    if fd < 10 then caption := ' '+inttostr(fd)
                               else caption := inttostr(fd);
                    left := date[i,j].width div 2 ;
                    top := (date[i,j].width div 6)*(f1-1) + 1  ;
                    font.size := 15 ;
                    if j=1 then  Font.Color := clRed
                  end;
                  if f1=2 then
                  begin
                    left := date[i,j].width div 2 * 0 + 1;
                    top := (date[i,j].width div 6)*f1 + 1  ;
                    font.size := 10 ;

                    caption :='';
                    if fd<>0 then
                    begin
                      if (fd=d2) then
                      begin
                        solortolunar(year,month,fd,lyear,lmonth,lday,
                                     lmoonyun,largemonth);
                        getlunarfirst(year,month,fd,
                                      y1,mo1,d1,h1,mi1,ip,
                                      ym,mom,dm,hm,mim,ipm,
                                      y2,mo2,d2,h2,mi2,ip1);
                      end;
                      if (lday=1) or (fd=1) then
                      begin
                        if lmoonyun then st := '윤'+inttostr(lmonth)+'.'+inttostr(lday)
                                    else st :=inttostr(lmonth)+'.'+inttostr(lday);
                        Font.Color := clBlue;
                      end
                      else
                      begin
                        if lday < 10 then st := ' '+ inttostr(lday)
                                     else st :=inttostr(lday);
                      end;
                      if lday=1 then
                      begin
                        if abs(ip)<15.3 then st := st + ' 일식'
                                      else if abs(ip)<18.5 then st := st + ' 일식가능';
                      end;
                      if fd=dm then
                      begin
                        st:=st + ' 망';
                        Font.Color:= clBlue;
                        if abs(ipm)<9.5 then st:=st+' 월식'
                        else
                        begin
                          if abs(ipm)<12.2 then st:=st+' 월식가능'
                        end;
                      end;

                      caption := st ; { 일식가능 표시 }
                      lday := lday + 1;
                    end;
                  end;
                  if f1=3 then
                  begin
                    left := date[i,j].width div 2 * 0 + 1;
                    top := (date[i,j].width div 6)*f1 + 1  ;
                    font.size := 10 ;
                    caption :='';
                    if fd<>0 then
                    begin
                      caption := ganji[so24day];
                      so24day := so24day + 1;
                      if so24day=0 then font.Color:=clGreen;
                      if so24day=60 then so24day := 0 ;
                    end;
                  end;
                  if f1=4 then
                  begin
                    left := date[i,j].width div 2 * 1 + 1;
                    top := (date[i,j].width div 6)*(f1-1) + 1  ;
                    font.size := 10 ;
                    caption := '' ;

                    if fd=ingiday then caption := monthst[inginame];
                    if fd=midday then caption := monthst[midname] ;
                    if caption <> '' then Font.color :=clFuchsia;
                  end;
                end;  { with }
              end; { for f1 }
            end
            else
            begin
              visible := true ;
              hint := '42';
              caption := '안내';
            end;
            if fd <> 0 then fd := fd+1;
            mo2 := month+1;
            y2 := year ;
            if mo2=13 then
            begin
              y2 := year + 1;
              mo2 := 1;
            end ;
            getdatebymin(200,y2,mo2,1,0,0,y1,mo1,d1,h1,mi1);
            if fd>d1 then fd:=0
          end; {with}
        end; { for j }
      progress.free ;
      premonth := month;
      preyear := year
    end
  end;
  starti := starti + 1 ;
  if starti>2 then
  begin
     starti := 3 ;
     start := false
  end;
end;

end.
