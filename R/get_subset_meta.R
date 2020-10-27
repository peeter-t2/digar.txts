#' Get corpus metadata
#'
#' This function allows you to express your love of cats.
#' @param subset Needs to get the subset from the subset.
#' @keywords data
#' @export
#' @examples
#' subset_meta <- get_subset_meta(subset)
#'

get_subset_meta <- function(subset){
  metafiles <- subset[zippath_sections!="",unique(zippath_sections_meta)]
  metafilelist <- paste0(collectionname,"/meta_sections/", metafiles)
  subset_meta <- data.table::rbindlist(lapply(paste0("unzip -p ",metafilelist), data.table::fread,fill=T),idcol=T)
  system(paste0('printf "setupmeta \t $USER \t got corpus meta ', length(metafilelist) ,' files \t" >> /gpfs/hpc/projects/digar_txt/appendOnly_testDir/log1.txt; date +"%Y-%m-%d %T" >> /gpfs/hpc/projects/digar_txt/appendOnly_testDir/log1.txt'))
  return(subset_meta)
}
