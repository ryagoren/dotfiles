local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

return {
	-- Main function with argument parsing
	s("cmain", {
		t({"#include <stdio.h>",
		"#include <stdlib.h>",
		"#include <string.h>",
		"#include <getopt.h>",
		"",
		"int main(int argc, char *argv[]) {",
		"    int opt;",
		"    while ((opt = getopt(argc, argv, \""}),
		i(1, "hi:o:"),
		t({"\")) != -1) {",
		"        switch (opt) {",
		"            case 'h':",
		"                printf(\"Usage: %s ", "[-h] "}),
		i(2, "[-i input_file] [-o output_file]"),
		t({"\", argv[0]);",
		"                return 0;",
		"            case 'i':",
		"                // sme input file",
		"                break;",
		"            case 'o':",
		"                // sme output file",
		"                break;",
		"            default:",
		"                fprintf(stderr, \"Usage: %s ", "[-h] "}),
		f(function(args) return args[1][1] end, {2}),
		t({"\\n\", argv[0]);",
		"                return 1;",
		"        }",
		"    }",
		"",
		"    // Your code here",
		"",
		"    return 0;",
		"}"}),
	}),

	-- read a file into mem
	s("creadfile", {
		t({"FILE *fp = fopen("}),
		i(1, "filename"),
		t({", \"r\");",
		"if (fp == NULL) {",
		"    perror(\"Error opening file\");",
		"    return 1;",
		"}",
		"",
		"char *line = NULL;",
		"size_t len = 0;",
		"ssize_t read;",
		"",
		"while ((read = getline(&line, &len, fp)) != -1) {",
		"    // process line",
		"    "}),
		i(2, "printf(\"%s\", line);"),
		t({"",
		"}",
		"",
		"fclose(fp);",
		"if (line)",
		"    free(line);"}),
	}),

	-- err maco
	s("cerr", {
		t({"#define ERROR_CHECK(condition, message) \\",
		"    do { \\",
		"        if (condition) { \\",
		"            fprintf(stderr, \"Error: %s\\n\", message); \\",
		"            "}),
		c(1, {
			t("exit(1);"),
			t("return 1;"),
			t("goto cleanup;"),
		}),
		t({" \\",
		"        } \\",
		"    } while (0)"}),
	}),
	-- Add more C snippets here...
}

