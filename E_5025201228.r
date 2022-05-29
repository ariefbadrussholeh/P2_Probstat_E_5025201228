install.packages("BSDA")

library(BSDA)

# ------------------- Nomor 1 -----------------------

## a) Standar Deviasi dari data selisih pasangan pengamatan tabel
### Kadar saturasi oksigen sebelum aktivitas A
x = c(78, 75, 67, 77, 70, 72, 78, 74, 77)   ;x

### Kadar saturasi oksigen sebelum aktivitas B
y = c(100, 95, 70, 90, 90, 90, 89, 90, 100) ;y

### Menghitung standar deviasi data selisih
sd = sd(y-x) ;sd

## b) Nilai t (p-value)
t.test(x,y,paired = TRUE,var.equal = var(x) == var(y))

## c) Penjelasan di Github


# ----------------- -Nomor 2 --------------------
## Diketahui :
mu = 20000
n = 100
sd = 3900
mean = 23500

## a) Apakah setuju dengan klaim?

### Uji tolak H0
z = (mean-mu)/(sd/sqrt(n)) ;z

a = 5/100
z.a = qnorm(1-a) ;z.a

z > z.a
### Setuju, penjelasan di Github

## b) Maksud dari output

zsum.test(mean.x = mean, sigma.x = sd, n.x = n, alternative = "greater", mu = mu,
          conf.level = 0.95)
### Penjelasan di Github

## c) Kesimpulan dari p-value

### Menghitung nilai pvalue
pvalue = pnorm(-abs(z)) ;pvalue
### Kesimpulan di github


# ----------------- Nomor 3 ---------------------

## a) H0 dan H1

### Hipotesis Awal H0 : "Rata-rata saham di bandung sama dengan di Bali".
### Hipotesis alternatif H1 : "Rata-rata saham di bandung tidak sama dengan di Bali"

## b) Hitung Sampel Statistik

### Diketahui:
nBd  = 19
nBl  = 27
mBd  = 3.64
mBl  = 2.79
sdBd = 1.67
sdBl = 1.32

### Hitung sampel statistik
tsum.test(mean.x=mBd, s.x = sdBd, n.x = nBd, mean.y =mBl , s.y = sdBl, 
          n.y = nBl, alternative = "two.side", var.equal = TRUE)

## c) Lakukan Uji Statistik (df =2)

### Diketahui:
alpha = 0.05
df = 2

### Uji statistik
t.tabel = qt(p=alpha/2,df=df,lower.tail = FALSE) ;t.tabel

## d) Nilai kritikal
sp = sqrt(((nBd-1)*sdBd^2 + (nBl-1)*sdBl^2)/(df)) ;sp
t.value = (mBd-mBl)/(sp*sqrt((1/nBd)+(1/nBl))) ;t.value

## e) Keputusan
### Penjelasan di Github

## f) Kesimpulan
### Penjelasan di Github

# ----------------- Nomor 4 ---------------------

# ----------------- Nomor 5 ---------------------