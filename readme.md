# Accessing National Library texts

## Setting up in the JupyterLab environment

- Go to webpage jupyter.hpc.ut.ee/, log in. 
- Pick the first (default) option, with 1 CPU core, 8Gb memory, 6h timelimit.
- Create new python notebook, set Kernel as R.

## Contents

The library access package is comprised of 4 native commands and a file system.
- get_digar_overvew() - gives overview of the collection (issue-level)
- get_subset_meta() - gives metainformation of the subset (article-level)
- do_subset_search() - does a search on the subset and prints results to file
- get_concordances() - gets word-in-context within the search results

Any R packages can be used to manipulate the packages in the meanwhile. The native commands are based on the data.table package.

---

## Starting up

1) First, install the required package

```
#Install package remotes, if needed. JupyterLab should have it.
#install.packages("remotes")

#Since the JypiterLab that we use does not have write-access to 
#all the files, we specify a local folder for our packages.
dir.create("R_pckg")
remotes::install_github("peeter-t2/digar.txts",lib="~/R_pckg/",upgrade="never")
```

2) Activate the package that was installed, use 
```
library(digar.txts,lib.loc="~/R_pckg/")
```

3) Use get_digar_overview() to get overview of the collections (issue-level).

```
all_issues <- get_digar_overview()
```

4) Build a custom subset through any tools in R. Here is a tidyverse style example.
```
subset <- all_issues %>%
    filter(DocumentType=="NEWSPAPER") %>%
    filter(year>1880&year<1940) %>%
    filter(keyid=="postimeesew")

```

5) Get meta information on that subset with get_subset_meta(). If this information is reused, sometimes storing the data is useful wth the commented lines.
```
subset_meta <- get_subset_meta(subset)
#potentially write to file, for easier access if returning to it
#readr::write_tsv(subset_meta,"subset_meta_postimeesew1.tsv")
#subset_meta <- readr::read_tsv("subset_meta_postimeesew1.tsv")
```

6) Do a search with do_subset_search(). This exports the search results into a file. do_subset_search() ignores case.
```
do_subset_search(searchterm="lurich", searchfile="lurich1.txt",subset)
```

7) Read the search results. Use any R tools. It's useful to name the id and text columns id and txt.
```
texts <- fread("lurich1.txt",header=F)[,.(id=V1,txt=V2)]
```

8) Get concordances using the get_concordances() command 
```
concs <- get_concordances(searchterm="[Ll]urich",texts=texts,before=30,after=30,txt="txt",id="id")
```



#### Convenience suggestion

To use ctrl-shift-m to make %>% function in the JupyterLab as in RStudio, add this code in Settings -> Advanced Settings Editor... -> Keyboard Shortcuts, on the left in the User Preferences box.

```
{
    "shortcuts": [
         {
            "command": "notebook:replace-selection",
            "selector": ".jp-Notebook",
            "keys": ["Ctrl Shift M"],
            "args": {"text": '%>% '}
        }
    ]
}

```
