// Sets each room's creation code to the code entry gml_Room_<room>_Create when the room has none.
// scripts/build.py runs this through UndertaleModCli after scripts/utmt/import_code.csx, which adds
// the code entries from PicayuneDreams_new but does not attach them to rooms.

using System;

EnsureDataLoaded();

int linked = 0;
foreach (var room in Data.Rooms)
{
    if (room.CreationCodeId is not null)
        continue;

    var code = Data.Code.ByName("gml_Room_" + room.Name.Content + "_Create");
    if (code is null)
        continue;

    room.CreationCodeId = code;
    linked++;
    Console.WriteLine("linked creation code to " + room.Name.Content);
}

Console.WriteLine($"linked {linked} room creation codes");
