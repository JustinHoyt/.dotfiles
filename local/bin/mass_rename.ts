#!/usr/bin/env -S deno run --allow-all --ext ts

// Monday, May 27 2024
// pastebin backup: https://paste.googleplex.com/6454411794841600

import { parse } from "https://deno.land/std@0.200.0/flags/mod.ts";
import "npm:zx@7.2.3/globals";
import { assertEquals } from "https://deno.land/std@0.220.0/assert/assert_equals.ts";

// Disable escaping strings automatically
$.quote = (unescapedCmd) => unescapedCmd;

interface Args {
  help?: boolean;
  directories_and_files?: boolean;
  find: string;
  replace: string;
  // _ is where all the non-flag variables are set
  _: (string | number)[];
}

/**
 * Converts from any of the 8 cases to camel case to normalize on camel case
 *
 * This makes all the other functions much easier to maintain by only accepting camel cased inputs.
 */
function anyToCamelCase(input: string): string {
  if (input === input.toUpperCase()) {
    // Convert UPPER_CASE to lower_case for initial processing
    input = input.toLowerCase();
  }

  return input
    // Convert spaces, underscores, and hyphens to spaces
    .replace(/[_\-\s]+(.)?/g, (_, chr) => chr ? chr.toUpperCase() : "")
    // Convert UPPER_CASE to lowerCase and treat it as snake_case
    .replace(/([A-Z])([A-Z]+)/g, (m, p1, p2) => p1 + p2.toLowerCase())
    // Handle cases where the first letter should be lowercase
    .replace(/^[A-Z]/, (chr) => chr.toLowerCase());
}

function toSnakeCase(str: string): string {
  return str.replace(/([a-z])([A-Z])/g, "$1_$2").toLowerCase();
}

function toKebabCase(str: string): string {
  return str.replace(/([a-z])([A-Z])/g, "$1-$2").toLowerCase();
}

function toMixedCase(str: string): string {
  return str.charAt(0).toUpperCase() + str.slice(1);
}

function toUpperCase(str: string): string {
  return str.replace(/([a-z])([A-Z])/g, "$1_$2").toUpperCase();
}

function toTitleCase(str: string): string {
  return str.replace(/([a-z])([A-Z])/g, "$1 $2")
    .replace(/\b\w/g, (char) => char.toUpperCase());
}

function toSentenceCase(str: string): string {
  const result = str.replace(/([a-z])([A-Z])/g, "$1 $2");
  return result.charAt(0).toUpperCase() + result.slice(1).toLowerCase();
}

function toSpaceCase(str: string): string {
  return str.replace(/([a-z])([A-Z])/g, "$1 $2").toLowerCase();
}

function isArgsValid(args: Partial<Args>): args is Args {
  return args.find != null || args.replace != null;
}

function main(args: Args): [string, string] {
  const normalizedFind = anyToCamelCase(args.find);
  const normalizedReplace = anyToCamelCase(args.replace);

  return [
    `fd --type file | xargs -P $(nproc) -n 1000 -d '\\n' \\
perl -i -pE 's#${normalizedFind}#${normalizedReplace}#g; \\
s#${toSnakeCase(normalizedFind)}#${toSnakeCase(normalizedReplace)}#g; \\
s#${toKebabCase(normalizedFind)}#${toKebabCase(normalizedReplace)}#g; \\
s#${toMixedCase(normalizedFind)}#${toMixedCase(normalizedReplace)}#g; \\
s#${toSpaceCase(normalizedFind)}#${toSpaceCase(normalizedReplace)}#g; \\
s#${toTitleCase(normalizedFind)}#${toTitleCase(normalizedReplace)}#g; \\
s#${toSentenceCase(normalizedFind)}#${toSentenceCase(normalizedReplace)}#g; \\
s#${toUpperCase(normalizedFind)}#${toUpperCase(normalizedReplace)}#g;'
`,
    `f2 --include-dir --recursive --find '${
      toSnakeCase(normalizedFind)
    }' --replace '${toSnakeCase(normalizedReplace)}' --fix-conflicts --allow-overwrites --verbose --exec`,
  ];
}

if (import.meta.main) {
  const args = parse(Deno.args, {
    alias: {
      h: "help",
      f: "find",
      r: "replace",
      d: "directories_and_files",
    },
    boolean: ["help", "directories_and_files"],
    string: ["find", "replace"],
  });

  if (args.help) {
    console.log(
      `Renames files, directories, and lines from a matching regex to a target regex.`,
    );
    console.log(`\nUsage: mass_rename [OPTIONS...] [PATH]`);
    console.log("\nRequired flags:");
    console.log(
      "  -f, --find                    Regex for finding file/dir/line matches",
    );
    console.log(
      "  -r, --replace                 Regex for replacing file/dir/line matches",
    );
    console.log("\nOptional flags:");
    console.log("  -h, --help                    Display this help and exit");
    console.log("  -d, --directories_and_files   renames files and directories too");

    Deno.exit(0);
  }

  if (!isArgsValid(args)) {
    throw new Error("--find and --replace are required");
  }

  const [renameLines, renameFilesAndDirs] = main(args);
  await $`${renameLines}`;
	console.warn("DEBUGPRINT[2]: mass_rename.ts:134: args.directories_and_files=", args.directories_and_files)
	if (args.directories_and_files) {
		await $`${renameFilesAndDirs}`;
	}
}

Deno.test("toSnakeCase", () => {
  assertEquals(toSnakeCase("camelCaseVariable"), "camel_case_variable");
});

Deno.test("toKebabCase", () => {
  assertEquals(toKebabCase("camelCaseVariable"), "camel-case-variable");
});

Deno.test("toMixedCase", () => {
  assertEquals(toMixedCase("camelCaseVariable"), "CamelCaseVariable");
});

Deno.test("toUpperCase", () => {
  assertEquals(toUpperCase("camelCaseVariable"), "CAMEL_CASE_VARIABLE");
});

Deno.test("toTitleCase", () => {
  assertEquals(toTitleCase("camelCaseVariable"), "Camel Case Variable");
});

Deno.test("toSentenceCase", () => {
  assertEquals(toSentenceCase("camelCaseVariable"), "Camel case variable");
});

Deno.test("toSpaceCase", () => {
  assertEquals(toSpaceCase("camelCaseVariable"), "camel case variable");
});

Deno.test("main camel case input", () => {
  assertEquals(
    main({
      _: [],
      find: "selectDeployment",
      replace: "createDeployment",
    }),
    [
      `fd --type file | xargs -P $(nproc) -n 1000 -d '\\n' \\
perl -i -pE 's#selectDeployment#createDeployment#g; \\
s#select_deployment#create_deployment#g; \\
s#select-deployment#create-deployment#g; \\
s#SelectDeployment#CreateDeployment#g; \\
s#select deployment#create deployment#g; \\
s#Select Deployment#Create Deployment#g; \\
s#Select deployment#Create deployment#g; \\
s#SELECT_DEPLOYMENT#CREATE_DEPLOYMENT#g;'
`,
      `f2 --include-dir --recursive --find 'select_deployment' --replace 'create_deployment' --fix-conflicts --allow-overwrites --verbose --exec`,
    ],
  );
});

Deno.test("main snake case input", () => {
  assertEquals(
    main({
      _: [],
      find: "select_deployment",
      replace: "create_deployment",
    }),
    [
      `fd --type file | xargs -P $(nproc) -n 1000 -d '\\n' \\
perl -i -pE 's#selectDeployment#createDeployment#g; \\
s#select_deployment#create_deployment#g; \\
s#select-deployment#create-deployment#g; \\
s#SelectDeployment#CreateDeployment#g; \\
s#select deployment#create deployment#g; \\
s#Select Deployment#Create Deployment#g; \\
s#Select deployment#Create deployment#g; \\
s#SELECT_DEPLOYMENT#CREATE_DEPLOYMENT#g;'
`,
      `f2 --include-dir --recursive --find 'select_deployment' --replace 'create_deployment' --fix-conflicts --allow-overwrites --verbose --exec`,
    ],
  );
});

Deno.test("main kebab case input", () => {
  assertEquals(
    main({
      _: [],
      find: "select-deployment",
      replace: "create-deployment",
    }),
    [
      `fd --type file | xargs -P $(nproc) -n 1000 -d '\\n' \\
perl -i -pE 's#selectDeployment#createDeployment#g; \\
s#select_deployment#create_deployment#g; \\
s#select-deployment#create-deployment#g; \\
s#SelectDeployment#CreateDeployment#g; \\
s#select deployment#create deployment#g; \\
s#Select Deployment#Create Deployment#g; \\
s#Select deployment#Create deployment#g; \\
s#SELECT_DEPLOYMENT#CREATE_DEPLOYMENT#g;'
`,
      `f2 --include-dir --recursive --find 'select_deployment' --replace 'create_deployment' --fix-conflicts --allow-overwrites --verbose --exec`,
    ],
  );
});

Deno.test("main mixed case input", () => {
  assertEquals(
    main({
      _: [],
      find: "SelectDeployment",
      replace: "CreateDeployment",
    }),
    [
      `fd --type file | xargs -P $(nproc) -n 1000 -d '\\n' \\
perl -i -pE 's#selectDeployment#createDeployment#g; \\
s#select_deployment#create_deployment#g; \\
s#select-deployment#create-deployment#g; \\
s#SelectDeployment#CreateDeployment#g; \\
s#select deployment#create deployment#g; \\
s#Select Deployment#Create Deployment#g; \\
s#Select deployment#Create deployment#g; \\
s#SELECT_DEPLOYMENT#CREATE_DEPLOYMENT#g;'
`,
      `f2 --include-dir --recursive --find 'select_deployment' --replace 'create_deployment' --fix-conflicts --allow-overwrites --verbose --exec`,
    ],
  );
});

Deno.test("main upper case input", () => {
  assertEquals(
    main({
      _: [],
      find: "SELECT_DEPLOYMENT",
      replace: "CREATE_DEPLOYMENT",
    }),
    [
      `fd --type file | xargs -P $(nproc) -n 1000 -d '\\n' \\
perl -i -pE 's#selectDeployment#createDeployment#g; \\
s#select_deployment#create_deployment#g; \\
s#select-deployment#create-deployment#g; \\
s#SelectDeployment#CreateDeployment#g; \\
s#select deployment#create deployment#g; \\
s#Select Deployment#Create Deployment#g; \\
s#Select deployment#Create deployment#g; \\
s#SELECT_DEPLOYMENT#CREATE_DEPLOYMENT#g;'
`,
      `f2 --include-dir --recursive --find 'select_deployment' --replace 'create_deployment' --fix-conflicts --allow-overwrites --verbose --exec`,
    ],
  );
});

Deno.test("main title case input", () => {
  assertEquals(
    main({
      _: [],
      find: "Select Deployment",
      replace: "Create Deployment",
    }),
    [
      `fd --type file | xargs -P $(nproc) -n 1000 -d '\\n' \\
perl -i -pE 's#selectDeployment#createDeployment#g; \\
s#select_deployment#create_deployment#g; \\
s#select-deployment#create-deployment#g; \\
s#SelectDeployment#CreateDeployment#g; \\
s#select deployment#create deployment#g; \\
s#Select Deployment#Create Deployment#g; \\
s#Select deployment#Create deployment#g; \\
s#SELECT_DEPLOYMENT#CREATE_DEPLOYMENT#g;'
`,
      `f2 --include-dir --recursive --find 'select_deployment' --replace 'create_deployment' --fix-conflicts --allow-overwrites --verbose --exec`,
    ],
  );
});

Deno.test("main sentence case input", () => {
  assertEquals(
    main({
      _: [],
      find: "Select deployment",
      replace: "Create deployment",
    }),
    [
      `fd --type file | xargs -P $(nproc) -n 1000 -d '\\n' \\
perl -i -pE 's#selectDeployment#createDeployment#g; \\
s#select_deployment#create_deployment#g; \\
s#select-deployment#create-deployment#g; \\
s#SelectDeployment#CreateDeployment#g; \\
s#select deployment#create deployment#g; \\
s#Select Deployment#Create Deployment#g; \\
s#Select deployment#Create deployment#g; \\
s#SELECT_DEPLOYMENT#CREATE_DEPLOYMENT#g;'
`,
      `f2 --include-dir --recursive --find 'select_deployment' --replace 'create_deployment' --fix-conflicts --allow-overwrites --verbose --exec`,
    ],
  );
});

Deno.test("main space case input", () => {
  assertEquals(
    main({
      _: [],
      find: "select deployment",
      replace: "create deployment",
    }),
    [
      `fd --type file | xargs -P $(nproc) -n 1000 -d '\\n' \\
perl -i -pE 's#selectDeployment#createDeployment#g; \\
s#select_deployment#create_deployment#g; \\
s#select-deployment#create-deployment#g; \\
s#SelectDeployment#CreateDeployment#g; \\
s#select deployment#create deployment#g; \\
s#Select Deployment#Create Deployment#g; \\
s#Select deployment#Create deployment#g; \\
s#SELECT_DEPLOYMENT#CREATE_DEPLOYMENT#g;'
`,
      `f2 --include-dir --recursive --find 'select_deployment' --replace 'create_deployment' --fix-conflicts --allow-overwrites --verbose --exec`,
    ],
  );
});
