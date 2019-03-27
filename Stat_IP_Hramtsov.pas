library Stat_IP_Hramtsov;
Uses graphABC;
type strarray = array of string;

function csvtoarray(s:string):array of strarray;
var
f:text;
i,j,k,l:integer;
str,s2:string;
a:array of strarray;
begin
   assign(f,s);
   reset(f);
   i:=0;
   while not eof(f) do
   begin
      readln(f,str);
      i+=1;
   end;
   a:= new strarray[i];
   close(f);
   assign(f,s);
   reset(f);
   readln(f,str);
   for j:=0 to i-2 do
   a[j]:=new string[7];
   i:=0;
   while not eof(f) do
   begin
      readln(f,str);
      k:=0;
      l:=0;
      s2:='';
      j:=1;
      while j<=str.Length do
      begin
      if str[j]='"' then
         k+=1
      else
         s2+=str[j];
      j+=1;
      if k=2 then
      begin   
         a[i,l]:=s2;
         l+=1;
         k:=0;
         s2:='';
         j+=1;
      end;
      end;
   i+=1;
   end;
   close(f);
   result:=a;
end;

function reverseip(a:string):string;
var
i,j:integer;
s,s1,s2:string;
begin
   for i:=1 to a.Length do
   if a[i]<>'-' then
   if j=0 then
   s1+=a[i]
   else
   s2+=a[i]
   else
   j+=1;
   s:=s2+'-'+s1;
   result:=s;
end;

function uniq(a:array of strarray;q:integer):array of string;
var
i,j:integer;
b,c:array of string;
begin
   b:=new string[a.Length-1];
   for i:=0 to a.Length-2 do
   b[i]:=a[i,q];
   for i:=0 to b.Length-2 do
   for j:=i+1 to b.Length-1 do
   if b[i]=b[j] then
      b[j]:='';
   j:=0;
   for i:=0 to b.Length-1 do
   if b[i]<>'' then
      j+=1;
   c:=new string[j];
   j:=0;
   for i:=0 to b.Length-1 do
   if b[i]<>'' then
   begin
      c[j]:=b[i];
      j+=1;
   end;
   result:=c;   
end;

function uniqip(a:array of strarray):array of string;
var
s2:string;
i,j,e:integer;
b,c:array of string;
w:array of integer;
begin
   b:=new string[a.Length-1];
   for i:=0 to a.Length-2 do
   b[i]:=a[i,2]+'-'+a[i,3];
   for i:=0 to b.Length-2 do
   for j:=i+1 to b.Length-1 do
   if b[i]=b[j] then
      b[j]:='';
   j:=0;
   for i:=0 to b.Length-1 do
   if b[i]<>'' then
      j+=1;
   c:=new string[j];
   w:=new integer[j];
   j:=0;
   for i:=0 to b.Length-1 do
   if b[i]<>'' then
   begin
      c[j]:=b[i];
      j+=1;
   end;
   for i:=0 to a.Length-2 do
   for j:=0 to c.Length-1 do
   if a[i,2]+'-'+a[i,3]=c[j] then
   w[j]+=1;
   for i:=0 to c.Length-2 do
   for j:=i+1 to c.Length-1 do
   if w[i]<w[j] then
   begin
      e:=w[i];
      w[i]:=w[j];
      w[j]:=e;
      s2:=c[i];
      c[i]:=c[j];
      c[j]:=s2;
   end;
   //for i:=0 to c.Length-1 do
   //writeln(c[i],' - ',w[i]);
   result:=c;   
end;

function md(a:real):integer;
var
i:integer;
begin
   while a>=1 do
   begin
      i+=1;
      a-=1;
   end;
   result:=i;
end;

procedure statip(a:array of strarray;s:string);
var
s2:string;
i,j,e,global_score:integer;
b,c:array of string;
w:array of integer;
begin
   b:=new string[a.Length-1];
   for i:=0 to a.Length-2 do
   b[i]:=a[i,2]+'-'+a[i,3];
   for i:=0 to b.Length-2 do
   for j:=i+1 to b.Length-1 do
   if b[i]=b[j] then
      b[j]:='';
   j:=0;
   for i:=0 to b.Length-1 do
   if b[i]<>'' then
      j+=1;
   c:=new string[j];
   w:=new integer[j];
   j:=0;
   for i:=0 to b.Length-1 do
   if b[i]<>'' then
   begin
      c[j]:=b[i];
      j+=1;
   end;
   for i:=0 to a.Length-2 do
   for j:=0 to c.Length-1 do
   if a[i,2]+'-'+a[i,3]=c[j] then
   w[j]+=1;
   for i:=0 to c.Length-2 do
   for j:=i+1 to c.Length-1 do
   if w[i]<w[j] then
   begin
      e:=w[i];
      w[i]:=w[j];
      w[j]:=e;
      s2:=c[i];
      c[i]:=c[j];
      c[j]:=s2;
   end;
   for i:=0 to c.Length-2 do
   for j:=i+1 to c.Length-1 do
   if c[i]=reverseip(c[j]) then
   begin
      c[j]:='';
      w[i]+=w[j];
      w[j]:=0;
   end;
   for i:=0 to c.Length-2 do
   for j:=i+1 to c.Length-1 do
   if w[i]<w[j] then
   begin
      e:=w[i];
      w[i]:=w[j];
      w[j]:=e;
      s2:=c[i];
      c[i]:=c[j];
      c[j]:=s2;
   end;
   var r:array of string;
   var t:array of integer;
   e:=0;
   for i:=0 to c.Length-1 do
   if w[i]>0 then
   e+=1;
   r:=new string[e];
   t:=new integer[e];
   e:=0;
   for i:=0 to c.Length-1 do
   if w[i]>0 then
   begin
      r[e]:=c[i];
      t[e]:=w[i];
      e+=1;
   end;
   var f:text;
   assign(f,s);
   rewrite(f);
   for i:=0 to r.Length-1 do
   global_score+=t[i];
   writeln(f,'Количество пакетов '+global_score);
   for i:=0 to r.Length-1 do
   writeln(f,r[i],' - ',t[i]);
   close(f);
   SetWindowSize(900,500);
   Window.Title:='Статистика';
   var x:=250;
   var y:=250;
   var nw:array of integer;
   nw:=new integer[t.Length];
   nw[0]:=t[0];
   for i:=1 to t.Length-1 do
   nw[i]:=nw[i-1]+t[i];
   Brush.Color:=clRandom;
   Pie(x,y,240,0,md((nw[0]/global_score)*360));
   FillRectangle(510,10,530,30);
   Rectangle(510,10,530,30);
   Brush.Color:=clWhite;
   TextOut(550,10,t[0]+'       '+r[0]);
   for i:=1 to t.Length-1 do
   begin
      Brush.Color:=clRandom;
      Pie(x,y,240,md((nw[i-1]/global_score)*360),md((nw[i]/global_score)*360));
      if i<11 then
      begin
         FillRectangle(510,50*i+10,530,50*i+30);
         Rectangle(510,50*i+10,530,50*i+30);
         Brush.Color:=clWhite;
         TextOut(550,50*i+10,t[i]+'       '+r[i]);
      end;
   end;
   Window.Save('stat.png');
end;

function sortarray(a:array of strarray;s:string;n:integer):array of strarray;
var
i,j,score:integer;
b:array of strarray;
begin
   
   for i:=0 to a.Length-2 do
   if a[i,n]=s then
   score+=1;
   b:=new strarray[score];
   for i:=0 to b.Length-1 do
   b[i]:=new string[a[0].Length];
   score:=0;
   for i:=0 to a.Length-2 do
   if a[i,n]=s then
   begin
      for j:=0 to a[0].Length-1 do
      b[score,j]:=a[i,j];
      score+=1;
   end;
   result:=b;
end;
procedure savecsv(a:array of strarray;s:string);
var
f:text;
i,j:integer;
begin
   assign(f,s);
   rewrite(f);
   writeln(f,'"No.","Time","Source","Destination","Protocol","Length","Info"');
   for i:=0 to a.Length-2 do
   begin
      for j:=0 to a[0].Length-2 do
      write(f,'"'+a[i][j]+'",');
      writeln(f,'"'+a[i][j+1]+'"');
   end;
   close(f);
end;

end.