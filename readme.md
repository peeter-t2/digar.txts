Use the following examples to use.


```
install.packages("remotes")
remotes::install_github("peeter-t2/digar.txts")

```

```
library(digar.txts)
```

Use get_digar_overview() to get data

```
all_issues <- get_digar_overview()
```

Build a custom subset through favourite tools
```
subset <- all_issues[stringr::str_detect(DocumentType,"NEWSPAPER")&year>1920&year<1940&keyid=="postimeesew"]
```

Get meta information on that subset
```
subset_meta <- get_subset_meta(subset)
#potentially write to file
#readr::write_tsv(subset_meta,"subset_meta_postimeesew1.tsv")

```

Do a search. This exports the search results into a file.
```
do_subset_search("oskar kallas", "results1.txt",subset)

```
