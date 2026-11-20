// Imports code from .gml files (all subfolders). scripts/build.py runs this through UndertaleModCli.
//
// Each file name is the code entry name.
//   <PDA_IMPORT_DIR>  replaces existing code entries.
//   <PDA_NEW_DIR>     (optional) adds new code entries and creates the objects, events and
//                     scripts they belong to; every name must be absent from the game.
// Also disables the runner's file-system sandbox.

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

string newFolder = Environment.GetEnvironmentVariable("PDA_NEW_DIR");
string[] files = Directory.GetFiles(codeFolder, "*.gml", SearchOption.AllDirectories);
string[] newFiles = !string.IsNullOrEmpty(newFolder) && Directory.Exists(newFolder)
    ? Directory.GetFiles(newFolder, "*.gml", SearchOption.AllDirectories)
    : new string[0];
if (files.Length == 0 && newFiles.Length == 0)
{
    ScriptError("No .gml files in " + codeFolder + (string.IsNullOrEmpty(newFolder) ? "" : " or " + newFolder));
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

var existing = newFiles
    .Select(Path.GetFileNameWithoutExtension)
    .Where(name => Data.Code.ByName(name) is not null)
    .ToList();
if (existing.Count > 0)
{
    ScriptError("Already a code entry in the game (edit it in the edited folder instead): " + string.Join(", ", existing));
    return;
}

// New global scripts are compiled first, then the other new code, then the replacements, so that
// every call to a function from a new script resolves to that function.
void ImportGroup(string[] groupFiles, bool autoCreateAssets)
{
    if (groupFiles.Length == 0)
        return;

    UndertaleModLib.Compiler.CodeImportGroup group = new(Data)
    {
        AutoCreateAssets = autoCreateAssets,
    };
    foreach (string file in groupFiles)
    {
        group.QueueReplace(Path.GetFileNameWithoutExtension(file), File.ReadAllText(file));
    }
    group.Import();
}

bool IsGlobalScript(string file) => Path.GetFileName(file).StartsWith("gml_GlobalScript_");

ImportGroup(newFiles.Where(IsGlobalScript).ToArray(), true);
ImportGroup(newFiles.Where(file => !IsGlobalScript(file)).ToArray(), true);
ImportGroup(files, false);

// lets the runner use absolute paths (program_directory) outside its AppData save area
var options = UndertaleModLib.Models.UndertaleOptions.OptionsFlags.DisableSandbox;
Data.Options.Info |= options;
Console.WriteLine("file system sandbox: disabled");

Console.WriteLine($"replaced {files.Length} code entries, added {newFiles.Length}");
