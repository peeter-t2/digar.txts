#' Do corpus search
#'
#' This function performs a search within the subset of the corpus files
#' @param searchterm Write the search term here. By default it is read as regular expressions.
#' @param searchfile Write the filename to store the results in.
#' @param subset Needs subset to be specified
#' @keywords data
#' @import data.table
#' @export
#' @examples
#' do_subset_search("oskar kallas","results1.txt",subset)
#'

do_subset_search <- function(searchterm = "oskar kallas",searchfile = "oskarkallas.txt",subset){
  subset <- data.table(subset)
  files <- subset[zippath_sections!="",unique(zippath_sections)]
  collectionname <- "/gpfs/hpc/projects/digar_txt/text"
  filelist <- paste0(collectionname,"/text_sections/", files)
  if(file.exists(searchfile)){system(paste0("rm ",searchfile))}
  for (seq in 0:floor(length(filelist)/1000)){
    system(paste0("for file in ", paste0(filelist[(1+1000*seq):min(length(filelist),(1000*(seq+1)))],collapse=" "),"; do unzip -c $file | grep -iE '",searchterm,"' >> ",searchfile,"; done"))
    system(paste0('printf "search \t $USER \t do search ', searchterm, ' in ' , length(filelist),' files \t" >> /gpfs/hpc/projects/digar_txt/appendOnly_testDir/log1.txt; date +"%Y-%m-%d %T" >> /gpfs/hpc/projects/digar_txt/appendOnly_testDir/log1.txt'))

  }
}
