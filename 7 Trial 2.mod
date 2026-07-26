/*********************************************
 * OPL 22.1.2.0 Model
 * Author: 0204a
 * Creation Date: 24-Aug-2025 at 11:06:16 am
 *********************************************/
int MS=...; //number of material suppliers
int RC=...; //recycling centers
int PR=...; //number of periods
int RM=...; //Rawmaterials
int DMC=...;// dismental centers
int UA=...;//user A
int UB=...;//user B
int UC=...;//user C
int MT=...;//Material types
int MF=...;//manufacturers
int C=...;//number of customers
int U=...;//Number of users
int DS=...;//number of disassemblycentres
int CC=...;//number of collectioncentres
int cc=...;//transportation cost
int DPS=...;//number of disposecentres
float wr=...;//ratio of wt of semifinished product
float ws=...;//ratio of wt of 1 pieces to total wt
float mu=...;//percentage of material sent from dismantle centre to recycling centre
float oga=...;//percentage of material sent from dismantle centre to user A
float ogb=...;//percentage of material sent from dismantle centre to user B
float ll=...;//percentage of material sent from dismantle centre to user C
float tt=...;//percentage of material sent from dismantle centre to dispose centre
float tz=...;//percentage of raw material seperated from recycling centre
range I=1..MS;//1 to 4
range Q=1..RC;//1 to 2
range P=1..PR;//1 to3
range R=1..RM;//1 to 4
range O=1..DMC;//1 to 2
range FB=1..UB;//1 to 2
range S=1..MT;//1 to 4
range FA=1..UA;//1 to 2
range FC=1..UC;//1 to 2
range J=1..MF;//1 to 2
range K=1..C;//1 to 3
range L=1..U;//1 to 5
range M=1..DS;//1 to 2
range N=1..CC;//1 to 2
range V=1..DPS;//1 to 2
 

//Purchasing cost from material i of material r in period p
float Temp_Uirp[1..MS*RM*PR]=...;//Purchasing cost from material i of material r in period p(50-125)  all costs are 1D arrays temporary
float Uirp[I][R][P];

execute
{
  var count_urip=0;
  var i,j,k;
  for(i in I)
  {
    for(j in R)
    {
      for(k in P)
      {
        count_urip++;
        Uirp[i][j][k]=Temp_Uirp[count_urip];
      }
    }
  }
}
//Purchasing cost of material s in period p for user b
float Temp_eefbsp[1..UB*MT*PR]=...;//Purchasing cost of material s in period p for user b(800-2500)
float eefbsp[FB][S][P];
execute
{
  var count_eefbsp=0;
  var i,j,k;
  for(i in FB)
  {
    for(j in S)
    {
      for(k in P)
      {
        count_eefbsp++;
        eefbsp[i][j][k]=Temp_eefbsp[count_eefbsp];
      }
    }
  }
}

//Purchasing cost of material s in period p from user a
float Temp_ddfasp[1..UA*MT*PR]=...;//Purchasing cost of material s in period p from user a(1000-2000)
float ddfasp[FA][S][P];
execute
{
  var count_ddfasp=0;
  var i,j,k;
  for(i in FA)
  {
    for(j in S)
    {
      for(k in P)
      {
        count_ddfasp++;
        ddfasp[i][j][k]=Temp_ddfasp[count_ddfasp];
      }
    }
  }
}
// Purchasing cost of material s in period p from user c
float Temp_ggfcsp[1..UC*MT*PR]=...;// Purchasing cost of material s in period p from user c(1200-3800)
float ggfcsp[FC][S][P];
execute
{
  var count_ggfcsp=0;
  var i,j,k;
  for(i in FC)
  {
    for(j in S)
    {
      for(k in P)
      {
        count_ggfcsp++;
        ggfcsp[i][j][k]=Temp_ggfcsp[count_ggfcsp];
      }
    }
  }
}

//Purchasing cost of customer in period p
float Temp_Vkp[1..C*PR]=...;//Purchasing cost of customer in period p(1500000-3500000)
float Vkp[K][P];
execute
{
  var count_Vkp=0;
  var i,j;
  for(i in K)
  {
    for(j in P)
    {
        count_Vkp++;
        Vkp[i][j]=Temp_Vkp[count_Vkp];
      }
    }
  }
//Purchasing cost of user in period p
float Temp_Wlp[1..U*PR]=...;//Purchasing cost of user in period p(700000-1700000)
float Wlp[L][P];
execute
{
  var count_Wlp=0;
  var i,j;
  for(i in L)
  {
    for(j in P)
    {
        count_Wlp++;
        Wlp[i][j]=Temp_Wlp[count_Wlp];
      }
    }
  }
//Manufacturing cost of manufacturer j in period p
float Temp_AAjp[1..MF*PR]=...;//Manufacturing cost of manufacturer j in period p(α)(166000-221000)
float AAjp[J][P];
execute
{
  var count_AAjp=0;
  var i,j;
  for(i in J)
  {
    for(j in P)
    {
        count_AAjp++;
        AAjp[i][j]=Temp_AAjp[count_AAjp];
      }
    }
  }
//Operation cost of disassembly centre m in period p
float Temp_BBmp[1..DS*PR]=...;//Operation cost of disassembly centre m in period p(γ)(83K – 110K)
float BBmp[M][P];
execute
{
  var count_BBmp=0;
  var i,j;
  for(i in M)
  {
    for(j in P)
    {
        count_BBmp++;
        BBmp[i][j]=Temp_BBmp[count_BBmp];
      }
    }
  }
  //Operation cost of collection centre n in period p
float Temp_CCnp[1..CC*PR]=...;//Operation cost of collection centre n in period p(θ)(27K – 55K)
float CCnp[N][P];
execute
{
  var count_CCnp=0;
  var i,j;
  for(i in N)
  {
    for(j in P)
    {
        count_CCnp++;
        CCnp[i][j]=Temp_CCnp[count_CCnp];
      }
    }
  }

float Temp_DDop[1..DMC*PR]=...;//Operation cost of dismantle centre o in period p(β)(110K – 138K)
float DDop[O][P];
execute
{
  var count_DDop=0;
  var i,j;
  for(i in O)
  {
    for(j in P)
    {
        count_DDop++;
        DDop[i][j]=Temp_DDop[count_DDop];
      }
    }
  }
  
//Operation cost of raw material r in recycle centre q in period p  
float Temp_Kqrp[1..RC*RM*PR]=...;//Operation cost of raw material r in recycle centre q in period p(194K – 221K)
float Kqrp[Q][R][P];
execute
{
  var count_Kqrp=0;
  var i,j,k;
  for(i in Q)
  {
    for(j in R)
    {
      for(k in P)
      {
        count_Kqrp++;
        Kqrp[i][j][k]=Temp_Kqrp[count_Kqrp];
      }
    }
  }
}  
//fixed facility cost of manufcaturer j in period p
float Temp_fjp[1..MF*PR]=...;//fixed facility cost of manufcaturer j in period p(157K – 183K)
float fjp[J][P];
execute
{
  var count_fjp=0;
  var i,j;
  for(i in J)
  {
    for(j in P)
    {
        count_fjp++;
        fjp[i][j]=Temp_fjp[count_fjp];
      }
    }
  }
//fixed facility cost of disassembly centre in period p  
float Temp_fmp[1..DS*PR]=...;//fixed facility cost of disassembly centre in period p(78K – 105K)
float fmp[M][P];
execute
{
  var count_fmp=0;
  var i,j;
  for(i in M)
  {
    for(j in P)
    {
        count_fmp++;
        fmp[i][j]=Temp_fmp[count_fmp];
      }
    }
  }
  //fixed facility cost of collection centre in period p
float Temp_fnp[1..CC*PR]=...;//fixed facility cost of collection centre in period p(52K – 78K)
float fnp[N][P];
execute
{
  var count_fnp=0;
  var i,j;
  for(i in N)
  {
    for(j in P)
    {
        count_fnp++;
        fnp[i][j]=Temp_fnp[count_fnp];
      }
    }
  }
//fixed facility cost of dismantle centre in period p
float Temp_fop[1..DMC*PR]=...;//fixed facility cost of dismantle centre in period p(105K – 131K) 
float fop[O][P];
execute
{
  var count_fop=0;
  var i,j;
  for(i in O)
  {
    for(j in P)
    {
        count_fop++;
        fop[i][j]=Temp_fop[count_fop];
      }
    }
  }
//fixed facility cost of recycling centre in period p
float Temp_fqp[1..RC*PR]=...;//fixed facility cost of recycling centre in period p(131K – 157K)
float fqp[Q][P];
execute
{
  var count_fqp=0;
  var i,j;
  for(i in Q)
  {
    for(j in P)
    {
        count_fqp++;
        fqp[i][j]=Temp_fqp[count_fqp];
      }
    }
  }
float Temp_Dij[1..MS*MF]=...;//Distance between supplier i and manufacturer j(Δij)[Given]
float Dij[I][J];
execute
{
  var count_Dij=0;
  var i,j;
  for(i in I)
  {
    for(j in J)
    {
        count_Dij++;
        Dij[i][j]=Temp_Dij[count_Dij];
      }
    }
  }
//Distance between manufcaturer j and customer k
float Temp_Djk[1..MF*C]=...;//Distance between manufcaturer j and customer k(Δjk)[Given]
float Djk[J][K];
execute
{
  var count_Djk=0;
  var i,j;
  for(i in J)
  {
    for(j in K)
    {
        count_Djk++;
        Djk[i][j]=Temp_Djk[count_Djk];
      }
    }
  }
float Temp_Dkl[1..C*U]=...;//Distance between customer k and user l(Δkl)[Given]
float Dkl[K][L];
execute
{
  var count_Dkl=0;
  var i,j;
  for(i in K)
  {
    for(j in L)
    {
        count_Dkl++;
        Dkl[i][j]=Temp_Dkl[count_Dkl];
      }
    }
  }
//Distance between user l and disassembly centre m
float Temp_Dlm[1..U*DS]=...;//Distance between user l and disassembly centre m(Δlm)[Given]
float Dlm[L][M];
execute
{
  var count_Dlm=0;
  var i,j;
  for(i in L)
  {
    for(j in M)
    {
        count_Dlm++;
        Dlm[i][j]=Temp_Dlm[count_Dlm];
      }
    }
  }

//Distance between disassembly centre m and collection centre n
float Temp_Dmn[1..DS*CC]=...;//Distance between disassembly centre m and collection centre n(Δmn)[Given]
float Dmn[M][N];
execute
{
  var count_Dmn=0;
  var i,j;
  for(i in M)
  {
    for(j in N)
    {
        count_Dmn++;
        Dmn[i][j]=Temp_Dmn[count_Dmn];
      }
    }
  }
  //Distance between collection centre n and dismantle centre o
float Temp_Dno[1..CC*DMC]=...;//Distance between collection centre n and dismantle centre o(Δno)[Given]
float Dno[N][O];
execute
{
  var count_Dno=0;
  var i,j;
  for(i in N)
  {
    for(j in O)
    {
        count_Dno++;
        Dno[i][j]=Temp_Dno[count_Dno];
      }
    }
  }

//Distance between recycling centre q and material supplier centre i
float Temp_Dqi[1..RC*MS]=...;//Distance between recycling centre q and material supplier centre i(Δqi)[Given]
float Dqi[Q][I];
execute
{
  var count_Dqi=0;
  var i,j;
  for(i in Q)
  {
    for(j in I)
    {
        count_Dqi++;
        Dqi[i][j]=Temp_Dqi[count_Dqi];
      }
    }
  }
//Distance between dismantle centre o and user fa
float Temp_Dofa[1..DMC*UA]=...;//Distance between dismantle centre o and user fa(Δofa)[Given]
float Dofa[O][FA];
execute
{
  var count_Dofa=0;
  var i,j;
  for(i in O)
  {
    for(j in FA)
    {
        count_Dofa++;
        Dofa[i][j]=Temp_Dofa[count_Dofa];
      }
    }
  }
//Distance between dismantle centre o and user fb
float Temp_Dofb[1..DMC*UB]=...;//Distance between dismantle centre o and user fb(Δofb)[Given]
float Dofb[O][FB];
execute
{
  var count_Dofb=0;
  var i,j;
  for(i in O)
  {
    for(j in FB)
    {
        count_Dofb++;
        Dofb[i][j]=Temp_Dofb[count_Dofb];
      }
    }
  }
//Distance between dismantle centre o and user fc
float Temp_Dofc[1..DMC*UC]=...;//Distance between dismantle centre o and user fc(Δofc)[Given]
float Dofc[O][FC];
execute
{
  var count_Dofc=0;
  var i,j;
  for(i in O)
  {
    for(j in FC)
    {
        count_Dofc++;
        Dofc[i][j]=Temp_Dofc[count_Dofc];
      }
    }
  }
//Collection centre n of capacity in period p
float Temp_qnp[1..CC*PR]=...; //Collection centre n of capacity in period p[Given]
float qnp[N][P];
execute
{
  var count_qnp=0;
  var i,j;
  for(i in N)
  {
    for(j in P)
    {
        count_qnp++;
        qnp[i][j]=Temp_qnp[count_qnp];
      }
    }
  }
//Largest number of manufacturer in period p
float Lp[P]=...;//Largest number of manufacturer in period p[Given]
float Np[P]=...;//Largest number of diassembly centre in period p[Given]
float Rp[P]=...;//Largest number of collection centre in period p[Given]
float Sp[P]=...;//Largest number of recycling centre in period p[Given]
float ZZp[P]=...;//Largest number of dismantle centre in period p[Given]

float Temp_nlp[1..U*PR]=...;//Demand of user l in period p[Given]
float nlp[L][P];
execute
{
  var count_nlp=0;
  var i,j;
  for(i in L)
  {
    for(j in P)
    {
        count_nlp++;
        nlp[i][j]=Temp_nlp[count_nlp];
      }
    }
  }
//Amount of material r from recycling centre q to dispose centre v in period p
float Temp_dmp[1..DS*PR]=...;//Description not given in research paper[not given]
float dmp[M][P];
execute
{
  var count_dmp=0;
  var i,j;
  for(i in M)
  {
    for(j in P)
    {
        count_dmp++;
        dmp[i][j]=Temp_dmp[count_dmp];
      }
    }
  }
  //Amount of material r from recycling centre q to dispose centre v in period p
float Temp_JJqvrp[1..RC*DPS*RM*PR]=...;//Amount of material r from recycling centre q to dispose centre v in period p[not given]((0.3 * (2100 - 4400))= 630 - 1320)
float JJqvrp[Q][V][R][P];
execute
{
  var count_JJqvrp=0;
  var i,j,k,l;
  for(i in Q)
  {
    for(j in V)
    {
      for(k in R)
      {
        for(l in P)
        {
         count_JJqvrp++;
        JJqvrp[i][j][k][l]=Temp_JJqvrp[count_JJqvrp];
      }        
      }
    }
  }
}  
  //recycling centre q of material capacity r in period p
float Temp_cqrp[1..RC*RM*PR]=...;//recycling centre q of material capacity r in period p[Given]
float cqrp[Q][R][P];
execute
{
  var count_cqrp=0;
  var i,j,k;
  for(i in Q)
  {
    for(j in R)
    {
      for(k in P)
      {
        count_cqrp++;
        cqrp[i][j][k]=Temp_cqrp[count_cqrp];
      }
    }
              
   }
  }
//dismantle centre o of capacity in period p
float Temp_bop[1..DMC*PR]=...;//dismantle centre o of capacity in period p[Given]
float bop[O][P];
execute
{
  var count_bop=0;
  var i,j;
  for(i in O)
  {
    for(j in P)
    {
        count_bop++;
        bop[i][j]=Temp_bop[count_bop];
      }
    }
              
   }
float Temp_eisp[1..MS*PR*MT]=...;//dismantle centre o of capacity in period p[Given]
float eisp[I][S][P];
execute
{
  var count_eisp=0;
  var i,j,k;
  for(i in I)
  {
    for(j in S)
    {
      for(k in P)
      {
        count_eisp++;
        eisp[i][j][k]=Temp_eisp[count_eisp];
      }
    }
  }    
}                
float Temp_tjp[1..MF*PR]=...;//dismantle centre o of capacity in period p[Given]
float tjp[J][P];
execute
{
  var count_tjp=0;
  var i,j;
  for(i in J)
  {
    for(j in P)
    {
        count_tjp++;
        tjp[i][j]=Temp_tjp[count_tjp];
      }
    }           
  }
float Temp_zkp[1..C*PR]=...;//dismantle centre o of capacity in period p[Given]
float zkp[K][P];
execute
{
  var count_zkp=0;
  var i,j;
  for(i in K)
  {
    for(j in P)
    {
        count_zkp++;
        zkp[i][j]=Temp_zkp[count_zkp];
      }
    }           
  }  
  
  
//defining the decision variables
dvar float+ Hqirp[Q][I][R][P];//amount of raw materials(r)from recycling centre(q) in period(p)
dvar float+ SUPBofbsp[O][FB][S][P];//Description not given in the research paper
dvar float+ USRAofasp[O][FA][S][P];//amount of material(s)from dismantle centre(o) to user a in period p
dvar float+ USRBofbsp[O][FB][S][P];//amount of material s from dismantle centre o to user b in period p
//dvar float+ USRCofcsp[O][FC][S][P];//amount of material s from dismantle centre o to user c in period p
dvar float+ SUPCofcsp[O][FC][S][P];//`Description not given in the research paper
dvar float+ Bjkp[J][K][P];//Amount of material transferred from manufcaturer j to customer k  in period p(ton)
dvar float+ Cklp[K][L][P];//Amount of product transported from customer k to user l in period p
dvar float+ Aijsp[I][J][S][P];//Amount of material transported from raw material centre i to to manufacturer j in period p
dvar float+ Dlmp[L][M][P];//Amount of product transported from user l to disassembly centre m in period p
dvar float+ Emnp[M][N][P];//Amount of product transported from disassembly centre m to collection centre n in period p
dvar float+ Fnop[N][O][P];//Amount of product transported from collection centre n to dismantle centre o in period p
dvar float+ Goqp[O][Q][P];//Amount of second-hand products from dismantle centre o to recycling centre q in period p
dvar boolean Xjp[J][P];//if manufacturer j opens in period p, 1 otherwise 0
dvar boolean Ymp[M][P];//if disassembly centre m opens in period p, 1 otherwise 0
dvar boolean PPnp[N][P];//if collection centre n opens in period p, 1 otherwise 0
dvar boolean Top[O][P];//if dismantle centre o opens in period p, 1 otherwise 0
dvar boolean Zqp[Q][P];//if recycling centre q opens in period p, 1 otherwise 0 
dvar float+ Hqisp[Q][I][S][P];//Description not given in the research paper
dvar float+ SUPAofasp[O][FA][S][P];//Description not given in the research paper
dvar float+ SUPAofbsp[O][FB][S][P];//Description not given in the research paper
dvar float+ SUPAofcsp[O][FC][S][P];//Description not given in the research paper
dvar float+ BBop[O][P];

//Expressions of Objective function
dexpr float P1=sum(i in Q,j in I, k in R, l in P)Hqirp[i][j][k][l]*Uirp[i][k][l];
dexpr float P2=sum(i in O, j in FA, k in S, l in P)USRAofasp[i][j][k][l]*ddfasp[j][k][l];
dexpr float P3=sum(i in O, j in FB, k in S, l in P)SUPBofbsp[i][j][k][l]*eefbsp[j][k][l];
dexpr float P4=sum(i in O, j in FC, k in S, l in P)SUPCofcsp[i][j][k][l]*ggfcsp[j][k][l];
dexpr float P5=sum(i in J, j in K, k in P)Bjkp[i][j][k]*Vkp[j][k];
dexpr float P6=sum(i in K, j in L, k in P)Cklp[i][j][k]*Wlp[j][k];
dexpr float P7=sum(i in I, j in J, k in S, l in P)AAjp[j][l]*Aijsp[i][j][k][l];
dexpr float P8=sum(i in L, j in M, k in P)BBmp[j][k]*Dlmp[i][j][k];
dexpr float P9=sum(i in M, j in N, k in P)CCnp[j][k]*Emnp[i][j][k];
dexpr float P10=sum(i in N, j in O, k in P)BBop[j][k]*Fnop[i][j][k];
dexpr float P11=sum(i in O, k in Q, l in P, j in R)Goqp[i][k][l]*Kqrp[k][j][l];
dexpr float P12=sum(i in J, j in P)fjp[i][j]*Xjp[i][j];
dexpr float P13=sum(i in M, j in P)fmp[i][j]*Ymp[i][j];
dexpr float P14=sum(i in N, j in P)fnp[i][j]*PPnp[i][j];
dexpr float P15=sum(i in O, j in P)fop[i][j]*Top[i][j];
dexpr float P16=sum(i in Q, j in P)fqp[i][j]*Zqp[i][j];
dexpr float P17=sum(i in I, j in J, k in S, l in P)Aijsp[i][j][k][l]*Dij[i][j];
dexpr float P18=sum(i in J, j in K, k in P)Bjkp[i][j][k]*Djk[i][j];
dexpr float P19=sum(i in K, j in L, k in P)Cklp[i][j][k]*Dkl[i][j];
dexpr float P20=sum(i in L, j in M, k in P)Dlmp[i][j][k]*Dlm[i][j]; 
dexpr float P21=sum(i in M, j in N, k in P)Emnp[i][j][k]*Dmn[i][j];
dexpr float P22=sum(i in N, j in O, k in P)Fnop[i][j][k]*Dno[i][j];
dexpr float P23=sum(i in Q, j in I, k in S, l in P)Hqisp[i][j][k][l]*Dqi[i][j];
dexpr float P24=sum(i in O, j in FA, k in S, l in P)SUPAofasp[i][j][k][l]*Dofa[i][j];
dexpr float P25=sum(i in O, j in FB, k in S, l in P)SUPAofbsp[i][j][k][l]*Dofb[i][j];  
dexpr float P26=sum(i in O, j in FC, k in S, l in P)SUPAofcsp[i][j][k][l]*Dofc[i][j];
//Model to maximize the profit
dexpr float cost=(P1+P2+P3+P4-(P5+P6+P7+P8+P9+P10+P11+P12+P13+P14+P15+P16)-cc*(P17+P18+P19+P20+P21+P22+P23+P24+P25+P26));  
maximize cost;
dvar float+ Slack[L][P];
dvar float+ OverCap[q in Q, r in R, p in P];
dvar float+ BalSlackPlus[q in Q, r in R, p in P];
dvar float+ BalSlackMinus[q in Q, r in R, p in P];
//defining constraints 
subject to {
  // C1 supplier -> manufacturer capacity (for each supplier i, material s, period p)
C1:
forall(i in I, s in S, p in P)
  sum(j in J) Aijsp[i][j][s][p] <= eisp[i][s][p];

// C2 manufacturer -> customer capacity (for each manufacturer j, period p)
C2:
forall(j in J, p in P)
  sum(k in K) Bjkp[j][k][p] <= tjp[j][p] * Xjp[j][p];

forall(j in J, k in K, p in P)
  Bjkp[j][k][p] <= tjp[j][p] * Xjp[j][p];

// C3 user -> disassembly capacity (for each disassembly m, period p)
C3:
forall(m in M, p in P)
  sum(l in L) Dlmp[l][m][p] <= dmp[m][p] * Ymp[m][p]; // (make sure you use the correct param name for disassembly cap)

// C4 disassembly -> collection capacity (for each collection n, period p)
C4:
forall(n in N, p in P)
  sum(m in M) Emnp[m][n][p] <= qnp[n][p] * PPnp[n][p];

// C5 dismantler capacity (per o,p)
C5:
forall(o in O, p in P)
  sum(n in N) Fnop[n][o][p]
+ sum(fa in FA, s in S) USRAofasp[o][fa][s][p]
+ sum(fb in FB, s in S) SUPBofbsp[o][fb][s][p]   // <-- use SUPBofbsp here
+ sum(fc in FC, s in S) SUPCofcsp[o][fc][s][p]
<= bop[o][p] * Top[o][p];

// C6 recycling capacity (for each recycling q, raw r, period p)
C6:
forall(q in Q, r in R, p in P)
  wr * sum(o in O) Goqp[o][q][p]
  + sum(v in V) JJqvrp[q][v][r][p]
  <= cqrp[q][r][p] + OverCap[q][r][p];

// C7 (customers demand) -- restore if needed
// C7:
// forall(k in K, p in P)
//   sum(j in J) Bjkp[j][k][p] >= zkp[k][p];

// C8 users demand
C8: 

forall(l in L, p in P)
  sum(k in K) Cklp[k][l][p] + Slack[l][p] >= nlp[l][p];

// C9..C13 facility count upper-limits (these were fine conceptually)
// C9:
forall(p in P) sum(j in J) Xjp[j][p] <= Lp[p];
// C10:
forall(p in P) sum(m in M) Ymp[m][p] <= Np[p];
// C11:
forall(p in P) sum(n in N) PPnp[n][p] <= Rp[p];
// C12:
forall(p in P) sum(o in O) Top[o][p] <= ZZp[p];
// C13:
forall(p in P) sum(q in Q) Zqp[q][p] <= Sp[p];

// --- Balance constraints ---
// C14: supplier->manufacturer inflow vs manufacturer->customer outflow (for each manufacturer j and period p)
C14:
forall(j in J, p in P)
  sum(i in I, s in S) Aijsp[i][j][s][p]
  - ws * sum(k in K) Bjkp[j][k][p] == 0;

// C15: manufacturer -> customer -> user (for each customer k and period p)
C15:
forall(k in K, p in P)
  sum(j in J) Bjkp[j][k][p]
  - sum(l in L) Cklp[k][l][p] >= 0;

// C16 (user l balance)  NO p+1
C16:
forall(l in L, p in P)
  sum(k in K) Cklp[k][l][p]
  - sum(m in M) Dlmp[l][m][p] == 0;

// C17 (disassembly m balance)  NO p+1
C17:
forall(m in M, p in P)
  sum(l in L) Dlmp[l][m][p]
  - sum(n in N) Emnp[m][n][p] == 0;

// C18 (collection n balance)  NO p+1
C18:
forall(n in N, p in P)
  sum(m in M) Emnp[m][n][p]
  - sum(o in O) Fnop[n][o][p] == 0;

// C19: dismantler -> recycling (uncomment if you need conservation for recycled fraction)
//C19:
//forall(o in O, p in P : p < PR)
  //wr * sum(n in N) Fnop[n][o][p+1] - sum(q in Q) Goqp[o][q][p+1] == 0;

//forall(o in O, p in P : p == PR)
  //wr * sum(n in N) Fnop[n][o][p] - sum(q in Q) Goqp[o][q][p] == 0;

// C20..C22 (splits from dismantler o to users A,B,C)  NO p+1
C20:
forall(o in O, p in P)
  oga * sum(n in N) Fnop[n][o][p]
  - sum(fa in FA, s in S) USRAofasp[o][fa][s][p] == 0;

C21:
forall(o in O, p in P)
  ogb * sum(n in N) Fnop[n][o][p]
- sum(fb in FB, s in S) USRBofbsp[o][fb][s][p] == 0;

C22:
forall(o in O, p in P)
  ll * sum(n in N) Fnop[n][o][p]
  - sum(fc in FC, s in S) SUPCofcsp[o][fc][s][p] == 0;

// C23 (recycling q -> waste v, raw r)  NO p+1
C23:
forall(q in Q, r in R, p in P)
  wr * tt * sum(o in O) Goqp[o][q][p]
  - sum(v in V) JJqvrp[q][v][r][p]
  + BalSlackPlus[q][r][p] - BalSlackMinus[q][r][p] == 0;

// C24 (recycling q -> raw-material centers i, raw r)  NO p+1
C24:
forall(q in Q, r in R, p in P)
  wr * tz * sum(o in O) Goqp[o][q][p]
  - sum(i in I) Hqirp[q][i][r][p] == 0;
   
C25:
forall(j in J, k in K, p in P)
  Bjkp[j][k][p] <= tjp[j][p] * Xjp[j][p];


}


float Temp_Hqirp[1..RC*MS*RM*PR];
execute{
  var count_Hqirp=0;
  var q,i,r,p;
  for(q in Q)
  {
    for(i in I)
    {
      for(r in R)
      {
        for(p in P)
        {
          count_Hqirp++;
          Temp_Hqirp[count_Hqirp]=Hqirp[q][i][r][p];
        }
      }
    }
  }
}

float Temp_SUPBofbsp[1..DMC*UB*MT*PR];
execute{
  var count_SUPBofbsp=0;
  var o,fb,s,p;
  for(o in O)
  {
    for(fb in FB)
    {
      for(s in S)
      {
        for(p in P)
        {
          count_SUPBofbsp++;
          Temp_SUPBofbsp[count_SUPBofbsp]=SUPBofbsp[o][fb][s][p];
        }
      }
    }
  }
} 

float Temp_USRAofasp[1..DMC*UA*MT*PR];
execute{
  var count_USRAofasp=0;
  var o,fa,s,p;
  for(o in O)
  {
    for(fa in FA)
    {
      for(s in S)
      {
        for(p in P)
        {
          count_USRAofasp++;
          Temp_USRAofasp[count_USRAofasp]=USRAofasp[o][fa][s][p];
        }
      }
    }
  }
} 

float Temp_USRBofbsp[1..DMC*UB*MT*PR];
execute{
  var count_USRBofbsp=0;
  var o,fb,s,p;
  for(o in O)
  {
    for(fb in FB)
    {
      for(s in S)
      {
        for(p in P)
        {
          count_USRBofbsp++;
          Temp_USRBofbsp[count_USRBofbsp]=USRBofbsp[o][fb][s][p];
        }
      }
    }
  }
} 

float Temp_SUPCofcsp[1..DMC*UC*MT*PR];
execute{
  var count_SUPCofcsp=0;
  var o,fc,s,p;
  for(o in O)
  {
    for(fc in FC)
    {
      for(s in S)
      {
        for(p in P)
        {
          count_SUPCofcsp++;
          Temp_SUPCofcsp[count_SUPCofcsp]=SUPCofcsp[o][fc][s][p];
        }
      }
    }
  }
} 

float Temp_SUPAofasp[1..DMC*UA*MT*PR];
execute{
  var count_SUPAofasp=0;
  var o,fa,s,p;
  for(o in O)
  {
    for(fa in FA)
    {
      for(s in S)
      {
        for(p in P)
        {
          count_SUPAofasp++;
          Temp_SUPAofasp[count_SUPAofasp]=SUPAofasp[o][fa][s][p];
        }
      }
    }
  }
} 

float Temp_SUPAofbsp[1..DMC*UB*MT*PR];
execute{
  var count_SUPAofbsp=0;
  var o,fb,s,p;
  for(o in O)
  {
    for(fb in FB)
    {
      for(s in S)
      {
        for(p in P)
        {
          count_SUPAofbsp++;
          Temp_SUPAofbsp[count_SUPAofbsp]=SUPAofbsp[o][fb][s][p];
        }
      }
    }
  }
}

float Temp_SUPAofcsp[1..DMC*UC*MT*PR];
execute{
  var count_SUPAofcsp=0;
  var o,fc,s,p;
  for(o in O)
  {
    for(fc in FC)
    {
      for(s in S)
      {
        for(p in P)
        {
          count_SUPAofcsp++;
          Temp_SUPAofcsp[count_SUPAofcsp]=SUPAofcsp[o][fc][s][p];
        }
      }
    }
  }
}

float Temp_Bjkp[1..PR*C*MF];
execute{
  var count_Bjkp=0;
  var j,k,p;
  for(j in J)
  {
      for(k in K)
      {
        for(p in P)
        {
          count_Bjkp++;
          Temp_Bjkp[count_Bjkp]=Bjkp[j][k][p];
        }
      }
  }
}

float Temp_Cklp[1..PR*C*U];
execute{
  var count_Cklp=0;
  var k,l,p;
  for(k in K)
  {
      for(l in L)
      {
        for(p in P)
        {
          count_Cklp++;
          Temp_Cklp[count_Cklp]=Cklp[k][l][p];
        }
      }
  }
}

float Temp_Aijsp[1..MS*MF*MT*PR];
execute{
  var count_Aijsp=0;
  var i,j,s,p;
  for(i in I)
  {
    for(j in J)
    {
      for(s in S)
      {
        for(p in P)
        {
          count_Aijsp++;
          Temp_Aijsp[count_Aijsp]=Aijsp[i][j][s][p];
        }
      }
    }
  }
}

float Temp_Dlmp[1..PR*DS*U];
execute{
  var count_Dlmp=0;
  var l,m,p;
  for(l in L)
  {
      for(m in M)
      {
        for(p in P)
        {
          count_Dlmp++;
          Temp_Dlmp[count_Dlmp]=Dlmp[l][m][p];
        }
      }
  }
}

float Temp_Emnp[1..PR*DS*CC];
execute{
  var count_Emnp=0;
  var m,n,p;
  for(m in M)
  {
      for(n in N)
      {
        for(p in P)
        {
          count_Emnp++;
          Temp_Emnp[count_Emnp]=Emnp[m][n][p];
        }
      }
  }
}

float Temp_Hqisp[1..RC*MS*MT*PR];
execute{
  var count_Hqisp=0;
  var q,i,s,p;
  for(q in Q)
  {
    for(i in I)
    {
      for(s in S)
      {
        for(p in P)
        {
          count_Hqisp++;
          Temp_Hqisp[count_Hqisp]=Hqisp[q][i][s][p];
        }
      }
    }
  }
}

float Temp_BBop[1..PR*DMC];
execute{
  var count_BBop=0;
  var o,p;
  for(o in O)
  {
      for(p in P)
        {
          count_BBop++;
          Temp_BBop[count_BBop]=BBop[o][p];
        }
  }
}

float Temp_Xjp[1..PR*MF];
execute{
  var count_Xjp=0;
  var j,p;
  for(j in J)
  {
      for(p in P)
        {
          count_Xjp++;
          Temp_Xjp[count_Xjp]=Xjp[j][p];
        }
  }
}

float Temp_Ymp[1..PR*DS];
execute{
  var count_Ymp=0;
  var m,p;
  for(m in M)
  {
      for(p in P)
        {
          count_Ymp++;
          Temp_Ymp[count_Ymp]=Ymp[m][p];
        }
  }
}

float Temp_PPnp[1..PR*CC];
execute{
  var count_PPnp=0;
  var n,p;
  for(n in N)
  {
      for(p in P)
        {
          count_PPnp++;
          Temp_PPnp[count_PPnp]=PPnp[n][p];
        }
  }
}

float Temp_Top[1..PR*DMC];
execute{
  var count_Top=0;
  var o,p;
  for(o in O)
  {
      for(p in P)
        {
          count_Top++;
          Temp_Top[count_Top]=Top[o][p];
        }
  }
}

float Temp_Zqp[1..PR*RC];
execute{
  var count_Zqp=0;
  var q,p;
  for(q in Q)
  {
      for(p in P)
        {
          count_Zqp++;
          Temp_Zqp[count_Zqp]=Zqp[q][p];
        }
  }
}