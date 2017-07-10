# download data from http://ocelma.net/MusicRecommendationDataset/lastfm-360K.html
set.seed(1)
library(data.table)
library(Matrix)
library(sparsio)

raw_data = fread("~/datasets/usersha1-artmbid-artname-plays.tsv", showProgress = FALSE)
setnames(raw_data, c("user_id", "artist_id", "artist_name", "number_plays"))
user_encoding = raw_data[, .(uid = .GRP), keyby = user_id]
item_encoding = raw_data[, .(iid = .GRP, artist_name = artist_name[[1]]), keyby = artist_id]
raw_data[, artist_name := NULL]

# just join raw_data and user/item encodings
dt = user_encoding[raw_data, .(artist_id, uid, number_plays), on = .(user_id = user_id)]
dt = item_encoding[dt, .(iid, uid, number_plays), on = .(artist_id = artist_id)]
fwrite(dt, file = "~/datasets/lastfm360.txt", col.names = F, sep = " ")

X = sparseMatrix(i = dt$uid, j = dt$iid, x = dt$number_plays, giveCsparse = FALSE, check = FALSE)
write_svmlight(X, file = "~/datasets/lastfm360.svm")



