unit randomnote;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,mseforms,msedock,
 msesimplewidgets,msewidgets,mseedit,msestatfile,msestream,SysUtils,mseact,
 msedataedits,msedropdownlist,mseificomp,mseificompglob,mseifiglob,
 msedispwidgets,mserichstring,msegraphedits,msescrollbar, msechartedit,
 msesiggui, msesignal, mseimage;

type
  trandomnotefo = class(tdockform)
    bnbchords: TButton;
    maxnote: tintegeredit;
    numchord: tintegerdisp;
    bchord1: TButton;
    bchord2: TButton;
    bchord3: TButton;
    bchord4: TButton;
    bchord5: TButton;
    chord4: tstringdisp;
    chord5: tstringdisp;
    withrandom: tbooleanedit;
    withsharp: tbooleanedit;
    nodrums: tbooleanedit;
   bpm: tintegerdisp;
   tbutton2: tbutton;
   tbutton3: tbutton;
   guitar2: tstringdisp;
   guitar3: tstringdisp;
   piano1: tstringdisp;
   guitar1: tstringdisp;
   guitar5: tstringdisp;
   guitar4: tstringdisp;
   piano5: tstringdisp;
   piano4: tstringdisp;
   keyb1: timage;
   elipse1_1: timage;
   elipse1_2: timage;
   elipse1_3: timage;
   piano2: tstringdisp;
   keyb2: timage;
   elipse2_1: timage;
   elipse2_2: timage;
   elipse2_3: timage;
   piano3: tstringdisp;
   keyb3: timage;
   elipse3_1: timage;
   elipse3_2: timage;
   elipse3_3: timage;
   timage1: timage;
   gelipse1_3: timage;
   gelipse1_2: timage;
   gelipse1_1: timage;
   gelipse2_3: timage;
   gelipse2_1: timage;
   gelipse2_2: timage;
   timage8: timage;
   gelipse3_3: timage;
   gelipse3_2: timage;
   gelipse3_1: timage;
   timage12: timage;
   chord1: tbutton;
   chord2: tbutton;
   chord3: tbutton;
   tbutton4: tbutton;
   bass1: tstringdisp;
   timage2: timage;
   belipse1_3: timage;
   belipse1_1: timage;
   belipse1_2: timage;
   bass2: tstringdisp;
   timage6: timage;
   belipse2_3: timage;
   belipse2_1: timage;
   belipse2_2: timage;
   bass3: tstringdisp;
   timage11: timage;
   belipse3_3: timage;
   belipse3_1: timage;
   belipse3_2: timage;
   tbutton5: tbutton;
   procedure dorandomchordbut(const Sender: TObject);
    procedure dorandomchord(const Sender: TObject);
    procedure oncreatedev(const Sender: TObject);
    procedure randomnum(const Sender: TObject);
   procedure onclosev(const sender: TObject);
   procedure doclear(const sender: TObject);
   procedure onshowdrums(const sender: TObject);
   procedure doquit(const sender: TObject);
   procedure pianochord(num, ranchord, ismin : integer);
   procedure guitarchord(num, ranchord, ismin : integer);
   procedure basschord(num, ranchord, ismin : integer);
   procedure showguit(const sender: TObject);
   procedure onmouseguit(const sender: twidget; var ainfo: mouseeventinfoty);
   procedure onmousepiano(const sender: twidget; var ainfo: mouseeventinfoty);
   procedure refreshform(const sender: TObject);
   procedure onmouseform(const sender: twidget; var ainfo: mouseeventinfoty);
   procedure ontextmax(const sender: tcustomdataedit; var atext: msestring;
                   var accept: Boolean);
   procedure playrandomchords(thenum : integer);                
                   
    end;

var
  randomnotefo: trandomnotefo;
  chordran: integer;
  chordmem1, chordmem2, chordmem3 : string;
  blocked :integer = 0;

implementation

uses
  randomnote_mfm, main, uos_flat, guitars,
  drums;
  
procedure trandomnotefo.guitarchord(num, ranchord, ismin : integer);
begin
 if num = 1 then 
      begin
      gelipse1_1.visible := true;
	 gelipse1_2.visible := true;
	 gelipse1_3.visible := true;  
      end else 
      if num = 2 then 
      begin
     gelipse2_1.visible := true;
	 gelipse2_2.visible := true;
	 gelipse2_3.visible := true;  
      end else
      if num = 3 then 
      begin
     gelipse3_1.visible := true;
	 gelipse3_2.visible := true;
	 gelipse3_3.visible := true;  
      end;
 
    if (ranchord = 1) and (ismin = 1)  then
// La maj     
    begin  
       if num = 1 then 
      begin        
       // 4-2
    gelipse1_1.top := 74;
	gelipse1_1.left := 48;

	 // 3-2
	gelipse1_2.top := 74;
	gelipse1_2.left := 68;

	 // 2-2
	gelipse1_3.top := 74;
	gelipse1_3.left := 88;
	
	guitar1.text := ' X 0       0' + lineend + ' ══════════  0';
	
       end else
      if num = 2 then 
      begin        
         // 4-2
    gelipse2_1.top := 74;
	gelipse2_1.left := 48;

	 // 3-2
	gelipse2_2.top := 74;
	gelipse2_2.left := 68;

	// 2-2
	gelipse2_3.top := 74;
	gelipse2_3.left := 88;
	
	guitar2.text := ' X 0       0' + lineend + ' ══════════  0';
       
       end else
        if num = 3 then 
      begin        
          // 4-2
    gelipse3_1.top := 74;
	gelipse3_1.left := 48;

	 // 3-2
	gelipse3_2.top := 74;
	gelipse3_2.left := 68;

	 // 2-2
	gelipse3_3.top := 74;
	gelipse3_3.left := 88;
	
	guitar3.text := ' X 0       0' + lineend + ' ══════════  0';
     end;

	end else
   if (ranchord = 1) and (ismin <> 1)  then
// La min   
begin
  if num = 1 then 
      begin        
       // 4-2
    gelipse1_1.top := 74;
	gelipse1_1.left := 48;

	 // 3-2
	gelipse1_2.top := 74;
	gelipse1_2.left := 68;

	 // 2-1
	gelipse1_3.top := 32;
	gelipse1_3.left := 88;
	
	guitar1.text := ' X 0       0' + lineend + ' ══════════  0';
	
       end else
      if num = 2 then 
      begin        
         // 4-2
    gelipse2_1.top := 74;
	gelipse2_1.left := 48;

	 // 3-2
	gelipse2_2.top := 74;
	gelipse2_2.left := 68;

	// 2-1
	gelipse2_3.top := 32;
	gelipse2_3.left := 88;
	
	guitar2.text := ' X 0       0' + lineend + ' ══════════  0';
       
       end else
        if num = 3 then 
      begin        
          // 4-2
    gelipse3_1.top := 74;
	gelipse3_1.left := 48;

	 // 3-2
	gelipse3_2.top := 74;
	gelipse3_2.left := 68;

	 // 2-1
	gelipse3_3.top := 32;
	gelipse3_3.left := 88;
	
	guitar3.text := ' X 0       0' + lineend + ' ══════════  0';
     end;
      end else
     if ((withsharp.Value = false) and (ranchord = 2) and (ismin = 1 )) or
     ((withsharp.Value = true) and (ranchord = 3) and (ismin = 1)) then
    begin     
// Si Maj
  if num = 1 then 
      begin        
       // 4-2
    gelipse1_1.top := 74;
	gelipse1_1.left := 48;

	 // 3-2
	gelipse1_2.top := 74;
	gelipse1_2.left := 68;

	 // 2-2
	gelipse1_3.top := 74;
	gelipse1_3.left := 88;
	
	guitar1.text := '═X═0═══════0═ '+ lineend +' ══════════  2';
	
       end else
      if num = 2 then 
      begin        
         // 4-2
    gelipse2_1.top := 74;
	gelipse2_1.left := 48;

	 // 3-2
	gelipse2_2.top := 74;
	gelipse2_2.left := 68;

	// 2-2
	gelipse2_3.top := 74;
	gelipse2_3.left := 88;
	
	guitar2.text := '═X═0═══════0═ '+ lineend +' ══════════  2';
       
       end else
        if num = 3 then 
      begin        
          // 4-2
    gelipse3_1.top := 74;
	gelipse3_1.left := 48;

	 // 3-2
	gelipse3_2.top := 74;
	gelipse3_2.left := 68;

	 // 2-2
	gelipse3_3.top := 74;
	gelipse3_3.left := 88;
	
	guitar3.text := '═X═0═══════0═ '+ lineend +' ══════════  2';
     end;

    end 
    else
     if ((withsharp.Value = false) and (ranchord = 2) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 3) and (ismin <> 1)) then
    begin 
// Si min 
  if num = 1 then 
      begin        
       // 4-2
    gelipse1_1.top := 74;
	gelipse1_1.left := 48;

	 // 3-2
	gelipse1_2.top := 74;
	gelipse1_2.left := 68;

	 // 2-1
	gelipse1_3.top := 32;
	gelipse1_3.left := 88;
	
	guitar1.text := '═X═0═══════0═ '+ lineend +' ══════════  2';
	
       end else
      if num = 2 then 
      begin        
         // 4-2
    gelipse2_1.top := 74;
	gelipse2_1.left := 48;

	 // 3-2
	gelipse2_2.top := 74;
	gelipse2_2.left := 68;

	// 2-1
	gelipse2_3.top := 32;
	gelipse2_3.left := 88;
	
	guitar2.text := '═X═0═══════0═ '+ lineend +' ══════════  2';
       
       end else
        if num = 3 then 
      begin        
          // 4-2
    gelipse3_1.top := 74;
	gelipse3_1.left := 48;

	 // 3-2
	gelipse3_2.top := 74;
	gelipse3_2.left := 68;

	 // 2-1
	gelipse3_3.top := 32;
	gelipse3_3.left := 88;
	
	guitar3.text := '═X═0═══════0═ '+ lineend +' ══════════  2';
	end;
     end 
      else
     if ((withsharp.Value = false) and (ranchord = 3) and (ismin = 1 )) or
     ((withsharp.Value = true) and (ranchord = 4) and (ismin = 1)) then
    begin     
// Do Maj
  if num = 1 then 
      begin        
       // 5-3
    gelipse1_1.top := 114;
	gelipse1_1.left := 28;

	 // 4-2
	gelipse1_2.top := 74;
	gelipse1_2.left := 48;

	 // 2-1
	gelipse1_3.top := 32;
	gelipse1_3.left := 88;
	
	guitar1.text :=  ' X         0' + lineend + ' ══════════  0';
	
       end else
      if num = 2 then 
      begin        
         // 4-2
     gelipse2_1.top := 114;
	gelipse2_1.left := 28;

	 // 4-2
	gelipse2_2.top := 74;
	gelipse2_2.left := 48;

	 // 2-1
	gelipse2_3.top := 32;
	gelipse2_3.left := 88;
	
	guitar2.text :=  ' X         0' + lineend + ' ══════════  0';
       
       end else
        if num = 3 then 
      begin   
           
    gelipse3_1.top := 114;
	gelipse3_1.left := 28;

	 // 4-2
	gelipse3_2.top := 74;
	gelipse3_2.left := 48;

	 // 2-1
	gelipse3_3.top := 32;
	gelipse3_3.left := 88;
	
	guitar3.text := ' X         0' + lineend + ' ══════════  0';
     end;

    end 
    else
     if ((withsharp.Value = false) and (ranchord = 3) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 4) and (ismin <> 1)) then
    begin 
// Do min 
  if num = 1 then 
      begin        
        // 4-2
    gelipse1_1.top := 74;
	gelipse1_1.left := 48;

	 // 3-2
	gelipse1_2.top := 74;
	gelipse1_2.left := 68;

	 // 2-1
	gelipse1_3.top := 32;
	gelipse1_3.left := 88;
	
	guitar1.text :=  '═X═0═══════0═' + lineend + ' ══════════  3';
	
	  end else
      if num = 2 then 
      begin        
        // 4-2
    gelipse2_1.top := 74;
	gelipse2_1.left := 48;

	 // 3-2
	gelipse2_2.top := 74;
	gelipse2_2.left := 68;

	 // 2-1
	gelipse2_3.top := 32;
	gelipse2_3.left := 88;
	
	guitar2.text := '═X═0═══════0═' + lineend + ' ══════════  3';
       
       end else
        if num = 3 then 
      begin        
        // 4-2
    gelipse3_1.top := 74;
	gelipse3_1.left := 48;

	 // 3-2
	gelipse3_2.top := 74;
	gelipse3_2.left := 68;

	 // 2-1
	gelipse3_3.top := 32;
	gelipse3_3.left := 88;
	
	guitar3.text :=  '═X═0═══════0═' + lineend + ' ══════════  3';
     end;  end 
      else
     if ((withsharp.Value = false) and (ranchord = 4) and (ismin = 1 )) or
     ((withsharp.Value = true) and (ranchord = 6) and (ismin = 1)) then
    begin     
// Ré Maj
  if num = 1 then 
      begin        
       // 3-2
    gelipse1_1.top := 74;
	gelipse1_1.left := 68;

	 // 2-3
	gelipse1_2.top := 116;
	gelipse1_2.left := 90;

	 // 2-1
	gelipse1_3.top := 74;
	gelipse1_3.left := 108;
	
	guitar1.text :=  ' X X 0      ' + lineend + ' ══════════  0';
	
       end else
      if num = 2 then 
      begin        
        // 3-2
    gelipse2_1.top := 74;
	gelipse2_1.left := 68;

	 // 2-3
	gelipse2_2.top := 116;
	gelipse2_2.left := 90;

	 // 2-1
	gelipse2_3.top := 74;
	gelipse2_3.left := 108;
	
	guitar2.text :=   ' X X 0      ' + lineend + ' ══════════  0';
       
       end else
        if num = 3 then 
      begin   
       // 3-2
    gelipse3_1.top := 74;
	gelipse3_1.left := 68;

	 // 2-3
	gelipse3_2.top := 116;
	gelipse3_2.left := 90;

	 // 2-1
	gelipse3_3.top := 74;
	gelipse3_3.left := 108;
	
	guitar3.text :=  ' X X 0      ' + lineend + ' ══════════  0';
     end;

    end 
    else
     if ((withsharp.Value = false) and (ranchord = 4) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 6) and (ismin <> 1)) then
    begin 
// Ré min 
  if num = 1 then 
      begin        
        // 3-2
    gelipse1_1.top := 74;
	gelipse1_1.left := 68;

	 // 2-3
	gelipse1_2.top := 116;
	gelipse1_2.left := 90;

	 // 2-1
	gelipse1_3.top := 32;
	gelipse1_3.left := 108;
	
	guitar1.text :=   ' X X 0      ' + lineend + ' ══════════  0';
		  end else
      if num = 2 then 
      begin        
        // 3-2
    gelipse2_1.top := 74;
	gelipse2_1.left := 68;

	 // 2-3
	gelipse2_2.top := 116;
	gelipse2_2.left := 90;

	 // 2-1
	gelipse2_3.top := 32;
	gelipse2_3.left := 108;
	
	guitar2.text :=  ' X X 0      ' + lineend + ' ══════════  0';
       
       end else
        if num = 3 then 
      begin        
           // 3-2
    gelipse3_1.top := 74;
	gelipse3_1.left := 68;

	 // 2-3
	gelipse3_2.top := 116;
	gelipse3_2.left := 90;

	 // 2-1
	gelipse3_3.top := 32;
	gelipse3_3.left := 108;
	
	guitar3.text :=   ' X X 0      ' + lineend + ' ══════════  0';
     end; end 
      else
     if ((withsharp.Value = false) and (ranchord = 5) and (ismin = 1 )) or
     ((withsharp.Value = true) and (ranchord = 8) and (ismin = 1)) then
    begin     
// Mi Maj
  if num = 1 then 
      begin        
       // 5-2
    gelipse1_1.top := 74;
	gelipse1_1.left := 26;

	 // 4-2
	gelipse1_2.top := 74;
	gelipse1_2.left := 48;

	 // 3-1
	gelipse1_3.top := 30;
	gelipse1_3.left := 70;
	
	guitar1.text :=  ' 0       0 0' + lineend + ' ══════════  0';
	
       end else
      if num = 2 then 
      begin        
      // 5-2
    gelipse2_1.top := 74;
	gelipse2_1.left := 26;

	 // 4-2
	gelipse2_2.top := 74;
	gelipse2_2.left := 48;

	 // 3-1
	gelipse2_3.top := 30;
	gelipse2_3.left := 70;;
	
	guitar2.text :=  ' 0       0 0' + lineend + ' ══════════  0';
       
       end else
        if num = 3 then 
      begin   
      // 5-2
    gelipse3_1.top := 74;
	gelipse3_1.left := 26;

	 // 4-2
	gelipse3_2.top := 74;
	gelipse3_2.left := 48;

	 // 3-1
	gelipse3_3.top := 30;
	gelipse3_3.left := 70;
	
	guitar3.text :=  ' 0       0 0' + lineend + ' ══════════  0';
     end;

    end 
    else
     if ((withsharp.Value = false) and (ranchord = 5) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 8) and (ismin <> 1)) then
    begin 
// mi min 
  if num = 1 then 
      begin        
         // 5-2
    gelipse1_1.top := 74;
	gelipse1_1.left := 26;

	 // 4-2
	gelipse1_2.top := 74;
	gelipse1_2.left := 48;
	 
	gelipse1_3.visible := false;
	
	guitar1.text :=   ' 0     0 0 0' + lineend + ' ══════════  0';
		  end else
      if num = 2 then 
      begin        
         // 5-2
    gelipse2_1.top := 74;
	gelipse2_1.left := 26;

	 // 4-2
	gelipse2_2.top := 74;
	gelipse2_2.left := 48;
	 
	gelipse2_3.visible := false;
	
	guitar2.text := ' 0     0 0 0' + lineend + ' ══════════  0';
       
       end else
        if num = 3 then 
      begin        
           // 5-2
    gelipse3_1.top := 74;
	gelipse3_1.left := 26;

	 // 4-2
	gelipse3_2.top := 74;
	gelipse3_2.left := 48;
	 
	gelipse3_3.visible := false;
	
	guitar3.text :=   ' 0     0 0 0' + lineend + ' ══════════  0';
     end;  
   
  
    end else
     if ((withsharp.Value = false) and (ranchord = 6) and (ismin = 1 )) or
     ((withsharp.Value = true) and (ranchord = 9) and (ismin = 1)) then
    begin     
// Fa Maj
  if num = 1 then 
      begin        
       // 5-2
    gelipse1_1.top := 74;
	gelipse1_1.left := 26;

	 // 4-2
	gelipse1_2.top := 74;
	gelipse1_2.left := 48;

	 // 3-1
	gelipse1_3.top := 30;
	gelipse1_3.left := 70;
	
	guitar1.text :=  '═0═══════0═0═' + lineend + ' ══════════  1';
	 
	
       end else
      if num = 2 then 
      begin        
      // 5-2
    gelipse2_1.top := 74;
	gelipse2_1.left := 26;

	 // 4-2
	gelipse2_2.top := 74;
	gelipse2_2.left := 48;

	 // 3-1
	gelipse2_3.top := 30;
	gelipse2_3.left := 70;;
	
	guitar2.text :=   '═0═══════0═0═' + lineend + ' ══════════  1';
       
       end else
        if num = 3 then 
      begin   
      // 5-2
    gelipse3_1.top := 74;
	gelipse3_1.left := 26;

	 // 4-2
	gelipse3_2.top := 74;
	gelipse3_2.left := 48;

	 // 3-1
	gelipse3_3.top := 30;
	gelipse3_3.left := 70;
	
	guitar3.text :=   '═0═══════0═0═' + lineend + ' ══════════  1';
     end;

    end 
    else
     if ((withsharp.Value = false) and (ranchord = 6) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 9) and (ismin <> 1)) then
    begin 
// Fa min 
  if num = 1 then 
      begin        
         // 5-2
    gelipse1_1.top := 74;
	gelipse1_1.left := 26;

	 // 4-2
	gelipse1_2.top := 74;
	gelipse1_2.left := 48;
	 
	gelipse1_3.visible := false;
	
	guitar1.text := '═0═════0═0═0═' + lineend + ' ══════════  1';
		  end else
      if num = 2 then 
      begin        
         // 5-2
    gelipse2_1.top := 74;
	gelipse2_1.left := 26;

	 // 4-2
	gelipse2_2.top := 74;
	gelipse2_2.left := 48;
	 
	gelipse2_3.visible := false;
	
	guitar2.text := '═0═════0═0═0═' + lineend + ' ══════════  1';
	
       end else
        if num = 3 then 
      begin        
           // 5-2
    gelipse3_1.top := 74;
	gelipse3_1.left := 26;

	 // 4-2
	gelipse3_2.top := 74;
	gelipse3_2.left := 48;
	 
	gelipse3_3.visible := false;
	
	guitar3.text := '═0═════0═0═0═' + lineend + ' ══════════  1';
     end;  
      end else
     if ((withsharp.Value = false) and (ranchord = 7) and (ismin = 1 )) or
     ((withsharp.Value = true) and (ranchord = 11) and (ismin = 1)) then
    begin     
// Sol Maj
  if num = 1 then 
      begin        
       // 6-3
    gelipse1_1.top := 114;
	gelipse1_1.left := 6;

	 // 5-2
	gelipse1_2.top := 74;
	gelipse1_2.left := 26;

	 // 1-3
	gelipse1_3.top := 114;
	gelipse1_3.left := 110;
	
	guitar1.text :=  '     0 0 0   ' + lineend + ' ══════════  0';
  
	       end else
      if num = 2 then 
      begin        
          // 6-3
    gelipse2_1.top := 114;
	gelipse2_1.left := 6;

	 // 5-2
	gelipse2_2.top := 74;
	gelipse2_2.left := 26;

	 // 1-3
	gelipse2_3.top := 114;
	gelipse2_3.left := 110;
    guitar2.text :=  '     0 0 0   ' + lineend + ' ══════════  0';
         
       end else
        if num = 3 then 
      begin   
          // 6-3
    gelipse3_1.top := 114;
	gelipse3_1.left := 6;

	 // 5-2
	gelipse3_2.top := 74;
	gelipse3_2.left := 26;

	 // 1-3
	gelipse3_3.top := 114;
	gelipse3_3.left := 110;
	guitar3.text :=  '     0 0 0   ' + lineend + ' ══════════  0';
     end;

    end 
    else
     if ((withsharp.Value = false) and (ranchord = 7) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 11) and (ismin <> 1)) then
    begin 
// Sol min 
  if num = 1 then 
      begin        
         // 5-2
    gelipse1_1.top := 74;
	gelipse1_1.left := 26;

	 // 4-2
	gelipse1_2.top := 74;
	gelipse1_2.left := 48;
	 
	gelipse1_3.visible := false;
	
	guitar1.text := '═0═════0═0═0═' + lineend + ' ══════════  3';
		  end else
      if num = 2 then 
      begin        
         // 5-2
    gelipse2_1.top := 74;
	gelipse2_1.left := 26;

	 // 4-2
	gelipse2_2.top := 74;
	gelipse2_2.left := 48;
	 
	gelipse2_3.visible := false;
	
	guitar2.text := '═0═════0═0═0═' + lineend + ' ══════════  3';
       
       end else
        if num = 3 then 
      begin        
           // 5-2
    gelipse3_1.top := 74;
	gelipse3_1.left := 26;

	 // 4-2
	gelipse3_2.top := 74;
	gelipse3_2.left := 48;
	 
	gelipse3_3.visible := false;
	
	guitar3.text := '═0═════0═0═0═' + lineend + ' ══════════  3';
     end;  
   
  
    end else
    begin
      if num = 1 then 
      begin
      guitar1.text := '';
      gelipse1_1.visible := false;
	 gelipse1_2.visible := false;
	 gelipse1_3.visible := false;  
      end else 
      if num = 2 then 
      begin
      guitar2.text := '';
     gelipse2_1.visible := false;
	 gelipse2_2.visible := false;
	 gelipse2_3.visible := false;  
      end else
      if num = 3 then 
      begin
      guitar3.text := '';
     gelipse3_1.visible := false;
	 gelipse3_2.visible := false;
	 gelipse3_3.visible := false;  
      end;
    end;
    
end;  
  
  
procedure trandomnotefo.pianochord(num, ranchord, ismin : integer);
begin
     if num = 1 then 
      begin
      elipse1_1.visible := true;
	 elipse1_2.visible := true;
	 elipse1_3.visible := true;  
      end else 
      if num = 2 then 
      begin
     elipse2_1.visible := true;
	 elipse2_2.visible := true;
	 elipse2_3.visible := true;  
      end else
      if num = 3 then 
      begin
     elipse3_1.visible := true;
	 elipse3_2.visible := true;
	 elipse3_3.visible := true;  
      end;
 
    if (ranchord = 1) and (ismin = 1)  then
// La maj     
    begin  
       if num = 1 then 
      begin        
       // la
    elipse1_1.top := 96;
	elipse1_1.left := 136;

	// do# 2
	elipse1_2.top := 24;
	elipse1_2.left := 201;

	// mi 2
	elipse1_3.top := 96;
	elipse1_3.left := 240;
       end else
      if num = 2 then 
      begin        
       // la
        elipse2_1.top := 96;
	elipse2_1.left := 136;

	// do# 2
	elipse2_2.top := 24;
	elipse2_2.left := 201;

	// mi 2
	elipse2_3.top := 96;
	elipse2_3.left := 240;
       end else
        if num = 3 then 
      begin        
       // la
    elipse3_1.top := 96;
	elipse3_1.left := 136;

	// do# 2
	elipse3_2.top := 24;
	elipse3_2.left := 201;

	// mi 2
	elipse3_3.top := 96;
	elipse3_3.left := 240;
     end;

	end else
   if (ranchord = 1) and (ismin <> 1)  then
// La min   
    begin  
      if num = 1 then 
      begin         
          // la
    elipse1_1.top := 96;
	elipse1_1.left := 136;

	// do 2
	elipse1_2.top := 96;
	elipse1_2.left := 188;

	// mi 2
	elipse1_3.top := 96;
	elipse1_3.left := 240;
	end else
	if num = 2 then 
      begin         
          // la
    elipse2_1.top := 96;
	elipse2_1.left := 136;

	// do 2
	elipse2_2.top := 96;
	elipse2_2.left := 188;

	// mi 2
	elipse2_3.top := 96;
	elipse2_3.left := 240;
	end else
	if num = 3 then 
      begin         
          // la
    elipse3_1.top := 96;
	elipse3_1.left := 136;

	// do 2
	elipse3_2.top := 96;
	elipse3_2.left := 188;

	// mi 2
	elipse3_3.top := 96;
	elipse3_3.left := 240;
	end;
	end else
	if ((withsharp.Value = false) and (ranchord = 2) and (ismin = 1 )) or
     ((withsharp.Value = true) and (ranchord = 3) and (ismin = 1)) then
    begin     
// Si Maj
    if num = 1 then 
      begin 
       // fa#
    elipse1_1.top := 24;
	elipse1_1.left := 92;

	// si
	elipse1_2.top := 96;
	elipse1_2.left := 160;

	// ré# 2
	elipse1_3.top := 24;
	elipse1_3.left := 228;
	end else
	if num = 2 then 
      begin 
       // fa#
    elipse2_1.top := 24;
	elipse2_1.left := 92;

	// si
	elipse2_2.top := 96;
	elipse2_2.left := 160;

	// ré# 2
	elipse2_3.top := 24;
	elipse2_3.left := 228;
	end else
	if num = 3 then 
      begin 
       // fa#
    elipse3_1.top := 24;
	elipse3_1.left := 92;

	// si
	elipse3_2.top := 96;
	elipse3_2.left := 160;

	// ré# 2
	elipse3_3.top := 24;
	elipse3_3.left := 228;
	end;
	
	end 
	else
  if ((withsharp.Value = false) and (ranchord = 2) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 3) and (ismin <> 1)) then
    begin     
// Si min    
   if num = 1 then 
    begin 
   // fa#
    elipse1_1.top := 24;
	elipse1_1.left := 92;

	// si
	elipse1_2.top := 96;
	elipse1_2.left := 160;

	// ré 2
	elipse1_3.top := 96;
	elipse1_3.left := 214;
	end else
	if num = 2 then 
    begin 
   // fa#
    elipse2_1.top := 24;
	elipse2_1.left := 92;

	// si
	elipse2_2.top := 96;
	elipse2_2.left := 160;

	// ré 2
	elipse2_3.top := 96;
	elipse2_3.left := 214;
	end else
	if num = 3 then 
    begin 
   // fa#
    elipse3_1.top := 24;
	elipse3_1.left := 92;

	// si
	elipse3_2.top := 96;
	elipse3_2.left := 160;

	// ré 2
	elipse3_3.top := 96;
	elipse3_3.left := 214;
	end;
	
	end 
    else if ((withsharp.Value = false) and (ranchord = 3) and (ismin = 1)) or
     ((withsharp.Value = true) and (ranchord = 4) and (ismin = 1)) then
    begin   // do Maj
    
    if num = 1 then 
    begin 
       // do
    elipse1_1.top := 96;
	elipse1_1.left := 0;

	// mi
	elipse1_2.top := 96;
	elipse1_2.left := 54;

	// sol
	elipse1_3.top := 96;
	elipse1_3.left := 108;
	end else
	if num = 2 then 
    begin 
       // do
    elipse2_1.top := 96;
	elipse2_1.left := 0;

	// mi
	elipse2_2.top := 96;
	elipse2_2.left := 54;

	// sol
	elipse2_3.top := 96;
	elipse2_3.left := 108;
	end else
	if num = 3 then 
    begin 
       // do
    elipse3_1.top := 96;
	elipse3_1.left := 0;

	// mi
	elipse3_2.top := 96;
	elipse3_2.left := 54;

	// sol
	elipse3_3.top := 96;
	elipse3_3.left := 108;
	end;
	
	end else
	 if ((withsharp.Value = false) and (ranchord = 3) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 4) and (ismin <> 1)) then
    begin     
// do min
    if num = 1 then 
    begin 
       // do
    elipse1_1.top := 96;
	elipse1_1.left := 0;

	// ré #
	elipse1_2.top := 24;
	elipse1_2.left := 40;

	// sol
	elipse1_3.top := 96;
	elipse1_3.left := 108;
	end else
	 if num = 2 then 
    begin 
       // do
    elipse2_1.top := 96;
	elipse2_1.left := 0;

	// ré #
	elipse2_2.top := 24;
	elipse2_2.left := 40;

	// sol
	elipse2_3.top := 96;
	elipse2_3.left := 108;
	end else
	 if num = 3 then 
    begin 
       // do
    elipse3_1.top := 96;
	elipse3_1.left := 0;

	// ré #
	elipse3_2.top := 24;
	elipse3_2.left := 40;

	// sol
	elipse3_3.top := 96;
	elipse3_3.left := 108;
	end;
	end 
	else if ((withsharp.Value = false) and (ranchord = 4) and (ismin = 1)) or
     ((withsharp.Value = true) and (ranchord = 6) and (ismin = 1)) then    begin       
// ré Maj
       // ré
    if num = 1 then 
    begin   
    elipse1_1.top := 96;
	elipse1_1.left := 28;

	// fa #
	elipse1_2.top := 26;
	elipse1_2.left := 94;

	// la
	elipse1_3.top := 96;
	elipse1_3.left := 134;
	end else
	if num = 2 then 
    begin   
    elipse2_1.top := 96;
	elipse2_1.left := 28;

	// fa #
	elipse2_2.top := 26;
	elipse2_2.left := 94;

	// la
	elipse2_3.top := 96;
	elipse2_3.left := 134;
	end else
	if num = 3 then 
    begin   
    elipse3_1.top := 96;
	elipse3_1.left := 28;

	// fa #
	elipse3_2.top := 26;
	elipse3_2.left := 94;

	// la
	elipse3_3.top := 96;
	elipse3_3.left := 134;
	end;
	end else
	 if ((withsharp.Value = false) and (ranchord = 4) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 6) and (ismin <> 1)) then    begin    
// ré min
    if num = 1 then 
    begin 
       // ré
    elipse1_1.top := 96;
	elipse1_1.left := 28;

	// fa
	elipse1_2.top := 96;
	elipse1_2.left := 80;

	// la
	elipse1_3.top := 96;
	elipse1_3.left := 134;
	end else 
	if num = 2 then 
    begin 
       // ré
    elipse2_1.top := 96;
	elipse2_1.left := 28;

	// fa
	elipse2_2.top := 96;
	elipse2_2.left := 80;

	// la
	elipse2_3.top := 96;
	elipse2_3.left := 134;
	end else 
	if num = 3 then 
    begin 
       // ré
    elipse3_1.top := 96;
	elipse3_1.left := 28;

	// fa
	elipse3_2.top := 96;
	elipse3_2.left := 80;

	// la
	elipse3_3.top := 96;
	elipse3_3.left := 134;
	end;
	end
	else if ((withsharp.Value = false) and (ranchord = 5) and (ismin = 1)) or
     ((withsharp.Value = true) and (ranchord = 8) and (ismin = 1)) then    begin       
// mi Maj
    if num = 1 then 
    begin
       // mi
    elipse1_1.top := 96;
	elipse1_1.left := 54;

	// sol #
	elipse1_2.top := 24;
	elipse1_2.left := 122;

	// si
	elipse1_3.top := 96;
	elipse1_3.left := 162;
	end else
	if num = 2 then 
    begin
       // mi
    elipse2_1.top := 96;
	elipse2_1.left := 54;

	// sol #
	elipse2_2.top := 24;
	elipse2_2.left := 122;

	// si
	elipse2_3.top := 96;
	elipse2_3.left := 162;
	end else
	if num = 3 then 
    begin
       // mi
    elipse3_1.top := 96;
	elipse3_1.left := 54;

	// sol #
	elipse3_2.top := 24;
	elipse3_2.left := 122;

	// si
	elipse3_3.top := 96;
	elipse3_3.left := 162;
	end;
	
	end else
	 if ((withsharp.Value = false) and (ranchord = 5) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 8) and (ismin <> 1)) then    begin    
// mi min
         // mi
    if num = 1 then 
    begin     
    elipse1_1.top := 96;
	elipse1_1.left := 54;

	// sol
	elipse1_2.top := 96;
	elipse1_2.left := 108;

	// si
	elipse1_3.top := 96;
	elipse1_3.left := 162;
	end else
	 if num = 2 then 
    begin     
    elipse2_1.top := 96;
	elipse2_1.left := 54;

	// sol
	elipse2_2.top := 96;
	elipse2_2.left := 108;

	// si
	elipse2_3.top := 96;
	elipse2_3.left := 162;
	end else
	 if num = 3 then 
    begin     
    elipse3_1.top := 96;
	elipse3_1.left := 54;

	// sol
	elipse3_2.top := 96;
	elipse3_2.left := 108;

	// si
	elipse3_3.top := 96;
	elipse3_3.left := 162;
	end;
	
	end
	else if ((withsharp.Value = false) and (ranchord = 6) and (ismin = 1)) or
     ((withsharp.Value = true) and (ranchord = 9) and (ismin = 1)) then    begin       
// fa Maj
    if num = 1 then 
    begin
       // fa
    elipse1_1.top := 96;
	elipse1_1.left := 80;

	// la
	elipse1_2.top := 96;
	elipse1_2.left := 134;

	// do 2
	elipse1_3.top := 96;
	elipse1_3.left := 190;
	end else
	if num = 2 then 
    begin
       // fa
    elipse2_1.top := 96;
	elipse2_1.left := 80;

	// la
	elipse2_2.top := 96;
	elipse2_2.left := 134;

	// do 2
	elipse2_3.top := 96;
	elipse2_3.left := 190;
	end else
	if num = 3 then 
    begin
       // fa
    elipse3_1.top := 96;
	elipse3_1.left := 80;

	// la
	elipse3_2.top := 96;
	elipse3_2.left := 134;

	// do 2
	elipse3_3.top := 96;
	elipse3_3.left := 190;
	end;
	
	end else
	 if ((withsharp.Value = false) and (ranchord = 6) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 9) and (ismin <> 1)) then    begin    
// fa min
    if num = 1 then 
    begin
       // fa
    elipse1_1.top := 96;
	elipse1_1.left := 80;

	// la
	elipse1_2.top := 24;
	elipse1_2.left := 120;

	// do 2
	elipse1_3.top := 96;
	elipse1_3.left := 190;
	end else
	if num = 2 then 
    begin
       // fa
    elipse2_1.top := 96;
	elipse2_1.left := 80;

	// la
	elipse2_2.top := 24;
	elipse2_2.left := 120;

	// do 2
	elipse2_3.top := 96;
	elipse2_3.left := 190;
	end else
	if num = 3 then 
    begin
       // fa
    elipse3_1.top := 96;
	elipse3_1.left := 80;

	// la
	elipse3_2.top := 24;
	elipse3_2.left := 120;

	// do 2
	elipse3_3.top := 96;
	elipse3_3.left := 190;
	end;
	end
	else if ((withsharp.Value = false) and (ranchord = 7) and (ismin = 1)) or
     ((withsharp.Value = true) and (ranchord = 11) and (ismin = 1)) then    begin       
// sol Maj
      // sol
    if num = 1 then 
    begin  
    elipse1_1.top := 96;
	elipse1_1.left := 108;

	// si
	elipse1_2.top := 96;
	elipse1_2.left := 160;

	// ré 2
	elipse1_3.top := 96;
	elipse1_3.left := 218;
	end else
	if num = 2 then 
    begin  
    elipse2_1.top := 96;
	elipse2_1.left := 108;

	// si
	elipse2_2.top := 96;
	elipse2_2.left := 160;

	// ré 2
	elipse2_3.top := 96;
	elipse2_3.left := 218;
	end else
	if num = 3 then 
    begin  
    elipse3_1.top := 96;
	elipse3_1.left := 108;

	// si
	elipse3_2.top := 96;
	elipse3_2.left := 160;

	// ré 2
	elipse3_3.top := 96;
	elipse3_3.left := 218;
	end;
	
	end else
	 if ((withsharp.Value = false) and (ranchord = 7) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 11) and (ismin <> 1)) then    begin    
// sol min
    if num = 1 then 
    begin 
      // sol
    elipse1_1.top := 96;
	elipse1_1.left := 108;

	// la#
	elipse1_2.top := 24;
	elipse1_2.left := 148;

	// ré 2
	elipse1_3.top := 96;
	elipse1_3.left := 218;
	end else
	if num = 2 then 
    begin 
      // sol
    elipse2_1.top := 96;
	elipse2_1.left := 108;

	// la#
	elipse2_2.top := 24;
	elipse2_2.left := 148;

	// ré 2
	elipse2_3.top := 96;
	elipse2_3.left := 218;
	end else
	if num = 3 then 
    begin 
      // sol
    elipse3_1.top := 96;
	elipse3_1.left := 108;

	// la#
	elipse3_2.top := 24;
	elipse3_2.left := 148;

	// ré 2
	elipse3_3.top := 96;
	elipse3_3.left := 218;
	end;
	end else
	begin
	if num = 1 then 
    begin
	elipse1_1.visible := false;
	elipse1_2.visible := false;
	elipse1_3.visible := false;
	end else
	if num = 2 then 
    begin
	elipse2_1.visible := false;
	elipse2_2.visible := false;
	elipse2_3.visible := false;
	end else
	if num = 3 then 
    begin
	elipse3_1.visible := false;
	elipse3_2.visible := false;
	elipse3_3.visible := false;
	end;
	end;
end;	  

procedure trandomnotefo.basschord(num, ranchord, ismin : integer);
begin
     if num = 1 then 
      begin
      belipse1_1.visible := true;
	// belipse1_2.visible := true;
	// belipse1_3.visible := true;  
      end else 
      if num = 2 then 
      begin
     belipse2_1.visible := true;
	// belipse2_2.visible := true;
	// belipse2_3.visible := true;  
      end else
      if num = 3 then 
      begin
     belipse3_1.visible := true;
	// belipse3_2.visible := true;
	// belipse3_3.visible := true;  
      end;
 
    if (ranchord = 1) and (ismin = 1)  then
// La maj     
    begin  
       if num = 1 then 
      begin        
       // la
    belipse1_1.top := 126;
	belipse1_1.left := 10;

	// do# 2
	belipse1_2.top := 24;
	belipse1_2.left := 201;

	// mi 2
	belipse1_3.top := 96;
	belipse1_3.left := 240;
       end else
      if num = 2 then 
      begin        
       // la
        belipse2_1.top := 126;
	belipse2_1.left := 10;

	// do# 2
	belipse2_2.top := 24;
	belipse2_2.left := 201;

	// mi 2
	belipse2_3.top := 96;
	belipse2_3.left := 240;
       end else
        if num = 3 then 
      begin        
       // la
    belipse3_1.top := 126;
	belipse3_1.left := 10;

	// do# 2
	belipse3_2.top := 24;
	belipse3_2.left := 201;

	// mi 2
	belipse3_3.top := 96;
	belipse3_3.left := 240;
     end;

	end else
   if (ranchord = 1) and (ismin <> 1)  then
// La min   
    begin  
      if num = 1 then 
      begin         
          // la
    belipse1_1.top := 126;
	belipse1_1.left := 10;

	// do 2
	belipse1_2.top := 96;
	belipse1_2.left := 188;

	// mi 2
	belipse1_3.top := 96;
	belipse1_3.left := 240;
	end else
	if num = 2 then 
      begin         
          // la
    belipse2_1.top := 126;
	belipse2_1.left := 10;

	// do 2
	belipse2_2.top := 96;
	belipse2_2.left := 188;

	// mi 2
	belipse2_3.top := 96;
	belipse2_3.left := 240;
	end else
	if num = 3 then 
      begin         
          // la
    belipse3_1.top := 126;
	belipse3_1.left := 10;

	// do 2
	belipse3_2.top := 96;
	belipse3_2.left := 188;

	// mi 2
	belipse3_3.top := 96;
	belipse3_3.left := 240;
	end;
	end else
	if ((withsharp.Value = false) and (ranchord = 2) and (ismin = 1 )) or
     ((withsharp.Value = true) and (ranchord = 3) and (ismin = 1)) then
    begin     
// Si Maj
    if num = 1 then 
      begin 
       // fa#
    belipse1_1.top := 42;
	belipse1_1.left := 38;

	// si
	belipse1_2.top := 96;
	belipse1_2.left := 160;

	// ré# 2
	belipse1_3.top := 24;
	belipse1_3.left := 228;
	end else
	if num = 2 then 
      begin 
       // fa#
    belipse2_1.top := 42;
	belipse2_1.left := 38;

	// si
	belipse2_2.top := 96;
	belipse2_2.left := 160;

	// ré# 2
	belipse2_3.top := 24;
	belipse2_3.left := 228;
	end else
	if num = 3 then 
      begin 
       // fa#
    belipse3_1.top := 42;
	belipse3_1.left := 38;

	// si
	belipse3_2.top := 96;
	belipse3_2.left := 160;

	// ré# 2
	belipse3_3.top := 24;
	belipse3_3.left := 228;
	end;
	
	end 
	else
  if ((withsharp.Value = false) and (ranchord = 2) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 3) and (ismin <> 1)) then
    begin     
// Si min    
   if num = 1 then 
    begin 
   // fa#
    belipse1_1.top := 42;
	belipse1_1.left := 38;

	// si
	belipse1_2.top := 96;
	belipse1_2.left := 160;

	// ré 2
	belipse1_3.top := 96;
	belipse1_3.left := 214;
	end else
	if num = 2 then 
    begin 
   // fa#
    belipse2_1.top := 42;
	belipse2_1.left := 38;

	// si
	belipse2_2.top := 96;
	belipse2_2.left := 160;

	// ré 2
	belipse2_3.top := 96;
	belipse2_3.left := 214;
	end else
	if num = 3 then 
    begin 
   // fa#
    belipse3_1.top := 42;
	belipse3_1.left := 38;

	// si
	belipse3_2.top := 96;
	belipse3_2.left := 160;

	// ré 2
	belipse3_3.top := 96;
	belipse3_3.left := 214;
	end;
	
	end 
    else if ((withsharp.Value = false) and (ranchord = 3) and (ismin = 1)) or
     ((withsharp.Value = true) and (ranchord = 4) and (ismin = 1)) then
    begin   // do Maj
    
    if num = 1 then 
    begin 
       // do
    belipse1_1.top := 74;
	belipse1_1.left := 38;

	// mi
	belipse1_2.top := 96;
	belipse1_2.left := 54;

	// sol
	belipse1_3.top := 96;
	belipse1_3.left := 108;
	end else
	if num = 2 then 
    begin 
       // do
    belipse2_1.top := 74;
	belipse2_1.left := 38;

	// mi
	belipse2_2.top := 96;
	belipse2_2.left := 54;

	// sol
	belipse2_3.top := 96;
	belipse2_3.left := 108;
	end else
	if num = 3 then 
    begin 
       // do
    belipse3_1.top := 74;
	belipse3_1.left := 38;

	// mi
	belipse3_2.top := 96;
	belipse3_2.left := 54;

	// sol
	belipse3_3.top := 96;
	belipse3_3.left := 108;
	end;
	
	end else
	 if ((withsharp.Value = false) and (ranchord = 3) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 4) and (ismin <> 1)) then
    begin     
// do min
    if num = 1 then 
    begin 
       // do
    belipse1_1.top := 74;
	belipse1_1.left := 38;

	// ré #
	belipse1_2.top := 24;
	belipse1_2.left := 40;

	// sol
	belipse1_3.top := 96;
	belipse1_3.left := 108;
	end else
	 if num = 2 then 
    begin 
       // do
    belipse2_1.top := 74;
	belipse2_1.left := 38;

	// ré #
	belipse2_2.top := 24;
	belipse2_2.left := 40;

	// sol
	belipse2_3.top := 96;
	belipse2_3.left := 108;
	end else
	 if num = 3 then 
    begin 
       // do
    belipse3_1.top := 74;
	belipse3_1.left := 38;

	// ré #
	belipse3_2.top := 24;
	belipse3_2.left := 40;

	// sol
	belipse3_3.top := 96;
	belipse3_3.left := 108;
	end;
	end 
	else if ((withsharp.Value = false) and (ranchord = 4) and (ismin = 1)) or
     ((withsharp.Value = true) and (ranchord = 6) and (ismin = 1)) then    begin       
// ré Maj
       // ré
    if num = 1 then 
    begin   
    belipse1_1.top := 128;
	belipse1_1.left := 36;

	// fa #
	belipse1_2.top := 26;
	belipse1_2.left := 94;

	// la
	belipse1_3.top := 96;
	belipse1_3.left := 134;
	end else
	if num = 2 then 
    begin   
    belipse2_1.top := 128;
	belipse2_1.left := 36;

	// fa #
	belipse2_2.top := 26;
	belipse2_2.left := 94;

	// la
	belipse2_3.top := 96;
	belipse2_3.left := 134;
	end else
	if num = 3 then 
    begin   
    belipse3_1.top := 128;
	belipse3_1.left := 36;

	// fa #
	belipse3_2.top := 26;
	belipse3_2.left := 94;

	// la
	belipse3_3.top := 96;
	belipse3_3.left := 134;
	end;
	end else
	 if ((withsharp.Value = false) and (ranchord = 4) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 6) and (ismin <> 1)) then    begin    
// ré min
    if num = 1 then 
    begin 
       // ré
    belipse1_1.top := 128;
	belipse1_1.left := 36;

	// fa
	belipse1_2.top := 96;
	belipse1_2.left := 80;

	// la
	belipse1_3.top := 96;
	belipse1_3.left := 134;
	end else 
	if num = 2 then 
    begin 
       // ré
    belipse2_1.top := 128;
	belipse2_1.left := 36;

	// fa
	belipse2_2.top := 96;
	belipse2_2.left := 80;

	// la
	belipse2_3.top := 96;
	belipse2_3.left := 134;
	end else 
	if num = 3 then 
    begin 
       // ré
    belipse3_1.top := 128;
	belipse3_1.left := 36;

	// fa
	belipse3_2.top := 96;
	belipse3_2.left := 80;

	// la
	belipse3_3.top := 96;
	belipse3_3.left := 134;
	end;
	end
	else if ((withsharp.Value = false) and (ranchord = 5) and (ismin = 1)) or
     ((withsharp.Value = true) and (ranchord = 8) and (ismin = 1)) then    begin       
// mi Maj
    if num = 1 then 
    begin
       // mi
    belipse1_1.top := 42;
	belipse1_1.left := 68;

	// sol #
	belipse1_2.top := 24;
	belipse1_2.left := 122;

	// si
	belipse1_3.top := 96;
	belipse1_3.left := 162;
	end else
	if num = 2 then 
    begin
       // mi
    belipse2_1.top := 42;
	belipse2_1.left := 68;

	// sol #
	belipse2_2.top := 24;
	belipse2_2.left := 122;

	// si
	belipse2_3.top := 96;
	belipse2_3.left := 162;
	end else
	if num = 3 then 
    begin
       // mi
    belipse3_1.top := 42;
	belipse3_1.left := 68;

	// sol #
	belipse3_2.top := 24;
	belipse3_2.left := 122;

	// si
	belipse3_3.top := 96;
	belipse3_3.left := 162;
	end;
	
	end else
	 if ((withsharp.Value = false) and (ranchord = 5) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 8) and (ismin <> 1)) then    begin    
// mi min
         // mi
    if num = 1 then 
    begin     
    belipse1_1.top := 42;
	belipse1_1.left := 68;

	// sol
	belipse1_2.top := 96;
	belipse1_2.left := 108;

	// si
	belipse1_3.top := 96;
	belipse1_3.left := 162;
	end else
	 if num = 2 then 
    begin     
    belipse2_1.top := 42;
	belipse2_1.left := 68;

	// sol
	belipse2_2.top := 96;
	belipse2_2.left := 108;

	// si
	belipse2_3.top := 96;
	belipse2_3.left := 162;
	end else
	 if num = 3 then 
    begin     
    belipse3_1.top := 42;
	belipse3_1.left := 68;

	// sol
	belipse3_2.top := 96;
	belipse3_2.left := 108;

	// si
	belipse3_3.top := 96;
	belipse3_3.left := 162;
	end;
	
	end
	else if ((withsharp.Value = false) and (ranchord = 6) and (ismin = 1)) or
     ((withsharp.Value = true) and (ranchord = 9) and (ismin = 1)) then    begin       
// fa Maj
    if num = 1 then 
    begin
       // fa
    belipse1_1.top := 8;
	belipse1_1.left := 12;

	// la
	belipse1_2.top := 96;
	belipse1_2.left := 134;

	// do 2
	belipse1_3.top := 96;
	belipse1_3.left := 190;
	end else
	if num = 2 then 
    begin
       // fa
    belipse2_1.top := 8;
	belipse2_1.left := 12;

	// la
	belipse2_2.top := 96;
	belipse2_2.left := 134;

	// do 2
	belipse2_3.top := 96;
	belipse2_3.left := 190;
	end else
	if num = 3 then 
    begin
       // fa
    belipse3_1.top := 8;
	belipse3_1.left := 12;

	// la
	belipse3_2.top := 96;
	belipse3_2.left := 134;

	// do 2
	belipse3_3.top := 96;
	belipse3_3.left := 190;
	end;
	
	end else
	 if ((withsharp.Value = false) and (ranchord = 6) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 9) and (ismin <> 1)) then    begin    
// fa min
    if num = 1 then 
    begin
       // fa
    belipse1_1.top := 8;
	belipse1_1.left := 12;

	// la
	belipse1_2.top := 24;
	belipse1_2.left := 120;

	// do 2
	belipse1_3.top := 96;
	belipse1_3.left := 190;
	end else
	if num = 2 then 
    begin
       // fa
    belipse2_1.top := 8;
	belipse2_1.left := 12;

	// la
	belipse2_2.top := 24;
	belipse2_2.left := 120;

	// do 2
	belipse2_3.top := 96;
	belipse2_3.left := 190;
	end else
	if num = 3 then 
    begin
       // fa
    belipse3_1.top := 8;
	belipse3_1.left := 12;

	// la
	belipse3_2.top := 24;
	belipse3_2.left := 120;

	// do 2
	belipse3_3.top := 96;
	belipse3_3.left := 190;
	end;
	end
	else if ((withsharp.Value = false) and (ranchord = 7) and (ismin = 1)) or
     ((withsharp.Value = true) and (ranchord = 11) and (ismin = 1)) then    begin       
// sol Maj
      // sol
    if num = 1 then 
    begin  
    belipse1_1.top := 74;
	belipse1_1.left := 10;

	// si
	belipse1_2.top := 96;
	belipse1_2.left := 160;

	// ré 2
	belipse1_3.top := 96;
	belipse1_3.left := 218;
	end else
	if num = 2 then 
    begin  
    belipse2_1.top := 74;
	belipse2_1.left := 10;

	// si
	belipse2_2.top := 96;
	belipse2_2.left := 160;

	// ré 2
	belipse2_3.top := 96;
	belipse2_3.left := 218;
	end else
	if num = 3 then 
    begin  
    belipse3_1.top := 74;
	belipse3_1.left := 10;

	// si
	belipse3_2.top := 96;
	belipse3_2.left := 160;

	// ré 2
	belipse3_3.top := 96;
	belipse3_3.left := 218;
	end;
	
	end else
	 if ((withsharp.Value = false) and (ranchord = 7) and (ismin <> 1 )) or
     ((withsharp.Value = true) and (ranchord = 11) and (ismin <> 1)) then    begin    
// sol min
    if num = 1 then 
    begin 
      // sol
    belipse1_1.top := 74;
	belipse1_1.left := 10;

	// la#
	belipse1_2.top := 24;
	belipse1_2.left := 148;

	// ré 2
	belipse1_3.top := 96;
	belipse1_3.left := 218;
	end else
	if num = 2 then 
    begin 
      // sol
    belipse2_1.top := 74;
	belipse2_1.left := 10;

	// la#
	belipse2_2.top := 24;
	belipse2_2.left := 148;

	// ré 2
	belipse2_3.top := 96;
	belipse2_3.left := 218;
	end else
	if num = 3 then 
    begin 
      // sol
    belipse3_1.top := 74;
	belipse3_1.left := 10;

	// la#
	belipse3_2.top := 24;
	belipse3_2.left := 148;

	// ré 2
	belipse3_3.top := 96;
	belipse3_3.left := 218;
	end;
	end else
	begin
	if num = 1 then 
    begin
	belipse1_1.visible := false;
	belipse1_2.visible := false;
	belipse1_3.visible := false;
	end else
	if num = 2 then 
    begin
	belipse2_1.visible := false;
	belipse2_2.visible := false;
	belipse2_3.visible := false;
	end else
	if num = 3 then 
    begin
	belipse3_1.visible := false;
	belipse3_2.visible := false;
	belipse3_3.visible := false;
	end;
	end;
end;

procedure trandomnotefo.dorandomchordbut(const Sender: TObject);
begin
if blocked = 0 then begin
blocked := 1;
dorandomchord(Sender);
playrandomchords(TButton(Sender).tag-1);
application.processmessages;
blocked := 0;
end;
end;

	  

procedure trandomnotefo.dorandomchord(const Sender: TObject);
var
  str2, str3: string;
  ismin, x, ranchord: integer;
   isminstr: string;
   
 begin
   refreshform(sender);
  x := 0;
  while x < 50 do
  begin

    ismin := Random(2);

    if ismin = 1 then
     begin 
      isminstr := '';
      str3 := 'Major';
     end else
    begin
      isminstr := 'm';
      str3 := 'Minor';
    end; 
 
    str3 := lineend + str3; 

    if withsharp.Value = false then
    begin
      ranchord := Random(7) + 1;
      if ranchord = 1 then
       str2   := 'A / La' + str3
      else if ranchord = 2 then
        str2   := 'B / Si' + str3
      else if ranchord = 3 then
        str2   := 'C / Do' + str3
      else if ranchord = 4 then
        str2   := 'D / Ré' + str3
      else if ranchord = 5 then
        str2   := 'E / Mi' + str3
      else if ranchord = 6 then
        str2   := 'F / Fa' + str3
      else if ranchord = 7 then
        str2   := 'G / Sol' + str3;

    end
    else
    begin
      ranchord := Random(12) + 1;
      if ranchord = 1 then
        str2   := 'A / La' + str3
      else if ranchord = 2 then
        str2   := 'A# / La#' + str3
      else if ranchord = 3 then
        str2   := 'B / Si' + str3
      else if ranchord = 4 then
        str2   := 'C / Do' + str3
      else if ranchord = 5 then
        str2   := 'C# / Do#' + str3
      else if ranchord = 6 then
        str2   := 'D / Ré' + str3
      else if ranchord = 7 then
        str2   := 'D# / Ré#' + str3
      else if ranchord = 8 then
        str2   := 'E / Mi' + str3
      else if ranchord = 9 then
        str2   := 'F / Fa' + str3
      else if ranchord = 10 then
        str2   := 'F# / Fa#' + str3
      else if ranchord = 11 then
        str2   := 'G / Sol' + str3
      else if ranchord = 12 then
        str2   := 'G# / Sol#' + str3;
    end;
    
    if TButton(Sender).tag = 0 then
    begin
      if chordran = 1 then 
      begin
        chord1.caption := str2;
        chordmem1 := copy(str2,1,1) + isminstr ;
      end  
     else if chordran = 2 then
      begin
      chord2.caption := str2;
      chordmem2 := copy(str2,1,1) + isminstr  ;
      end else if chordran = 3 then
      begin
        chord3.caption := str2;
        chordmem3 := copy(str2,1,1) + isminstr  ;
       end 
      else if chordran = 4 then
        chord4.Text := str2
      else if chordran = 5 then
        chord5.Text := str2;
     if  (x = 49) then
     begin
      pianochord(chordran, ranchord, ismin);
      guitarchord(chordran, ranchord, ismin); 
      basschord(chordran, ranchord, ismin); 
       refreshform(sender);
     end;   
     end
    else
    begin
    if TButton(Sender).tag = 1 then
    begin
      chord1.caption := str2;
       chordmem1 := copy(str2,1,1) + isminstr ;
     end  
    else if TButton(Sender).tag = 2 then
    begin
      chord2.caption := str2;
       chordmem2 := copy(str2,1,1) + isminstr ; 
     end  
    else if TButton(Sender).tag = 3 then
    begin
     chordmem3 := copy(str2,1,1) + isminstr ;
      chord3.caption := str2;
    end  
    else if TButton(Sender).tag = 4 then
      chord4.Text := str2
    else if TButton(Sender).tag = 5 then
      chord5.Text := str2;
   
   
     if  (x = 49) then 
     begin
     pianochord(TButton(Sender).tag, ranchord, ismin); 
     guitarchord(TButton(Sender).tag, ranchord, ismin);  
     basschord(TButton(Sender).tag, ranchord, ismin);  
      refreshform(sender);
     end;
    end;  
    
      Inc(x);
    application.ProcessMessages;
    sleep(20);
  end;
 
end;

procedure trandomnotefo.oncreatedev(const Sender: TObject);
begin
  randomize;
 // Visible := False;
 keyb2.bitmap :=  keyb1.bitmap;
 keyb3.bitmap :=  keyb1.bitmap;
 timage8.bitmap :=  timage1.bitmap;
 timage12.bitmap :=  timage1.bitmap;
 timage6.bitmap :=  timage2.bitmap;
 timage11.bitmap :=  timage2.bitmap;
 
 elipse1_2.bitmap :=  elipse1_1.bitmap;
 elipse1_3.bitmap :=  elipse1_1.bitmap;
 elipse2_1.bitmap :=  elipse1_1.bitmap;
 elipse2_2.bitmap :=  elipse1_1.bitmap;
 elipse2_3.bitmap :=  elipse1_1.bitmap;
 elipse3_1.bitmap :=  elipse1_1.bitmap;
 elipse3_2.bitmap :=  elipse1_1.bitmap;
 elipse3_3.bitmap :=  elipse1_1.bitmap;
 
 gelipse1_2.bitmap :=  gelipse1_1.bitmap;
 gelipse1_3.bitmap :=  gelipse1_1.bitmap;
 gelipse2_1.bitmap :=  gelipse1_1.bitmap;
 gelipse2_2.bitmap :=  gelipse1_1.bitmap;
 gelipse2_3.bitmap :=  gelipse1_1.bitmap;
 gelipse3_1.bitmap :=  gelipse1_1.bitmap;
 gelipse3_2.bitmap :=  gelipse1_1.bitmap;
 gelipse3_3.bitmap :=  gelipse1_1.bitmap;
 
 belipse1_1.bitmap :=  gelipse1_1.bitmap;
// belipse1_2.bitmap :=  gelipse1_1.bitmap;
// belipse1_3.bitmap :=  gelipse1_1.bitmap;
 belipse2_1.bitmap :=  gelipse1_1.bitmap;
// belipse2_2.bitmap :=  gelipse1_1.bitmap;
// belipse2_3.bitmap :=  gelipse1_1.bitmap;
 belipse3_1.bitmap :=  gelipse1_1.bitmap;
// belipse3_2.bitmap :=  gelipse1_1.bitmap;
// belipse3_3.bitmap :=  gelipse1_1.bitmap;

end;


procedure trandomnotefo.randomnum(const Sender: TObject);
var
   x, ax: integer;
begin
if blocked = 0 then begin
blocked := 1;
 doclear(sender);
 numchord.visible := true;
  bnbchords.left := 64;
  bnbchords.top := 184;
  if withrandom.Value = false then
    numchord.Value := maxnote.Value
  else
  begin

    x := 0;
    while x < 50 do
    begin

      numchord.Value := Random(maxnote.Value) + 1;
      Inc(x);
      application.ProcessMessages;
      sleep(20);
    end;
  end;

  if numchord.Value = 5 then
  begin
      bchord1.Visible := True;
    chord1.Visible  := True;
        
    chordran        := 1;
    dorandomchord(Sender);
    
    piano1.Visible := True;
    guitar1.Visible  := True;
    bass1.Visible  := True;
  
    bchord2.Visible := True;
    chord2.Visible  := True;
    
    chord2.caption := chord1.caption ;
     x := 0;
    while (x < 10) and (chord2.caption = chord1.caption) do
    begin
    chordran        := 2;
    dorandomchord(Sender);
    inc(x);
    end;
    
    piano2.Visible := True;
    guitar2.Visible  := True;
    bass2.Visible  := True;
    
    chord3.caption := chord2.caption ;
     bchord3.Visible := True;
    chord3.Visible  := True;
     x := 0;
    while (x < 10) and ((chord2.caption = chord3.caption) or (chord1.caption = chord3.caption)) do
    begin
    chordran        := 3;
    dorandomchord(Sender);
    inc(x);
    end;
    
    piano3.Visible := True;
    guitar3.Visible  := True;
    bass3.Visible  := True;

    bchord4.Visible := True;
    chord4.Visible  := True;
    chordran        := 4;
    dorandomchord(Sender);

    bchord5.Visible := True;
    chord5.Visible  := True;
    chordran        := 5;
    dorandomchord(Sender);
    piano5.Visible := True;
    guitar5.Visible  := True;
    
  end
  else if numchord.Value = 4 then
  begin
     bchord1.Visible := True;
    chord1.Visible  := True;
    chordran        := 1;
    dorandomchord(Sender);
    
    piano1.Visible := True;
    guitar1.Visible  := True;
    bass1.Visible  := True;
    
    chord2.caption := chord1.caption ;
    bchord2.Visible := True;
    chord2.Visible  := True;
     x := 0;
    while (x < 10) and (chord2.caption = chord1.caption) do
    begin
    chordran        := 2;
    dorandomchord(Sender);
    inc(x);
    end;
    
    piano2.Visible := True;
    guitar2.Visible  := True;
    bass2.Visible  := True;
    
    chord3.caption := chord2.caption ;
     x := 0;
     bchord3.Visible := True;
    chord3.Visible  := True;
    while (x < 10) and ((chord2.caption = chord3.caption) or (chord1.caption = chord3.caption)) do
    begin
     chordran        := 3;
    dorandomchord(Sender);
    inc(x);
    end;
    
    piano3.Visible := True;
    guitar3.Visible  := True;
    bass3.Visible  := True;

    bchord4.Visible := True;
    chord4.Visible  := True;
    chordran        := 4;
    dorandomchord(Sender);
    
    piano4.Visible := True;
    guitar4.Visible  := True;

  end
  else if numchord.Value = 3 then
  begin
    bchord1.Visible := True;
    chord1.Visible  := True;
    chordran        := 1;
    dorandomchord(Sender);
    
     piano1.Visible := True;
    guitar1.Visible  := True;
    bass1.Visible  := True;
    
     application.processmessages;
     
    playrandomchords(0);
    
     application.processmessages;
    
    chord2.caption := chord1.caption ;
     x := 0;
    while (x < 10) and (chord2.caption = chord1.caption) do
    begin
    bchord2.Visible := True;
    chord2.Visible  := True;
    chordran        := 2;
    dorandomchord(Sender);
    inc(x);
    end;
     piano2.Visible := True;
    guitar2.Visible  := True;
    
    bass2.Visible  := True;
    
     application.processmessages;
    
    playrandomchords(1);
    
    application.processmessages;
    
    
    chord3.caption := chord2.caption ;
     x := 0;
    while (x < 10) and ((chord2.caption = chord3.caption) or (chord1.caption = chord3.caption)) do
    begin
     bchord3.Visible := True;
    chord3.Visible  := True;
    chordran        := 3;
    dorandomchord(Sender);
    inc(x);
    end;
    
   piano3.Visible := True;
    guitar3.Visible  := True;  
   bass3.Visible  := True;
   
    application.processmessages;
    playrandomchords(2);
     application.processmessages;
    
  end
  else if numchord.Value = 2 then
  begin
      bchord1.Visible := True;
    chord1.Visible  := True;
    chordran        := 1;
    dorandomchord(Sender);
     piano1.Visible := True;
    guitar1.Visible  := True;
     bass1.Visible  := True;  
    chord2.caption := chord1.caption ;
    bchord2.Visible := True;
    chord2.Visible  := True;
     x := 0;
    while (x < 10) and (chord2.caption = chord1.caption) do
    begin
    chordran        := 2;
    dorandomchord(Sender);
    inc(x);
    end;
    
     piano2.Visible := True;
    guitar2.Visible  := True;
    bass2.Visible  := True;
    
 
   end
  else if numchord.Value = 1 then
  begin
    bchord1.Visible := True;
    chord1.Visible  := True;
    chordran        := 1;
    dorandomchord(Sender);
     piano1.Visible := True;
    guitar1.Visible  := True;
    bass1.Visible  := True;

  end;
  
   tbutton2.visible := true;
   
   if nodrums.Value = true then
  begin
    tbutton3.visible := true;
        drum_beats[0] := 'x000x000x000x000'; // closed hat
        drum_beats[1] := '0000000000000000'; // opened hat
        drum_beats[2] := '0000000000000000'; // snare
        drum_beats[3] := 'x000000000000000'; // kick
        drumsfo.novoice.Value := true;
     for ax := 0 to 15 do
  begin
    if (Copy(drum_beats[0], ax + 1, 1) = 'x') then
      ach[ax].Value := True
    else
      ach[ax].Value := False;

    if (Copy(drum_beats[1], ax + 1, 1) = 'x') then
      aoh[ax].Value := True
    else
      aoh[ax].Value := False;

    if (Copy(drum_beats[2], ax + 1, 1) = 'x') then
      asd[ax].Value := True
    else
      asd[ax].Value := False;

    if (Copy(drum_beats[3], ax + 1, 1) = 'x') then
      abd[ax].Value := True
    else
      abd[ax].Value := False;
  end; 
    
 drumsfo.dragdock.float();
 drumsfo.visible := true;
    
 refreshform(sender); 
     
 bpm.visible := true;
 bpm.value := (80 + random(80));
 drumsfo.edittempo.value := bpm.value * 2;
 drumsfo.dostart(sender);
 end;
 
 blocked := 0;
 
 end;

end;

procedure trandomnotefo.onclosev(const sender: TObject);
begin
doclear(sender);
end;

procedure trandomnotefo.doclear(const sender: TObject);
begin
bchord1.Visible := False;
numchord.visible := false;
  chord1.Visible  := False;
  bchord2.Visible := False;
  chord2.Visible  := False;
  bchord3.Visible := False;
  chord3.Visible  := False;
  bchord4.Visible := False;
  chord4.Visible  := False;
  bchord5.Visible := False;
  chord5.Visible  := False;
  guitar1.Visible  := False;
  guitar2.Visible  := False;
  guitar3.Visible  := False;
  guitar4.Visible  := False;
  guitar5.Visible  := False;
  piano1.Visible  := False;
  piano2.Visible  := False;
  piano3.Visible  := False;
  piano4.Visible  := False;
  piano5.Visible  := False;
  bass1.Visible  := false;
  bass2.Visible  := false;
  bass3.Visible  := false;
  bpm.visible := false;
  drumsfo.visible := false;
  tbutton3.visible := false;
  tbutton2.visible := false;
  drumsfo.dostop(sender);
  bnbchords.left := 534;
  bnbchords.top := 350;
  refreshform(sender);
end;

procedure trandomnotefo.refreshform(const sender: TObject);
begin

if guitarsfo.visible then
  begin
    guitarsfo.top  := top + tbutton5.top + 18;
    guitarsfo.left := left + tbutton5.left; 
    guitarsfo.visible := true;
    guitarsfo.bringtofront; 
  end;
  
  if drumsfo.visible then
  begin
 drumsfo.top  := top +386;
    drumsfo.left := left + 40;
    drumsfo.visible := true;
    drumsfo.bringtofront; 
 end;    

 end;

procedure trandomnotefo.onshowdrums(const sender: TObject);
begin
   drumsfo.dragdock.float();
   drumsfo.visible := true;
      refreshform(sender); 
end;

procedure trandomnotefo.doquit(const sender: TObject);
begin
if drumsfo.visible then drumsfo.visible := false;
//if guitarsfo.visible then guitarsfo.visible := false;
mainfo.onexit(sender);
end;

procedure trandomnotefo.showguit(const sender: TObject);
begin
        
   guitarsfo.dragdock.float();
   guitarsfo.visible := true;
   refreshform(sender); 

end;

procedure trandomnotefo.playrandomchords(thenum : integer);
var
thedir, afile : string;
begin

if thenum = 0 then afile := chordmem1 + '_PIANO'
else if thenum = 1 then afile := chordmem2 + '_PIANO'
else if thenum = 2 then afile := chordmem3 + '_PIANO'
else afile := '';

thedir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +
       'sound' + directoryseparator + 'piano' + directoryseparator + afile + '.ogg';

 uos_Stop(20);

if uos_CreatePlayer(20) then

 if uos_AddFromFile(20, PChar(thedir)) > -1 then

 
   {$if defined(cpuarm)}
    if uos_AddIntoDevOut(20, -1, 0.3, -1, -1, -1, -1, -1) > -1 then
   {$else}
    if uos_AddIntoDevOut(20) > -1 then
    {$endif}
         
  uos_Play(20);
  
  sleep(4500);

if thenum = 0 then afile := chordmem1 + '_GUIT'
else if thenum = 1 then afile := chordmem2 + '_GUIT'
else if thenum = 2 then afile := chordmem3 + '_GUIT'
else afile := '';

thedir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +
       'sound' + directoryseparator + 'guitar' + directoryseparator + afile + '.ogg';

 uos_Stop(21);

if uos_CreatePlayer(21) then

 if uos_AddFromFile(21, PChar(thedir)) > -1 then

 
   {$if defined(cpuarm)}
    if uos_AddIntoDevOut(21, -1, 0.3, -1, -1, -1, -1, -1) > -1 then
   {$else}
    if uos_AddIntoDevOut(21) > -1 then
    {$endif}
         
  uos_Play(21);
  
  sleep(6000);
  
end;

procedure trandomnotefo.onmouseguit(const sender: twidget;
               var ainfo: mouseeventinfoty);

var
thedir, afile : string;
begin
with ainfo do begin
  
   if eventkind in [ek_buttonpress] then begin


if Timage(Sender).tag = 0 then afile := chordmem1 + '_GUIT'
else if Timage(Sender).tag = 1 then afile := chordmem2 + '_GUIT'
else if Timage(Sender).tag = 2 then afile := chordmem3 + '_GUIT'
else afile := '';

thedir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +
       'sound' + directoryseparator + 'guitar' + directoryseparator + afile + '.ogg';

 uos_Stop(Timage(Sender).tag + 10);

if uos_CreatePlayer(Timage(Sender).tag + 10) then

 if uos_AddFromFile(Timage(Sender).tag + 10, PChar(thedir)) > -1 then

 
   {$if defined(cpuarm)}
    if uos_AddIntoDevOut(Timage(Sender).tag + 10, -1, 0.3, -1, -1, -1, -1, -1) > -1 then
   {$else}
    if uos_AddIntoDevOut(Timage(Sender).tag + 10) > -1 then
    {$endif}
         
  uos_Play(Timage(Sender).tag + 10);
  
  refreshform(sender);
    
end;

end;

end;

procedure trandomnotefo.onmousepiano(const sender: twidget;
               var ainfo: mouseeventinfoty);
var
thedir, afile : string;
begin
with ainfo do begin  
   if eventkind in [ek_buttonpress] then begin


if Timage(Sender).tag = 0 then afile := chordmem1 + '_PIANO'
else if Timage(Sender).tag = 1 then afile := chordmem2 + '_PIANO'
else if Timage(Sender).tag = 2 then afile := chordmem3 + '_PIANO'
else afile := '';

thedir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +
       'sound' + directoryseparator + 'piano' + directoryseparator + afile + '.ogg';

 uos_Stop(Timage(Sender).tag + 20);

if uos_CreatePlayer(Timage(Sender).tag + 20) then

 if uos_AddFromFile(Timage(Sender).tag + 20, PChar(thedir)) > -1 then

 
   {$if defined(cpuarm)}
    if uos_AddIntoDevOut(Timage(Sender).tag + 20, -1, 0.3, -1, -1, -1, -1, -1) > -1 then
   {$else}
    if uos_AddIntoDevOut(Timage(Sender).tag + 20) > -1 then
    {$endif}
         
  uos_Play(Timage(Sender).tag + 20);
  
  refreshform(sender);
    
end;

end;

end;

procedure trandomnotefo.onmouseform(const sender: twidget;
               var ainfo: mouseeventinfoty);
begin
with ainfo do begin  
   if eventkind in [ek_buttonpress] then begin
   refreshform(sender);
end;
end;
end;

procedure trandomnotefo.ontextmax(const sender: tcustomdataedit;
               var atext: msestring; var accept: Boolean);
begin
 refreshform(sender);
end;

end.

