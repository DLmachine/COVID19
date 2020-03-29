# Julia COVID 19 Data Analusis
# Isaac Weintraub MAR 2020

#;`git submodule add https://github.com/CSSEGISandData/COVID-19.git`
#;`git submodule add https://github.com/datasets/population.git`
;`git submodule update --remote`
Pkg.add("CSV")
pops = CSV.File(population/data/population);