program strumpract;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$ifdef FPC}
 {$ifdef mswindows}{$apptype gui}{$endif}
{$endif}
{$ifdef mswindows}
 {$R dp.res}
{$endif}
uses
 {$ifdef FPC}{$ifdef unix}cthreads,{$endif}{$endif} 
 msegui, main, aboutform, infos;
begin
  application.createform(tmainfo,mainfo);
  application.createform(taboutfo,aboutfo);
  application.createform(tinfosfo,infosfo);
 application.run;
end.
