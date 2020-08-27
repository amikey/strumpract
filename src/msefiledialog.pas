{ MSEgui Copyright (c) 1999-2016 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}

unit msefiledialog;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses
 mseglob, mseguiglob, mseforms, classes, mclasses, mseclasses, msewidgets,
 msegrids,mselistbrowser, mseedit, msesimplewidgets, msedataedits, msedialog,
 msetypes,msestrings, msesystypes, msesys, msedispwidgets, msedatalist,msestat,
  msestatfile,msebitmap, msedatanodes, msefileutils, msedropdownlist,mseevent,
  msegraphedits,mseeditglob, msesplitter, msemenus, msegridsglob,msegraphics,
  msegraphutils,msedirtree, msewidgetgrid, mseact, mseapplication,msegui,
  mseificomp,mseificompglob, mseifiglob, msestream, sysutils,msemenuwidgets,
  msescrollbar,mserichstring, msedragglob;

const 
  defaultlistviewoptionsfile = defaultlistviewoptions + [lvo_readonly];

type 
  tfilelistitem = class(tlistitem)
    private 
    protected 
    public 

      constructor create(Const aowner: tcustomitemlist);
      override;
  end;
  pfilelistitem = ^tfilelistitem;

  tfileitemlist = class(titemviewlist)
    protected 
      procedure createitem(out item: tlistitem);
      override;
  end;

  getfileiconeventty = procedure (Const sender: tobject; Const ainfo: fileinfoty;
                                  Var imagelist: timagelist; Var imagenr: integer) of object;

  tfilelistview = class(tlistview)
    private 
      foptionsfile: filelistviewoptionsty;
      fmaskar: filenamearty;
      fdirectory: filenamety;
      ffilecount: integer;
      fincludeattrib, fexcludeattrib: fileattributesty;
      fonlistread: notifyeventty;
      ffocusmoved: boolean;
      fongetfileicon: getfileiconeventty;
      foncheckfile: checkfileeventty;
      procedure filelistchanged(Const sender: tobject);
      procedure setfilelist(Const Value: tfiledatalist);
      function getpath: msestring;
      procedure setpath(Const Value: msestring);
      procedure setdirectory(Const Value: msestring);
      function getmask: filenamety;
      procedure setmask(Const value: filenamety);
      function getselectednames: filenamearty;
      procedure setselectednames(Const avalue: filenamearty);
      function getchecksubdir: boolean;
      procedure setchecksubdir(Const avalue: boolean);
      procedure setoptionsfile(Const avalue: filelistviewoptionsty);
      procedure checkcasesensitive;
    protected 
      foptionsdir: dirstreamoptionsty;
      fcaseinsensitive: boolean;
      //   procedure setoptions(const Value: listviewoptionsty); override;
      procedure docellevent(Var info: celleventinfoty);
      override;
    public 
      ffilelist: tfiledatalist;

      constructor create(aowner: tcomponent);
      override;

      destructor destroy;
      override;
      procedure readlist;
      procedure updir;
      function filecount: integer;
      property directory: filenamety read fdirectory write setdirectory;
      property includeattrib: fileattributesty read fincludeattrib
                              write fincludeattrib default [fa_all];
      property excludeattrib: fileattributesty read fexcludeattrib
                              write fexcludeattrib default [fa_hidden];
      property maskar: filenamearty read fmaskar write fmaskar;
      //nil -> all
      property mask: filenamety read getmask write setmask;
      //'' -> all
      property path: filenamety read getpath write setpath;
      //calls readlist
      property selectednames: filenamearty read getselectednames write setselectednames;
      property  checksubdir: boolean read getchecksubdir write setchecksubdir;
    published 
      property options default defaultlistviewoptionsfile;
      property optionsfile: filelistviewoptionsty read foptionsfile
                            write setoptionsfile default defaultfilelistviewoptions;
      property filelist: tfiledatalist read ffilelist write setfilelist;
      property onlistread: notifyeventty read fonlistread write fonlistread;
      property ongetfileicon: getfileiconeventty read fongetfileicon
                              write fongetfileicon;
      property oncheckfile: checkfileeventty read foncheckfile write foncheckfile;
  end;

const 
  defaulthistorymaxcount = 50;

type 
  filedialogoptionty = (fdo_filtercasesensitive,    //flvo_maskcasesensitive
                        fdo_filtercaseinsensitive,  //flvo_maskcaseinsensitive
                        fdo_save,
                        fdo_dispname,fdo_dispnoext,fdo_sysfilename,fdo_params,
                        fdo_directory,fdo_file,
                        fdo_absolute,fdo_relative,fdo_lastdirrelative,
                        fdo_basedirrelative,
                        fdo_quotesingle,
                        fdo_link, //links lastdir of controllers with same group
                        fdo_checkexist,fdo_acceptempty,fdo_single,
                        fdo_chdir,fdo_savelastdir,
                        fdo_checksubdir);
  filedialogoptionsty = set of filedialogoptionty;
const 
  defaultfiledialogoptions = [fdo_savelastdir];

type 
  filedialogkindty = (fdk_none,fdk_open,fdk_save,fdk_new);

  tfiledialogcontroller = class;

    filedialogbeforeexecuteeventty = procedure (Const sender: tfiledialogcontroller;
                                                Var dialogkind: filedialogkindty; Var aresult:
                                                modalresultty) of object;
    filedialogafterexecuteeventty = procedure (Const sender: tfiledialogcontroller;
                                               Var aresult: modalresultty) of object;

    tfiledialogcontroller = class(tlinkedpersistent)
      private 
        fowner: tmsecomponent;
        fgroup: integer;
        fonchange: proceventty;
        ffilenames: filenamearty;
        ffilterlist: tdoublemsestringdatalist;
        ffilter: filenamety;
        ffilterindex: integer;
        fcolwidth: integer;
        fwindowrect: rectty;
        fhistorymaxcount: integer;
        fhistory: msestringarty;
        fcaptionopen: msestring;
        fcaptionsave: msestring;
        fcaptionnew: msestring;
        finclude: fileattributesty;
        fexclude: fileattributesty;
        fonbeforeexecute: filedialogbeforeexecuteeventty;
        fonafterexecute: filedialogafterexecuteeventty;
        fongetfilename: setstringeventty;
        fongetfileicon: getfileiconeventty;
        foncheckfile: checkfileeventty;
        fimagelist: timagelist;
        fparams: msestring;
        procedure setfilterlist(Const Value: tdoublemsestringdatalist);
        procedure sethistorymaxcount(Const Value: integer);
        function getfilename: filenamety;
        procedure setfilename(Const avalue: filenamety);
        procedure dochange;
        procedure setdefaultext(Const avalue: filenamety);
        procedure setoptions(Value: filedialogoptionsty);
        procedure checklink;
        procedure setlastdir(Const avalue: filenamety);
        procedure setimagelist(Const avalue: timagelist);
        function getsysfilename: filenamety;
      protected 
        flastdir: filenamety;
        fbasedir: filenamety;
        fdefaultext: filenamety;
        foptions: filedialogoptionsty;
      public 

        constructor create(Const aowner: tmsecomponent = Nil;
                           Const onchange: proceventty = Nil);
        reintroduce;

        destructor destroy;
        override;
        procedure readstatvalue(Const reader: tstatreader);
        procedure readstatstate(Const reader: tstatreader);
        procedure readstatoptions(Const reader: tstatreader);
        procedure writestatvalue(Const writer: tstatwriter);
        procedure writestatstate(Const writer: tstatwriter);
        procedure writestatoptions(Const writer: tstatwriter);
        function actcaption(Const dialogkind: filedialogkindty): msestring;
        function execute(dialogkind: filedialogkindty = fdk_none): modalresultty;
        overload;
        //fdk_none -> use options fdo_save
        function execute(dialogkind: filedialogkindty; Const acaption: msestring;
                         aoptions: filedialogoptionsty): modalresultty;
        overload;
        function execute(Const dialogkind: filedialogkindty;
                         Const acaption: msestring): modalresultty;
        overload;
        function execute(Const dialogkind: filedialogkindty;
                         Const aoptions: filedialogoptionsty): modalresultty;
        overload;
        function execute(Var avalue: filenamety;
                         dialogkind: filedialogkindty = fdk_none): boolean;
        overload;
        function execute(Var avalue: filenamety; Const  dialogkind: filedialogkindty;
                         Const acaption: msestring): boolean;
        overload;
        function execute(Var avalue: filenamety; Const  dialogkind: filedialogkindty;
                         Const acaption: msestring;
                         aoptions: filedialogoptionsty): boolean;
        overload;
        function canoverwrite(): boolean;
        //true if current filename is allowed to write
        procedure clear;
        procedure componentevent(Const event: tcomponentevent);
        property history: msestringarty read fhistory write fhistory;
        property filenames: filenamearty read ffilenames write ffilenames;
        property syscommandline: filenamety read getsysfilename;
        deprecated;
        property sysfilename: filenamety read getsysfilename;
        property params: msestring read fparams;
      published 
        property filename: filenamety read getfilename write setfilename;
        property lastdir: filenamety read flastdir write setlastdir;
        property basedir: filenamety read fbasedir write fbasedir;
        property filter: filenamety read ffilter write ffilter;
        property filterlist: tdoublemsestringdatalist read ffilterlist write setfilterlist;
        property filterindex: integer read ffilterindex write ffilterindex default 0;
        property include: fileattributesty read finclude write finclude default [fa_all];
        property exclude: fileattributesty read fexclude write fexclude default [fa_hidden];
        property colwidth: integer read fcolwidth write fcolwidth default 0;
        property defaultext: filenamety read fdefaultext write setdefaultext;
        property options: filedialogoptionsty read foptions write setoptions
                          default defaultfiledialogoptions;
        property historymaxcount: integer read fhistorymaxcount
                                  write sethistorymaxcount default defaulthistorymaxcount;
        property captionopen: msestring read fcaptionopen write fcaptionopen;
        property captionsave: msestring read fcaptionsave write fcaptionsave;
        property captionnew: msestring read fcaptionnew write fcaptionnew;
        property group: integer read fgroup write fgroup default 0;
        property imagelist: timagelist read fimagelist write setimagelist;
        property ongetfilename: setstringeventty read fongetfilename write fongetfilename;
        property ongetfileicon: getfileiconeventty read fongetfileicon
                                write fongetfileicon;
        property oncheckfile: checkfileeventty read foncheckfile write foncheckfile;
        property onbeforeexecute: filedialogbeforeexecuteeventty
                                  read fonbeforeexecute write fonbeforeexecute;
        property onafterexecute: filedialogafterexecuteeventty
                                 read fonafterexecute write fonafterexecute;
    end;

    const 
      defaultfiledialogoptionsedit1 = defaultoptionsedit1+
                                      [oe1_savevalue, oe1_savestate, oe1_saveoptions];

    type 
      tfiledialog = class(tdialog,istatfile)
        private 
          fcontroller: tfiledialogcontroller;
          fstatvarname: msestring;
          fstatfile: tstatfile;
          fdialogkind: filedialogkindty;
          //   foptionsedit: optionseditty;
          foptionsedit1: optionsedit1ty;
          fstatpriority: integer;
          procedure setcontroller(Const value: tfiledialogcontroller);
          procedure setstatfile(Const Value: tstatfile);
          procedure readoptionsedit(reader: treader);
        protected 
          procedure defineproperties(filer: tfiler);
          override;
          //istatfile
          procedure dostatread(Const reader: tstatreader);
          procedure dostatwrite(Const writer: tstatwriter);
          procedure statreading;
          procedure statread;
          function getstatvarname: msestring;
          function getstatpriority: integer;
        public 

          constructor create(aowner: tcomponent);
          override;

          destructor destroy;
          override;
          function execute: modalresultty;
          overload;
          override;
          function execute(Const akind: filedialogkindty): modalresultty;
          reintroduce;
          overload;
          function execute(Const akind: filedialogkindty;
                           Const aoptions: filedialogoptionsty): modalresultty;
          reintroduce;
          overload;
          procedure componentevent(Const event: tcomponentevent);
          override;
        published 
          property statfile: tstatfile read fstatfile write setstatfile;
          property statvarname: msestring read getstatvarname write fstatvarname;
          property statpriority: integer read fstatpriority
                                 write fstatpriority default 0;
          property controller: tfiledialogcontroller read fcontroller
                               write setcontroller;
          property dialogkind: filedialogkindty read fdialogkind write fdialogkind
                               default fdk_none;
          property optionsedit1: optionsedit1ty read foptionsedit1 write foptionsedit1
                                 default defaultfiledialogoptionsedit1;
      end;

      tcustomfilenameedit1 = class;
        tfilenameeditcontroller = class(tstringdialogcontroller)
          protected 
            function execute(Var avalue: msestring): boolean;
            override;
          public 

            constructor create(Const aowner: tcustomfilenameedit1);
        end;

        tcustomfilenameedit1 = class(tcustomdialogstringed)
          private 
            fcontroller: tfiledialogcontroller;
            procedure setcontroller(Const avalue: tfiledialogcontroller);
            function getsysvalue: filenamety;
            procedure setsysvalue(Const avalue: filenamety);
            function getsysvaluequoted: filenamety;
          protected 
            function createdialogcontroller: tstringdialogcontroller;
            override;
            procedure texttovalue(Var accept: boolean; Const quiet: boolean);
            override;
            procedure updatedisptext(Var avalue: msestring);
            override;
            function getvaluetext: msestring;
            override;
            procedure readstatvalue(Const reader: tstatreader);
            override;
            procedure readstatstate(Const reader: tstatreader);
            override;
            procedure readstatoptions(Const reader: tstatreader);
            override;
            procedure writestatvalue(Const writer: tstatwriter);
            override;
            procedure writestatstate(Const writer: tstatwriter);
            override;
            procedure writestatoptions(Const writer: tstatwriter);
            override;
            procedure valuechanged;
            override;
            procedure updatecopytoclipboard(Var atext: msestring);
            override;
            procedure updatepastefromclipboard(Var atext: msestring);
            override;
          public 

            constructor create(aowner: tcomponent);
            override;

            destructor destroy;
            override;
            procedure componentevent(Const event: tcomponentevent);
            override;
            property controller: tfiledialogcontroller read fcontroller
                                 write setcontroller;
            property sysvalue: filenamety read getsysvalue write setsysvalue;
            property sysvaluequoted: filenamety read getsysvaluequoted write setsysvalue;
          published 
            property optionsedit1 default defaultfiledialogoptionsedit1;
        end;

        tcustomfilenameedit = class(tcustomfilenameedit1)
          public 

            constructor create(aowner: tcomponent);
            override;

            destructor destroy;
            override;
        end;

        tcustomremotefilenameedit = class(tcustomfilenameedit1)
          private 
            fdialog: tfiledialog;
            procedure setfiledialog(Const avalue: tfiledialog);
          protected 
            procedure objectevent(Const sender: tobject;
                                  Const event: objecteventty);
            override;
          public 
            property dialog: tfiledialog read fdialog write setfiledialog;
        end;

        tfilenameedit = class(tcustomfilenameedit)
          published 
            property frame;
            property passwordchar;
            property maxlength;
            property value;
            property onsetvalue;
            property controller;
        end;

        tremotefilenameedit = class(tcustomremotefilenameedit)
          published 
            property frame;
            property passwordchar;
            property maxlength;
            property value;
            property onsetvalue;
            property dialog;
        end;

        dirdropdowneditoptionty = (ddeo_showhiddenfiles,ddeo_checksubdir);
        dirdropdowneditoptionsty = set of dirdropdowneditoptionty;

        tdirdropdownedit = class(tdropdownwidgetedit)
          private 
            foptions: dirdropdowneditoptionsty;
            function getshowhiddenfiles: boolean;
            procedure setshowhiddenfiles(Const avalue: boolean);
            function getchecksubdir: boolean;
            procedure setchecksubdir(Const avalue: boolean);
          protected 
            procedure createdropdownwidget(Const atext: msestring;
                                           out awidget: twidget);
            override;
            function getdropdowntext(Const awidget: twidget): msestring;
            override;
            procedure pathchanged(Const sender: tobject);
            procedure doafterclosedropdown;
            override;
            procedure updatecopytoclipboard(Var atext: msestring);
            override;
            procedure updatepastefromclipboard(Var atext: msestring);
            override;
          public 
            property showhiddenfiles: boolean read getshowhiddenfiles
                                      write setshowhiddenfiles;
            property checksubdir: boolean read getchecksubdir
                                  write setchecksubdir;
          published 
            property options: dirdropdowneditoptionsty read foptions
                              write foptions default [];
        end;

        dirtreepatheventty = procedure (Const sender: tobject;
                                        Const avalue: msestring) of object;

        tdirtreeview = class(tpublishedwidget,icaptionframe)
          private 
            fonpathchanged: dirtreepatheventty;
            fonpathselected: dirtreepatheventty;
            fonselectionchanged: listitemeventty;
            function getoptions: dirtreeoptionsty;
            procedure setoptions(Const avalue: dirtreeoptionsty);
            function getpath: filenamety;
            procedure setpath(Const avalue: filenamety);
            procedure setroot(Const avalue: filenamety);
            function getgrid: twidgetgrid;
            procedure setgrid(Const avalue: twidgetgrid);
            function getoptionstree: treeitemeditoptionsty;
            procedure setoptionstree(Const avalue: treeitemeditoptionsty);
            function getoptionsedit: optionseditty;
            procedure setoptionsedit(Const avalue: optionseditty);
            function getcol_color: colorty;
            procedure setcol_color(Const avalue: colorty);
            function getcol_coloractive: colorty;
            procedure setcol_coloractive(Const avalue: colorty);
            function getcol_colorfocused: colorty;
            procedure setcol_colorfocused(Const avalue: colorty);
            function getcell_options: coloptionsty;
            procedure setcell_options(Const avalue: coloptionsty);



{
   function getcell_frame: tcellframe;
   procedure setcell_frame(const avalue: tcellframe);
   function getcell_face: tcellface;
   procedure setcell_face(const avalue: tcellface);
   function getcell_datalist: ttreeitemeditlist;
   procedure setcell_datalist(const avalue: ttreeitemeditlist);
  }
          protected 
            fdirview: tdirtreefo;
            fpath: filenamety;
            froot: filenamety;
            procedure dopathchanged(Const sender: tobject);
            procedure dopathselected(Const sender: tobject);
            procedure doselectionchanged(Const sender: tobject; Const aitem: tlistitem);
            procedure internalcreateframe;
            override;
            procedure loaded();
            override;
            class function classskininfo: skininfoty;
              override;
              public 

                constructor create(aowner: tcomponent);
                override;

                destructor destroy();
                override;
                procedure refresh();
                property dirview: tdirtreefo read fdirview;
                property path: filenamety read getpath write setpath;
                property root: filenamety read froot write setroot;
              published 
                property font: twidgetfont read getfont write setfont stored isfontstored;
                property options: dirtreeoptionsty read getoptions
                                  write setoptions default [];
                property optionstree: treeitemeditoptionsty read getoptionstree
                                      write setoptionstree default [teo_treecolnavig, 
                                      teo_enteronimageclick];
                property optionsedit: optionseditty read getoptionsedit write setoptionsedit
                                      default [oe_readonly, oe_undoonesc, oe_checkmrcancel, 
                                      oe_forcereturncheckvalue, oe_hintclippedtext, oe_locate];
                property col_color: colorty read getcol_color
                                    write setcol_color default cl_default;
                property col_coloractive: colorty read getcol_coloractive
                                          write setcol_coloractive default cl_none;
                property col_colorfocused: colorty read getcol_colorfocused
                                           write setcol_colorfocused default cl_active;
                property col_options: coloptionsty read getcell_options
                                      write setcell_options default [co_readonly, co_fill, 
                                      co_savevalue];
                //   property col_frame: tcellframe read getcell_frame write setcell_frame;
                //   property col_face: tcellface read getcell_face write setcell_face;
                //   property col_datalist: ttreeitemeditlist read getcell_datalist 
                //                                                   write setcell_datalist;
                property onpathchanged: dirtreepatheventty read
                                        fonpathchanged write fonpathchanged;
                property onpathselected: dirtreepatheventty read
                                         fonpathselected write fonpathselected;
                property onselectionchanged: listitemeventty read
                                             fonselectionchanged write fonselectionchanged;
                //for checkboxes
                property optionswidget default defaultoptionswidgetsubfocus;
            end;

            tfiledialogfo = class(tmseform)
              listview: tfilelistview;
              tlayouter2: tlayouter;
              filename: thistoryedit;
              filter: tdropdownlistedit;
              cancel: tbutton;
              ok: tbutton;
              showhidden: tbooleanedit;
              dir: tdirdropdownedit;
              createdir: tbutton;
              home: tbutton;
              up: tstockglyphbutton;
              back: tstockglyphbutton;
              forward: tstockglyphbutton;
              ldir: tstringdisp;
              list_log: tstringgrid;
   iconslist: timagelist;
              procedure createdironexecute(Const sender: TObject);
              procedure listviewselectionchanged(Const sender: tcustomlistview);
              procedure listviewitemevent(Const sender: tcustomlistview;
                                          Const index: Integer; Var info: celleventinfoty);
              procedure listviewonkeydown(Const sender: twidget; Var info: keyeventinfoty);
              procedure upaction(Const sender: TObject);
              procedure dironsetvalue(Const sender: TObject; Var avalue: mseString;
                                      Var accept: Boolean);
              procedure filenamesetvalue(Const sender: TObject; Var avalue: mseString;
                                         Var accept: Boolean);
              procedure listviewonlistread(Const sender: tobject);
              procedure filteronafterclosedropdown(Const sender: tobject);
              procedure filteronsetvalue(Const sender: tobject; Var avalue: msestring; Var accept:
                                         boolean);
              procedure filepathentered(Const sender: tobject);
              procedure okonexecute(Const sender: tobject);
              procedure layoutev(Const sender: TObject);
              procedure showhiddenonsetvalue(Const sender: TObject; Var avalue: Boolean;
                                             Var accept: Boolean);
              procedure formoncreate(Const sender: TObject);
              procedure dirshowhint(Const sender: TObject; Var info: hintinfoty);
              procedure copytoclip(Const sender: TObject; Var avalue: msestring);
              procedure pastefromclip(Const sender: TObject; Var avalue: msestring);
              procedure homeaction(Const sender: TObject);
              procedure backexe(Const sender: TObject);
              procedure forwardexe(Const sender: TObject);
              procedure buttonshowhint(Const sender: TObject; Var ainfo: hintinfoty);

              procedure onchangedir(Const sender: TObject);
              procedure oncellev(Const sender: TObject; Var info: celleventinfoty);
   procedure ondrawcell(const sender: tcol; const canvas: tcanvas;
                   var cellinfo: cellinfoty);
              private 
                fselectednames: filenamearty;
                finit: boolean;
                fcourse: filenamearty;
                fcourseid: int32;
                fcourselock: boolean;
                procedure updatefiltertext;
                function tryreadlist(Const adir: filenamety;
                                     Const errormessage: boolean): boolean;
                //restores old dir on error
                function changedir(Const adir: filenamety): boolean;
                procedure checkcoursebuttons();
                procedure course(Const adir: filenamety);
                procedure doup();
              public 
                dialogoptions: filedialogoptionsty;
                defaultext: filenamety;
                filenames: filenamearty;
            end;

            function filedialog(Var afilenames: filenamearty;
                                Const aoptions: filedialogoptionsty;
                                Const acaption: msestring;    //'' -> 'Open' or 'Save'
                                Const filterdesc: Array Of msestring;
                                Const filtermask: Array Of msestring;
                                Const adefaultext: filenamety = '';
                                Const filterindex: pinteger = Nil;     //nil -> 0
                                Const filter: pfilenamety = Nil;       //nil -> unused
                                Const colwidth: pinteger = Nil;        //nil -> default
                                Const includeattrib: fileattributesty = [fa_all];
                                Const excludeattrib: fileattributesty = [fa_hidden];
                                Const history: pmsestringarty = Nil;
                                Const historymaxcount: integer = defaulthistorymaxcount;
                                Const imagelist: timagelist = Nil;
                                Const ongetfileicon: getfileiconeventty = Nil;
                                Const oncheckfile: checkfileeventty = Nil
            ): modalresultty;
            overload;
            //threadsafe
            function filedialog(Var afilename: filenamety;
                                Const aoptions: filedialogoptionsty;
                                Const acaption: msestring;
                                Const filterdesc: Array Of msestring;
                                Const filtermask: Array Of msestring;
                                Const adefaultext: filenamety = '';
                                Const filterindex: pinteger = Nil;     //nil -> 0
                                Const filter: pfilenamety = Nil;       //nil -> unused
                                Const colwidth: pinteger = Nil;        //nil -> default
                                Const includeattrib: fileattributesty = [fa_all];
                                Const excludeattrib: fileattributesty = [fa_hidden];
                                Const history: pmsestringarty = Nil;
                                Const historymaxcount: integer = defaulthistorymaxcount;
                                Const imagelist: timagelist = Nil;
                                Const ongetfileicon: getfileiconeventty = Nil;
                                Const oncheckfile: checkfileeventty = Nil
            ): modalresultty;
            overload;
            //threadsafe

            procedure getfileicon(Const info: fileinfoty; Var imagelist: timagelist;
                                  out imagenr: integer);
            procedure updatefileinfo(Const item: tlistitem; Const info: fileinfoty;
                                     Const withicon: boolean);

            var 
              thesender : integer;

            implementation

            uses 
            filelistform, songplayer, recorder, msefiledialog_mfm, msebits, mseactions, 
            msestringenter, msefiledialogres, msekeyboard, 
            msestockobjects, msesysintf, msearrayutils;

            type 
              tdirtreefo1 = class(tdirtreefo);
                tcomponent1 = class(tcomponent);



                  procedure getfileicon(Const info: fileinfoty; Var imagelist: timagelist;
                                        out imagenr: integer);
                  begin
                    with info do
                      begin
                        //  imagelist:= nil;
                        imagenr := -1;
                        if fis_typevalid in state then
                          begin
                            case extinfo1.filetype of 
                              ft_dir:
                                      begin
                                        if fis_diropen in state then
                                          begin
                                            filedialogres.getfileicon(fdi_diropen,imagelist,imagenr)
                                            ;
                                          end
                                        else
                                          begin
                                            if fis_hasentry in state then
                                              begin
                                                filedialogres.getfileicon(fdi_direntry,imagelist,
                                                                          imagenr);
                                              end
                                            else
                                              begin
                                                filedialogres.getfileicon(fdi_dir,imagelist,imagenr)
                                                ;
                                              end;
                                          end;
                                      end;
                              ft_reg, ft_lnk:
                                              begin
                                                filedialogres.getfileicon(fdi_file,imagelist,imagenr
                                                );
                                              end;
                            end;
                          end;
                      end;
                  end;

                  procedure updatefileinfo(Const item: tlistitem; Const info: fileinfoty;
                                           Const withicon: boolean);
                  var 
                    aimagelist: timagelist;
                    aimagenr: integer;
                  begin
                    aimagelist := item.imagelist;
                    item.caption := info.name;
                    if withicon then
                      begin
                        getfileicon(info,aimagelist,aimagenr);
                        item.imagelist := aimagelist;
                        if aimagelist <> nil then
                          begin
                            item.imagenr := aimagenr;
                          end;
                      end;
                  end;

                  function filedialog1(dialog: tfiledialogfo; Var afilenames: filenamearty;
                                       Const filterdesc: Array Of msestring;
                                       Const filtermask: Array Of msestring;
                                       Const filterindex: pinteger;
                                       Const afilter: pfilenamety;      //nil -> unused
                                       Const colwidth: pinteger;        //nil -> default
                                       Const includeattrib: fileattributesty;
                                       Const excludeattrib: fileattributesty;
                                       Const history: pmsestringarty;
                                       Const historymaxcount: integer;
                                       Const acaption: msestring;
                                       Const aoptions: filedialogoptionsty;
                                       Const adefaultext: filenamety;
                                       Const imagelist: timagelist;
                                       Const ongetfileicon: getfileiconeventty;
                                       Const oncheckfile: checkfileeventty
                  ): modalresultty;
                  var 
                    int1: integer;
                  begin
                    with dialog do
                      begin
                        dir.checksubdir := fdo_checksubdir In aoptions;
                        listview.checksubdir := fdo_checksubdir In aoptions;
                        dialogoptions := aoptions;
                        if fdo_filtercasesensitive in aoptions then
                          begin
                            listview.optionsfile := listview.optionsfile + [flvo_maskcasesensitive];
                          end;
                        if fdo_filtercaseinsensitive in aoptions then
                          begin
                            listview.optionsfile := listview.optionsfile + [flvo_maskcaseinsensitive
                                                    ];
                          end;
                        if fdo_single in aoptions then
                          begin
                            listview.options := listview.options - [lvo_multiselect];
                          end;
                        defaultext := adefaultext;
                        // caption:= acaption;
                        // caption := 'Select a audio file (wav, ogg, flac or mp3)';
                        listview.includeattrib := includeattrib;
                        listview.excludeattrib := excludeattrib;
                        listview.itemlist.imagelist := imagelist;
                        if imagelist <> nil then
                          begin
                            listview.itemlist.imagesize := imagelist.size;
                          end;
                        listview.ongetfileicon := ongetfileicon;
                        listview.oncheckfile := oncheckfile;
                        filter.dropdown.cols[0].count := high(filtermask) + 1;
                        for int1:= 0 to high(filtermask) do
                          begin
                            if (int1 <= high(filterdesc)) and (filterdesc[int1] <> '') then
                              begin
                                filter.dropdown.cols[0][int1] := filterdesc[int1] + ' ('+
                                                                 filtermask[int1] + ')';
                              end
                            else
                              begin
                                filter.dropdown.cols[0][int1] := filtermask[int1];
                              end;
                          end;
                        filter.dropdown.cols[1].assignopenarray(filtermask);
                        if filterindex <> nil then
                          begin
                            filter.dropdown.itemindex := filterindex^;
                          end
                        else
                          begin
                            filter.dropdown.itemindex := 0;
                          end;
                        if (afilter = nil) or (afilter^ = '') or
                           (filter.dropdown.itemindex >= 0) and
                           (afilter^ = filter.dropdown.cols[1][filter.dropdown.itemindex]) then
                          begin
                            updatefiltertext;
                          end
                        else
                          begin
                            filter.value := afilter^;
                            listview.mask := afilter^;
                          end;
                        if history <> nil then
                          begin
                            filename.dropdown.valuelist.asarray := history^;
                            filename.dropdown.historymaxcount := historymaxcount;
                          end
                        else
                          begin
                            filename.dropdown.options := [deo_disabled];
                          end;
                        if (high(afilenames) = 0) and (fdo_directory in aoptions) then
                          begin
                            filename.value := filepath(afilenames[0]);
                          end
                        else
                          begin
                            filename.value := quotefilename(afilenames);
                          end;
                        if (colwidth <> nil) and (colwidth^ <> 0) then
                          begin
                            listview.cellwidth := colwidth^;
                          end;
                        finit := true;
                        try
                          filename.checkvalue;
                        finally
                          finit := false;
                      end;
                    showhidden.value := Not (fa_hidden In excludeattrib);
                    show(true);
                    result := window.modalresult;
                    if result <> mr_ok then
                      begin
                        result := mr_cancel;
                      end;
                    if (colwidth <> nil) then
                      begin
                        colwidth^ := listview.cellwidth;
                      end;
                    if result = mr_ok then
                      begin
                        afilenames := filenames;
                        if filterindex <> nil then
                          begin
                            filterindex^ := filter.dropdown.itemindex;
                          end;
                        if afilter <> nil then
                          begin
                            afilter^ := listview.mask;
                          end;
                        if high(afilenames) = 0 then
                          begin
                            filename.dropdown.savehistoryvalue(afilenames[0]);
                          end;
                        if history <> nil then
                          begin
                            history^ := filename.dropdown.valuelist.asarray;
                          end;
                        if fdo_chdir in aoptions then
                          begin
                            setcurrentdirmse(listview.directory);
                          end;
                      end;
                  end;
                end;

                function filedialog(Var afilenames: filenamearty;
                                    Const aoptions: filedialogoptionsty;
                                    Const acaption: msestring;
                                    Const filterdesc: Array Of msestring;
                                    Const filtermask: Array Of msestring;
                                    Const adefaultext: filenamety = '';
                                    Const filterindex: pinteger = Nil;
                                    Const filter: pfilenamety = Nil;       //nil -> unused
                                    Const colwidth: pinteger = Nil;        //nil -> default
                                    Const includeattrib: fileattributesty = [fa_all];
                                    Const excludeattrib: fileattributesty = [fa_hidden];
                                    Const history: pmsestringarty = Nil;
                                    Const historymaxcount: integer = defaulthistorymaxcount;
                                    Const imagelist: timagelist = Nil;
                                    Const ongetfileicon: getfileiconeventty = Nil;
                                    Const oncheckfile: checkfileeventty = Nil
                ): modalresultty;
                var 
                  dialog: tfiledialogfo;
                  str1: msestring;
                begin
                  application.lock;
                  try
                    dialog := tfiledialogfo.create(Nil);
                    if acaption = '' then
                      begin
                        with stockobjects do
                          begin
                            if fdo_save in aoptions then
                              begin
                                str1 := captions[sc_save];
                              end
                            else
                              begin
                                str1 := captions[sc_open];
                              end;
                          end;
                      end
                    else
                      begin
                        str1 := acaption;
                      end;
                    try
                      result := filedialog1(dialog,afilenames,filterdesc,filtermask,
                                filterindex,filter,colwidth,
                                includeattrib,excludeattrib,history,historymaxcount,str1,aoptions,
                                adefaultext,imagelist,ongetfileicon,oncheckfile);

                    finally
                      dialog.Free;
                end;
              finally
                application.unlock;
            end;
        end;

        function filedialog(Var afilename: filenamety;
                            Const aoptions: filedialogoptionsty;
                            Const acaption: msestring;
                            Const filterdesc: Array Of msestring;
                            Const filtermask: Array Of msestring;
                            Const adefaultext: filenamety = '';
                            Const filterindex: pinteger = Nil;
                            Const filter: pfilenamety = Nil;       //nil -> unused
                            Const colwidth: pinteger = Nil;        //nil -> default
                            Const includeattrib: fileattributesty = [fa_all];
                            Const excludeattrib: fileattributesty = [fa_hidden];
                            Const history: pmsestringarty = Nil;
                            Const historymaxcount: integer = defaulthistorymaxcount;
                            Const imagelist: timagelist = Nil;
                            Const ongetfileicon: getfileiconeventty = Nil;
                            Const oncheckfile: checkfileeventty = Nil
        ): modalresultty;
        var 
          ar1: filenamearty;
        begin
          setlength(ar1,1);
          ar1[0] := afilename;
          result := filedialog(ar1,aoptions,acaption,filterdesc,filtermask,adefaultext,
                    filterindex,
                    filter,colwidth,includeattrib,excludeattrib,history,historymaxcount,
                    imagelist,ongetfileicon,oncheckfile);
          if result = mr_ok then
            begin
              if (high(ar1) > 0) or (fdo_quotesingle in aoptions) then
                begin
                  afilename := quotefilename(ar1);
                end
              else
                begin
                  if high(ar1) = 0 then
                    begin
                      afilename := ar1[0];
                    end
                  else
                    begin
                      afilename := '';
                    end;
                end;
            end;
        end;

{ tfilelistview }

        constructor tfilelistview.create(aowner: tcomponent);
        begin
          fcaseinsensitive := filesystemiscaseinsensitive;
          fincludeattrib := [fa_all];
          fexcludeattrib := [fa_hidden];
          fitemlist := tfileitemlist.create(self);
          foptionsfile := defaultfilelistviewoptions;
          ffilelist := tfiledatalist.create;
          
          ffilelist.onchange := {$ifdef FPC}@{$endif}filelistchanged;
          inherited;
          options := defaultlistviewoptionsfile;
          checkcasesensitive;
        end;

        destructor tfilelistview.destroy;
        begin
          inherited;
          ffilelist.Free;
        end;

        procedure tfilelistview.checkcasesensitive;
        begin
          fcaseinsensitive := filesystemiscaseinsensitive;
          if flvo_maskcasesensitive in foptionsfile then
            begin
              fcaseinsensitive := false;
            end;
          if flvo_maskcaseinsensitive in foptionsfile then
            begin
              fcaseinsensitive := true;
            end;
          // options:= options; //set casesensitive
        end;



{
procedure tfilelistview.setoptions(const Value: listviewoptionsty);
begin
 if fcaseinsensitive then begin
  inherited setoptions(value - [lvo_casesensitive]);
 end
 else begin
  inherited setoptions(value + [lvo_casesensitive]);
 end;
end;
}
        procedure tfilelistview.docellevent(Var info: celleventinfoty);
        var 
          index: integer;
        begin
          with info do
            begin
              if iscellclick(info,[ccr_buttonpress]) then
                begin
                  options := options + [lvo_focusselect];
                end;
              case eventkind of 
                cek_enter:
                           begin
                             if ffocusmoved then
                               begin
                                 options := options + [lvo_focusselect];
                               end
                             else
                               begin
                                 ffocusmoved := true;
                               end;
                             inherited;
                           end;
                cek_select:
                            begin
                              index := celltoindex(cell,false);
                              if index >= 0 then
                                begin
                                  if (flvo_nofileselect in foptionsfile) and
                                     (ffilelist[index].extinfo1.filetype <> ft_dir) then
                                    begin
                                      accept := false;
                                    end
                                  else
                                    begin
                                      if (flvo_nodirselect in foptionsfile) and
                                         (ffilelist[index].extinfo1.filetype = ft_dir) then
                                        begin
                                          accept := false;
                                        end;
                                    end;
                                  inherited;
                                end
                              else
                                begin
                                  inherited;
                                end;
                            end;
                else
                  begin
                    inherited;
                  end;
              end;
            end;
        end;

        procedure tfilelistview.filelistchanged(Const sender: tobject);
        var 
          int1: integer;
          po1: pfilelistitem;
          po2: pfileinfoty;
          imlist1: timagelist;
          imnr1: integer;
          bo1: boolean;
        begin
          options := options - [lvo_focusselect];
          ffocusmoved := false;
          with ffilelist do
            begin
              self.beginupdate;
              self.fitemlist.beginupdate;
              try
                self.fitemlist.clear;

                self.fitemlist.count := count;
                po1 := pfilelistitem(self.fitemlist.datapo);
                po2 := pfileinfoty(datapo);
                bo1 := checksubdir;
                for int1:= 0 to count - 1 do
                  begin
                    if bo1 and (po2^.extinfo1.filetype = ft_dir) and
                       dirhasentries(path+'/'+po2^.name,includeattrib,excludeattrib) then
                      begin
                        include(po2^.state,fis_hasentry);
                      end;
                    updatefileinfo(po1^,po2^,true);
                    if assigned(fongetfileicon) then
                      begin
                        imlist1 := po1^.imagelist;
                        imnr1 := po1^.imagenr;
                        fongetfileicon(self,po2^,imlist1,imnr1);
                        po1^.imagelist := imlist1;
                        po1^.imagenr := imnr1;
                      end;
                    inc(po1);
                    inc(po2);
                  end;
              finally
                self.fitemlist.endupdate;
                self.endupdate;
            end;
        end;
      end;

    function tfilelistview.getselectednames: msestringarty;
    var 
      int1, int2: integer;
    begin
      int2 := 0;
      result := Nil;
      for int1:= 0 to ffilelist.count - 1 do
        begin
          if fitemlist[int1].selected then
            begin
              additem(result,ffilelist[int1].name,int2);
            end;
        end;
      setlength(result,int2);
    end;

    procedure tfilelistview.setselectednames(Const avalue: filenamearty);
    var 
      int1: integer;
      item1: tlistitem;
      po1: plistitematy;
      // cell1: gridcoordty;
    begin
      po1 := fitemlist.datapo;
      fitemlist.beginupdate;
      try
        for int1:= 0 to fitemlist.count - 1 do
          begin
            po1^[int1].selected := false;
          end;
        for int1:= 0 to high(avalue) do
          begin
            item1 := finditembycaption(avalue[int1]);
            if item1 <> nil then
              begin
                item1.selected := true;
              end;
          end;
      finally
        fitemlist.endupdate;
    end;



{
 for int1:= 0 to high(avalue) do begin
  if findcellbycaption(avalue[int1],cell1) then begin
   fdatacols.selected[cell1]:= true;
  end;
 end;
 }
    // focuscell(cell1);
  end;

procedure tfilelistview.setfilelist(Const Value: tfiledatalist);
begin
  if ffilelist <> value then
    begin
      ffilelist.Assign(value);
    end;
end;

procedure tfilelistview.readlist;
var 
  int1, x: integer;
  po1: pfileinfoty;
  level1: fileinfolevelty;
begin
  beginupdate;
  try
    defocuscell;
    fdatacols.clearselection;
    ffilelist.clear;
    ffilecount := 0;
    level1 := fil_type;
    if assigned(foncheckfile) then
      begin
        level1 := fil_ext2;
      end;
    if fmaskar = nil then
      begin
        ffilelist.adddirectory(fdirectory,level1,fmaskar,
                               fincludeattrib,fexcludeattrib,foptionsdir,
                               foncheckfile);
        if ffilelist.count > 0 then
          begin
            po1 := ffilelist.itempo(0);
            for int1:= 0 to ffilelist.count - 1 do
              begin
                if not (fa_dir in po1^.extinfo1.attributes) then
                  begin
                    inc(ffilecount);
                  end;
                inc(po1);
              end;
          end;
      end
    else
      begin
        if (fincludeattrib = [fa_all]) or not(fa_dir in fincludeattrib) then
          begin
            ffilelist.adddirectory(fdirectory,level1,Nil,[fa_dir],
                                   fexcludeattrib*[fa_hidden],foptionsdir,foncheckfile);
            int1 := ffilelist.count;
            ffilelist.adddirectory(fdirectory,level1,fmaskar,fincludeattrib,
                                   fexcludeattrib+[fa_dir],foptionsdir,foncheckfile);
            ffilecount := ffilelist.count - int1;
          end
        else
          begin
            ffilelist.adddirectory(fdirectory,level1,fmaskar,
                                   fincludeattrib,fexcludeattrib,foptionsdir,foncheckfile);
            ffilecount := ffilelist.count;
          end;
      end;
  finally
    endupdate;
end;
if assigned(fonlistread) then
  begin
    fonlistread(self);
  end;
end;

procedure tfilelistview.updir;
var 
  str1: msestring;
  int1: integer;
begin
  str1 := removelastdir(fdirectory,fdirectory);
  if str1 <> '' then
    begin
      readlist;
      int1 := ffilelist.indexof(str1);
      if int1 >= 0 then
        begin
          focuscell(indextocell(int1), fca_focusin);
        end;
    end;
end;

procedure tfilelistview.setdirectory(Const Value: msestring);
begin
  fdirectory := filepath(value,fk_dir);
end;

function tfilelistview.getpath: msestring;
begin
  if fmaskar = nil then
    begin
      result := filepath(fdirectory);
    end
  else
    begin
      result := filepath(fdirectory,fmaskar[0]);
    end;
end;

procedure tfilelistview.setpath(Const Value: filenamety);
var 
  str1: msestring;
begin
  splitfilepath(value,fdirectory,str1);
  mask := str1;
  readlist;
end;

procedure tfilelistview.setmask(Const value: filenamety);
begin
  unquotefilename(value,fmaskar);
end;

function tfilelistview.getmask: filenamety;
begin
  result := quotefilename(fmaskar);
end;

function tfilelistview.filecount: integer;
begin
  if ffilelist.count < ffilecount then
    begin
      ffilecount := 0;
    end;
  result := ffilecount;
end;

function tfilelistview.getchecksubdir: boolean;
begin
  result := flvo_checksubdir In foptionsfile;
end;

procedure tfilelistview.setchecksubdir(Const avalue: boolean);
begin
  if avalue then
    begin
      include(foptionsfile,flvo_checksubdir);
    end
  else
    begin
      exclude(foptionsfile,flvo_checksubdir);
    end;
end;

procedure tfilelistview.setoptionsfile(Const avalue: filelistviewoptionsty);
const 
  mask1: filelistviewoptionsty = [flvo_maskcasesensitive, flvo_maskcaseinsensitive];
begin
  if avalue <> foptionsfile then
    begin
      foptionsfile := filelistviewoptionsty(
                      setsinglebit({$ifdef FPC}longword{$else}byte{$endif}(avalue),
                               {$ifdef FPC}longword{$else}byte{$endif}(foptionsfile),
                               {$ifdef FPC}longword{$else}byte{$endif}(mask1)));
      foptionsdir := dirstreamoptionsty(foptionsfile) *
                     [dso_casesensitive,dso_caseinsensitive];
      checkcasesensitive;
    end;
end;

{ tfilelistitem }

constructor tfilelistitem.create(Const aowner: tcustomitemlist);
begin
  inherited;
end;

{ tfileitemlist }

procedure tfileitemlist.createitem(out item: tlistitem);
begin
  item := tfilelistitem.create(self);
end;

 { tfiledialogfo }

procedure Tfiledialogfo.createdironexecute(Const sender: TObject);
var 
  mstr1: msestring;
begin
  mstr1 := '';
  with stockobjects do
    begin
      if stringenter(mstr1,captions[sc_name],
         captions[sc_create_new_directory]) = mr_ok then
        begin
          mstr1 := filepath(listview.directory,mstr1,fk_file);
          msefileutils.createdir(mstr1);
          changedir(mstr1);
          filename.setfocus;
        end;
    end;
end;

procedure tfiledialogfo.listviewselectionchanged(Const sender: tcustomlistview);
var 
  ar1: msestringarty;
begin
  ar1 := Nil;
  //compiler warning
  if not (fdo_directory in dialogoptions) then
    begin
      ar1 := listview.selectednames;
      if length(ar1) > 0 then
        begin
          if length(ar1) > 1 then
            begin
              filename.value := quotefilename(ar1);
            end
          else
            begin
              filename.value := ar1[0];
            end;
        end;
    end;
end;

function tfiledialogfo.changedir(Const adir: filenamety): boolean;
begin
  result := tryreadlist(filepath(adir),true);
  if result then
    begin
      course(adir);
    end;
  with listview do
    begin
      if filelist.count > 0 then
        begin
          focuscell(makegridcoord(0,0));
        end;
    end;
end;

procedure tfiledialogfo.listviewitemevent(Const sender: tcustomlistview;
                                          Const index: Integer; Var info: celleventinfoty);
var 
  str1: filenamety;
begin
  with tfilelistview(sender) do
    begin
      if iscellclick(info) then
        begin
          if filelist.isdir(index) then
            begin
              str1 := filepath(directory+filelist[index].name);
              changedir(str1);
            end
          else
            begin
              if info.eventkind = cek_keydown then
                begin
                  system.exclude(info.keyeventinfopo^.eventstate,es_processed);
                  //do not eat key_return
                end;
              if iscellclick(info,[ccr_dblclick,ccr_nokeyreturn]) and
                 (length(fdatacols.selectedcells) = 1) then
                begin
                  okonexecute(Nil);
                end;
            end;
        end;
    end;
end;

procedure tfiledialogfo.doup();
begin
  listview.updir();
  course(listview.directory);
end;

procedure tfiledialogfo.listviewonkeydown(Const sender: twidget; Var info: keyeventinfoty);
begin
  with info do
    begin
      if (key = key_pageup) and (shiftstate = [ss_ctrl]) then
        begin
          doup();
          include(info.eventstate,es_processed);
        end;
    end;
end;

procedure Tfiledialogfo.upaction(Const sender: TObject);
begin
  doup();
end;



{
function tfiledialogfo.readlist: boolean;
begin
 result:= true;
 try
  with listview do begin
   readlist;
  end;
 except
  on ex: esys do begin
   result:= false;
  // if esys(ex).error = sye_dirstream then begin
    listview.directory:= '';
    with stockobjects do begin
     showerror(captions[sc_can_not_read_directory]+ ' ' + esys(ex).text,
               captions[sc_error]);
//     showerror('Can not read directory '''+ esys(ex).text+'''.','Error');
    end;
    try
     listview.readlist;
    except
     application.handleexception(self);
    end;
//   end
//   else begin
//    application.handleexception(self);
//   end;
  end;
  else begin
   result:= false;
   application.handleexception(self);
  end;
 end;
end;
}
function tfiledialogfo.tryreadlist(Const adir: filenamety;
                                   Const errormessage: boolean): boolean;
//restores old dir on error
var 
  dirbefore: filenamety;
begin
  dirbefore := listview.directory;
  listview.directory := adir;
  result := false;
  try
    listview.readlist;
    result := true;
  except
    on ex: esys do
           begin
             result := false;
             if errormessage then
               begin
                 with stockobjects do
                   begin
                     showerror(captions[sc_can_not_read_directory]+ ' ' +
                               msestring(esys(ex).text), captions[sc_error]);
                   end;
               end;
           end;
    else
      begin
        result := false;
        application.handleexception(self);
      end;
end;
if not result then
  begin
    listview.directory := dirbefore;
    try
      listview.readlist;
    except
      listview.directory := '';
      listview.readlist;
  end;
end;
end;

procedure Tfiledialogfo.filenamesetvalue(Const sender: TObject;
                                         Var avalue: msestring;  Var accept: Boolean);
var 
  str1, str2, str3: filenamety;
  // ar1: msestringarty;
  bo1: boolean;
  newdir: filenamety;
begin
  newdir := '';
  avalue := trim(avalue);
  unquotefilename(avalue,fselectednames);
  if (fdo_single in dialogoptions) and (high(fselectednames) > 0) then
    begin
      with stockobjects do
        begin
          showmessage(captions[sc_single_item_only]+'.',captions[sc_error]);
        end;
      accept := false;
      exit;
    end;
  bo1 := false;
  if high(fselectednames) > 0 then
    begin
      str1 := extractrootpath(fselectednames);
      if str1 <> '' then
        begin
          bo1 := true;
          newdir := str1;
          avalue := quotefilename(fselectednames);
        end;
    end
  else
    begin
      str3 := filepath(listview.directory,avalue);
      splitfilepath(str3,str1,str2);
      newdir := str1;
      if hasmaskchars(str2) then
        begin
          filter.value := str2;
          listview.mask := str2;
          str2 := '';
        end
      else
        begin
          if searchfile(str3,true) <> '' then
            begin
              newdir := str3;
              str2 := '';
            end;
        end;
      avalue := str2;
      if str2 = '' then
        begin
          fselectednames := Nil;
        end
      else
        begin
          setlength(fselectednames,1);
          fselectednames[0] := str2;
        end;
      bo1 := true;
    end;
  if bo1 then
    begin
      if tryreadlist(newdir,not finit) then
        begin
          if  finit then
            begin
              setlength(fcourse,1);
              fcourse[0] := newdir;
              fcourseid := 0;
            end
          else
            begin
              course(newdir);
            end;
        end;
      if fdo_directory in dialogoptions then
        begin
          avalue := listview.directory;
        end;
    end;
  listview.selectednames := fselectednames;
end;

procedure tfiledialogfo.filepathentered(Const sender: tobject);
begin
  tryreadlist(listview.directory,true);
  // readlist;
end;

procedure tfiledialogfo.dironsetvalue(Const sender: TObject;
                                      Var avalue: mseString; Var accept: Boolean);
begin
  //
  accept := tryreadlist(avalue,true);
  if accept then
    begin

      ldir.value := tosysfilepath(avalue);
      ldir.hint := ' Selected: ' + ldir.value + ' ' ;
      course(avalue);
    end;
  // listview.directory:= avalue;
end;

procedure tfiledialogfo.listviewonlistread(Const sender: tobject);
var 
  x, y, z : integer;
  info: fileinfoty;
  thedir, thestrnum, tmp : string;
begin
  with listview do
    begin
      dir.value := directory;
      //  if fa_dir in finclude then begin
      if fdo_directory in self.dialogoptions then
        begin
          filename.value := directory;
        end;
    end;

  list_log.rowcount := listview.rowcount;

  for x := 0 to listview.rowcount - 1 do
    begin
      list_log[0][x] := '';
      list_log[1][x] := '';
      list_log[2][x] := '';
      list_log[3][x] := '';
      list_log[4][x] := '';
    end;

  if  listview.rowcount > 0 then
    begin
      // list_log.visible := true;

      for x := 0 to listview.rowcount - 1 do
        begin
          list_log[4][x] := inttostr(x);
         
         if not listview.filelist.isdir(x) then
            begin
          list_log[0][x] := '     ' + utf8decode(filenamebase(listview.itemlist[x].caption));
          tmp := fileext(listview.itemlist[x].caption);
          if tmp <> '' then tmp := '.' + tmp;
          
          list_log[1][x] := utf8decode(tmp);
          thedir :=  dir.value + trim(list_log[0][x] + tmp) ;
          end else
          begin
          list_log[0][x] := '     ' +utf8decode(listview.itemlist[x].caption);
          list_log[1][x] := '';
          thedir :=  dir.value +  trim(list_log[0][x]);
          end;

          getfileinfo(utf8decode(trim(thedir)) , info);
          
          if not listview.filelist.isdir(x) then
            begin
              if info.extinfo1.size > 0 then
                begin
                  if info.extinfo1.size div 1024 > 0 then y := info.extinfo1.size Div 1024
                  else y := 1;
                end
              else y := 0;
              
              thestrnum := IntToStr(y);
              
               z := Length(thestrnum) ; 
               
               if z < 7 then 
                for y := 0 to 6 - z do
                  thestrnum := ' ' + thestrnum;
                           
              list_log[2][x] := thestrnum + ' Kb';
            end;

          list_log[3][x] := formatdatetime('YY-MM-DD hh:mm:ss',info.extinfo1.modtime);

        end;
    end;
end;

procedure tfiledialogfo.updatefiltertext;
begin
  with filter,dropdown do
    begin
      if itemindex >= 0 then
        begin
          value := cols[0][itemindex];
          listview.mask := cols[1][itemindex];
        end;
    end;
end;

procedure tfiledialogfo.filteronafterclosedropdown(Const sender: tobject);
begin
  updatefiltertext;
  filter.initfocus;
end;

procedure tfiledialogfo.filteronsetvalue(Const sender: tobject;
                                         Var avalue: msestring; Var accept: boolean);
begin
  listview.mask := avalue;
end;

procedure tfiledialogfo.okonexecute(Const sender: tobject);
var 
  bo1: boolean;
  int1: integer;
  str1: filenamety;
begin

  if thesender = 5 then
    begin
      filelistfo.historyfn.dropdown.valuelist.asarray := filename.dropdown.valuelist.asarray;
      filelistfo.historyfn.value := tosysfilepath(dir.value);
      filelistfo.historyfn.hint := ' Selected: ' + filelistfo.historyfn.value + ' ';
      //filelistfo.onfloat(nil) ;
    end;

  if thesender = 0 then
    begin
      songplayerfo.historyfn.dropdown.valuelist.asarray := filename.dropdown.valuelist.asarray;
      songplayerfo.historyfn.value := tosysfilepath(dir.value + filename.value);
      songplayerfo.historyfn.hint := ' Selected: ' + songplayerfo.historyfn.value + ' ';
    end;

  if thesender = 1 then
    begin
      songplayer2fo.historyfn.dropdown.valuelist.asarray := filename.dropdown.valuelist.asarray;
      songplayer2fo.historyfn.value := tosysfilepath(dir.value + filename.value);
      songplayer2fo.historyfn.hint := ' Selected: ' + songplayer2fo.historyfn.value + ' ';
    end;

  if thesender = 2 then
    begin
      recorderfo.historyfn.dropdown.valuelist.asarray := filename.dropdown.valuelist.asarray;
      recorderfo.historyfn.value := tosysfilepath(dir.value + filename.value);
      recorderfo.historyfn.hint :=  ' Selected: ' + recorderfo.historyfn.value + ' ';
    end;

  if (filename.value <> '') or (fdo_acceptempty in dialogoptions) then
    begin
      if fdo_directory in dialogoptions then
        begin
          str1 := quotefilename(listview.directory);
        end
      else
        begin
          str1 := quotefilename(listview.directory,filename.value);
        end;
      unquotefilename(str1,filenames);
      if (defaultext <> '') then
        begin
          for int1:= 0 to high(filenames) do
            begin
              if not hasfileext(filenames[int1]) then
                begin
                  filenames[int1] := filenames[int1] + '.'+defaultext;
                end;
            end;
        end;
      if (fdo_checkexist in dialogoptions) and
         not ((filename.value = '') and (fdo_acceptempty in dialogoptions)) then
        begin
          if fdo_directory in dialogoptions then
            begin
              bo1 := finddir(filenames[0]);
            end
          else
            begin
              bo1 := findfile(filenames[0]);
            end;
          if fdo_save in dialogoptions then
            begin
              if bo1 then
                begin
                  with stockobjects do
                    begin
                      if not askok(captions[sc_file]+' "'+filenames[0]+
                         '" '+ captions[sc_exists_overwrite],
                         captions[sc_warningupper]) then
                        begin
                          //      if not askok('File "'+filenames[0]+
                          //            '" exists, do you want to overwrite?','WARNING') then begin
                          filename.setfocus;
                          exit;
                        end;
                    end;
                end;
            end
          else
            begin
              if not bo1 then
                begin
                  with stockobjects do
                    begin
                      showerror(captions[sc_file]+' "'+filenames[0]+'" '+
                                captions[sc_does_not_exist]+'.',
                                captions[sc_errorupper]);
                    end;
                  //      showerror('File "'+filenames[0]+'" does not exist.');
                  filename.setfocus;
                  exit;
                end;
            end;
        end;
      // visible := false;
      window.modalresult := mr_ok;
      //  application.unlock();
    end
  else
    begin
      filename.setfocus;
    end;
  // end;
end;

procedure tfiledialogfo.layoutev(Const sender: TObject);
begin
  // placeyorder(2,[2],[dir,listview],2);
  // aligny(wam_center,[dir,back,forward,home,up,createdir]);
  // aligny(wam_center,[filename,showhidden]);
  if ok.height <= filter.height then
    begin
      //  aligny(wam_center,[filter,ok,cancel]);
    end
  else
    begin
      //  ok.top:= showhidden.bottom + 4;
      // aligny(wam_center,[ok,cancel]);
    end;
  // syncpaintwidth([filename,filter],namecont.bounds_cx);
  listview.synctofontheight;
  //listview.cellwidth := listview.width - 20;
end;

procedure tfiledialogfo.showhiddenonsetvalue(Const sender: TObject;
                                             Var avalue: Boolean; Var accept: Boolean);
begin
  dir.showhiddenfiles := avalue;
  if avalue then
    begin
      listview.excludeattrib := listview.excludeattrib - [fa_hidden];
    end
  else
    begin
      listview.excludeattrib := listview.excludeattrib + [fa_hidden];
    end;
  listview.readlist;
end;

procedure tfiledialogfo.formoncreate(Const sender: TObject);
begin
  fcourseid := -1;

  font.color := cl_black;

  with stockobjects do
    begin
      // dir.frame.caption:= captions[sc_dirhk];
      home.caption := captions[sc_homehk];
      //  up.caption:= captions[sc_uphk];
      createdir.caption := captions[sc_new_dirhk];
      // filename.frame.caption:= captions[sc_namehk];
      filter.frame.caption := captions[sc_filterhk];
      //  showhidden.frame.caption:= captions[sc_show_hidden_fileshk];
      ok.caption := modalresulttext[mr_ok];
      cancel.caption := modalresulttext[mr_cancel];

      if thesender = 5 then
        begin
          filename.visible := false;
          filter.visible := false;
          showhidden.visible := false;
          ldir.top := 0;
          ldir.visible := true;
          cancel.top := 0 ;
          ok.top := 0 ;
          caption := 'Select a audio directory';
        end
      else

        begin
          ldir.visible := false;
          cancel.top := 19 ;
          ok.top := 19 ;
          showhidden.visible := true;
          filename.visible := true;
          filter.visible := true;
          caption := 'Select a audio file (wav, ogg, flac or mp3)';
        end;

    end;
  back.tag := ord(sc_back);
  forward.tag := ord(sc_forward);
  up.tag := ord(sc_up);

end;

procedure tfiledialogfo.dirshowhint(Const sender: TObject;
                                    Var info: hintinfoty);
begin
  if dir.editor.textclipped then
    begin
      info.caption := dir.value;
    end;
end;

procedure tfiledialogfo.copytoclip(Const sender: TObject; Var avalue: msestring);
begin
  tosysfilepath1(avalue);
end;

procedure tfiledialogfo.pastefromclip(Const sender: TObject;
                                      Var avalue: msestring);
begin
  tomsefilepath1(avalue);
end;

procedure tfiledialogfo.homeaction(Const sender: TObject);
begin
  if tryreadlist(sys_getuserhomedir,true) then
    begin
      dir.value := listview.directory;
      course(listview.directory);
    end;
end;

procedure tfiledialogfo.checkcoursebuttons();
begin
  back.enabled := fcourseid > 0;
  forward.enabled := fcourseid < high(fcourse);
end;

procedure tfiledialogfo.course(Const adir: filenamety);
begin
  if not fcourselock then
    begin
      inc(fcourseid);
      setlength(fcourse,fcourseid+1);
      fcourse[fcourseid] := adir;
      checkcoursebuttons();
    end;
end;

procedure tfiledialogfo.backexe(Const sender: TObject);
begin
  fcourselock := true;
  try
    dec(fcourseid);
    if changedir(fcourse[fcourseid]) then
      begin
        checkcoursebuttons();
      end
    else
      begin
        inc(fcourseid);
      end;
  finally
    fcourselock := false;
end;
end;

procedure tfiledialogfo.forwardexe(Const sender: TObject);
begin
  fcourselock := true;
  try
    inc(fcourseid);
    if changedir(fcourse[fcourseid]) then
      begin
        checkcoursebuttons();
      end
    else
      begin
        dec(fcourseid);
      end;
  finally
    fcourselock := false;
end;
end;

procedure tfiledialogfo.buttonshowhint(Const sender: TObject;
                                       Var ainfo: hintinfoty);
begin
  with tcustombutton(sender) do
    begin
      ainfo.caption := sc(stockcaptionty(tag))+' '+
                       '('+encodeshortcutname(shortcut)+')';
    end;
end;

procedure tfiledialogfo.onchangedir(Const sender: TObject);
begin
  if thesender = 5 then
    begin
      ldir.value := dir.value;
      ldir.hint := ' Selected: ' + dir.value + ' ' ;
    end;
end;

procedure tfiledialogfo.oncellev(Const sender: TObject;
                                 Var info: celleventinfoty);
var 
  cellpos, cellpos2: gridcoordty;
  x,y: integer;
  str1: string;
begin
  cellpos := info.cell;
  
  if (info.eventkind = cek_buttonrelease) then
    begin
    
      if  (cellpos.row > -1) then
        begin
          cellpos.col := 0;
          cellpos2.col := 0;
          
          y := strtoint(list_log[4][cellpos.row]);
          cellpos2.row := y;
          
          if listview.filelist.isdir(y) then
            begin
               listview.defocuscell;
              listview.datacols.clearselection;
              list_log.datacols.clearselection;
              list_log.defocuscell;
           //   str1 := filepath(dir.value+listview.filelist[cellpos.row].name);
              str1 := filepath(dir.value+listview.filelist[y].name);
              changedir(str1);
                                    
            end else
            begin
            
          listview.defocuscell;
          list_log.defocuscell;  
          listview.datacols.clearselection;
          listview.selectcell(cellpos2, csm_select, False);
          list_log.datacols.clearselection;
          list_log.selectcell(cellpos, csm_select, False);
          if (listview.rowcount > 0) and (not listview.filelist.isdir(y)) and (ss_double in info.mouseeventinfopo^.shiftstate) then
          okonexecute(sender);
     
          end;
   
        end;
      
    end;
end;

procedure tfiledialogfo.ondrawcell(Const sender: tcol; Const canvas: tcanvas;
                                   Var cellinfo: cellinfoty);
var 
  aicon: integer;

begin

  if (list_log[1][cellinfo.cell.row] = '') and (list_log[2][cellinfo.cell.row] = '')  then aicon := 
                                                                                                   0
  else
    if (lowercase(list_log[1][cellinfo.cell.row]) = '.txt') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.pdf') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.ini') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.md') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.htlm') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.inc') then aicon := 2
  else
    if (lowercase(list_log[1][cellinfo.cell.row]) = '.pas') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.lpi') or 
       (lowercase(list_log[1][cellinfo.cell.row]) = '.lpr') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.prj') or 
       (lowercase(list_log[1][cellinfo.cell.row]) = '.pp') then aicon := 8
   else 
   if (lowercase(list_log[1][cellinfo.cell.row]) = '.lps') or 
      (lowercase(list_log[1][cellinfo.cell.row]) = '.mfm')  then aicon := 9
    else
    if (lowercase(list_log[1][cellinfo.cell.row]) = '.java') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.js') or 
       (lowercase(list_log[1][cellinfo.cell.row]) = '.class') then aicon := 10
   else   
       if (lowercase(list_log[1][cellinfo.cell.row]) = '.c') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.cc') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.cpp') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.h') then aicon := 11
   else   
       if (lowercase(list_log[1][cellinfo.cell.row]) = '.py') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.pyc') then aicon := 12
   else    
    if (lowercase(list_log[1][cellinfo.cell.row]) = '.wav') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.m4a') or 
       (lowercase(list_log[1][cellinfo.cell.row]) = '.mp3') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.opus') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.flac') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.ogg') then aicon := 3
  else
    if (lowercase(list_log[1][cellinfo.cell.row]) = '.avi') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.mp4') then aicon := 4
  else
    if (lowercase(list_log[1][cellinfo.cell.row]) = '.png') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.jpeg') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.ico') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.webp') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.bmp') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.tiff') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.gif') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.svg') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.jpg') then aicon := 7
  else
    if (lowercase(list_log[1][cellinfo.cell.row]) = '') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.exe') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.com') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.bat') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.bin') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.dll') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.pyc') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.res') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.so') then aicon := 5
  else
    if (lowercase(list_log[1][cellinfo.cell.row]) = '.zip') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.iso') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.cab') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.torrent') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.7z') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.txz') or 
       (lowercase(list_log[1][cellinfo.cell.row]) = '.rpm') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.tar') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.gz') or
       (lowercase(list_log[1][cellinfo.cell.row]) = '.deb') then aicon := 6
  else
    aicon := 1;

  iconslist.paint(canvas, aicon, nullpoint, cl_default,
                  cl_default, cl_default, 0);

end;


{ tfiledialogcontroller }

constructor tfiledialogcontroller.create(Const aowner: tmsecomponent = Nil;
                                         Const onchange: proceventty = Nil);
begin
  foptions := defaultfiledialogoptions;
  fhistorymaxcount := defaulthistorymaxcount;
  fowner := aowner;
  ffilterlist := tdoublemsestringdatalist.create;
  finclude := [fa_all];
  fexclude := [fa_hidden];
  fonchange := onchange;
  inherited create;
end;

destructor tfiledialogcontroller.destroy;
begin
  inherited;
  ffilterlist.Free;
end;

procedure tfiledialogcontroller.readstatvalue(Const reader: tstatreader);
begin
  ffilenames := reader.readarray('filenames',ffilenames);
  if fdo_params in foptions then
    begin
      fparams := reader.readmsestring('params',fparams);
    end;
end;

procedure tfiledialogcontroller.readstatstate(Const reader: tstatreader);
begin
  ffilterindex := reader.readinteger('filefilterindex',ffilterindex);
  ffilter := reader.readmsestring('filefilter',ffilter);
  fwindowrect.x := reader.readinteger('x',fwindowrect.x);
  fwindowrect.y := reader.readinteger('y',fwindowrect.y);
  fwindowrect.cx := reader.readinteger('cx',fwindowrect.cx);
  fwindowrect.cy := reader.readinteger('cy',fwindowrect.cy);
  fcolwidth := reader.readinteger('filecolwidth',fcolwidth);
  if fdo_chdir in foptions then
    begin
      //  try
      trysetcurrentdirmse(flastdir);
      //  except
      //  end;
    end;
end;

procedure tfiledialogcontroller.readstatoptions(Const reader: tstatreader);
begin
  if fdo_savelastdir in foptions then
    begin
      flastdir := reader.readmsestring('lastdir',flastdir);
    end;
  if fhistorymaxcount > 0 then
    begin
      fhistory := reader.readarray('filehistory',fhistory);
    end;
end;

procedure tfiledialogcontroller.writestatvalue(Const writer: tstatwriter);
begin
  writer.writearray('filenames',ffilenames);
  if fdo_params in foptions then
    begin
      writer.writemsestring('params',fparams);
    end;
end;

procedure tfiledialogcontroller.writestatstate(Const writer: tstatwriter);
begin
  writer.writeinteger('filecolwidth',fcolwidth);
  writer.writeinteger('x',fwindowrect.x);
  writer.writeinteger('y',fwindowrect.y);
  writer.writeinteger('cx',fwindowrect.cx);
  writer.writeinteger('cy',fwindowrect.cy);
end;

procedure tfiledialogcontroller.writestatoptions(Const writer: tstatwriter);
begin
  if fdo_savelastdir in foptions then
    begin
      writer.writemsestring('lastdir',flastdir);
    end;
  if fhistorymaxcount > 0 then
    begin
      writer.writearray('filehistory',fhistory);
    end;
  writer.writeinteger('filefilterindex',ffilterindex);
  writer.writemsestring('filefilter',ffilter);
end;

procedure tfiledialogcontroller.componentevent(Const event: tcomponentevent);
begin
  if (fdo_link in foptions) and (event.sender <> self) and
     (event.sender is tfiledialogcontroller) then
    begin
      with tfiledialogcontroller(event.sender) do
        begin
          if fgroup = self.fgroup then
            begin
              self.flastdir := flastdir;
            end;
        end;
    end;
end;

procedure tfiledialogcontroller.checklink;
begin
  if (fdo_link in foptions) and (fowner <> nil) then
    begin
      fowner.sendrootcomponentevent(tcomponentevent.create(self), true);
    end;
end;

function tfiledialogcontroller.execute(dialogkind: filedialogkindty;
                                       Const acaption: msestring;
                                       aoptions: filedialogoptionsty): modalresultty;
var 
  po1: pmsestringarty;
  fo: tfiledialogfo;
  ara, arb: msestringarty;
  rectbefore: rectty;
begin
  ara := Nil;
  //compiler warning
  arb := Nil;
  //compiler warning
  result := mr_ok;
  if assigned(fonbeforeexecute) then
    begin
      fonbeforeexecute(self,dialogkind,result);
      if result <> mr_ok then
        begin
          exit;
        end;
    end;
  if fhistorymaxcount > 0 then
    begin
      po1 := @fhistory;
    end
  else
    begin
      po1 := Nil;
    end;
  fo := tfiledialogfo.create(Nil);
  try
 {$ifdef FPC} {$checkpointer off} {$endif}
    //todo!!!!! bug 3348
    ara := ffilterlist.asarraya;
    arb := ffilterlist.asarrayb;
    if dialogkind <> fdk_none then
      begin
        if dialogkind in [fdk_save,fdk_new] then
          begin
            system.include(aoptions,fdo_save);
          end
        else
          begin
            system.exclude(aoptions,fdo_save);
          end;
      end;
    if fdo_relative in foptions then
      begin
        fo.listview.directory := getcurrentdirmse;
      end
    else
      begin
        fo.listview.directory := flastdir;
      end;
    if (fwindowrect.cx > 0) and (fwindowrect.cy > 0) then
      begin
        fo.widgetrect := clipinrect(fwindowrect,application.screenrect(fo.window));
      end;
    rectbefore := fo.widgetrect;
    result := filedialog1(fo,ffilenames,ara,arb,
              @ffilterindex,@ffilter,@fcolwidth,finclude,
              fexclude,po1,fhistorymaxcount,acaption,aoptions,fdefaultext,
              fimagelist,fongetfileicon,foncheckfile);
    if not rectisequal(fo.widgetrect,rectbefore) then
      begin
        fwindowrect := fo.widgetrect;
      end;
    if assigned(fonafterexecute) then
      begin
        fonafterexecute(self,result);
      end;
 {$ifdef FPC} {$checkpointer default} {$endif}
    if result = mr_ok then
      begin
        if fdo_relative in foptions then
          begin
            flastdir := getcurrentdirmse;
          end
        else
          begin
            flastdir := fo.dir.value;
          end;
      end;
  finally
    fo.Free;
end;
end;

function tfiledialogcontroller.execute(Const dialogkind: filedialogkindty;
                                       Const acaption: msestring): modalresultty;
begin
  result := execute(dialogkind,acaption,foptions);
end;

function tfiledialogcontroller.actcaption(
                                          Const dialogkind: filedialogkindty): msestring;
begin
  case dialogkind of 
    fdk_save:
              begin
                result := fcaptionsave;
              end;
    fdk_new:
             begin
               result := fcaptionnew;
             end;
    else
      begin
        result := fcaptionopen;
      end;
  end;
end;

function tfiledialogcontroller.execute(Const dialogkind: filedialogkindty;
                                       Const aoptions: filedialogoptionsty): modalresultty;
begin
  result := execute(dialogkind,actcaption(dialogkind),aoptions);
end;

function tfiledialogcontroller.execute(
                                       dialogkind: filedialogkindty = fdk_none): modalresultty;
begin
  if dialogkind = fdk_none then
    begin
      if fdo_save in foptions then
        begin
          dialogkind := fdk_save;
        end
      else
        begin
          dialogkind := fdk_open;
        end;
    end;
  result := execute(dialogkind,actcaption(dialogkind));
end;

function tfiledialogcontroller.execute(Var avalue: filenamety;
                                       dialogkind: filedialogkindty = fdk_none): boolean;
begin
  if dialogkind = fdk_none then
    begin
      if fdo_save in foptions then
        begin
          dialogkind := fdk_save;
        end
      else
        begin
          dialogkind := fdk_open;
        end;
    end;
  result := execute(avalue,dialogkind,actcaption(dialogkind));
end;

function tfiledialogcontroller.execute(Var avalue: filenamety;
                                       Const  dialogkind: filedialogkindty; Const acaption:
                                       msestring;
                                       aoptions: filedialogoptionsty): boolean;
var 
  wstr1: filenamety;
begin
  wstr1 := filename;
  if assigned(fongetfilename) then
    begin
      result := true;
      fongetfilename(self,avalue,result);
      if not result then
        begin
          exit;
        end;
    end;
  filename := avalue;
  result := execute(dialogkind,acaption,aoptions) = mr_ok;
  if result then
    begin
      avalue := filename;
      checklink;
    end
  else
    begin
      filename := wstr1;
    end;
end;

function tfiledialogcontroller.canoverwrite(): boolean;
begin
  with stockobjects do
    begin
      result := Not findfile(filename) Or
                askok(captions[sc_file]+' "'+filename+
                '" '+ captions[sc_exists_overwrite],
                captions[sc_warningupper]);
    end;
end;

function tfiledialogcontroller.execute(Var avalue: filenamety;
                                       Const dialogkind: filedialogkindty;
                                       Const acaption: msestring): boolean;
begin
  result := execute(avalue,dialogkind,acaption,foptions);
end;

function tfiledialogcontroller.getfilename: filenamety;
begin
  if (high(ffilenames) > 0) or (fdo_quotesingle in foptions) or
     (fdo_params in foptions) and (high(ffilenames) = 0) and
     (findchar(pmsechar(ffilenames[0]),' ') > 0) then
    begin
      result := quotefilename(ffilenames);
    end
  else
    begin
      if high(ffilenames) = 0 then
        begin
          result := ffilenames[0];
        end
      else
        begin
          result := '';
        end;
    end;
  if (fdo_params in foptions) and (fparams <> '') then
    begin
      if fdo_sysfilename in foptions then
        begin
          tosysfilepath1(result);
        end;
      result := result + ' '+fparams;
    end
  else
    begin
      if fdo_sysfilename in foptions then
        begin
          tosysfilepath1(result);
        end;
    end;
end;

const 
  quotechar = msechar('"');

procedure tfiledialogcontroller.setfilename(Const avalue: filenamety);
var 
  int1: integer;
  akind: filekindty;
begin
  unquotefilename(avalue,ffilenames);
  if fdo_params in foptions then
    begin
      fparams := '';
      if high(ffilenames) >= 0 then
        begin
          if avalue[1] = quotechar then
            begin
              fparams := copy(avalue,length(ffilenames[0])+3,bigint);
              if (fparams <> '') and (fparams[1] = ' ') then
                begin
                  delete(fparams,1,1);
                end;
              setlength(ffilenames,1);
            end
          else
            begin
              int1 := findchar(ffilenames[0],' ');
              if int1 > 0 then
                begin
                  fparams := copy(ffilenames[0],int1+1,bigint);
                  setlength(ffilenames[0],int1-1);
                end;
            end;
        end;
    end;
  akind := fk_default;
  if fdo_directory in foptions then
    begin
      akind := fk_dir;
      if fdo_file in foptions then
        begin
          akind := fk_file;
        end;
    end
  else
    begin
      if fdo_file in foptions then
        begin
          akind := fk_file;
        end;
    end;
  if [fdo_relative,fdo_lastdirrelative,fdo_basedirrelative] *
     foptions <> [] then
    begin
      if fdo_relative in foptions then
        begin
          flastdir := getcurrentdirmse;
        end
      else
        begin
          if fdo_basedirrelative in foptions then
            begin
              flastdir := fbasedir;
            end;
        end;
      for int1:= 0 to high(ffilenames) do
        begin
          if isrootpath(filenames[int1]) then
            begin
              ffilenames[int1] := relativepath(filenames[int1],flastdir,akind);
            end;
        end;
    end
  else
    begin
      if high(ffilenames) = 0 then
        begin
          if fdo_directory in foptions{akind = fk_dir} then
            begin
              flastdir := filepath(avalue,fk_dir);
            end
          else
            begin
              flastdir := filedir(avalue);
            end;
        end;
      for int1:= 0 to high(ffilenames) do
        begin
          ffilenames[int1] := filepath(filenames[int1],akind,
                              Not (fdo_absolute In foptions));
        end;
    end;
end;

procedure tfiledialogcontroller.setfilterlist(
                                              Const Value: tdoublemsestringdatalist);
begin
  ffilterlist.assign(Value);
end;

procedure tfiledialogcontroller.sethistorymaxcount(Const Value: integer);
begin
  fhistorymaxcount := Value;
  if length(fhistory) > fhistorymaxcount then
    begin
      setlength(fhistory,fhistorymaxcount);
    end;
end;

procedure tfiledialogcontroller.dochange;
begin
  if assigned(fonchange) then
    begin
      fonchange;
    end;
end;

procedure tfiledialogcontroller.setdefaultext(Const avalue: filenamety);
begin
  if fdefaultext <> avalue then
    begin
      fdefaultext := avalue;
      dochange;
    end;
end;

procedure tfiledialogcontroller.setoptions(Value: filedialogoptionsty);



(*
const
 mask1: filedialogoptionsty = [fdo_absolute,fdo_relative];
// mask2: filedialogoptionsty = [fdo_directory,fdo_file];
 mask3: filedialogoptionsty = [fdo_filtercasesensitive,fdo_filtercaseinsensitive];
*)
begin
  value := filedialogoptionsty(setsinglebit(card32(value),card32(foptions),
           [card32([fdo_absolute,fdo_relative,fdo_lastdirrelative,
           fdo_basedirrelative]),
           card32([fdo_filtercasesensitive,fdo_filtercaseinsensitive])]));



(*
 {$ifdef FPC}longword{$else}longword{$endif}(value):=
      setsinglebit({$ifdef FPC}longword{$else}longword{$endif}(value),
      {$ifdef FPC}longword{$else}longword{$endif}(foptions),
      {$ifdef FPC}longword{$else}longword{$endif}(mask1));
// {$ifdef FPC}longword{$else}longword{$endif}(value):=
//      setsinglebit({$ifdef FPC}longword{$else}longword{$endif}(value),
//      {$ifdef FPC}longword{$else}longword{$endif}(foptions),
//      {$ifdef FPC}longword{$else}longword{$endif}(mask2));
 {$ifdef FPC}longword{$else}longword{$endif}(value):=
      setsinglebit({$ifdef FPC}longword{$else}longword{$endif}(value),
      {$ifdef FPC}longword{$else}longword{$endif}(foptions),
      {$ifdef FPC}longword{$else}longword{$endif}(mask3));
 *)
  if foptions <> value then
    begin
      foptions := Value;
      if not (fdo_params in foptions) then
        begin
          fparams := '';
        end;
      dochange;
    end;
end;

procedure tfiledialogcontroller.clear;
begin
  ffilenames := Nil;
  flastdir := '';
  fhistory := Nil;
end;

procedure tfiledialogcontroller.setlastdir(Const avalue: filenamety);
begin
  flastdir := avalue;
  checklink;
end;

procedure tfiledialogcontroller.setimagelist(Const avalue: timagelist);
begin
  setlinkedvar(avalue,tmsecomponent(fimagelist));
end;

function tfiledialogcontroller.getsysfilename: filenamety;
var 
  bo1: boolean;
begin
  bo1 := fdo_sysfilename In foptions;
  system.include(foptions,fdo_sysfilename);
  result := getfilename;
  if not bo1 then
    begin
      system.exclude(foptions,fdo_sysfilename);
    end;
end;

{ tfiledialog }

constructor tfiledialog.create(aowner: tcomponent);
begin
  // foptionsedit:= defaultfiledialogoptionsedit;
  foptionsedit1 := defaultfiledialogoptionsedit1;
  fcontroller := tfiledialogcontroller.create(Nil);

  inherited;
end;

destructor tfiledialog.destroy;
begin
  inherited;
  fcontroller.free;
end;

function tfiledialog.execute: modalresultty;
begin
  result := fcontroller.execute(fdialogkind);
end;

function tfiledialog.execute(Const akind: filedialogkindty): modalresultty;
begin
  result := fcontroller.execute(akind);
end;

function tfiledialog.execute(Const akind: filedialogkindty;
                             Const aoptions: filedialogoptionsty): modalresultty;
begin
  result := fcontroller.execute(akind,aoptions);
end;

procedure tfiledialog.setcontroller(Const value: tfiledialogcontroller);
begin
  fcontroller.assign(value);
end;

procedure tfiledialog.dostatread(Const reader: tstatreader);
begin
  if canstatvalue(foptionsedit1,reader) then
    begin
      fcontroller.readstatvalue(reader);
    end;
  if canstatstate(foptionsedit1,reader) then
    begin
      fcontroller.readstatstate(reader);
    end;
  if canstatoptions(foptionsedit1,reader) then
    begin
      fcontroller.readstatoptions(reader);
    end;
end;

procedure tfiledialog.dostatwrite(Const writer: tstatwriter);
begin
  if canstatvalue(foptionsedit1,writer) then
    begin
      fcontroller.writestatvalue(writer);
    end;
  if canstatstate(foptionsedit1,writer) then
    begin
      fcontroller.writestatstate(writer);
    end;
  if canstatoptions(foptionsedit1,writer) then
    begin
      fcontroller.writestatoptions(writer);
    end;
end;

function tfiledialog.getstatvarname: msestring;
begin
  result := fstatvarname;
end;

procedure tfiledialog.setstatfile(Const Value: tstatfile);
begin
  setstatfilevar(istatfile(self), value, fstatfile);
end;

procedure tfiledialog.statreading;
begin
  //dummy
end;

procedure tfiledialog.statread;
begin
  //dummy
end;

procedure tfiledialog.componentevent(Const event: tcomponentevent);
begin
  fcontroller.componentevent(event);
  inherited;
end;

function tfiledialog.getstatpriority: integer;
begin
  result := fstatpriority;
end;

procedure tfiledialog.readoptionsedit(reader: treader);
var 
  opt1: optionseditty;
begin
  opt1 := optionseditty(reader.readset(typeinfo(optionseditty)));
  updatebit(longword(foptionsedit1), ord(oe1_savevalue), oe_savevalue in opt1);
  updatebit(longword(foptionsedit1), ord(oe1_savestate), oe_savestate in opt1);
  updatebit(longword(foptionsedit1), ord(oe1_saveoptions), oe_saveoptions in opt1);
  updatebit(longword(foptionsedit1), ord(oe1_checkvalueafterstatread), 
  oe_checkvaluepaststatread in opt1);
end;

procedure tfiledialog.defineproperties(filer: tfiler);
begin
  inherited;
  filer.defineproperty('optionsedit',@readoptionsedit,Nil,false);
end;

{ tfilenameeditcontroller }

constructor tfilenameeditcontroller.create(Const aowner: tcustomfilenameedit1);
begin
  inherited create(aowner);
end;

function tfilenameeditcontroller.execute(Var avalue: msestring): boolean;
begin
  with tcustomfilenameedit1(fowner) do
    begin
      if fcontroller <> nil then
        begin
          result := fcontroller.execute(avalue);
        end
      else
        begin
          result := false;
        end;
    end;
end;

{ tcustomfilenameedit1 }

constructor tcustomfilenameedit1.create(aowner: tcomponent);
begin
  // fcontroller:= tfiledialogcontroller.create(self,{$ifdef FPC}@{$endif}formatchanged);
  inherited;
  optionsedit1 := defaultfiledialogoptionsedit1;
end;

destructor tcustomfilenameedit1.destroy;
begin
  inherited;
  // fcontroller.Free;
end;



{
function tcustomfilenameedit.execute(var avalue: msestring): boolean;
begin
 result:= fcontroller.execute(avalue);
end;
}
procedure tcustomfilenameedit1.setcontroller(Const avalue: tfiledialogcontroller);
begin
  if fcontroller <> nil then
    begin
      fcontroller.assign(avalue);
    end;
end;

procedure tcustomfilenameedit1.readstatvalue(Const reader: tstatreader);
begin
  if fgridintf <> nil then
    begin
      inherited;
    end
  else
    begin
      if fcontroller <> nil then
        begin
          fcontroller.readstatvalue(reader);
          value := fcontroller.filename;
        end;
    end;
end;

procedure tcustomfilenameedit1.readstatstate(Const reader: tstatreader);
begin
  if fcontroller <> nil then
    begin
      fcontroller.readstatstate(reader);
    end;
end;

procedure tcustomfilenameedit1.readstatoptions(Const reader: tstatreader);
begin
  if fcontroller <> nil then
    begin
      fcontroller.readstatoptions(reader);
    end;
end;

procedure tcustomfilenameedit1.writestatvalue(Const writer: tstatwriter);
begin
  if fgridintf <> nil then
    begin
      inherited;
    end
  else
    begin
      if fcontroller <> nil then
        begin
          fcontroller.writestatvalue(writer);
        end;
    end;
end;

procedure tcustomfilenameedit1.writestatstate(Const writer: tstatwriter);
begin
  if fcontroller <> nil then
    begin
      fcontroller.writestatstate(writer);
    end;
end;

procedure tcustomfilenameedit1.writestatoptions(Const writer: tstatwriter);
begin
  if fcontroller <> nil then
    begin
      fcontroller.writestatoptions(writer);
    end;
end;

function tcustomfilenameedit1.getvaluetext: msestring;
begin
  // result:= filepath(fcontroller.filename);
  if fcontroller <> nil then
    begin
      result := fcontroller.filename;
    end
  else
    begin
      result := '';
    end;
end;

procedure tcustomfilenameedit1.texttovalue(Var accept: boolean;
                                           Const quiet: boolean);
var 
  ar1: filenamearty;
  mstr1: filenamety;
  int1: integer;
begin
  if fcontroller <> nil then
    begin
      if (fcontroller.defaultext <> '') then
        begin
          unquotefilename(text,ar1);
          for int1:= 0 to high(ar1) do
            begin
              if not hasfileext(ar1[int1]) then
                begin
                  ar1[int1] := ar1[int1] + '.'+controller.defaultext;
                end;
            end;
          mstr1 := quotefilename(ar1);
        end
      else
        begin
          mstr1 := text;
        end;
      fcontroller.filename := mstr1;
    end;
  inherited;
end;

procedure tcustomfilenameedit1.updatedisptext(Var avalue: msestring);
begin
  if fcontroller <> nil then
    begin
      with fcontroller do
        begin
          if fdo_dispname in foptions then
            begin
              avalue := msefileutils.filename(avalue);
            end;
          if fdo_dispnoext in foptions then
            begin
              avalue := removefileext(avalue);
            end;
        end;
    end;
end;

procedure tcustomfilenameedit1.valuechanged;
begin
  if fcontroller <> nil then
    begin
      fcontroller.filename := value;
    end;
  inherited;
end;

procedure tcustomfilenameedit1.componentevent(Const event: tcomponentevent);
begin
  if fcontroller <> nil then
    begin
      fcontroller.componentevent(event);
    end;
  inherited;
end;

procedure tcustomfilenameedit1.updatecopytoclipboard(Var atext: msestring);
begin
  tosysfilepath1(atext);
  inherited;
end;

procedure tcustomfilenameedit1.updatepastefromclipboard(Var atext: msestring);
begin
  tomsefilepath1(atext);
  inherited;
end;

function tcustomfilenameedit1.createdialogcontroller: tstringdialogcontroller;
begin
  result := tfilenameeditcontroller.create(self);
end;

function tcustomfilenameedit1.getsysvalue: filenamety;
begin
  result := tosysfilepath(value);
end;

procedure tcustomfilenameedit1.setsysvalue(Const avalue: filenamety);
begin
  value := tomsefilepath(avalue);
end;

function tcustomfilenameedit1.getsysvaluequoted: filenamety;
begin
  result := tosysfilepath(value,true);
end;

{ tcustomfilenameedit }

constructor tcustomfilenameedit.create(aowner: tcomponent);
begin
  fcontroller := tfiledialogcontroller.create(self,
                                {$ifdef FPC}@{$endif}formatchanged);
  inherited;
end;

destructor tcustomfilenameedit.destroy;
begin
  inherited;
  fcontroller.Free;
end;

{ tdirdropdownedit }

procedure tdirdropdownedit.createdropdownwidget(Const atext: msestring;
                                                out awidget: twidget);
begin
  awidget := tdirtreefo.create(Nil);
  with tdirtreefo(awidget) do
    begin
      showhiddenfiles := ddeo_showhiddenfiles In foptions;
      checksubdir := ddeo_checksubdir In foptions;
      path := atext;
      onpathchanged := {$ifdef FPC}@{$endif}pathchanged;
      text := path;
      if deo_colsizing in fdropdown.options then
        begin
          optionssizing := [osi_right];
        end;
    end;
  feditor.sellength := 0;
end;

procedure tdirdropdownedit.doafterclosedropdown;
begin
  text := value;
  feditor.selectall;
  inherited;
end;

function tdirdropdownedit.getdropdowntext(Const awidget: twidget): msestring;
begin
  result := tdirtreefo(awidget).path;
end;

procedure tdirdropdownedit.pathchanged(Const sender: tobject);
begin
  text := tdirtreefo(sender).path;
end;

function tdirdropdownedit.getshowhiddenfiles: boolean;
begin
  result := ddeo_showhiddenfiles In foptions;
end;

procedure tdirdropdownedit.setshowhiddenfiles(Const avalue: boolean);
begin
  if avalue then
    begin
      include(foptions,ddeo_showhiddenfiles)
    end
  else
    begin
      exclude(foptions,ddeo_showhiddenfiles)
    end;
end;

function tdirdropdownedit.getchecksubdir: boolean;
begin
  result := ddeo_checksubdir In foptions;
end;

procedure tdirdropdownedit.setchecksubdir(Const avalue: boolean);
begin
  if avalue then
    begin
      include(foptions,ddeo_checksubdir)
    end
  else
    begin
      exclude(foptions,ddeo_checksubdir)
    end;
end;

procedure tdirdropdownedit.updatecopytoclipboard(Var atext: msestring);
begin
  tosysfilepath1(atext);
  inherited;
end;

procedure tdirdropdownedit.updatepastefromclipboard(Var atext: msestring);
begin
  tomsefilepath1(atext);
  inherited;
end;

{ tcustomremotefilenameedit }

procedure tcustomremotefilenameedit.setfiledialog(Const avalue: tfiledialog);
begin
  setlinkedvar(avalue,tmsecomponent(fdialog));
  if avalue = nil then
    begin
      fcontroller := Nil;
    end
  else
    begin
      fcontroller := avalue.fcontroller;
    end;
end;

procedure tcustomremotefilenameedit.objectevent(Const sender: tobject;
                                                Const event: objecteventty);
begin
  if (event = oe_destroyed) and (sender = fdialog) then
    begin
      fcontroller := Nil;
    end;
  inherited;
end;

{ tdirtreeview }

constructor tdirtreeview.create(aowner: tcomponent);
begin
  inherited;
  createframe();
  foptionswidget := defaultoptionswidgetsubfocus;
  fdirview := tdirtreefo.create(Nil,self,false);
  //owner must be nil because of streaming
  fdirview.onpathchanged := @dopathchanged;
  fdirview.onselectionchanged := @doselectionchanged;
  fdirview.treeitem.ondataentered := @dopathselected;
  fdirview.grid.frame.framewidth := 0;
  fdirview.bounds_cxmin := 0;
  fdirview.anchors := [];
  fdirview.visible := true;
end;

destructor tdirtreeview.destroy();
begin
  fdirview.free();
  inherited;
  //fdirview destroyed by destroy children
end;

procedure tdirtreeview.refresh();
begin
  tdirtreefo1(fdirview).updatepath();
end;

function tdirtreeview.getoptions: dirtreeoptionsty;
begin
  result := fdirview.optionsdir;
end;

procedure tdirtreeview.setoptions(Const avalue: dirtreeoptionsty);
begin
  fdirview.optionsdir := avalue;
end;

function tdirtreeview.getpath: filenamety;
begin
  if csdesigning in componentstate then
    begin
      result := fpath;
    end
  else
    begin
      result := fdirview.path;
    end;
end;

procedure tdirtreeview.setpath(Const avalue: filenamety);
begin
  fpath := avalue;
  if componentstate * [csdesigning,csloading] = [] then
    begin
      fdirview.path := avalue;
    end;
end;

procedure tdirtreeview.setroot(Const avalue: filenamety);
begin
  froot := avalue;
  if componentstate * [csdesigning,csloading] = [] then
    begin
      fdirview.root := avalue;
    end;
end;

function tdirtreeview.getgrid: twidgetgrid;
begin
  result := fdirview.grid;
end;

procedure tdirtreeview.setgrid(Const avalue: twidgetgrid);
begin
  //dummy
end;

function tdirtreeview.getoptionstree: treeitemeditoptionsty;
begin
  result := fdirview.treeitem.options;
end;

procedure tdirtreeview.setoptionstree(Const avalue: treeitemeditoptionsty);
begin
  fdirview.treeitem.options := avalue;
end;

function tdirtreeview.getoptionsedit: optionseditty;
begin
  result := fdirview.treeitem.optionsedit;
end;

procedure tdirtreeview.setoptionsedit(Const avalue: optionseditty);
begin
  fdirview.treeitem.optionsedit := avalue;
end;

function tdirtreeview.getcol_color: colorty;
begin
  result := fdirview.grid.datacols[0].color;
end;

procedure tdirtreeview.setcol_color(Const avalue: colorty);
begin
  fdirview.grid.datacols[0].color := avalue;
end;

function tdirtreeview.getcol_coloractive: colorty;
begin
  result := fdirview.grid.datacols[0].coloractive;
end;

procedure tdirtreeview.setcol_coloractive(Const avalue: colorty);
begin
  fdirview.grid.datacols[0].coloractive := avalue;
end;

function tdirtreeview.getcol_colorfocused: colorty;
begin
  result := fdirview.grid.datacols[0].colorfocused;
end;

procedure tdirtreeview.setcol_colorfocused(Const avalue: colorty);
begin
  fdirview.grid.datacols[0].colorfocused := avalue;
end;

function tdirtreeview.getcell_options: coloptionsty;
begin
  result := fdirview.grid.datacols[0].options;
end;

procedure tdirtreeview.setcell_options(Const avalue: coloptionsty);
begin
  fdirview.grid.datacols[0].options := avalue;
end;



{
function tdirtreeview.getcell_frame: tcellframe;
begin
 if csreading in componentstate then begin
  fdirview.grid.datacols[0].createframe();
 end;
 result:= fdirview.grid.datacols[0].frame;
end;

procedure tdirtreeview.setcell_frame(const avalue: tcellframe);
begin
 fdirview.grid.datacols[0].frame:= avalue;
end;

function tdirtreeview.getcell_face: tcellface;
begin
 if csreading in componentstate then begin
  fdirview.grid.datacols[0].createface();
 end;
 result:= fdirview.grid.datacols[0].face;
end;

procedure tdirtreeview.setcell_face(const avalue: tcellface);
begin
 if avalue <> nil then begin
  fdirview.grid.datacols[0].createface();
 end;
 fdirview.grid.datacols[0].face:= avalue;
end;

function tdirtreeview.getcell_datalist: ttreeitemeditlist;
begin
 result:= ttreeitemeditlist(fdirview.grid.datacols[0].datalist);
end;

procedure tdirtreeview.setcell_datalist(const avalue: ttreeitemeditlist);
begin
 fdirview.grid.datacols[0].datalist:= avalue;
end;
}
procedure tdirtreeview.dopathchanged(Const sender: tobject);
begin
  if canevent(tmethod(fonpathchanged)) then
    begin
      fonpathchanged(self,fdirview.path);
    end;
end;

procedure tdirtreeview.dopathselected(Const sender: tobject);
begin
  if canevent(tmethod(fonpathselected)) then
    begin
      fonpathselected(self,fdirview.path);
    end;
end;

procedure tdirtreeview.doselectionchanged(Const sender: tobject;
                                          Const aitem: tlistitem);
begin
  if canevent(tmethod(fonselectionchanged)) then
    begin
      fonselectionchanged(self,aitem);
    end;
end;

procedure tdirtreeview.internalcreateframe;
begin
  timpressedcaptionframe.create(icaptionframe(self));
end;

procedure tdirtreeview.loaded();
begin
  inherited;
  if not (csdesigning in componentstate) then
    begin
      with tdirtreefo1(fdirview) do
        begin
          froot := self.froot;
          path := self.fpath;
        end;
    end;
end;

class function tdirtreeview.classskininfo: skininfoty;
  begin
    result := Inherited classskininfo;
    result.objectkind := sok_dataedit;
  end;

end.
