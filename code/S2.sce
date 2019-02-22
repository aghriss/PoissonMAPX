t=3
lambda = 3
x0 = 1
p=1000
Nt= grand(1,1,"poi",lambda*t) // génère une valeur de Nt suivant la loi de Poisson
U=grand(Nt,1,"unf",0,t)   // génère Nt variables de loi uniforme sur [0,t]
U=gsort(U,"g","i") // vecteur de statistiques d'ordre associées

function yprim = g (t,y)
  yprim = -lambda*(2+cos(y))
endfunction

yU(1)=ode(x0,0,U(1),g) //résolution de l'ED y'=-lambda*f(y)
yU(1)=yU(1) + 2 + cos(yU(1)) // on ajoute le saut Delta(X)=2+cos(X_ti)
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
    z(j)=ode(x0,0,x(j),g) // si N(ti)=0, on initialise
  else
    z(j)=ode(yU(N(j)),U(N(j)),x(j),g)
  end
end
plot2d(x,z)
