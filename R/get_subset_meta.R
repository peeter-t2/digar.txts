#' Get corpus metadata
#'
#' This function gets the metadata for the subset. Metadata is made into chunks by decade and publication.
#' @param subset Needs to get the subset from the subset.
#' @keywords data
#' @import data.table
#' @export
#' @examples
#' subset_meta <- get_subset_meta(subset)
#'

get_subset_meta <- function(subset){
  subset <- data.table(subset)
  mainpaper <- subset[,.N,keyid][order(-N)]
  papers <- subset[,uniqueN(keyid)] -1
  minyear <- subset[,(min(year))]
  maxyear <- subset[,(max(year))]
  nissues <- nrow(subset)
  metafiles <- subset[zippath_sections!="",unique(zippath_sections_meta)]
  collectionname <- "/gpfs/hpc/projects/digar_txt/text"
  metafilelist <- paste0(collectionname,"/meta_sections/", metafiles)
  subset_meta <- data.table::rbindlist(lapply(paste0("unzip -p ",metafilelist), function(x) data.table::fread(cmd=x,fill=T)),idcol=T)
  system(paste0('printf "setupmeta \t $USER \t got corpus meta ', length(metafilelist) ,' files:', nissues, " issues from", minyear, " to ", maxyear, " in ", mainpaper, " and ", papers, " other papers" ,'\t" >> /gpfs/hpc/projects/digar_txt/appendOnly_testDir/log1.txt; date +"%Y-%m-%d %T" >> /gpfs/hpc/projects/digar_txt/appendOnly_testDir/log1.txt'))
  return(subset_meta)
}
