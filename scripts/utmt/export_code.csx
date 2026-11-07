// Decompiles every code entry to <PDA_EXPORT_DIR>/<name>.gml.
// scripts/setup.py runs this through UndertaleModCli.
//
// Decompiler settings are pinned (matching UndertaleModTool's GUI settings)
// so every machine produces byte-identical output for scripts/extract.sha256.

using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using UndertaleModLib.Util;

EnsureDataLoaded();

if (Data.IsYYC())
{
    ScriptError("The game uses YYC: no code is available.");
    return;
}

string codeFolder = Environment.GetEnvironmentVariable("PDA_EXPORT_DIR");
if (string.IsNullOrEmpty(codeFolder))
{
    ScriptError("PDA_EXPORT_DIR is not set.");
    return;
}
Directory.CreateDirectory(codeFolder);

var settings = new Underanalyzer.Decompiler.DecompileSettings
{
    IndentString = "    ",
    UseSemicolon = true,
    UseCSSColors = true,
    PrintWarnings = true,
    MacroDeclarationsAtTop = false,
    EmptyLineAfterBlockLocals = true,
    EmptyLineAroundEnums = true,
    EmptyLineAroundBranchStatements = true,
    EmptyLineBeforeSwitchCases = true,
    EmptyLineAfterSwitchCases = false,
    EmptyLineAroundFunctionDeclarations = true,
    EmptyLineAroundStaticInitialization = true,
    OpenBlockBraceOnSameLine = false,
    RemoveSingleLineBlockBraces = true,
    CleanupTry = true,
    CleanupElseToContinue = true,
    CleanupDefaultArgumentValues = true,
    CleanupBuiltinArrayVariables = true,
    CleanupLocalVarDeclarations = true,
    CleanupTemplateStrings = true,
    CreateEnumDeclarations = true,
    UnknownEnumName = "UnknownEnum",
    UnknownEnumValuePattern = "Value_{0}",
    UnknownArgumentNamePattern = "arg{0}",
    AllowLeftoverDataOnStack = true,
};

GlobalDecompileContext globalDecompileContext = new(Data);
var toDump = Data.Code.Where(c => c is not null && c.ParentEntry is null).ToList();

Parallel.ForEach(toDump, code =>
{
    string path = Paths.JoinVerifyWithinDirectory(codeFolder, code.Name.Content + ".gml");
    try
    {
        File.WriteAllText(path, new Underanalyzer.Decompiler.DecompileContext(globalDecompileContext, code, settings).DecompileToString());
    }
    catch (Exception e)
    {
        File.WriteAllText(path, "/*\nDECOMPILER FAILED!\n\n" + e.ToString() + "\n*/");
    }
});

Console.WriteLine($"exported {toDump.Count} code entries to {codeFolder}");
