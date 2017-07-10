// ./bin/spark-shell --master local[8] --driver-memory 16g
val INPUT_FILE = "file:///home/dselivanov/datasets/lastfm360.txt"
val RANK = 128
val N_ITER = 3
import org.apache.spark.ml.recommendation.ALS

case class Rating(userId: Int, itemId: Int, rating: Float)
def parseRating(str: String): Rating = {
  val fields = str.split(" ")
  assert(fields.size == 3)
  Rating(fields(0).toInt, fields(1).toInt, fields(2).toFloat)
}

val ratings = spark.read.textFile(INPUT_FILE).map(parseRating).toDF()

ratings.cache().count()

val als = new ALS().setMaxIter(N_ITER).setRegParam(0.0).setUserCol("userId").setItemCol("itemId")
als.setRatingCol("rating").setImplicitPrefs(true).setRank(RANK).setNumBlocks(8).setCheckpointInterval(-1)

val t1 = System.currentTimeMillis()
val model = als.fit(ratings)
println("took " + (System.currentTimeMillis() - t1) / 1000.0 + " sec")
