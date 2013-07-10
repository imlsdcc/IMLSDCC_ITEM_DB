SELECT     cp1.collectionID, cp0.text AS type_collection, cp2.text As format, cp3.text AS size, cp4.text AS relation_supplement, cp6.text AS audience, cp7.text AS interactivity, 
                      cp8.text AS accessrights, cp9.text AS rights, cp11.text AS accrualPeriodicity, in1.institutionName AS publisher, 
                      in2.institutionName AS contributor
FROM         
                      dbo.CollectionProperties AS cp1 LEFT OUTER JOIN
                      dbo.CollectionProperties AS cp2 ON cp1.collectionID = cp2.collectionID AND cp2.property = 'format' LEFT OUTER JOIN
                      dbo.CollectionProperties AS cp3 ON cp1.collectionID = cp3.collectionID AND cp3.property = 'size' LEFT OUTER JOIN
                      dbo.CollectionProperties AS cp4 ON cp1.collectionID = cp4.collectionID AND cp4.property = 'relation_supplement' LEFT OUTER JOIN
                      dbo.CollectionProperties AS cp6 ON cp1.collectionID = cp6.collectionID AND cp6.property = 'audience' LEFT OUTER JOIN
                      dbo.CollectionProperties AS cp7 ON cp1.collectionID = cp7.collectionID AND cp7.property = 'interactivity' LEFT OUTER JOIN
                      dbo.CollectionProperties AS cp8 ON cp1.collectionID = cp8.collectionID AND cp8.property = 'accessRights' LEFT OUTER JOIN
                      dbo.CollectionProperties AS cp9 ON cp1.collectionID = cp9.collectionID AND cp9.property = 'rights' LEFT OUTER JOIN
                      dbo.CollectionProperties AS cp0 ON cp1.collectionID = cp0.collectionID AND cp0.property = 'type_collection' LEFT OUTER JOIN
                      dbo.CollectionProperties AS cp11 ON cp1.collectionID = cp11.collectionID AND cp11.property = 'accrualPeriodicity' Left JOIN
                      dbo.CollectionInstitutions As cp13 ON cp13.collectionID = cp1.collectionID LEFT OUTER JOIN
                      dbo.Institutions AS in1 ON in1.institutionID = cp13.institutionID AND cp13.relationship = 'hosting' LEFT OUTER JOIN
                      dbo.Institutions AS in2 ON cp13.institutionID = in2.institutionID AND cp13.relationship = 'contributing'
                      where cp1.collectionID = 82407