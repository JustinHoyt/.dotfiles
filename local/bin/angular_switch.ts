#!/usr/bin/env -S deno run --allow-all --ext ts

import * as mod from "https://deno.land/std@0.209.0/assert/mod.ts";
import $ from "https://deno.land/x/dax@0.36.0/mod.ts";
import "https://deno.land/x/dax_extras@2.3.0-0.36.0/mod.ts";

enum FileType {
  CSS = "css",
  TS = "ts",
  TEST = "test",
  HTML = "html",
  BUILD = "build",
  HARNESS = "harness",
}

async function main(filename: string, convertTo: FileType): Promise<string> {
  const matchFileExtension = /(_test\.ts|\.ts|\.css|\.ng\.html|BUILD|harness.ts)$/;
  const matchFileName = new RegExp(`\/[^/]*${matchFileExtension.source}`);
	const path = filename.replace(matchFileName, "");

  switch (convertTo) {
    case FileType.CSS:
      return filename.replace(matchFileExtension, ".css");
    case FileType.TS:
      return filename.replace(matchFileExtension, ".ts");
    case FileType.TEST:
      return filename.replace(matchFileExtension, "_test.ts");
    case FileType.HTML:
      return filename.replace(matchFileExtension, ".ng.html");
    case FileType.BUILD:
      return `${filename.replace(matchFileName, "")}/BUILD`;
    case FileType.HARNESS: {
			const [file, ..._rest] = await $`fd --type file harness ${path}`.lines();
			if (file == "") {
				throw new Error("No test harness file:");
			}
			return file;
		}
    default:
      return convertTo satisfies never;
  }
}

if (import.meta.main) {
  const [filename, convertTo] = Deno.args;
  if (Deno.args.length < 2) {
    throw new Error(
      "Requires a filename argument and an argument of the type to conver to.",
    );
  }
  if (!Object.values<string>(FileType).includes(convertTo.toLowerCase())) {
    throw new Error(`Invalid FileType: ${convertTo.toString()}`);
  }
  console.log(await main(filename, convertTo as FileType));
}

Deno.test("parse string to file type", async () => {
  mod.assertEquals(
    await main("my_component.css", "ts" as FileType),
    "my_component.ts",
  );
});

Deno.test("convert to test", async () => {
  mod.assertEquals(
    await main("my_component.ts", FileType.TEST),
    "my_component_test.ts",
  );
});

Deno.test("convert to html", async () => {
  mod.assertEquals(
    await main("my_component_test.ts", FileType.HTML),
    "my_component.ng.html",
  );
});

Deno.test("convert to css", async () => {
  mod.assertEquals(
    await main("my_component.ng.html", FileType.CSS),
    "my_component.css",
  );
});

Deno.test("convert from css to ts", async () => {
  mod.assertEquals(
    await main("my_component.css", FileType.TS),
    "my_component.ts",
  );
});

Deno.test("convert from html to ts", async () => {
  mod.assertEquals(
    await main("this/that/my_component.ng.html", FileType.TS),
    "this/that/my_component.ts",
  );
});

Deno.test("convert to build", async () => {
  mod.assertEquals(
    await main("this/that/my_component.ts", FileType.BUILD),
    "this/that/BUILD",
  );
});

Deno.test("convert to harness", async () => {
  mod.assertEquals(
    await main("test/test.ts", FileType.HARNESS),
    "test/testing/test_harness.ts",
  );
});

Deno.test("convert to build to build", async () => {
	const build = await main("test/test.ts", FileType.BUILD);
	const buildBuild = await main(build, FileType.BUILD);
  mod.assertEquals(
    buildBuild,
    "test/BUILD",
  );
});

Deno.test("convert to harness to harness", async () => {
	const harness = await main("test/test.ts", FileType.HARNESS);
	const harnessHarness = await main(harness, FileType.HARNESS);
  mod.assertEquals(
    harnessHarness,
    "test/testing/test_harness.ts",
  );
});
