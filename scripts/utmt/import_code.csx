// Replaces code entries with every <PDA_IMPORT_DIR>/*.gml file.
// scripts/build.py runs this through UndertaleModCli.
//
// Each file name is the code entry name, so only existing entries are replaced.

using System;
using System.IO;
using System.Linq;

EnsureDataLoaded();

string codeFolder = Environment.GetEnvironmentVariable("PDA_IMPORT_DIR");
if (string.IsNullOrEmpty(codeFolder))
{
    ScriptError("PDA_IMPORT_DIR is not set.");
    return;
}

string[] files = Directory.GetFiles(codeFolder, "*.gml");
if (files.Length == 0)
{
    ScriptError("No .gml files in " + codeFolder);
    return;
}

var missing = files
    .Select(Path.GetFileNameWithoutExtension)
    .Where(name => Data.Code.ByName(name) is null)
    .ToList();
if (missing.Count > 0)
{
    ScriptError("No such code entry in the game: " + string.Join(", ", missing));
    return;
}

UndertaleModLib.Compiler.CodeImportGroup importGroup = new(Data)
{
    AutoCreateAssets = false,
};
foreach (string file in files)
{
    importGroup.QueueReplace(Path.GetFileNameWithoutExtension(file), File.ReadAllText(file));
}
importGroup.Import();

// lets the runner use absolute paths (program_directory) outside its AppData save area
var options = UndertaleModLib.Models.UndertaleOptions.OptionsFlags.DisableSandbox;
Data.Options.Info |= options;
Console.WriteLine("file system sandbox: disabled");

Console.WriteLine($"imported {files.Length} code entries from {codeFolder}");
