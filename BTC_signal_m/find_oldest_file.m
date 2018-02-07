function ans=find_oldest_file(s_dir, prim)
%Задача найти старейший фаил и выдать ссылку на его имя
%  prim строка которая должна содержаться в имени файла 
switch nargin
    case 1 
        search_prim=false;
        prim='';
    case 2
        search_prim=true;
    otherwise
        ans=0;
        disp('False param of find_oldest_file');
        return;
end

   for i=1:length(s_dir)
       if s_dir(i).isdir==0
           if search_prim
               if ~isempty(findstr(s_dir(i).name,prim))
                   a(i)=s_dir(i).datenum;
               end
           else
                a(i)=s_dir(i).datenum;
           end
       end
   end
   
   try
       [k,b]=max(a);
       ans=s_dir(b).name;
   catch
       warning('Problem using function.  Assigning a value of 0.');
       ans = 0;
   end
   
  
end

