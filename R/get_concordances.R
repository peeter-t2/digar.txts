#' Get concordances
#'
#' This function gets he concordances.
#' @param searchterm Write the search term here. By default it is read as regular expressions.
#' @param searchfile Write the filename to store the results in.
#' @param subset Needs subset to be specified
#' @keywords data
#' @import data.table
#' @export
#' @examples
#' get_concordances("searchterm",texts,30,30,"txt","id")
#'

get_concordances <- function(searchterm,texts,before=30,after=30,txtcolumn="txt",idcolumn="id"){
  names(texts)[names(texts)==txtcolumn] <- "txt"
  names(texts)[names(texts)==idcolumn] <- "id"
  texts <- data.table(texts)
  texts[,txt:=paste0(paste0(rep("-",before),collapse=""),txt,paste0(rep("-",after),collapse=""))]
  found_index <- texts[, .(locs=unlist(str_locate_all(txt,searchterm))),by=id]#[order(locs),.SD,by=eval(idcolumn)]
  found_index[,var:=rep(c("begin","end"),nrow(texts)/2)]
  found_index[,nr:=ceiling(seq_len(.N)/2),by=id]
  found_index_dcast <- dcast(found_index,id+nr~var,value.var = "locs")
  searching <- merge(texts,found_index_dcast,by="id")
  searching[,context:=substr(txt,begin-before,end+after)]
  export_concs <- searching[,-c("txt")]
  return(export_concs)
}
