local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

local snippets = {
	s("clongopts", {
		t({
			"struct option long_options[] = {",
			"\t{\"help\", no_argument, 0, 'h'},",
			"\t{\"input\", required_argument, 0, 'i'},",
			"\t{\"output\", required_argument, 0, 'o'},",
			"\t{0, 0, 0, 0}",
			"};",
			"",
			"int parse_opts(int argc, char **argv) {",
			"\tint option_index = 0;",
			"\tint c;",
			"",
			"\twhile ((c = getopt_long(argc, argv, \"hi:o:\", long_options, &option_index)) != -1) {",
			"\t\tswitch (c) {",
			"\t\tcase 'h':",
			"\t\t\tprintf(\"Usage: %s [options]\\n\", argv[0]);",
			"\t\t\tprintf(\"Options:\\n\");",
			"\t\t\tprintf(\"  -h, --help\\t\\tShow this help message\\n\");",
			"\t\t\tprintf(\"  -i, --input FILE\\tSpecify input file\\n\");",
			"\t\t\tprintf(\"  -o, --output FILE\\tSpecify output file\\n\");",
			"\t\t\treturn 0;",
			"\t\tcase 'i':",
			"\t\t\tprintf(\"Input file: %s\\n\", optarg);",
			"\t\t\tbreak;",
			"\t\tcase 'o':",
			"\t\t\tprintf(\"Output file: %s\\n\", optarg);",
			"\t\t\tbreak;",
			"\t\tcase '?':",
			"\t\t\t// getopt_long already printed an error message",
			"\t\t\treturn 1;",
			"\t\tdefault:",
			"\t\t\tabort();",
			"\t\t}",
			"\t}",
			"",
			"\tif (optind < argc) {",
			"\t\tprintf(\"non-option ARGV-elements: \");",
			"\t\twhile (optind < argc)",
			"\t\t\tprintf(\"%s \", argv[optind++]);",
			"\t\tprintf(\"\\n\");",
			"\t}",
			"",
			"\treturn 0;",
			"}"
		})
	}),

	s("cmainlong", {
		t({
			"#include <stdio.h>",
			"#include <stdlib.h>",
			"#include <getopt.h>",
			"",
			"int parse_opts(int argc, char **argv);",
			"",
			"int main(int argc, char **argv) {",
			"\tint result = parse_opts(argc, argv);",
			"\tif (result != 0) {",
			"\t\treturn result;",
			"\t}",
			"",
			"\t// code sth you animal",
			"\tprintf(\"Main running for `%s`...\\n\", *argv);",
			"",
			"\treturn 0;",
			"}"
		})
	}),

	s("cmain", {
		t({
			"#include <stdio.h>",
			"#include <stdlib.h>",
			"#include <unistd.h>",
			"",
			"int main(int argc, char **argv) {",
			"\tint opt;",
			"\tchar *ifile = NULL;",
			"\tchar *ofile = NULL;",
			"\twhile ((opt = getopt(argc, argv, \"hi:o:\")) != -1) {",
			"\t\tswitch (opt) {",
			"\t\tcase 'h':",
			"\t\t\tprintf(\"Usage: %s [-h] [-i input_file] [-o output_file]\\n\", argv[0]);",
			"\t\t\treturn 0;",
			"\t\tcase 'i':",
			"\t\t\tifile = optarg;",
			"\t\t\tbreak;",
			"\t\tcase 'o':",
			"\t\t\tofile = optarg;",
			"\t\t\tbreak;",
			"\t\tdefault:",
			"\t\t\tfprintf(stderr, \"Usage: %s [-h] [-i input_file] [-o output_file]\\n\", argv[0]);",
			"\t\t\treturn 1;",
			"\t\t}",
			"\t}",
			"",
			"\tif (ifile) printf(\"Input file: %s\\n\", ifile);",
			"\tif (ofile) printf(\"Output file: %s\\n\", ofile);",
			"",
			"\treturn 0;",
			"}"
		})
	}),

	-- read a file into mem
	s("creadfile", {
		t({"FILE *fp = fopen("}),
		i(1, "filename"),
		t({", \"r\");",
		"if (fp == NULL) {",
		"perror(\"Error opening file\");",
		"\treturn 1;",
		"}",
		"",
		"char *line = NULL;",
		"size_t len = 0;",
		"ssize_t read;",
		"",
		"while ((read = getline(&line, &len, fp)) != -1) {",
		"\t"}),
		i(2, "printf(\"%s\", line);"),
		t({"",
		"}",
		"",
		"fclose(fp);",
		"if (line)",
		"\tfree(line);"}),
	}),


	-- err maco
	s("cerr", {
		t({"#define ERROR_CHECK(condition, message) \\",
		"\tdo { \\",
		"\t\tif (condition) { \\",
		"\t\t\tfprintf(stderr, \"Error: %s\\n\", message); \\",
		"\t\t\t"}),
		c(1, {
			t("exit(1);"),
			t("return 1;"),
			t("goto cleanup;"),
		}),
		t({" \\",
		"\t\t} \\",
		"\t} while (0)"}),
	}),
}
return snippets

