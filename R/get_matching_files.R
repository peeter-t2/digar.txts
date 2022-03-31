#' Do corpus search
#'
#' This function gets either text or lemma data based on ids
#' @param fileids_w_meta the table to use for fileids.Must have zippath_sections, zippath_pages, keyid, year, month.
#' @param outputfile Write the filename to store the results in.
#' @param source Either "sections" or "pages" based on what kind of input is expected.
#' @param extracttype Either "text" or "lemmas" based on what kind of texts you want to extract.
#' @keywords data
#' @import data.table
#' @export
#' @examples
#' get_matching_files(fileds_w_meta, "results2.txt","sections","text")
#'

get_matching_files <- function (fileids_w_meta, outputfile = "file2.txt", 
                                source = "sections", extracttype = "text") {
  
  collectionname <- "/gpfs/space/projects/digar_txt/text"
  if(extracttype=="text"){
    if(source=="sections"){
      fileids_w_meta[,fullpath:=paste0(collectionname, "/text_sections/",zippath_sections)]
    }
    if(source=="pages"){
      fileids_w_meta[,fullpath:=paste0(collectionname, "/text_pages/",zippath_pages)]
    }
  }
  if(extracttype=="lemmas"){
    if(source=="sections"){
      fileids_w_meta[,fullpath:=paste0(collectionname, "/lemmas_sections/",zippath_sections)]
    }
    if(source=="pages"){
      fileids_w_meta[,fullpath:=paste0(collectionname, "/lemmas_pages/",zippath_pages)]
    }
  }
  fileids_w_meta[,inzippath:=paste0(keyid,"/",year,"/",month,"/",id)]
  fileids_for_extract <- fileids_w_meta[,.(inzipfiles =paste0(inzippath,collapse= " ")),.(fullpath)]
  system(paste0("rm ", outputfile))
  
  for (i in 1:nrow(fileids_for_extract)){
    system(paste0("echo ", fileids_for_extract[i,inzipfiles], "| xargs unzip -p ", fileids_for_extract[i,fullpath], " >> ", outputfile))
    #slower option not in use.
    # system(paste0("unzip -p ",texts_w_meta3[i,fullpath], " ", texts_w_meta3[i,inzippath], " >> ", outputfile))
    
  }
  
}