lpo = read.csv("2 LCN-003169 130G-LP (v36) - Copy.csv", header = TRUE)
TV_uwant <- "DM-000064"
#merge column 2 6 7 17 18 8
lpo2 <- cbind(lpo[2],lpo[17],lpo[18],lpo[6],lpo[7],lpo[11],lpo[8])
lpo2[is.na(lpo2)] <- ""
#str(lpo2)
###or replace same col
lpo2$Layer.Category <- gsub("Cadence Auxiliary", "", lpo2$Layer.Category)
lpo2$Layer.Category <- gsub("Generated Mask", "", lpo2$Layer.Category)
#str(lpo2)
lpo2 <- cbind(lpo2[1:4],
paste(lpo2$Layer.Category,lpo2$Layer.Sub.Category,sep=""),
lpo2[6])
colnames(lpo2)[5] <- c("Layer.Category")
colnames(lpo2)[6] <- c("TV")
#str(lpo2)
table(lpo2$Layer.Category)
#write.csv(x = lpo2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo2.csv", sep = "") )
#filter Tech Variant != blank
lpo2_22fdx <- lpo2[lpo2[6]!="", ]
#str(lpo2_22fdx)
#grep dataframe contain keywords
lpo2_22fdx <- lpo2_22fdx[grep(TV_uwant, lpo2_22fdx$TV),]
#str(lpo2_22fdx)
##or grep contain
###lpo2_22fdx <- lpo2_22fdx[grep("28SLPHV", lpo2_22fdx$TV),]
##or grep not SLPHV
#lpo2_22fdx <- lpo2_22fdx[grep("28SLPHV", lpo2_22fdx$TV, invert = TRUE),]
#filter Layer Status == Active
lpo2_22fdx_act <- lpo2_22fdx[lpo2_22fdx[4]=="Active", ]
#filter new Layer Category != 
lpo2_22fdx_act_cate <- lpo2_22fdx_act[lpo2_22fdx_act[5]!="", ]
#lpo2_22fdx_act_cate <- lpo2_22fdx_act[lpo2_22fdx_act[5]!="Cadence Auxiliary", ]
#lpo2_22fdx_act_cate <- lpo2_22fdx_act_cate[lpo2_22fdx_act_cate[5]!="Generated Mask", ]
#lpo2_22fdx_act_cate <- lpo2_22fdx_act_cate[lpo2_22fdx_act_cate[5]!="Unknown", ]
#write.csv(x = lpo2_22fdx_act_cate, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo2_22fdx_act_cate.csv", sep = "") )
#re-bind 3 columns
lpo2_22fdx_act_cate_3cols <- cbind(lpo2_22fdx_act_cate[1],lpo2_22fdx_act_cate[2],lpo2_22fdx_act_cate[3])
#remove duplicates
lpo2_22fdx_act_cate_dedup <- unique(lpo2_22fdx_act_cate_3cols) 
#re-order col 2 & 3
lpo2_22fdx_act_cate_dedup <- lpo2_22fdx_act_cate_dedup[ order(lpo2_22fdx_act_cate_dedup[,2], lpo2_22fdx_act_cate_dedup[,3]), ]
#remove last row -> why?
#lpo2_22fdx_act_cate_dedup <- lpo2_22fdx_act_cate_dedup[-dim(lpo2_22fdx_act_cate_dedup)[1],]
#will rbind c("Customer_Reserved_layers", "2000-2300", "0-9999")
last_row <- matrix(c("Customer_Reserved_layers", "2000-2300", "0-9999"), nrow = 1)
colnames(last_row) <- colnames(lpo2_22fdx_act_cate_dedup)
allowlayer1 <- rbind(lpo2_22fdx_act_cate_dedup, last_row)
write.csv(x = allowlayer1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_allow_layer_ans.csv", sep = "") )
#do summary table
#sum_count <- rbind( dim(lpo2_22fdx),dim(lpo2_22fdx_act),dim(lpo2_22fdx_act_cate),dim(lpo2_22fdx_act_cate_dedup) )
#rownames(sum_count) <- c("LPO_22FDX","LPO_filter1","LPO_filter2","LPO_ans")
#colnames(sum_count) <- c("ea rows","ea columns")
#write.csv(x = sum_count, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sum_count.csv", sep = "") )
####################################################end
####################################################end
####################################################end
