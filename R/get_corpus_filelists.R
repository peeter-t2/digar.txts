#' Get corpus filelists
#'
#' This function allows you to express your love of cats.
#' @param subset Needs a subset file as input. Make this by selecting the required rows from the whole metadata file.
#' @keywords data
#' @export
#' @examples
#' get_corpus_filelists(subset)
#'

get_corpus_filelists <-  function(subset){
  files <- subset[zippath_sections!="",unique(zippath_sections)]
  collectionname <- "/gpfs/hpc/projects/digar_txt/text"
  filelist <<- paste0(collectionname,"/text_sections/", files)
  metafiles <- subset[zippath_sections!="",unique(zippath_sections_meta)]
  metafilelist <<- paste0(collectionname,"/meta_sections/", metafiles)
  rm(files,metafiles)
  system(paste0('printf "setupsubset \t $USER \t setsubset ', nrow(subset) ,' issues \t" >> /gpfs/hpc/projects/digar_txt/appendOnly_testDir/log1.txt; date +"%Y-%m-%d %T" >> /gpfs/hpc/projects/digar_txt/appendOnly_testDir/log1.txt'))

}
