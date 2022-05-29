install.packages("BSDA")
install.packages("multcompView")
install.packages("ggplot2")
install.packages("devtools")
install.packages("readr")


library(readr)
library(ggplot2)
library(multcompView)
library(dplyr)
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

## a) Buatlah masing masing jenis spesies menjadi 3 subjek "Grup", lalu Gambarkan plot kuantil normal untuk setiap kelompok

### Ambil data pada dan inisialisasi pada variabel dataset
dataset <- read.table(url("https://rstatisticsandresearch.weebly.com/uploads/1/0/2/6/1026585/onewayanova.txt"))
dim(dataset)
head(dataset)
attach(dataset)

### Grup variabel dataset
dataset$V1 <- as.factor(dataset$V1)
dataset$V1 = factor(dataset$V1,labels = c("Kucing Oren","Kucing Hitam","Kucing Putih","Kucing Oren"))
class(dataset$V1)

### Bagi masing masing jenis spesies menjadi 3 grup
group1 <- subset(dataset, V1=="Kucing Oren")
group2 <- subset(dataset, V1=="Kucing Hitam")
group3 <- subset(dataset, V1=="Kucing Putih")

## b)

## c)

## d) 

## e)

## f)


# ----------------- Nomor 5 ---------------------


## a)  Plot sederhana untuk visualisasi data

### Membaca file GTL.csv
GTL <- read_csv("GTL.csv")
head(GTL)

str(GTL)

### Visualisasi menggunakan simple plot
qplot(x = Temp, y = Light, geom = "point", data = GTL) +
  facet_grid(.~Glass, labeller = label_both)

## b) uji ANOVA dua arah

### Membuat variabel as factor sebagai ANOVA
GTL$Glass <- as.factor(GTL$Glass)
GTL$Temp_Factor <- as.factor(GTL$Temp)
str(GTL)

### Analisis of variance
anova <- aov(Light ~ Glass*Temp_Factor, data = GTL)
summary(anova)

## c) Tampilkan tabel dengan mean dan standar deviasi keluaran cahaya

### Menampilkan tabel dengan mean dan sd
data_summary <- group_by(GTL, Glass, Temp) %>%
  summarise(mean=mean(Light), sd=sd(Light)) %>%
  arrange(desc(mean))
print(data_summary)

## d) Lakukan uji Tukey

### Uji Tukey
tukey <- TukeyHSD(anova)
print(tukey)

## f) Menunjukkan perbedaan signifikan antara uji Anova dan uji Tukey

### Menggunakan compact letter display
tukey.cld <- multcompLetters4(anova, tukey)
print(tukey.cld)

### Menambahkan compact letter display tersebut ke tabel
cld <- as.data.frame.list(tukey.cld$`Glass:Temp_Factor`)
data_summary$Tukey <- cld$Letters
print(data_summary)
