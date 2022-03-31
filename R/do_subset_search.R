#' Do corpus search
#'
#' This function performs a search within the subset of the corpus files
#' @param searchterm Write the search term here. By default it is read as regular expressions.
#' @param searchfile Write the filename to store the results in.
#' @param subset Needs subset to be specified
#' @param source Either "sections" or "pages" based on what kind of input is expected.
#' @keywords data
#' @import data.table
#' @export
#' @examples
#' do_subset_search("oskar kallas","results1.txt",subset)
#'

do_subset_search <- function(searchterm = "oskar kallas",searchfile = "oskarkallas.txt",subset, source="sections",searchtype="text"){
  subset <- data.table(subset)
  mainpaper <- subset[,.N,keyid][order(-N)][1][,keyid]
  mainpaper_issues <- subset[,.N,keyid][order(-N)][1][,N]
  papers <- subset[,uniqueN(keyid)] -1
  minyear <- subset[,(min(year))]
  maxyear <- subset[,(max(year))]
  nissues <- nrow(subset)
  if(source == "sections"){
  files <- subset[zippath_sections!="",unique(zippath_sections)]
  collectionname <- "/gpfs/space/projects/digar_txt/text"
  filelist <- paste0(collectionname,"/text_sections/", files)
  if(searchtype=="lemmas"){  filelist <- paste0(collectionname,"/lemmas_sections/", files)}
  if(file.exists(searchfile)){system(paste0("rm ",searchfile))}
  for (seq in 0:floor(length(filelist)/1000)){
    system(paste0("for file in ", paste0(filelist[(1+1000*seq):min(length(filelist),(1000*(seq+1)))],collapse=" "),"; do unzip -c $file | grep -iE '",searchterm,"' >> ",searchfile,"; done"))
    system(paste0('printf "search \t $USER \t do search ', searchterm, ' in ' , length(filelist),' files: ', nissues, ' issues from ', minyear, ' to ', maxyear, ' in ', mainpaper, ' (', mainpaper_issues, ')', ' and ', papers, ' other papers' ,' \t" >> /gpfs/space/projects/digar_txt/logs/log1.txt; date +"%Y-%m-%d %T" >> /gpfs/space/projects/digar_txt/logs/log1.txt'))
  }
  }

  if(source == "pages"){
  files <- subset[zippath_pages!="",unique(zippath_pages)]
  collectionname <- "/gpfs/space/projects/digar_txt/text"
  filelist <- paste0(collectionname,"/text_pages/", files)
  if(searchtype=="lemmas"){  filelist <- paste0(collectionname,"/lemmas_pages/", files)}
  if(file.exists(searchfile)){system(paste0("rm ",searchfile))}
  for (seq in 0:floor(length(filelist)/1000)){
    system(paste0("for file in ", paste0(filelist[(1+1000*seq):min(length(filelist),(1000*(seq+1)))],collapse=" "),"; do unzip -c $file | grep -iE '",searchterm,"' >> ",searchfile,"; done"))
    system(paste0('printf "search \t $USER \t do search ', searchterm, ' in ' , length(filelist),' files: ', nissues, ' issues from ', minyear, ' to ', maxyear, ' in ', mainpaper, ' (', mainpaper_issues, ')', ' and ', papers, ' other papers' ,' \t" >> /gpfs/space/projects/digar_txt/logs/log1.txt; date +"%Y-%m-%d %T" >> /gpfs/space/projects/digar_txt/logs/log1.txt'))
  }

  }
}
