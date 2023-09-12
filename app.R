library(shiny)
library(visNetwork)
library(shinythemes)
library(DT)
library(igraph)
library(DiagrammeR)
library(collapsibleTree)
library(readxl)
library(MASS)
 deneme <- read_excel("map_data.xlsx")
# Son iki sütunu link olarak göstermek için fonksiyon
make_link <- function(x) {
  paste0("<a target = '_blank' href= ", x,">",x,"</a>")
}

# Son iki sütunu link formatına dönüştürme
deneme[, (ncol(deneme)-1):ncol(deneme)] <- lapply(deneme[, (ncol(deneme)-1):ncol(deneme)], make_link)

# Define the graph structure
#node graph and relationship structure
nodes <- data.frame(id = c("Intermediate", "Fructose and Galactose", "Glycogenesis and Glycogenolysis", "Pentose phosphate pathway", "Fatty acid","Glycoconjugates, lipids and glycolipids: sphingolipids and glycosphingolipids", "Cholesterol and steroid", "Amino acid metabolism", "Nucleotide", "Neurotransmitter", "Heme", "Thyroid hormone", "Fructose", "Galactose1", "Galactose2", "Galactose3", "Mannose", "Glucose", "Uridine", "Other", "Fructose-1-phosphate", "DHAP/Glyceraldehyde", "Glyceraldehyde 3-phosptae", "Glucose 6-phospahete", "Glucose 1-phosphate", "Uridine diphosphate", "Uridine triphosphate", "Glycogen", "Limit dextran","Oxidative", "6-Phosphogluconolactone", "6-Phosphogluconate", "Ribulose 5-phosphate", "Ribose 5-phosphate", "Nonoxidative", "Xylulose 5-phosphate", "Sedoheptulose 7-phosphate", "Erythrose 4-phosphate", "Synthesis", "Acetyl-CoA", "Malonyl-CoA", "Degradation", "Acyl-CoA", "Acetyl-CoA_2", "Peroxisomal","Phytol","Phytanic acid", "Phytanoyl-CoA", "Pristanic acid", "Propionyl-CoA","Other_","Mevalonic acid","Very long chain fatty acid","Galactose-1-phosphate_","Glucose 1-phosphate_", "Glucose 6-phosphate_","Fructose 6-phosphate_","Uridine diphosphate galactose","Uridine diphosphate glucose","Galactitol","Iditol","Mannose-6-phosphate", "Fructose_6-phosphate","Ceramide_","Ganglioside","_Other","ganglioside","globoside","sphingomyelin","sulfatide","sphingosine","Cerebroside","Galactocerebroside","Glucocerebroside","Lactosylceramide","GM1","GM2","GM3","GD2","Globotriaosylceramide","_Glucocerebroside","_Galactocerebroside","Ceramide","Sphingosine-1-phosphate","Mevalonate pathway","Non-mevalonate pathway","to Cholesterol","from Cholesterol to Steroid hormones","Nonhuman","to HMG-CoA","Ketone bodies","to DMAPP","Geranyl-","Carotenoid","_Acetyl-CoA","Acetoacetyl-CoA","HMB","HMB-CoA","HMG-CoA","Acetone","Acetoacetic acid","β-Hydroxybutyric acid","_Mevalonic acid","_Phosphomevalonic acid","_5-Diphosphomevalonic acid","_Isopentenyl pyrophosphate","_Dimethylallyl pyrophosphate","Geranyl pyrophosphate","Geranylgeranyl pyrophosphate","Prephytoene diphosphate","Phytoene","DOXP","MEP","CDP-ME","CDP-MEP","MEcPP","HMB-PP","IPP","DMAPP","Farnesyl pyrophosphate","Squalene","2,3-Oxidosqualene","Lanosterol","14-demethyllanosterol","4alpha-Methylzymosterol","Zymosterone","Zymosterol","Zymostenol","Lathosterol","7-Dehydrocholesterol","Cholesterol","Cholesta-7,24-dien-3-ol","7-Dehydrodesmosterol","Desmosterol","22R-Hydroxycholesterol","20α,22R-Dihydroxycholesterol","to Sitosterol","to Ergocalciferol","Cycloartenol","Cycloeucalenol","Obtusifoliol","4α-methylfecosterol","Isofucosterol","24-Methylenelophenol","Sitosterol","Phytosterols","Fecosterol","Episterol","Ergostatrienol","Ergostatetraenol","Ergosterol","Ergocalciferol","K→acetyl-CoA","G","Other__","lysine→","leucine→","tryptophan→alanine→","Saccharopine","Allysine","α-Aminoadipic acid","α-Ketoadipate","Glutaryl-CoA","Glutaconyl-CoA","Crotonyl-CoA","β-Hydroxybutyryl-CoA","β-Hydroxy β-methylbutyric acid","β-Hydroxy β-methylbutyryl-Co","AIsovaleryl-CoA","α-Ketoisocaproic acid","β-Ketoisocaproic acid","β-Ketoisocaproyl-CoA","β-Leucine","β-Methylcrotonyl-CoA" ,"β-Methylglutaconyl-CoA","β-Hydroxy β-methylglutaryl-CoA_","N′-Formylkynurenine","Kynurenine","Anthranilic acid","3-Hydroxykynurenine","3-Hydroxyanthranilic acid","2-Amino-3-carboxymuconic semialdehyde","2-Aminomuconic semialdehyde","2-Aminomuconic acid","Glutaryl_CoA","G→pyruvate→citrate","G→glutamate→α-ketoglutarate","G→propionyl-CoA→succinyl-CoA","G→fumarate","G→oxaloacetate","glycine→","serine→","3-Phosphoglyceric acid","glycine→creatine: Glycocyamine","Phosphocreatine","Creatinine","histidine→","proline→","arginine→","other__","Urocanic acid","Imidazol-4-one-5-propionic acid","Formiminoglutamic acid","Glutamate-1-semialdehyde","	
1-Pyrroline-5-carboxylic acid","Agmatine","Ornithine","Citrulline","Cadaverine","Putrescine","cysteine","glutamate","glutathione", "γ-Glutamylcysteine","valine→","isoleucine→","methionine→","threonine→","propionyl-CoA→","α-Ketoisovaleric acid","Isobutyryl-CoA","Methacrylyl-CoA","3-Hydroxyisobutyryl-CoA","3-Hydroxyisobutyric acid","2-Methyl-3-oxopropanoic acid","	2,3-Dihydroxy-3-methylpentanoic acid","2-Methylbutyryl-CoA","Tiglyl-CoA","2-Methylacetoacetyl-CoA","generation of homocysteine:"," S-Adenosyl methionine","S-Adenosyl-l-homocysteine","Homocysteine","conversion to cysteine:","Cystathionine","α-Ketobutyric acid","Cysteine","α-Ketobutyric acid_","	Methylmalonyl-CoA","phenylalanine→tyrosine→","4-Hydroxyphenylpyruvic acid","Homogentisic acid","4-Maleylacetoacetic acid","urea cycle","Cysteine metabolism","Cysteine sulfinic acid","purine metabolism","pyrimidine metabolism","anabolism_","catabolism_","R5P→IMP:","IMP→AMP:","IMP→GMP:","Ribose 5-phosphate (R5P)","Phosphoribosyl pyrophosphate (PRPP)","Phosphoribosylamine (PRA)","Glycineamide ribonucleotide (GAR)","Phosphoribosyl-N-formylglycineamide (FGAR)","5′-Phosphoribosylformylglycinamidine (FGAM)","5-Aminoimidazole ribotide (AIR)","5′-Phosphoribosyl-4-carboxy-5-aminoimidazole (CAIR)","Phosphoribosylaminoimidazolesuccinocarboxamide (SAICAR)","AICA ribonucleotide (AICAR)","5-Formamidoimidazole-4-carboxamide ribotide (FAICAR)","	Adenylosuccinate","	Xanthosine monophosphate","5-Hydroxyisourate","Hypoxanthine","Uric acid","Xanthine","anabolism","catabolism","Carbamoyl aspartic acid","Carbamoyl phosphate","4,5-Dihydroorotic acid","Orotic acid","Orotidine 5'-monophosphate","Uridine monophosphate","uracil","thymine:","β-Alanine","Dihydrouracil","3-Ureidopropionic acid","3-Aminoisobutyric acid","Dihydrothymine","β-Ureidoisobutyric acid","catecholamines","tryptophan→serotonin","serotonin→melatonin","Anabolism(tyrosine→epinephrine)","Catabolism/metabolites","Tyrosine"," Levodopa", "Dopamine","Norepinephrine","Epinephrine","dopamine:","norepinephrine:","epinephrine:","DOPAL","DOPAC","MOPET","Hydroxytyrosol","3-Methoxytyramine","Homovanillic acid","_anabolism","_catabolism","5-Hydroxytryptophan","5-Hydroxyindoleacetic acid","Normelatonin","Porphyrin biosynthesis","Heme degradation and excretion","early mitochondrial:","cytosolic:","late mitochondrial:","D-Aminolevulinic acid","Porphobilinogen","Hydroxymethylbilane","Uroporphyrinogen III","Coproporphyrinogen III","Protoporphyrinogen IX","Protoporphyrin IX","Breakdown of heme","Intestine, excretion in feces","Kidney, excretion in urine","spleen:","blood:","liver:","heme","Biliverdin","Bilirubin","bilirubin","Albumin","Bilirubin glucuronide","Bilirubin diglucuronide","Stercobilinogen","Stercobilin","Urobilinogen","Urobilin","Tyrosine / iodotyrosine","Thyronine / iodothyronine","Thyronamine / iodothyronamine","Iodothyroacetate / iodothyroacetic acid","3-Iodotyrosine","Diiodotyrosine","3'-Monoiodothyronine","3,3'-Diiodothyronine","3,5-Diiodothyronine","3,3',5-Triiodothyronine (T3)","3,3',5'-Triiodothyronine (Reverse T3)","3,5,3',5'-Tetraiodothyronine (Thyroxine, T4)","3-Iodothyronamine","3,3',5-Triiodothyronamine","Triiodothyroacetate (TRIAC)"),
                    
                    label = c("Intermediate", "Fructose and Galactose","Glycogenesis and Glycogenolysis","Pentose phosphate pathway", "Fatty acid","Glycoconjugates, lipids and glycolipids: sphingolipids and glycosphingolipids", "Cholesterol and steroid", "Amino acid metabolism", "Nucleotide", "Neurotransmitter", "Heme", "Thyroid hormone", "Fructose", "Galactose1", "Galactose2", "Galactose3", "Mannose", "Glucose", "Uridine", "Other","Fructose-1-phosphate", "DHAP/Glyceraldehyde", "Glyceraldehyde 3-phosptae","Glucose 6-phospahete", "Glucose 1-phosphate", "Uridine diphosphate", "Uridine triphosphate", "Glycogen", "Limit dextran","Oxidative", "6-Phosphogluconolactone", "6-Phosphogluconate", "Ribulose 5-phosphate", "Ribose 5-phosphate", "Nonoxidative", "Xylulose 5-phosphate", "Sedoheptulose 7-phosphate", "Erythrose 4-phosphate","Synthesis", "Acetyl-CoA", "Malonyl-CoA","Degradation","Acyl-CoA","Acetyl-CoA_2","Peroxisomal","Phytol","Phytanic acid", "Phytanoyl-CoA", "Pristanic acid", "Propionyl-CoA","Other_","Mevalonic acid","Very long chain fatty acid","Galactose-1-phosphate_","Glucose 1-phosphate_", "Glucose 6-phosphate_","Fructose 6-phosphate_","Uridine diphosphate galactose","Uridine diphosphate glucose","Galactitol","Iditol","Mannose-6-phosphate","Fructose_6-phosphate","Ceramide_","Ganglioside","_Other","ganglioside","globoside","sphingomyelin","sulfatide","sphingosine","Cerebroside","Galactocerebroside","Glucocerebroside","Lactosylceramide","GM1","GM2","GM3","GD2","Globotriaosylceramide","_Glucocerebroside","_Galactocerebroside","Ceramide","Sphingosine-1-phosphate","Mevalonate pathway","Non-mevalonate pathway","to Cholesterol","from Cholesterol to Steroid hormones","Nonhuman","to HMG-CoA","Ketone bodies","to DMAPP","Geranyl-","Carotenoid","_Acetyl-CoA","Acetoacetyl-CoA","HMB","HMB-CoA","HMG-CoA","Acetone","Acetoacetic acid","β-Hydroxybutyric acid","_Mevalonic acid","_Phosphomevalonic acid","_5-Diphosphomevalonic acid","_Isopentenyl pyrophosphate","_Dimethylallyl pyrophosphate","Geranyl pyrophosphate","Geranylgeranyl pyrophosphate","Prephytoene diphosphate","Phytoene","DOXP","MEP","CDP-ME","CDP-MEP","MEcPP","HMB-PP","IPP","DMAPP","Farnesyl pyrophosphate","Squalene","2,3-Oxidosqualene","Lanosterol","14-demethyllanosterol","4alpha-Methylzymosterol","Zymosterone","Zymosterol","Zymostenol","Lathosterol","7-Dehydrocholesterol","Cholesterol","Cholesta-7,24-dien-3-ol","7-Dehydrodesmosterol","Desmosterol","22R-Hydroxycholesterol","20α,22R-Dihydroxycholesterol","to Sitosterol","to Ergocalciferol","Cycloartenol","Cycloeucalenol","Obtusifoliol","4α-methylfecosterol","Isofucosterol","24-Methylenelophenol","Sitosterol","Phytosterols","Fecosterol","Episterol","Ergostatrienol","Ergostatetraenol","Ergosterol","Ergocalciferol","K→acetyl-CoA","G","Other__","lysine→","leucine→","tryptophan→alanine→","Saccharopine","Allysine","α-Aminoadipic acid","α-Ketoadipate","Glutaryl-CoA","Glutaconyl-CoA","Crotonyl-CoA","β-Hydroxybutyryl-CoA","β-Hydroxy β-methylbutyric acid","β-Hydroxy β-methylbutyryl-Co","AIsovaleryl-CoA","α-Ketoisocaproic acid","β-Ketoisocaproic acid","β-Ketoisocaproyl-CoA","β-Leucine","β-Methylcrotonyl-CoA","β-Methylglutaconyl-CoA","β-Hydroxy β-methylglutaryl-CoA_","N′-Formylkynurenine","Kynurenine","Anthranilic acid","3-Hydroxykynurenine","3-Hydroxyanthranilic acid","2-Amino-3-carboxymuconic semialdehyde","2-Aminomuconic semialdehyde","2-Aminomuconic acid","Glutaryl_CoA","G→pyruvate→citrate","G→glutamate→α-ketoglutarate","G→propionyl-CoA→succinyl-CoA","G→fumarate","G→oxaloacetate","glycine→","serine→","3-Phosphoglyceric acid","glycine→creatine: Glycocyamine","Phosphocreatine","Creatinine","histidine→","proline→","arginine→","other__","Urocanic acid","Imidazol-4-one-5-propionic acid","Formiminoglutamic acid","Glutamate-1-semialdehyde","	
1-Pyrroline-5-carboxylic acid","Agmatine","Ornithine","Citrulline","Cadaverine","Putrescine","cysteine","glutamate","glutathione", "γ-Glutamylcysteine","valine→","isoleucine→","methionine→","threonine→","propionyl-CoA→","α-Ketoisovaleric acid","Isobutyryl-CoA","Methacrylyl-CoA","3-Hydroxyisobutyryl-CoA","3-Hydroxyisobutyric acid","2-Methyl-3-oxopropanoic acid","	2,3-Dihydroxy-3-methylpentanoic acid","2-Methylbutyryl-CoA","Tiglyl-CoA","2-Methylacetoacetyl-CoA","generation of homocysteine:"," S-Adenosyl methionine","S-Adenosyl-l-homocysteine","Homocysteine","conversion to cysteine:","Cystathionine","α-Ketobutyric acid","Cysteine","α-Ketobutyric acid_","	Methylmalonyl-CoA","phenylalanine→tyrosine→","4-Hydroxyphenylpyruvic acid","Homogentisic acid","4-Maleylacetoacetic acid","urea cycle","Cysteine metabolism","Cysteine sulfinic acid","purine metabolism","pyrimidine metabolism","anabolism_","catabolism_","R5P→IMP:","IMP→AMP:","IMP→GMP:","Ribose 5-phosphate (R5P)","Phosphoribosyl pyrophosphate (PRPP)","Phosphoribosylamine (PRA)","Glycineamide ribonucleotide (GAR)","Phosphoribosyl-N-formylglycineamide (FGAR)","5′-Phosphoribosylformylglycinamidine (FGAM)","5-Aminoimidazole ribotide (AIR)","5′-Phosphoribosyl-4-carboxy-5-aminoimidazole (CAIR)","Phosphoribosylaminoimidazolesuccinocarboxamide (SAICAR)","AICA ribonucleotide (AICAR)","5-Formamidoimidazole-4-carboxamide ribotide (FAICAR)","	Adenylosuccinate","	Xanthosine monophosphate","5-Hydroxyisourate","Hypoxanthine","Uric acid","Xanthine","anabolism","catabolism","Carbamoyl aspartic acid","Carbamoyl phosphate","4,5-Dihydroorotic acid","Orotic acid","Orotidine 5'-monophosphate","Uridine monophosphate","uracil","thymine:","β-Alanine","Dihydrouracil","3-Ureidopropionic acid","3-Aminoisobutyric acid","Dihydrothymine","β-Ureidoisobutyric acid","catecholamines","tryptophan→serotonin","serotonin→melatonin","Anabolism(tyrosine→epinephrine)","Catabolism/metabolites","Tyrosine"," Levodopa", "Dopamine","Norepinephrine","Epinephrine","dopamine:","norepinephrine:","epinephrine:","DOPAL","DOPAC","MOPET","Hydroxytyrosol","3-Methoxytyramine","Homovanillic acid","_anabolism","_catabolism","5-Hydroxytryptophan","5-Hydroxyindoleacetic acid","Normelatonin","Porphyrin biosynthesis","Heme degradation and excretion","early mitochondrial:","cytosolic:","late mitochondrial:","D-Aminolevulinic acid","Porphobilinogen","Hydroxymethylbilane","Uroporphyrinogen III","Coproporphyrinogen III","Protoporphyrinogen IX","Protoporphyrin IX","Breakdown of heme","Intestine, excretion in feces","Kidney, excretion in urine","spleen:","blood:","liver:","heme","Biliverdin","Bilirubin","bilirubin","Albumin","Bilirubin glucuronide","Bilirubin diglucuronide","Stercobilinogen","Stercobilin","Urobilinogen","Urobilin","Tyrosine / iodotyrosine","Thyronine / iodothyronine","Thyronamine / iodothyronamine","Iodothyroacetate / iodothyroacetic acid","3-Iodotyrosine","Diiodotyrosine","3'-Monoiodothyronine","3,3'-Diiodothyronine","3,5-Diiodothyronine","3,3',5-Triiodothyronine (T3)","3,3',5'-Triiodothyronine (Reverse T3)","3,5,3',5'-Tetraiodothyronine (Thyroxine, T4)","3-Iodothyronamine","3,3',5-Triiodothyronamine","Triiodothyroacetate (TRIAC)"))


edges <- data.frame(from = c("Intermediate", "Intermediate", "Intermediate", "Intermediate","Intermediate","Intermediate","Intermediate","Intermediate","Intermediate","Intermediate","Intermediate","Fructose and Galactose", "Fructose and Galactose", "Fructose and Galactose", "Fructose and Galactose","Fructose and Galactose","Glycogenesis and Glycogenolysis","Glycogenesis and Glycogenolysis","Glycogenesis and Glycogenolysis","Fructose", "Fructose-1-phosphate", "DHAP/Glyceraldehyde","Glucose", "Glucose 6-phospahete", "Uridine", "Uridine diphosphate", "Other","Glycogen","Pentose phosphate pathway", "Oxidative", "6-Phosphogluconolactone", "6-Phosphogluconate","Ribulose 5-phosphate", "Pentose phosphate pathway","Nonoxidative", "Xylulose 5-phosphate", "Sedoheptulose 7-phosphate","Fatty acid","Synthesis", "Acetyl-CoA", "Fatty acid", "Degradation", "Acyl-CoA","Fatty acid", "Peroxisomal", "Phytol", "Phytanic acid", "Phytanoyl-CoA", "Pristanic acid","Peroxisomal","Other_","Mevalonic acid","Galactose1","Galactose-1-phosphate_","Glucose 1-phosphate_", "Glucose 6-phosphate_","Galactose2","Uridine diphosphate galactose","Galactose3","Galactitol","Mannose","Mannose-6-phosphate","Glycoconjugates, lipids and glycolipids: sphingolipids and glycosphingolipids","Glycoconjugates, lipids and glycolipids: sphingolipids and glycosphingolipids","Glycoconjugates, lipids and glycolipids: sphingolipids and glycosphingolipids","Ganglioside","Ganglioside","Ganglioside","Ganglioside","Ganglioside","Ceramide_","Cerebroside","Cerebroside","Galactocerebroside","Glucocerebroside","ganglioside","GM1","GM2","GM3","globoside","sphingomyelin","sulfatide","sphingosine","_Other","Cholesterol and steroid","Cholesterol and steroid","Cholesterol and steroid","Cholesterol and steroid","Cholesterol and steroid","Mevalonate pathway","Mevalonate pathway","Mevalonate pathway","Mevalonate pathway","Mevalonate pathway","to HMG-CoA","_Acetyl-CoA","Acetoacetyl-CoA","HMB","HMB-CoA","Ketone bodies","Acetone","Acetoacetic acid","to DMAPP","_Mevalonic acid","_Phosphomevalonic acid","_5-Diphosphomevalonic acid","_Isopentenyl pyrophosphate","Geranyl-","Geranyl pyrophosphate","Carotenoid","Prephytoene diphosphate","Non-mevalonate pathway","DOXP","MEP","CDP-ME","CDP-MEP","MEcPP","HMB-PP","IPP","to Cholesterol","Farnesyl pyrophosphate","Squalene","2,3-Oxidosqualene","Lanosterol","14-demethyllanosterol","4alpha-Methylzymosterol","Zymosterone","Zymosterol","Zymostenol","Lathosterol","7-Dehydrocholesterol","Zymosterol","Cholesta-7,24-dien-3-ol","7-Dehydrodesmosterol","Desmosterol","from Cholesterol to Steroid hormones","22R-Hydroxycholesterol","Nonhuman","Nonhuman","to Sitosterol","Cycloartenol","Cycloeucalenol","Obtusifoliol","4α-methylfecosterol","Isofucosterol","24-Methylenelophenol","Sitosterol","to Ergocalciferol","Fecosterol","Episterol","Ergostatrienol","Ergostatetraenol","Ergosterol","Amino acid metabolism","Amino acid metabolism","Amino acid metabolism","K→acetyl-CoA","K→acetyl-CoA","K→acetyl-CoA","lysine→","Saccharopine","Allysine","α-Aminoadipic acid","α-Ketoadipate","Glutaryl-CoA","Glutaconyl-CoA","Crotonyl-CoA","β-Hydroxy β-methylbutyric acid","leucine→","β-Hydroxy β-methylbutyryl-Co","AIsovaleryl-CoA","α-Ketoisocaproic acid","β-Ketoisocaproic acid","β-Ketoisocaproyl-CoA","β-Leucine","β-Methylcrotonyl-CoA","β-Methylglutaconyl-CoA","tryptophan→alanine→","N′-Formylkynurenine","Kynurenine","Anthranilic acid","3-Hydroxykynurenine","3-Hydroxyanthranilic acid","2-Amino-3-carboxymuconic semialdehyde","2-Aminomuconic semialdehyde","2-Aminomuconic acid","G","G","G","G","G","G→pyruvate→citrate","G→pyruvate→citrate","glycine→","serine→","glycine→creatine: Glycocyamine","Phosphocreatine","G→glutamate→α-ketoglutarate","G→glutamate→α-ketoglutarate","G→glutamate→α-ketoglutarate","G→glutamate→α-ketoglutarate","histidine→","Urocanic acid","Imidazol-4-one-5-propionic acid","Formiminoglutamic acid","proline→","arginine→","Agmatine","Ornithine","Citrulline","Cadaverine","Other__","Other__","cysteine","glutamate","glutathione","G→propionyl-CoA→succinyl-CoA","G→propionyl-CoA→succinyl-CoA","G→propionyl-CoA→succinyl-CoA","G→propionyl-CoA→succinyl-CoA","G→propionyl-CoA→succinyl-CoA","valine→","α-Ketoisovaleric acid","Isobutyryl-CoA","Methacrylyl-CoA","3-Hydroxyisobutyryl-CoA","3-Hydroxyisobutyric acid","isoleucine→","	2,3-Dihydroxy-3-methylpentanoic acid","2-Methylbutyryl-CoA","Tiglyl-CoA","methionine→","methionine→","generation of homocysteine:"," S-Adenosyl methionine","S-Adenosyl-l-homocysteine","conversion to cysteine:","Cystathionine","α-Ketobutyric acid","threonine→","propionyl-CoA→","G→fumarate","phenylalanine→tyrosine→","4-Hydroxyphenylpyruvic acid","Homogentisic acid","G→oxaloacetate","Other__","Cysteine metabolism","Nucleotide","Nucleotide","purine metabolism","purine metabolism","anabolism_","anabolism_","anabolism_","R5P→IMP:","Ribose 5-phosphate (R5P)","Phosphoribosyl pyrophosphate (PRPP)","Phosphoribosylamine (PRA)","Glycineamide ribonucleotide (GAR)","Phosphoribosyl-N-formylglycineamide (FGAR)","5′-Phosphoribosylformylglycinamidine (FGAM)","5-Aminoimidazole ribotide (AIR)","5′-Phosphoribosyl-4-carboxy-5-aminoimidazole (CAIR)","Phosphoribosylaminoimidazolesuccinocarboxamide (SAICAR)","AICA ribonucleotide (AICAR)","IMP→AMP:","IMP→GMP:","catabolism_","5-Hydroxyisourate","Hypoxanthine","Uric acid","pyrimidine metabolism","pyrimidine metabolism","anabolism","Carbamoyl aspartic acid","Carbamoyl phosphate","4,5-Dihydroorotic acid","Orotic acid","Orotidine 5'-monophosphate","catabolism","catabolism","uracil","β-Alanine","Dihydrouracil","catabolism","3-Aminoisobutyric acid","Dihydrothymine","Neurotransmitter","Neurotransmitter","Neurotransmitter","catecholamines","catecholamines","Anabolism(tyrosine→epinephrine)","Tyrosine"," Levodopa", "Dopamine","Norepinephrine","Catabolism/metabolites","Catabolism/metabolites","Catabolism/metabolites","dopamine:","DOPAL","DOPAC","MOPET","Hydroxytyrosol","3-Methoxytyramine","tryptophan→serotonin","tryptophan→serotonin","_anabolism","_catabolism","serotonin→melatonin","Heme","Heme","Porphyrin biosynthesis","Porphyrin biosynthesis","Porphyrin biosynthesis","early mitochondrial:","cytosolic:","Porphobilinogen","Hydroxymethylbilane","Uroporphyrinogen III","late mitochondrial:","Protoporphyrinogen IX","Heme degradation and excretion","Heme degradation and excretion","Heme degradation and excretion","Breakdown of heme","Breakdown of heme","Breakdown of heme","spleen:","heme","Biliverdin","blood:","bilirubin","liver:","Bilirubin glucuronide","Intestine, excretion in feces","Stercobilinogen","Stercobilin","Kidney, excretion in urine","Thyroid hormone","Thyroid hormone","Thyroid hormone","Thyroid hormone","Tyrosine / iodotyrosine","3-Iodotyrosine","3'-Monoiodothyronine","Thyronine / iodothyronine","3,3'-Diiodothyronine","3,5-Diiodothyronine","3,3',5-Triiodothyronine (T3)","3,3',5'-Triiodothyronine (Reverse T3)","Thyronamine / iodothyronamine","3-Iodothyronamine","Iodothyroacetate / iodothyroacetic acid"),
                    
                    to = c("Fructose and Galactose", "Glycogenesis and Glycogenolysis", "Pentose phosphate pathway", "Fatty acid","Glycoconjugates, lipids and glycolipids: sphingolipids and glycosphingolipids", "Cholesterol and steroid", "Amino acid metabolism", "Nucleotide", "Neurotransmitter", "Heme", "Thyroid hormone","Fructose", "Galactose1", "Galactose2", "Galactose3", "Mannose","Glucose", "Uridine", "Other", "Fructose-1-phosphate", "DHAP/Glyceraldehyde", "Glyceraldehyde 3-phosptae","Glucose 6-phospahete", "Glucose 1-phosphate", "Uridine diphosphate", "Uridine triphosphate", "Glycogen", "Limit dextran", "Oxidative", "6-Phosphogluconolactone", "6-Phosphogluconate", "Ribulose 5-phosphate", "Ribose 5-phosphate","Nonoxidative","Xylulose 5-phosphate", "Sedoheptulose 7-phosphate", "Erythrose 4-phosphate","Synthesis", "Acetyl-CoA", "Malonyl-CoA", "Degradation", "Acyl-CoA", "Acetyl-CoA_2","Peroxisomal","Phytol","Phytanic acid", "Phytanoyl-CoA", "Pristanic acid", "Propionyl-CoA","Other_","Mevalonic acid","Very long chain fatty acid","Galactose-1-phosphate_","Glucose 1-phosphate_", "Glucose 6-phosphate_","Fructose 6-phosphate_","Uridine diphosphate galactose","Uridine diphosphate glucose","Galactitol","Iditol","Mannose-6-phosphate","Fructose_6-phosphate","Ceramide_","Ganglioside","_Other","ganglioside","globoside","sphingomyelin","sulfatide","sphingosine","Cerebroside","Galactocerebroside","Glucocerebroside","Lactosylceramide","Lactosylceramide","GM1","GM2","GM3","GD2","Globotriaosylceramide","_Glucocerebroside","_Galactocerebroside","Ceramide","Sphingosine-1-phosphate","Mevalonate pathway","Non-mevalonate pathway","to Cholesterol","from Cholesterol to Steroid hormones","Nonhuman","to HMG-CoA","Ketone bodies","to DMAPP","Geranyl-","Carotenoid","_Acetyl-CoA","Acetoacetyl-CoA","HMB","HMB-CoA","HMG-CoA","Acetone","Acetoacetic acid","β-Hydroxybutyric acid","_Mevalonic acid","_Phosphomevalonic acid","_5-Diphosphomevalonic acid","_Isopentenyl pyrophosphate","_Dimethylallyl pyrophosphate","Geranyl pyrophosphate","Geranylgeranyl pyrophosphate","Prephytoene diphosphate","Phytoene","DOXP","MEP","CDP-ME","CDP-MEP","MEcPP","HMB-PP","IPP","DMAPP","Farnesyl pyrophosphate","Squalene","2,3-Oxidosqualene","Lanosterol","14-demethyllanosterol","4alpha-Methylzymosterol","Zymosterone","Zymosterol","Zymostenol","Lathosterol","7-Dehydrocholesterol","Cholesterol","Cholesta-7,24-dien-3-ol","7-Dehydrodesmosterol","Desmosterol","Cholesterol","22R-Hydroxycholesterol","20α,22R-Dihydroxycholesterol","to Sitosterol","to Ergocalciferol","Cycloartenol","Cycloeucalenol","Obtusifoliol","4α-methylfecosterol","Isofucosterol","24-Methylenelophenol","Sitosterol","Phytosterols","Fecosterol","Episterol","Ergostatrienol","Ergostatetraenol","Ergosterol","Ergocalciferol","K→acetyl-CoA","G","Other__" ,"lysine→","leucine→","tryptophan→alanine→","Saccharopine","Allysine","α-Aminoadipic acid","α-Ketoadipate","Glutaryl-CoA","Glutaconyl-CoA","Crotonyl-CoA","β-Hydroxybutyryl-CoA","β-Hydroxy β-methylbutyric acid","β-Hydroxy β-methylbutyryl-Co","AIsovaleryl-CoA","α-Ketoisocaproic acid","β-Ketoisocaproic acid","β-Ketoisocaproyl-CoA","β-Leucine","β-Methylcrotonyl-CoA","β-Methylglutaconyl-CoA","β-Hydroxy β-methylglutaryl-CoA_","N′-Formylkynurenine","Kynurenine","Anthranilic acid","3-Hydroxykynurenine","3-Hydroxyanthranilic acid","2-Amino-3-carboxymuconic semialdehyde","2-Aminomuconic semialdehyde","2-Aminomuconic acid","Glutaryl_CoA","G→pyruvate→citrate","G→glutamate→α-ketoglutarate","G→propionyl-CoA→succinyl-CoA","G→fumarate","G→oxaloacetate","glycine→","serine→","3-Phosphoglyceric acid","glycine→creatine: Glycocyamine","Phosphocreatine","Creatinine","histidine→","proline→","arginine→","other__","Urocanic acid","Imidazol-4-one-5-propionic acid","Formiminoglutamic acid","Glutamate-1-semialdehyde","	
1-Pyrroline-5-carboxylic acid","Agmatine","Ornithine","Citrulline","Cadaverine","Putrescine","cysteine","glutamate","glutathione","glutathione","γ-Glutamylcysteine","valine→","isoleucine→","methionine→","threonine→","propionyl-CoA→","α-Ketoisovaleric acid","Isobutyryl-CoA","Methacrylyl-CoA","3-Hydroxyisobutyryl-CoA","3-Hydroxyisobutyric acid","2-Methyl-3-oxopropanoic acid","	2,3-Dihydroxy-3-methylpentanoic acid","2-Methylbutyryl-CoA","Tiglyl-CoA","2-Methylacetoacetyl-CoA","generation of homocysteine:","conversion to cysteine:"," S-Adenosyl methionine","S-Adenosyl-l-homocysteine","Homocysteine","Cystathionine","α-Ketobutyric acid","Cysteine","α-Ketobutyric acid_","	Methylmalonyl-CoA","phenylalanine→tyrosine→","4-Hydroxyphenylpyruvic acid","Homogentisic acid","4-Maleylacetoacetic acid","urea cycle","Cysteine metabolism","Cysteine sulfinic acid","purine metabolism","pyrimidine metabolism","anabolism_","catabolism_","R5P→IMP:","IMP→AMP:","IMP→GMP:","Ribose 5-phosphate (R5P)","Phosphoribosyl pyrophosphate (PRPP)","Phosphoribosylamine (PRA)","Glycineamide ribonucleotide (GAR)","Phosphoribosyl-N-formylglycineamide (FGAR)","5′-Phosphoribosylformylglycinamidine (FGAM)","5-Aminoimidazole ribotide (AIR)","5′-Phosphoribosyl-4-carboxy-5-aminoimidazole (CAIR)","Phosphoribosylaminoimidazolesuccinocarboxamide (SAICAR)","AICA ribonucleotide (AICAR)","5-Formamidoimidazole-4-carboxamide ribotide (FAICAR)","	Adenylosuccinate","	Xanthosine monophosphate","5-Hydroxyisourate","Hypoxanthine","Uric acid","Xanthine","anabolism","catabolism","Carbamoyl aspartic acid","Carbamoyl phosphate","4,5-Dihydroorotic acid","Orotic acid","Orotidine 5'-monophosphate","Uridine monophosphate","uracil","thymine:","β-Alanine","Dihydrouracil","3-Ureidopropionic acid","3-Aminoisobutyric acid","Dihydrothymine","β-Ureidoisobutyric acid","catecholamines","tryptophan→serotonin","serotonin→melatonin","Anabolism(tyrosine→epinephrine)","Catabolism/metabolites","Tyrosine"," Levodopa", "Dopamine","Norepinephrine","Epinephrine","dopamine:","norepinephrine:","epinephrine:","DOPAL","DOPAC","MOPET","Hydroxytyrosol","3-Methoxytyramine","Homovanillic acid","_anabolism","_catabolism","5-Hydroxytryptophan","5-Hydroxyindoleacetic acid","Normelatonin","Porphyrin biosynthesis","Heme degradation and excretion","early mitochondrial:","cytosolic:","late mitochondrial:","D-Aminolevulinic acid","Porphobilinogen","Hydroxymethylbilane","Uroporphyrinogen III","Coproporphyrinogen III","Protoporphyrinogen IX","Protoporphyrin IX","Breakdown of heme","Intestine, excretion in feces","Kidney, excretion in urine","spleen:","blood:","liver:","heme","Biliverdin","Bilirubin","bilirubin","Albumin","Bilirubin glucuronide","Bilirubin diglucuronide","Stercobilinogen","Stercobilin","Urobilinogen","Urobilin","Tyrosine / iodotyrosine","Thyronine / iodothyronine","Thyronamine / iodothyronamine","Iodothyroacetate / iodothyroacetic acid","3-Iodotyrosine","Diiodotyrosine","3'-Monoiodothyronine","3,3'-Diiodothyronine","3,5-Diiodothyronine","3,3',5-Triiodothyronine (T3)","3,3',5'-Triiodothyronine (Reverse T3)","3,5,3',5'-Tetraiodothyronine (Thyroxine, T4)","3-Iodothyronamine","3,3',5-Triiodothyronamine","Triiodothyroacetate (TRIAC)"))

# Create the igraph object
graph <- graph_from_data_frame(edges, vertices = nodes)

# Define the UI
ui <- fluidPage(
  
  theme = shinytheme("united"),
  navbarPage(
    "IntermedMap Project",
    tabPanel("Dashboard",
             fluidRow(
               column(10, offset = 1,
                      h3("Welcome to IntermedMap Project"),
                      p("This is a dashboard for exploring intermediates."),
                      p("(Zoom in-out)")
                      
               ),
               br(),
               br(),
               br(),
               visNetworkOutput("network"),
               align = "center"
             )
    ),
    tabPanel("Intermed",fluidPage(
      sidebarLayout(
        sidebarPanel(
          selectInput("secim", "Choose Intermediate:", choices = deneme[, 5])
        ),
        mainPanel(
          tabsetPanel(
            tabPanel("Search", 
                     tabsetPanel(
                       tabPanel("Introduction", DT::dataTableOutput("introduction")),
                       
                       tabPanel("Information", dataTableOutput("information")),
                       
                     )
            ))
        )
      )
    )
    ),
    tabPanel("Map",
             fluidRow(
               column(width = 12,
                      collapsibleTreeOutput("tree", height="950px")
               )
             )
    ),
    # visNetworkOutput("network")
    
    
    tabPanel("Data",
             h3("Intermediate Pathway Data"),
             p("In this page you can find information about; Cas Number, IUPAC Name, Class, Subclass, Pathway Name, Previous-Next Intermediate, Chemical Formula, Chemical Structure (2D and 3D) "),
             align = "center",
             DT::dataTableOutput("dataTable")),
    
              
    
    tabPanel("Team",
             fluidRow( titlePanel("TEAM"),
                       mainPanel(
                         grVizOutput("orgChart")
                       ),
                       h3("Contributor Team"),
                       p("'Rukiye Akarsu'
                       'Ertuğrul Akçakoca'
                       'Sümeyya Akkum'
'Nusaibah Tawfik Ahmed Al-Sanabani'
'Zeynep Arıcan'
'Zeynep Arslan'
'Fatima Ashumova'
'Sarah Olohitae Atane'
'Fuat Avci'
'Mine Nur Ayten'
'Havva Berre Ayvaz'
'Ebrar Beceren'
'Rümeyse Beyan'
'Fatma Beğendik'
'Pinar Biraderoğlu'
'Emine Bulut'
'Ayçanil Bölük'
'Ömer Faruk Demir'
'Aleyna Erakcaoğlu'
'Nurzülal Erden'
'Maryam Hammou'
'Hanife Kantarcı'
'Güneş Sıdıka Karataş
''Mustafa Emre Korkmaz'
'Ayşe Hamide Köse'
'Ümmü Eylül Muku'
'Tuğba Okur'
'Damla Puçak'
'Nargiz Rustamova'
'Elif Sarıalan'
'Şeyma Sağlam'
'Seda Nur Serbest'
'Saima Shabir'
'Gizem Sude Yalçın'
'Neslihan Yavrum'
'Esma İrem Yıldırım'
'Hilal Yıldız'
'Gamze Yılmaz'
'Hatice Yılmaz'
'Senanur Yüksel'
'Onur Çakıcı'
'Enes Çakmak'
'Başak Çelebi'
'Elif Rümeyse Özsoy'
'Simay Öztürk'
'Leyla Gül Şahin
'")
                       ,
                       align = "center"
             )
    ),
    tabPanel("Contact",
             fluidRow(
               column(10, offset = 1,
                      h3("Contact Information"),
                      p("Please feel free to reach out to us for any inquiries or feedback."),
                      p("E-mail: irem.kahveci@agu.edu.tr"),
                      p("E-mail: hamdifurkan.kepenek@agu.edu.tr"),
                      br(),
                      br(),
                      h3("Advisor"),
                      p("Prof Dr. Alaattin Şen"),
                      p("E-mail: sena@agu.edu.tr")
               ),
               align = "center"
             )
    )
  )
)

# Define the server
server <- function(input, output, session) {
  # Intermediate data
  intermediate_data <- data.frame(
    id = c("A", "B", "C", "D", "E"),
    label = c("Intermediate A", "Intermediate B", "Intermediate C", "Intermediate D", "Intermediate E"),
    structure = c("Structure-A", "Structure-B", "Structure-C", "Structure-D", "Structure-E"),
    id_name = c("Number-A", "Number-B", "Number-C", "Number-D", "Number-E"),
    iupac_name = c("Name-A", "Name-B", "Name-C", "Name-D", "Name-E"),
    relationship = c("Direct", "Direct", "Direct", "Indirect", "Direct")
  )
  #collapsible tree
  {
    output$tree <- renderCollapsibleTree({
      pathway <- deneme[, c(4, 6, 5)]
      collapsibleTree(pathway, hierarchy = c("Class", "Pathway_Name", "Subclass"),  width = 1000,
                      height = 8500, collapsed = TRUE)
    })
  }
  #team info
  
  {
    output$orgChart <- renderGrViz({
      grViz("digraph {
      node [shape = 'rectangle'];
      Advisor [label = 'Advisor: Alaattin Şen'];
      BioinformaticsTeam [label = 'Bioinformatics Team'];
      ContributorTeam [label = 'Contributor Team'];
      İremKahveci [label = 'İrem Kahveci'];
      HFKepenek [label = 'Hamdi Furkan Kepenek'];
    
      
      Advisor -> {BioinformaticsTeam ContributorTeam};
      BioinformaticsTeam -> {İremKahveci HFKepenek};
    }")
    })
  }
  
  # Define the output network
  output$network <- renderVisNetwork({
    # Create the network graph
    visIgraph(graph) %>% visLayout(randomSeed = 123) %>%
      visOptions(height = '225%', manipulation = TRUE)  # Enable dragging and repositioning of nodes
  })
  
  # Generate the information table for the selected intermediate
  output$intermed_table <- renderDataTable({
    selected_node <- visNetworkProxy("network") %>% visGetSelectedNodes()
    if (length(selected_node) > 0) {
      # Placeholder values for Structure, ID, and IUPAC.Name
      structure_info <- c("Structure-1", "Structure-2", "Structure-3")
      id_info <- c("ID-1", "ID-2", "ID-3")
      iupac_info <- c("IUPAC.Name-1", "IUPAC.Name-2", "IUPAC.Name-3")
      
      node_data <- intermediate_data[intermediate_data$id == selected_node, ]
      table_data <- data.frame(
        Structure = structure_info,
        ID = id_info,
        `IUPAC Name` = iupac_info
      )
      table_data
    }
  })
  #excel file in info tab
  {
    output$veri_tablosu <- renderDataTable({
      secilen_deger <- input$secim
      secilen_satirlar <- which(secilen_veri[, 5] == secilen_deger)
      secilen_veri_tablo <- secilen_veri[secilen_satirlar, ]
      
      secilen_veri_tablo$Chemical_Structure <- sapply(secilen_veri_tablo$Chemical_Structure, function(x) {
        if (grepl("^http", x)) {
          paste0('<a href="', x, '" target="_blank">', x, '</a>')
        } else {
          x
        }
      })
      
      secilen_veri_tablo$`3D_Structure` <- sapply(secilen_veri_tablo$`3D_Structure`, function(x) {
        if (grepl("^http", x)) {
          paste0('<a href="', x, '" target="_blank">', x, '</a>')
        } else {
          x
        }
      })
      
      datatable(secilen_veri_tablo, escape = FALSE)
    })
  }
  #intermed table get
  # Seçilen değerin bulunduğu satırın 1. sütunu
  secilenSutun1 <- reactive({
    secilen <- deneme[deneme[, 5] == input$secim, 1]  # 1. sütunu al
    secilen <- na.omit(secilen)  # NA değerleri içeren satırları kaldır
    secilen <- secilen[!is.na(secilen)]  # İçeriği bulunmayan satırları kaldır
    secilen
  })
  #
  secilenSutun1 <- reactive({
    secilen_deger <- input$secim
    secilen_satirlar <- which(deneme[, 5] == secilen_deger)
    
    secilen_veri_tablo <- deneme[secilen_satirlar, -1]  # 1. sütunu hariç al
    
    secilen_veri_tablo
  })
  # Genel çıktı
  output$introduction <- DT::renderDataTable({
    secilen_deger <- input$secim
    secilen_satirlar <- which(deneme[, 5] == secilen_deger)
    
    secilen_veri_tablo <- deneme[secilen_satirlar, 1]  # Sadece 1. sütunu al
    
    datatable(secilen_veri_tablo)
  })
  
  # Ayrıntı çıktı
  output$information <- DT::renderDataTable({
    secilen_deger <- input$secim
    secilen_satirlar <- which(deneme[, 5] == secilen_deger)
    
    secilen_veri_tablo <- deneme[secilen_satirlar, -1]  # 1. sütunu hariç al
    
    
    secilen_veri_tablo[, 10] <- sapply(secilen_veri_tablo[, 10], function(x) {
      if (grepl("^https", x)) {
        paste0('<a href="', x, '" target="_blank">', x, '</a>')
      } else {
        x
      }
    })
    
    secilen_veri_tablo[, 9] <- sapply(secilen_veri_tablo[, 9], function(x) {
      if (grepl("^https", x)) {
        paste0('<a href="', x, '" target="_blank">', x, '</a>')
      } else {
        x
      }
    })
    
    datatable(secilen_veri_tablo, escape = FALSE)
  })
  
  # Generate the information table for the selected intermediate in the Info tab
  output$info_table <- renderDataTable({
    selected_node <- visNetworkProxy("network") %>% visGetSelectedNodes()
    if (length(selected_node) > 0) {
      # Placeholder values for the intermediate information
      iupac <- c("irem", "furkan")
      pathway_name <- c("Pathway Name Text")
      previous_intermediate <- c("Previous Intermediate Text")
      next_intermediate <- c("Next Intermediate Text")
      cas_number <- c("CAS Number Text")
      chemical_formula <- c("Chemical Formula Text")
      chemical_structure <- c("Chemical Structure Text")
      structure_3d <- c("3D Structure Text")
      
      info_data <- data.frame(
        IUPAC = iupac,
        Pathway_Name = pathway_name,
        Previous_Intermediate = previous_intermediate,
        Next_Intermediate = next_intermediate,
        CAS_Number = cas_number,
        Chemical_Formula = chemical_formula,
        Chemical_Structure = chemical_structure,
        `3D_Structure` = structure_3d
      )
      info_data
    }
  })
  #data part
  output$dataTable <- DT::renderDataTable(
    deneme[, -1], escape = FALSE,
    options = list(
      dom = 'Bfrtip',
      buttons = list(
        list(extend = 'pdf', className = 'btn btn-primary buttons-pdf')
      )
    )
  )
  # Redirect to Intermed tab when an intermediate is clicked in Map tab
  observeEvent(input$network_selected, {
    if (!is.null(input$network_selected$nodes)) {
      updateNavbarPage(session, "IntermedMap Project", selected = "Intermed")
    }
  })
}

# Run the app
shinyApp(ui, server)