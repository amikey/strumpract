unit waveform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  msetypes,
  mseglob,
  mseguiglob,
  mseguiintf,
  mseapplication,
  msestat,
  msemenus,
  Math,
  mseact,
  msegui,
  SysUtils,
  msegraphics,
  msegraphutils,
  mseevent,
  mseclasses,
  mseforms,
  msedock,
  msegraphedits,
  mseificomp,
  mseificompglob,
  mseifiglob,
  msescrollbar,
  msebitmap,
  msetimer,
  msesimplewidgets,
  msewidgets,
  msegrids,
  msedataedits,
  msedropdownlist,
  mseedit,
  msestatfile,
  msestream;

type
  twavefo = class(tdockform)
    sliderimage: tbitmapcomp;
    ttimer1: ttimer;
    echelle: tstringgrid;
    trackbar1: tslider;
    tmainmenu1: tmainmenu;
    tfacebuttonslider: tfacecomp;
    procedure onresiz(const Sender: TObject);
    procedure ontimer(const Sender: TObject);
    procedure onfloat(const Sender: TObject);
    procedure ondock(const Sender: TObject);
    procedure onvisiblech(const Sender: TObject);
    procedure faceafterpaintbut(const Sender: tcustomface; const Canvas: tcanvas; const arect: rectty);
    procedure doechelle(const Sender: TObject);
    procedure onzoom(const Sender: TObject);
    procedure pageup(const Sender: TObject);
    procedure pagedown(const Sender: TObject);
    procedure onsliderchange(const Sender: TObject);
    procedure onafterev(const Sender: tcustomscrollbar; const akind: scrolleventty; const avalue: real);
    procedure oncreated(const Sender: TObject);
    procedure crea(const Sender: TObject);
    procedure onresiztimer(const Sender: TObject);

  end;

var
  wavefo: twavefo;
  wavefo2: twavefo;
  waveforec: twavefo;
  zoomint1: integer = 1;
  zoomint2: integer = 1;
  zoomintrec: integer = 1;

implementation

uses
  songplayer,
  recorder,
  main,
  dockpanel1,
  waveform_mfm;

procedure twavefo.faceafterpaintbut(const Sender: tcustomface; const Canvas: tcanvas; const arect: rectty);
var
  point1, point2: pointty;
begin
  point1.x := arect.x + (arect.cx div 2);
  point1.y := 0;
  point2.x := point1.x;
  point2.y := arect.cy;

  Canvas.drawline(point1, point2, cl_red);

end;

procedure twavefo.onresiz(const Sender: TObject);
begin
  if ttimer1.Enabled then
    ttimer1.restart // to reset
  else
    ttimer1.Enabled := True;
end;

procedure twavefo.onresiztimer(const Sender: TObject);
begin

if Caption <> 'Wave Recorder' then trackbar1.Width := Width - 15;

  if ((tag = 1) and (Assigned(songplayerfo))) or ((tag = 2) and (Assigned(songplayer2fo))) or ((Caption = 'Wave Recorder') and (Assigned(recorderfo)) and (islive = False)) then
  begin
    doechelle(nil);
    echelle.Visible  := True;
    trackbar1.Height := Height - echelle.Height;
  end
  else if ((Caption = 'Wave Recorder') and (Assigned(recorderfo)) and (islive = True)) then
  begin
    trackbar1.Width  := waveforec.Width - 11;
    trackbar1.Height := waveforec.Height - 18;
    echelle.Visible  := False;
  end;
  
  onzoom(Sender);

end;

procedure twavefo.doechelle(const Sender: TObject);
var
  i, totsec: integer;
  milisec: string;
  echsec: float;
begin
  totsec := 0;

  if (tag = 1) and (Assigned(songplayerfo)) and
    (hascue = True) and (totsec1 > 0) then
    totsec := totsec1;

  if (tag = 2) and (Assigned(songplayer2fo)) and
    (hascue2 = True) and (totsec2 > 0) then
    totsec := totsec2;

  echelle.Height   := 14;
  echelle.Width    := trackbar1.Width;
  trackbar1.Height := Height - echelle.Height - 18;

  echelle.datacols.Width := 24;
  echelle.datarowheight  := echelle.Height;
  echelle.datacols.Count := (echelle.Width div 24) + 1;

  echsec := totsec / ((echelle.Width / 25.15)); // yes, I know, it is strange...

  i := 0;

  while i < echelle.datacols.Count do
  begin

    if trunc(echsec * (i + 1)) mod 60 > 9 then

      milisec := IntToStr((trunc(echsec * (i + 1)) mod 60))
    else
      milisec := '0' + IntToStr((trunc(echsec * (i + 1)) mod 60));


    echelle[i][0] := utf8decode(IntToStr(trunc(echsec * (i + 1) / 60)) + '.' + milisec);

    echelle.datacols[i].color := cl_gray;

    Inc(i);
  end;
end;

procedure twavefo.ontimer(const Sender: TObject);
begin

  if (tag = 1) and (hascue = True) and (totsec1 > 0) and (Assigned(songplayerfo)) then
    songplayerfo.onwavform(Sender);

  if (tag = 2) and (hascue2 = True) and (totsec2 > 0) and (Assigned(songplayer2fo)) then
    songplayer2fo.onwavform(Sender);

end;

procedure twavefo.onfloat(const Sender: TObject);
begin
  bounds_cxmax := 0;
  bounds_cymax := 0;
end;

procedure twavefo.ondock(const Sender: TObject);
begin
  bounds_cymax := 128;
  bounds_cxmax := 442;
end;

procedure twavefo.onvisiblech(const Sender: TObject);
begin

  if (Assigned(mainfo)) and (Assigned(dockpanel1fo)) and (Assigned(dockpanel2fo)) and
    (Assigned(dockpanel3fo)) and (Assigned(dockpanel4fo)) and (Assigned(dockpanel5fo)) then
  begin
    if (tag = 1) then
      if Visible then
        mainfo.tmainmenu1.menu[4].submenu[12].Caption := ' Hide WaveForm 1 '
      else
        mainfo.tmainmenu1.menu[4].submenu[12].Caption := ' Show WaveForm 1 ';

    if (tag = 2) then
      if Visible then
        mainfo.tmainmenu1.menu[4].submenu[13].Caption := ' Hide WaveForm 2 '
      else
        mainfo.tmainmenu1.menu[4].submenu[13].Caption := ' Show WaveForm 2 ';

    if (Caption = 'Wave Recorder') then
      if Visible then
        mainfo.tmainmenu1.menu[4].submenu[14].Caption := ' Hide WaveForm Rec '
      else
        mainfo.tmainmenu1.menu[4].submenu[14].Caption := ' Show WaveForm Rec ';

    if norefresh = False then
    begin

      mainfo.updatelayoutstrum();

      if dockpanel1fo.Visible then
        dockpanel1fo.updatelayoutpan();

      if dockpanel2fo.Visible then
        dockpanel2fo.updatelayoutpan();

      if dockpanel3fo.Visible then
        dockpanel3fo.updatelayoutpan();

      if dockpanel4fo.Visible then
        dockpanel4fo.updatelayoutpan();

      if dockpanel5fo.Visible then
        dockpanel5fo.updatelayoutpan();

    end;

  end;

end;

procedure twavefo.onzoom(const Sender: TObject);
var
  rect1: rectty;
begin

  if as_checked in tmainmenu1.menu[0].state then
  begin

    rect1 := application.screenrect(window);

    if tmenuitem(Sender).tag = 0 then
      trackbar1.Width := Width - 10;

    if (tag = 1) and (tmenuitem(Sender).tag = 1) and (trackbar1.Width * 2 < Inputlength1 div 64) and
      ((trackbar1.Width * 2) div rect1.cx < 16) then
      trackbar1.Width := trackbar1.Width * 2;

    if (tag = 2) and (tmenuitem(Sender).tag = 1) and (trackbar1.Width * 2 < Inputlength2 div 64) and
      ((trackbar1.Width * 2) div rect1.cx < 16) then
      trackbar1.Width := trackbar1.Width * 2;

    if (tag = 1) and (tmenuitem(Sender).tag = 2) and (trackbar1.Width div 2 > Width - 30) then
      trackbar1.Width := trackbar1.Width div 2;

    if (tag = 2) and (tmenuitem(Sender).tag = 2) and (trackbar1.Width div 2 > Width - 30) then
      trackbar1.Width := trackbar1.Width div 2;

  end;

  if (tag = 1) then
    if (trackbar1.Width div Width) + 1 = 31 then
    begin
      zoomint1 := (trackbar1.Width div Width) + 2;
      tmainmenu1.menu[2].Caption := utf8decode(' Now=X' + IntToStr(zoomint1));
    end
    else
    begin
      zoomint1 := (trackbar1.Width div Width) + 1;
      tmainmenu1.menu[2].Caption := utf8decode(' Now=X' + IntToStr(zoomint1));
    end;

  if (tag = 2) then
    if (trackbar1.Width div Width) + 1 = 31 then
    begin
      zoomint2 := (trackbar1.Width div Width) + 2;
      tmainmenu1.menu[2].Caption := utf8decode(' Now=X' + IntToStr(zoomint2));
    end
    else
    begin
      zoomint2 := (trackbar1.Width div Width) + 1;
      tmainmenu1.menu[2].Caption := utf8decode(' Now=X' + IntToStr(zoomint2));
    end;

  if (tag = 1) or (tag = 2) then
    doechelle(Sender);

  if (tag = 1) and (hascue = True) and (totsec1 > 0) and (Assigned(songplayerfo)) then
    songplayerfo.onwavform(Sender);

  if (tag = 2) and (hascue2 = True) and (totsec2 > 0) and (Assigned(songplayer2fo)) then
    songplayer2fo.onwavform(Sender);

end;

procedure twavefo.pageup(const Sender: TObject);
begin
  container.frame.sbhorz.pageup;
end;

procedure twavefo.pagedown(const Sender: TObject);
begin
  container.frame.sbhorz.pagedown;
end;

procedure twavefo.onafterev(const Sender: tcustomscrollbar; const akind: scrolleventty; const avalue: real);
begin
  onsliderchange(Sender);

  if (tag = 1) and (hascue = True) and (totsec1 > 0) and (Assigned(songplayerfo)) then
    songplayerfo.onafterev(Sender, akind, avalue);

  if (tag = 2) and (hascue2 = True) and (totsec2 > 0) and (Assigned(songplayer2fo)) then
    songplayer2fo.onafterev(Sender, akind, avalue);
end;

procedure twavefo.onsliderchange(const Sender: TObject);
var
  temptime: ttime;
  ho, mi, se, ms: word;
begin
  if trackbar1.clicked then
  begin

    if (tag = 1) and (hascue = True) and (totsec1 > 0) and (Assigned(songplayerfo)) then
    begin
      temptime := tottime1 * TrackBar1.Value;
      DecodeTime(temptime, ho, mi, se, ms);
      songplayerfo.lposition.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));
    end;

    if (tag = 2) and (hascue2 = True) and (totsec2 > 0) and (Assigned(songplayer2fo)) then
    begin
      temptime := tottime2 * TrackBar1.Value;
      DecodeTime(temptime, ho, mi, se, ms);
      songplayer2fo.lposition.Value := utf8decode(format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]));
    end;

  end;
end;

procedure twavefo.oncreated(const Sender: TObject);
begin
  SetExceptionMask(GetExceptionMask + [exZeroDivide] + [exInvalidOp] +
    [exDenormalized] + [exOverflow] + [exUnderflow] + [exPrecision]);
  if (parentwidget = nil) then
  begin
    bounds_cxmax := 0;
    bounds_cymax := 0;
  end
  else
  begin
    bounds_cxmax := fowidth;
    bounds_cymax := wavefoheight;
    bounds_cxmin := fowidth;
    bounds_cymin := wavefoheight;
    Width        := fowidth;
    Height       := wavefoheight;
  end;
end;

procedure twavefo.crea(const Sender: TObject);
begin
  windowopacity := 0;
end;


end.

