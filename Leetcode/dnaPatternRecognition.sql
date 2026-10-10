-- 3475. DNA Pattern Recognition 

-- Biologists are studying basic patterns in DNA sequences. Write a solution to identify sample_id with the following patterns:

-- Sequences that start with ATG (a common start codon)
-- Sequences that end with either TAA, TAG, or TGA (stop codons)
-- Sequences containing the motif ATAT (a simple repeated pattern)
-- Sequences that have at least 3 consecutive G (like GGG or GGGG)
-- Return the result table ordered by sample_id in ascending order.

SELECT s.sequence_id AS sequence_id,
       s.dna_sequence AS dna_sequence,
       s.species AS species,
       CASE
           WHEN s.dna_sequence LIKE 'ATG%' THEN 1
           ELSE 0
       END AS has_start,

       CASE
           WHEN s.dna_sequence LIKE '%TAA' OR s.dna_sequence LIKE '%TAG' OR s.dna_sequence LIKE 'TGA%' THEN 1
           ELSE 0
       END AS has_stop,

       CASE 
           WHEN s.dna_sequence LIKE '%ATAT%' THEN 1
           ELSE 0
       END AS has_atat,

       CASE
           WHEN s.dna_sequence LIKE '%GGG%' THEN 1
           ELSE 0
       END AS has_ggg
FROM Samples s;