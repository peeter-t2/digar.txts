#' Do corpus search
#'
#' This function allows you to express your love of cats.
#' @param searchterm Write the search term here. By default it is read as regular expressions.
#' @param searchfile Write the filename to store the results in.
#' @param filelist It needs the filelist for raw texts as input too.
#' @keywords data
#' @export
#' @examples
#' do_corpus_search("oskar kallas","results1.txt")
#'

do_corpus_search <- function(searchterm = "oskar kallas",searchfile = "results1.txt",filelist=filelist){
  if(file.exists(searchfile)){system(paste0("rm ",searchfile))}
  for (seq in 0:floor(length(filelist)/1000)){
    system(paste0("for file in ", paste0(filelist[(1+1000*seq):min(length(filelist),(1000*(seq+1)))],collapse=" "),"; do unzip -c $file | grep -iE '",searchterm,"' >> ",searchfile,"; done"))
    system(paste0('printf "search \t $USER \t do search ', searchterm, ' in ' , length(filelist),' files \t" >> /gpfs/hpc/projects/digar_txt/appendOnly_testDir/log1.txt; date +"%Y-%m-%d %T" >> /gpfs/hpc/projects/digar_txt/appendOnly_testDir/log1.txt'))

  }
}
