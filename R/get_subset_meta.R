#' Get corpus metadata
#'
#' This function gets the metadata for the subset. Metadata is made into chunks by decade and publication.
#' @param subset Needs to get the subset metadata based on the subset.
#' @param source Either "sections" or "pages" based on what kind of input is expected.
#' @keywords data
#' @import data.table
#' @export
#' @examples
#' subset_meta <- get_subset_meta(subset)
#'

get_subset_meta <- function(subset, source="sections"){
  subset <- data.table(subset)
  mainpaper <- subset[,.N,keyid][order(-N)][1][,keyid]
  mainpaper_issues <- subset[,.N,keyid][order(-N)][1][,N]
  papers <- subset[,uniqueN(keyid)] -1
  minyear <- subset[,(min(year))]
  maxyear <- subset[,(max(year))]
  nissues <- nrow(subset)
  if(source == "sections"){
  metafiles <- subset[zippath_sections!="",unique(zippath_sections_meta)]
  collectionname <- "/gpfs/space/projects/digar_txt/text"
  metafilelist <- paste0(collectionname,"/meta_sections/", metafiles)
  subset_meta <- data.table::rbindlist(lapply(paste0("unzip -p ",metafilelist), function(x) data.table::fread(cmd=x,fill=T)),idcol=T)
  system(paste0('printf "setupmeta \t $USER \t got corpus meta sections ', length(metafilelist) ,' files: ', nissues, ' issues from ', minyear, ' to ', maxyear, ' in ', mainpaper, ' (', mainpaper_issues, ')', ' and ', papers, ' other papers' ,' \t" >> /gpfs/space/projects/digar_txt/logs/log1.txt; date +"%Y-%m-%d %T" >> /gpfs/space/projects/digar_txt/logs/log1.txt'))
  }
  if(source == "pages"){
  metafiles <- subset[zippath_pages!="",unique(zippath_pages_meta)]
  collectionname <- "/gpfs/space/projects/digar_txt/text"
  metafilelist <- paste0(collectionname,"/meta_pages/", metafiles)
  subset_meta <- data.table::rbindlist(lapply(paste0("unzip -p ",metafilelist), function(x) data.table::fread(cmd=x,fill=T)),idcol=T)
  system(paste0('printf "setupmeta \t $USER \t got corpus meta pages ', length(metafilelist) ,' files: ', nissues, ' issues from ', minyear, ' to ', maxyear, ' in ', mainpaper, ' (', mainpaper_issues, ')', ' and ', papers, ' other papers' ,' \t" >> /gpfs/space/projects/digar_txt/logs/log1.txt; date +"%Y-%m-%d %T" >> /gpfs/space/projects/digar_txt/logs/log1.txt'))
  }
  return(subset_meta)
}
