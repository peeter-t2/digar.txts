#' Get dataset overview function
#'
#' This function gets the most recent metadata from the file servers and stores it as a variable
#' @keywords data
#' @export
#' @examples
#' access_dataset()
#'

access_dataset <- function(){
  all_issues <<- data.table::fread("unzip -p /gpfs/hpc/projects/digar_txt/text/all_issues_access.zip",sep="\t")[access_now==T]
  if(nrow(all_issues)>100000){print("Issue metadata read")}
  system('printf "readmeta \t $USER \t read_all_issues_metadata \t" >> /gpfs/hpc/projects/digar_txt/appendOnly_testDir/log1.txt; date +"%Y-%m-%d %T" >> /gpfs/hpc/projects/digar_txt/appendOnly_testDir/log1.txt')

}
