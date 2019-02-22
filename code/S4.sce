t=3
lambda = 3
x0 = 1
p=40
Nb=10000
for j=1:p 
  z(j)=0
end
  
function yprim = g (t,y)
    yprim = -lambda*(2+cos(y))
endfunction
for i=1:Nb
  Nt=grand(1,1,"poi",lambda*t)
  U=grand(Nt,1,"unf",0,t)
  U=gsort(U,"g","i")
  
  yU(1)=ode(x0,0,U(1),g)
  yU(1)=yU(1) + 2 + cos(yU(1))
  for j=2:Nt
    yU(j)=ode(yU(j-1),U(j-1),U(j),g)
    yU(j)=yU(j) - g(0,yU(j)) /lambda
  end  

  x=linspace(0,t,p)
  for j=1:p
    N(j)=0
    for i=1:Nt
      if x(j)>=U(i) then
         N(j)=N(j)+1
       end
     end
  end
 
  for j=1:p
    if N(j)==0 then 
      z(j)=z(j)+ode(x0,0,x(j),g)
    else
      z(j)=z(j)+ode(yU(N(j)),U(N(j)),x(j),g)
    end
  end
end
for j=1:p 
  z(j)=z(j) / Nb
end 

disp(z)
