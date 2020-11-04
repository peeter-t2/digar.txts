# Accessing National Library texts

Use the following examples to use.

```
#Install package remotes, if needed. JupyterLab should have it.
#install.packages("remotes")

#Since the JypiterLab does not have access to all the files, we specify a local folder for our packages.
dir.create("R_pckg")
remotes::install_github("peeter-t2/digar.txts",lib="~/R_pckg/",upgrade="never")
```

```
#We also use the same local folder name when reading this installed package.
library(digar.txts,lib.loc="~/R_pckg/")
```

Use get_digar_overview() to get data.

```
all_issues <- get_digar_overview()
```

Build a custom subset through favourite tools.
```
subset  <- all_issues %>%
    filter(DocumentType=="NEWSPAPER") %>%
    filter(year>1920&year<1940) %>%
    filter(keyid=="postimeesew")
```

Get meta information on that subset.
```
subset_meta <- get_subset_meta(subset)
#potentially write to file, for easier access if returning to it
#readr::write_tsv(subset_meta,"subset_meta_postimeesew1.tsv")
#subset_meta <- readr::read_tsv("subset_meta_postimeesew1.tsv")

```

Do a search. This exports the search results into a file.
```
do_subset_search("lurich", "lurich1.txt",subset)

```

Read the results of the text search.

```
texts <- fread("lurich1.txt",header=F)[,.(id=V1,txt=V2)]
```

Get concordances from the set of files returned.

```
concs <- get_concordances("[Ll]urich",texts,30,30,"txt","id")

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
