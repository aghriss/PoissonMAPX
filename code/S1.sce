lambda=3
t=3

Nt= grand(1,1,"poi",lambda*t) // génère une valeur de Nt suivant la loi de Poisson
U=grand(Nt,1,"unf",0,t)   // génère Nt variables de loi uniforme sur [0,t]
U=gsort(U,"g","i") // vecteur de statistiques d'ordre associées

p=10000
x=linspace(0,t,p) // une partition (xi) de [0,t] de pas 1/p

for j=1:p
    y(j)=0
    for i=1:Nt
      if x(j)>=U(i) then  // une suite (yi) avec yi=Card{j/ xi>=Uj }
         y(j)=y(j)+1
       end
     end
end
plot2d(x,y)
xtitle(’Simulation de processus de Poisson sur [0,’+string(t)+’], avec lambda = ’+string(lambda));
