unit piano;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus,
 msegui,msegraphics, msegraphutils, mseevent, mseclasses, mseforms, msedock,
 msesimplewidgets, msewidgets, mseact, msechartedit, msedataedits,
 msedropdownlist, mseedit, msegraphedits, mseificomp, mseificompglob,mseifiglob,
 msescrollbar, msesiggui, msesignal, msestatfile, msestream,sysutils,
 msedispwidgets, mserichstring, msefilter, msesigaudio, msesignoise;

type
 tpianofo = class(tdockform)
   onpianoon: tbooleanedit;
   tenvelopeedit1: tenvelopeedit;
   tsigkeyboard1: tsigkeyboard;
   tsigfilter2: tsigfilter;
   tsigoutaudio1: tsigoutaudio;
   tsignoise1: tsignoise;
   tsigcontroller1: tsigcontroller;
   tsigfilter1: tsigfilter;
   linkpianochan: tbooleanedit;
   volpianoR: tintegerdisp;
   tsigslider32: tsigslider;
   volpiano: tintegerdisp;
   tsigslider3: tsigslider;
   procedure oncloseex(const sender: TObject);
   procedure oncreated(const sender: TObject);
   procedure onresizeex(const sender: TObject);
   procedure onsetsliderpiano(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure onsetsliderpianoR(const sender: TObject; var avalue: realty;
                   var accept: Boolean);
   procedure onpianoactivate(const sender: TObject; var avalue: Boolean;
                   var accept: Boolean);
   procedure onchangest(const sender: TObject);
   procedure ondockex(const sender: TObject);
   procedure onfloatex(const sender: TObject);
   procedure resizepi(fontheight :  integer );
   
   procedure crea(const sender: TObject);
 end;
var
 pianofo: tpianofo;
 hasinitp: Boolean = False;

implementation
uses
main, dockpanel1, captionstrumpract, piano_mfm;

var
  boundchildpi: array of boundchild;
  
procedure tpianofo.resizepi(fontheight :  integer );
var
 i1, i2: integer;
 ratio : double;
begin
    ratio := fontheight/12 ;
    bounds_cxmax := 0;
    bounds_cxmin := 0;
    bounds_cymax := 0;
    bounds_cymin := 0;
    bounds_cx := round(442 * ratio);
    bounds_cxmin := bounds_cx;
    bounds_cymax := round(284 * ratio);
    bounds_cymin := bounds_cymax;
    font.height :=  fontheight;
  
   frame.grip_size := round(8 * ratio);
  
       for i1 := 0 to childrencount - 1 do
         for i2 := 0 to length(boundchildpi) - 1 do
        if children[i1].name = boundchildpi[i2].name then
        begin
          children[i1].left := round(boundchildpi[i2].left * ratio);  
          children[i1].top := round(boundchildpi[i2].top * ratio);  
          children[i1].width := round(boundchildpi[i2].width * ratio);   
          children[i1].height := round(boundchildpi[i2].height * ratio); 
         end; 
 end; 

procedure tpianofo.oncloseex(const sender: TObject);
begin
 onpianoon.color := cl_transparent;
  tsigoutaudio1.audio.active := False;
end;

procedure tpianofo.oncreated(const sender: TObject);
begin
  tsigkeyboard1.keywidth := tsigkeyboard1.Width div 32;
   tsigcontroller1.inputtype := 0; // from synth/piano
   Caption := 'Piano Synthesizer' ;

  hasinitp := True;

end;

procedure tpianofo.onresizeex(const sender: TObject);
begin
 if hasinitp then
 begin
    tsigkeyboard1.keywidth := round(tsigkeyboard1.Width / 32);
 end;
end;

procedure tpianofo.onsetsliderpiano(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
 volpiano.Value := round(100 * avalue);
   if linkpianochan.value then
    begin
   volpianoR.Value := volpiano.Value;
   tsigslider32.value := avalue;
   end;
end;

procedure tpianofo.onsetsliderpianoR(const sender: TObject; var avalue: realty;
               var accept: Boolean);
begin
volpianoR.Value := round(100 * avalue);
    if linkpianochan.value then  begin
   volpiano.Value := volpianoR.Value;
   tsigslider3.value := avalue;
   end;
end;

procedure tpianofo.onpianoactivate(const sender: TObject; var avalue: Boolean;
               var accept: Boolean);
begin
 if hasinitp then
    if avalue then
    begin
   //   onpianoon.color := $3B4F00;
      tsigoutaudio1.audio.active := True;
      end
    else
    begin
  //    onpianoon.color := cl_transparent;
      tsigoutaudio1.audio.active := False;

end;
end;

procedure tpianofo.onchangest(const sender: TObject);
begin
if  (isactivated = true) then
 begin
 if Visible then
        begin
          mainfo.tmainmenu1.menu.itembynames(['show','showpiano']).caption :=
          lang_mainfo[Ord(ma_hide)] + ': Piano'; 
         //  lang_infosfo[Ord(in_infosfo)] ;
         end
      else
        begin
          mainfo.tmainmenu1.menu.itembynames(['show','showpiano']).caption :=
          lang_mainfo[Ord(ma_tmainmenu1_show)] + ': Piano';
          end;
          
      if (norefresh = False) and (parentwidget <> nil) then
      begin
     
       if (parentwidget = mainfo.basedock) or 
       (mainfo.basedock.dragdock.currentsplitdir = sd_tabed) then
          mainfo.updatelayoutstrum();
      
      if (parentwidget = dockpanel1fo.basedock) or 
       (dockpanel1fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel1fo.Visible then
        dockpanel1fo.updatelayoutpan();
     
      if (parentwidget = dockpanel2fo.basedock) or 
       (dockpanel2fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel2fo.Visible then
        dockpanel2fo.updatelayoutpan();
     
      if (parentwidget = dockpanel3fo.basedock) or 
       (dockpanel3fo.basedock.dragdock.currentsplitdir = sd_tabed) then
        if dockpanel3fo.Visible then
        dockpanel3fo.updatelayoutpan();
      
      if (parentwidget = dockpanel4fo.basedock) or 
       (dockpanel4fo.basedock.dragdock.currentsplitdir = sd_tabed) then
      if dockpanel4fo.Visible then
        dockpanel4fo.updatelayoutpan();
      
      if (parentwidget = dockpanel5fo.basedock) or 
       (dockpanel5fo.basedock.dragdock.currentsplitdir = sd_tabed) then
      if dockpanel5fo.Visible then
        dockpanel5fo.updatelayoutpan();
      end; 
  end;   
end;

procedure tpianofo.ondockex(const sender: TObject);
var
ratio : double;
begin
    resizepi(fontheightused);
    ratio := fontheightused/12 ;
    bounds_cxmin := round(442 * ratio);
    bounds_cxmax := round(442 * ratio);
    bounds_cx := bounds_cxmax;
    bounds_cymin := round(284 * ratio);
    bounds_cymax := round(284 * ratio);
    bounds_cy := bounds_cymax;
end;

procedure tpianofo.onfloatex(const sender: TObject);
var
ratio : double;
begin
    resizepi(fontheightused);
    ratio := fontheightused/12 ;
    bounds_cxmin := round(442 * ratio);
    bounds_cxmax := 0;
    bounds_cx := bounds_cxmax;
    bounds_cymin := round(284 * ratio);
    bounds_cymax := round(284 * ratio);
    bounds_cy := bounds_cymax;
end;

procedure tpianofo.crea(const sender: TObject);
var
i1, childn : integer;
begin
    setlength(boundchildpi,childrencount);
     
     childn := childrencount;
 
       for i1 := 0 to childrencount - 1 do
         begin
          boundchildpi[i1].left := children[i1].left; 
          boundchildpi[i1].top := children[i1].top; 
          boundchildpi[i1].width := children[i1].width;  
          boundchildpi[i1].height := children[i1].height;
          boundchildpi[i1].name := children[i1].name;
         end;
end;

end.
