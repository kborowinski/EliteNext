Dragon:	                DB $00
                        DW $5066
                        DW DragonEdges
                        DB DragonEdgesSize
                        DB $00, $3C
                        DB DragonVertSize /6 
                        DB DragonVertSize
                        DB DragonEdgesCnt
                        DB $00, $00
                        DB DragonNormalsSize
                        DB $20, $F7, $14
                        DW DragonNormals
                        DB $00, $47
                        DW DragonVertices
                        DB 0,0                      ; Type and Tactics
                        DB ShipCanAnger
DragonVertices:	        DB $00, $00, $FA, $1F, $6B, $05
                        DB $D8, $00, $7C, $1F, $67, $01
                        DB $D8, $00, $7C, $3F, $78, $12
                        DB $00, $28, $FA, $3F, $CD, $23
                        DB $00, $28, $FA, $7F, $CD, $89
                        DB $D8, $00, $7C, $BF, $9A, $34
                        DB $D8, $00, $7C, $9F, $AB, $45
                        DB $00, $50, $00, $1F, $FF, $FF
                        DB $00, $50, $00, $5F, $FF, $FF
DragonVertSize:         equ $ - DragonVertices	
DragonEdges:	        DB $1F, $01, $04, $1C
                        DB $1F, $12, $08, $1C
                        DB $1F, $23, $0C, $1C
                        DB $1F, $34, $14, $1C
                        DB $1F, $45, $18, $1C
                        DB $1F, $50, $00, $1C
                        DB $1F, $67, $04, $20
                        DB $1F, $78, $08, $20
                        DB $1F, $89, $10, $20
                        DB $1F, $9A, $14, $20
                        DB $1F, $AB, $18, $20
                        DB $1F, $B6, $00, $20
                        DB $1F, $06, $00, $04
                        DB $1F, $17, $04, $08
                        DB $1F, $4A, $14, $18
                        DB $1F, $5B, $00, $18
                        DB $1F, $2C, $08, $0C
                        DB $1F, $8C, $08, $10
                        DB $1F, $3D, $0C, $14
                        DB $1F, $9D, $10, $14
                        DB $1F, $CD, $0C, $10
DragonEdgesSize:        equ $ - DragonEdges	
DragonEdgesCnt:         equ DragonEdgesSize/4		
DragonNormals:	        DB $1F, $10, $5A, $1C
                        DB $1F, $21, $5A, $00
                        DB $3F, $19, $5B, $0E
                        DB $BF, $19, $5B, $0E
                        DB $9F, $21, $5A, $00
                        DB $9F, $10, $5A, $1C
                        DB $5F, $10, $5A, $1C
                        DB $5F, $21, $5A, $00
                        DB $7F, $19, $5B, $0E
                        DB $FF, $19, $5B, $0E
                        DB $DF, $21, $5A, $00
                        DB $DF, $10, $5A, $1C
                        DB $3F, $30, $00, $52
                        DB $BF, $30, $00, $52
DragonNormalsSize:      equ $ - DragonNormals	
DragonLen:              equ $ - Dragon	
