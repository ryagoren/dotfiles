local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

local snippets = {
	s("cmain", {
		t({
			"#include <stdio.h>",
			"#include <stdlib.h>",
			"#include <unistd.h>",
			"",
			"int main(int argc, char *argv[]) {",
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
			"\t// Your code here",
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
		"\t// process line",
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
print("C snippets table created with", #snippets, "snippets")
return snippets

