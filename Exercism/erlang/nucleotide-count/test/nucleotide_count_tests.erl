%% Generated with 'testgen v0.2.0'
%% Revision 1 of the exercises generator was used
%% https://github.com/exercism/problem-specifications/raw/42dd0cea20498fd544b152c4e2c0a419bb7e266a/exercises/nucleotide-count/canonical-data.json
%% This file is automatically generated from the exercises canonical data.

-module(nucleotide_count_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

'1_empty_strand_test_'() ->
    Strand = [],
    [
        {"empty strand, all",
            ?_assertEqual(
                lists:sort([
                    {"A", 0},
                    {"C", 0},
                    {"G", 0},
                    {"T", 0}
                ]),
                lists:sort(nucleotide_count:nucleotide_counts(Strand))
            )},
        {"empty strand, A", ?_assertEqual(0, nucleotide_count:count(Strand, "A"))},
        {"empty strand, C", ?_assertEqual(0, nucleotide_count:count(Strand, "C"))},
        {"empty strand, G", ?_assertEqual(0, nucleotide_count:count(Strand, "G"))},
        {"empty strand, T", ?_assertEqual(0, nucleotide_count:count(Strand, "T"))}
    ].

'2_can_count_one_nucleotide_in_single_character_input_test_'() ->
    Strand = "G",
    [
        {"can count one nucleotide in single-character "
            "input, all",
            ?_assertEqual(
                lists:sort([
                    {"A", 0},
                    {"C", 0},
                    {"G", 1},
                    {"T", 0}
                ]),
                lists:sort(nucleotide_count:nucleotide_counts(Strand))
            )},
        {"can count one nucleotide in single-character "
            "input, A", ?_assertEqual(0, nucleotide_count:count(Strand, "A"))},
        {"can count one nucleotide in single-character "
            "input, C", ?_assertEqual(0, nucleotide_count:count(Strand, "C"))},
        {"can count one nucleotide in single-character "
            "input, G", ?_assertEqual(1, nucleotide_count:count(Strand, "G"))},
        {"can count one nucleotide in single-character "
            "input, T", ?_assertEqual(0, nucleotide_count:count(Strand, "T"))}
    ].

'3_strand_with_repeated_nucleotide_test_'() ->
    Strand = "GGGGGGG",
    [
        {"strand with repeated nucleotide, all",
            ?_assertEqual(
                lists:sort([
                    {"A", 0},
                    {"C", 0},
                    {"G", 7},
                    {"T", 0}
                ]),
                lists:sort(nucleotide_count:nucleotide_counts(Strand))
            )},
        {"strand with repeated nucleotide, A",
            ?_assertEqual(0, nucleotide_count:count(Strand, "A"))},
        {"strand with repeated nucleotide, C",
            ?_assertEqual(0, nucleotide_count:count(Strand, "C"))},
        {"strand with repeated nucleotide, G",
            ?_assertEqual(7, nucleotide_count:count(Strand, "G"))},
        {"strand with repeated nucleotide, T",
            ?_assertEqual(0, nucleotide_count:count(Strand, "T"))}
    ].

'4_strand_with_multiple_nucleotides_test_'() ->
    Strand =
        "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGAT"
        "TAAAAAAAGAGTGTCTGATAGCAGC",
    [
        {"strand with multiple nucleotides, all",
            ?_assertEqual(
                lists:sort([
                    {"A", 20},
                    {"C", 12},
                    {"G", 17},
                    {"T", 21}
                ]),
                lists:sort(nucleotide_count:nucleotide_counts(Strand))
            )},
        {"strand with multiple nucleotides, A",
            ?_assertEqual(20, nucleotide_count:count(Strand, "A"))},
        {"strand with multiple nucleotides, C",
            ?_assertEqual(12, nucleotide_count:count(Strand, "C"))},
        {"strand with multiple nucleotides, G",
            ?_assertEqual(17, nucleotide_count:count(Strand, "G"))},
        {"strand with multiple nucleotides, T",
            ?_assertEqual(
                21,
                nucleotide_count:count(Strand, "T")
            )}
    ].

'5_strand_with_invalid_nucleotides_test_'() ->
    Strand = "AGXXACT",
    [
        {"strand with invalid nucleotides, all",
            ?_assertError(
                _,
                nucleotide_count:nucleotide_counts(Strand)
            )},
        {"strand with invalid nucleotides, A",
            ?_assertError(_, nucleotide_count:count(Strand, "A"))},
        {"strand with invalid nucleotides, C",
            ?_assertError(_, nucleotide_count:count(Strand, "C"))},
        {"strand with invalid nucleotides, G",
            ?_assertError(_, nucleotide_count:count(Strand, "G"))},
        {"strand with invalid nucleotides, T",
            ?_assertError(_, nucleotide_count:count(Strand, "T"))}
    ].
