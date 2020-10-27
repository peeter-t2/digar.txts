#' Get corpus metadata
#'
#' This function allows you to express your love of cats.
#' @param metafilelist Needs to get the metafilelist from the subset.
#' @keywords data
#' @export
#' @examples
#' get_corpus_meta()
#'

get_corpus_meta <- function(metafilelist){
  subset_meta <<- data.table::rbindlist(lapply(paste0("unzip -p ",metafilelist), data.table::fread,fill=T),idcol=T)
  system(paste0('printf "setupmeta \t $USER \t got corpus meta ', length(metafilelist) ,' files \t" >> /gpfs/hpc/projects/digar_txt/appendOnly_testDir/log1.txt; date +"%Y-%m-%d %T" >> /gpfs/hpc/projects/digar_txt/appendOnly_testDir/log1.txt'))
}
