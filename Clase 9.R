  # CLASE 9 #
# Primero hicimos tres ejercicios del apartado if else en NOTAS DE R.

# Has u codigo que determine el pH
readline(prompt = "Escribe el valor del pH de tu muestra:") -> pH
pH<-as.numeric(pH) #siempre cambiar el tipo de caracter, en este caso necesito que sea numerico.

if(pH < 7 & pH >= 1) {
  print("Tu pH es acido")
} else if (pH > 7 & pH <= 14) {
  print("Tu pH es basico")
} else if (pH == 7) {
  print("Tu pH es neutro")
}

# Determina la cantidad de GC en bacterias
# descomprimiendo
unzip("/Users/ivanjacobo/Desktop/NCBI roberto/ncbi_dataset.zip",
      exdir = "/Users/ivanjacobo/Desktop/NCBI roberto")
unzip("/Users/ivanjacobo/Desktop/NCBI roberto/ncbi_dataset_E.coliK-12.zip",
      exdir = "/Users/ivanjacobo/Desktop/NCBI roberto")
list.files("/Users/ivanjacobo/Desktop/NCBI roberto")
readDNAStringSet("/Users/ivanjacobo/Desktop/NCBI roberto/ncbi_dataset/data/GCA_000005845.2/GCA_000005845.2_ASM584v2_genomic.fna")

readline(prompt = "Ingresa la ruta del archivo de tu secuencia (sin comillas):") -> Ruta
readDNAStringSet(Ruta) -> Mi_secuencia
Mi_secuencia

if (width(Mi_secuencia) > 1) {
  frecuencia_CG <- letterFrequency(Mi_secuencia, "CG")
  print(paste("La frecuencia de CG en tu secuencia es:", frecuencia_CG))
} # Tengo que complementar. Para sacar el procentaje de GC tengo que dividir GC sobre ATGC,
# y el resultado será el procentaje de GC en mi secuencia

# CORRECCIÓN

if (width(Mi_secuencia) > 1) {
  frecuencia_CG <- letterFrequency(Mi_secuencia, "CG")
  frecuencia_ACGT <- letterFrequency(Mi_secuencia, "ACGT")
  porcentaje_CG <- frecuencia_CG/frecuencia_CG
} else if (porcentaje_CG < 0.5 ) {
  print("Tu proporcion de CG es menor al 50%")
} else if (porcentaje_CG == 0.5) {
  print("Tu porcentaje de GC es del 50%")
} else if (porcentaje_CG > 0.5) {
  print("Tu porcentaje de GC es mayor")
}

print(paste("La frecuencia de CG en tu secuencia es:", frecuencia_CG/frecuencia_ACGT))


# Un codigo que me diga si un hongo es patogeno, es patogeno si crece a 37 ºC

readline(prompt = "Ingrese la temperatura a la que su hongo crece optimamente:") -> Temperatura

if (Temperatura == 37) {
  print("Tu hongo es patogeno")
} else {
  print("Tu hongo no es patogeno")
}

# chose file: abre una ventana que me permite burcar archivos

direccion_globinas_roberto <- file.choose()
print(direccion_globinas_roberto)

readDNAStringSet(direccion_globinas_roberto)[[1]]

readAAStringSet(direccion_globinas_roberto) -> globinas
msa(globinas, method = "Muscle")


# TRABAJANDO con GENOMAS -------------------------------------- #
library(BSgenome)
available.genomes()
BiocManager::install("el nombre del genoma que quiero")
library("del genoma que quiero")
# con $ puedo seleccionar un elemenbto particular del archivo  exportarlo a otro objeto.

BiocManager::install("msa")
a

readDNAStringSet(cepas)
cepas


library(msa)

# CONVIRTIENDO SECUENCIAS DE E. COLI A AMINOACIDOS # 
alphabetFrequency(Escherichia_coli_536)
translate(Escherichia_coli_536) -> proteina_536
print(proteina_536)

alphabetFrequency(Escherichia_coli_ATCC_8739)
translate(Escherichia_coli_ATCC_8739) -> proteina_8739
print(proteina_8739)

alphabetFrequency(Escherichia_coli_O139_H28_str._E24377A)
translate(Escherichia_coli_O139_H28_str._E24377A) -> proteina_E24377A
print(proteina_E24377A)

# Reemplazar '*' con '-' para indicar gaps en el alineamiento
proteina_536 <- gsub("\\*", "-", proteina_536)
proteina_8739 <- gsub("\\*", "-", proteina_8739)
proteina_E24377A <- gsub("\\*", "-", proteina_E24377A)

# Crear el objeto AAStringSet de nuevo
proteinas_juntas <- AAStringSet(c(proteina_536, proteina_8739, proteina_E24377A))
proteinas_juntas
msa(proteinas_juntas)


# USANDO SECUENCIAS DE GLOBINAS DE ROBERTO #
file.choose() -> ubicacion_globinas
readAAStringSet(ubicacion_globinas) -> globinas
globinas

msa(globinas, method = "Muscle") -> globinas_alineadas
globinas_alineadas
class(globinas_alineadas)

AAStringSet(globinas_alineadas)


















AAStringSet(c(proteina_536, proteina_8739, proteina_E24377A)) -> proteinas_juntas
msa(proteinas_juntas, method = "Muscle")

class(proteinas_juntas)
print(proteinas_juntas)

writeXStringSet(proteinas_juntas, "output.fasta") -> listo_alinear
class(listo_alinear)

# pienso que el problema esta en el msa, como o estoy especificand nada
# quiza esta haciendo un alineamiento que no peremite la entrada de aminoacidos...

msa(listo_alinear)