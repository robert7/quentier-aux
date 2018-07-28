SELECT DISTINCT localUid , NoteTags.localTag FROM NoteFTS
  LEFT OUTER JOIN NoteTags ON NoteFTS.localUid = NoteTags.localNote
  WHERE
     (((
       (localUid IN (SELECT localUid FROM NoteFTS WHERE contentListOfWords MATCH 'crispy')) OR  /* source1 */
	   (localUid IN (SELECT localUid FROM NoteFTS WHERE titleNormalized MATCH 'crispy')) OR /* source1 */
	   (localUid IN (SELECT noteLocalUid FROM ResourceRecognitionDataFTS WHERE recognitionData MATCH 'crispy')) OR /* source3 */
	   (localUid IN ( /* source4 */
	     SELECT localNote FROM NoteTags LEFT OUTER JOIN TagFTS ON NoteTags.localTag=TagFTS.localUid
		 WHERE (nameLower IN (SELECT nameLower FROM TagFTS WHERE nameLower MATCH 'crispy')))
	   )
	)))


SELECT DISTINCT localUid, 1, NoteTags.localTag FROM NoteFTS
  LEFT OUTER JOIN NoteTags ON NoteFTS.localUid = NoteTags.localNote
  WHERE
     (((
       (localUid IN (SELECT localUid FROM NoteFTS WHERE contentListOfWords MATCH 'crispy'))
	)))
UNION
SELECT DISTINCT localUid, 2, NoteTags.localTag FROM NoteFTS
  LEFT OUTER JOIN NoteTags ON NoteFTS.localUid = NoteTags.localNote
  WHERE
     (((
	   (localUid IN (SELECT localUid FROM NoteFTS WHERE titleNormalized MATCH 'crispy'))
	)))
UNION
SELECT DISTINCT localUid, 3, NoteTags.localTag FROM NoteFTS
  LEFT OUTER JOIN NoteTags ON NoteFTS.localUid = NoteTags.localNote
  WHERE
     (((
	   (localUid IN (SELECT noteLocalUid FROM ResourceRecognitionDataFTS WHERE recognitionData MATCH 'crispy'))
	)))
UNION
SELECT DISTINCT localUid, 4, NoteTags.localTag FROM NoteFTS
  LEFT OUTER JOIN NoteTags ON NoteFTS.localUid = NoteTags.localNote
  WHERE
     (((
	   (localUid IN ( /* source4 */
	     SELECT localNote FROM NoteTags LEFT OUTER JOIN TagFTS ON NoteTags.localTag=TagFTS.localUid
		 WHERE (nameLower IN (SELECT nameLower FROM TagFTS WHERE nameLower MATCH 'crispy')))
	   )
	)))






SELECT DISTINCT localUid , NoteTags.localTag FROM NoteFTS
   LEFT OUTER JOIN NoteTags ON NoteFTS.localUid = NoteTags.localNote
   WHERE ((
     (
         (localUid IN (SELECT localUid FROM NoteFTS WHERE contentListOfWords MATCH 'crispy')) OR
         (localUid IN (SELECT localUid FROM NoteFTS WHERE titleNormalized MATCH 'crispy')) OR
         (localUid IN (SELECT noteLocalUid FROM ResourceRecognitionDataFTS WHERE recognitionData MATCH 'crispy')) OR
         (localUid IN (SELECT localNote FROM NoteTags LEFT OUTER JOIN TagFTS ON NoteTags.localTag=TagFTS.localUid
               WHERE (nameLower IN (SELECT nameLower FROM TagFTS WHERE nameLower MATCH 'crispy'))))
     ) AND
     ((localUid IN (SELECT localUid FROM NoteFTS WHERE contentListOfWords MATCH 'avocado')) OR
         (localUid IN (SELECT localUid FROM NoteFTS WHERE titleNormalized MATCH 'avocado')) OR
         (localUid IN (SELECT noteLocalUid FROM ResourceRecognitionDataFTS WHERE recognitionData MATCH
          'avocado')) OR (localUid IN (SELECT localNote FROM NoteTags LEFT OUTER JOIN TagFTS ON
          NoteTags.localTag=TagFTS.localUid WHERE (nameLower IN (SELECT nameLower FROM TagFTS
          WHERE nameLower MATCH 'avocado'))))
     )
     ))