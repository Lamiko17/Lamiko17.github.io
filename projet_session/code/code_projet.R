# Code(s) pour pojet fin de session : 

# 1. Import des données : 

# Charger les données IPC (Transparency International)
ipc <- read.csv("data/ipc_rdc.csv")

# Charger les données IIAG (Mo Ibrahim Foundation)
iiag <- read.csv("data/iiag_online.csv")

# Afficher les premières lignes pour vérifier
head(ipc)
head(iiag)


# 2. Préparation des données IIAG :

library(tidyverse)

# Renommer les colonnes
colnames(iiag) <- c(
  "localisation",
  "X2014", "X2015", "X2016", "X2017",
  "X2018", "X2019", "X2020", "X2021", "X2022", "X2023",
  "changement"
)

# Transformer au format long
iiag_long <- iiag %>%
  pivot_longer(
    cols = starts_with("X"),
    names_to  = "annee",
    values_to = "score"
  ) %>%
  mutate(
    annee = as.numeric(gsub("X", "", annee))
  )

# 3. Graphique IPC : 

library(ggplot2)

ggplot(ipc, aes(x = annee, y = ipc_score)) +
  geom_line(color = "#0072B2", size = 1.2) +
  geom_point(size = 2) +
  theme_minimal() +
  labs(
    title = "Évolution de l’Indice de Perception de la Corruption (RDC, 2012–2024)",
    x = "Année",
    y = "Score IPC (0–100, plus élevé = moins corrompu)"
  )

# 4. Graphique IIAG : 
groupes <- c(
  "CEDEAO",
  "Afrique Centrale",
  "Republique democratique du Congo"
)

iiag_comp <- iiag_long %>% 
  filter(localisation %in% groupes)

ggplot(iiag_comp, aes(x = annee, y = score, color = localisation)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  theme_minimal() +
  labs(
    title = "Comparaison du score IIAG : RDC vs Afrique Centrale vs CEDEAO (2014–2023)",
    x = "Année",
    y = "Score IIAG (0–100)",
    color = "Localisation"
  )