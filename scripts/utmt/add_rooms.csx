// Adds rooms cloned from existing rooms. scripts/build.py runs this through UndertaleModCli
// before scripts/utmt/import_code.csx, so code added from PicayuneDreams_new can refer to the
// new rooms by name.
//
// A clone copies the source room's settings, views, layers (effects, backgrounds, asset
// sprites) and the placed instances whose object is listed in KeepObjects. Instances get new
// instance ids and no creation code; room and instance creation code comes from
// PicayuneDreams_new (gml_Room_<room>_Create.gml).

using System;
using System.Collections.Generic;
using System.Linq;
using UndertaleModLib;
using UndertaleModLib.Models;

EnsureDataLoaded();

// (new room, source room, objects whose placed instances are copied)
var clones = new (string Name, string Source, string[] KeepObjects)[]
{
    ("rm_ap_connect", "rm_mainmenu", new[] { "obj_fadein" }),
};

foreach (var (name, sourceName, keepObjects) in clones)
{
    if (Data.Rooms.ByName(name) is not null)
    {
        ScriptError("Room already exists: " + name);
        return;
    }
    UndertaleRoom source = Data.Rooms.ByName(sourceName);
    if (source is null)
    {
        ScriptError("No such source room: " + sourceName);
        return;
    }

    var room = new UndertaleRoom
    {
        Name = Data.Strings.MakeString(name),
        Caption = source.Caption,
        Width = source.Width,
        Height = source.Height,
        Speed = source.Speed,
        Persistent = source.Persistent,
        BackgroundColor = source.BackgroundColor,
        DrawBackgroundColor = source.DrawBackgroundColor,
        Flags = source.Flags,
        World = source.World,
        Top = source.Top,
        Left = source.Left,
        Right = source.Right,
        Bottom = source.Bottom,
        GravityX = source.GravityX,
        GravityY = source.GravityY,
        MetersPerPixel = source.MetersPerPixel,
        GridWidth = source.GridWidth,
        GridHeight = source.GridHeight,
        GridThicknessPx = source.GridThicknessPx,
    };

    // a new room starts with default views and backgrounds
    room.Views.Clear();
    room.Backgrounds.Clear();

    foreach (var v in source.Views)
    {
        room.Views.Add(new UndertaleRoom.View
        {
            Enabled = v.Enabled, ViewX = v.ViewX, ViewY = v.ViewY, ViewWidth = v.ViewWidth, ViewHeight = v.ViewHeight,
            PortX = v.PortX, PortY = v.PortY, PortWidth = v.PortWidth, PortHeight = v.PortHeight,
            BorderX = v.BorderX, BorderY = v.BorderY, SpeedX = v.SpeedX, SpeedY = v.SpeedY, ObjectId = v.ObjectId,
        });
    }

    foreach (var b in source.Backgrounds)
    {
        room.Backgrounds.Add(new UndertaleRoom.Background
        {
            Enabled = b.Enabled, Foreground = b.Foreground, BackgroundDefinition = b.BackgroundDefinition,
            X = b.X, Y = b.Y, SpeedX = b.SpeedX, SpeedY = b.SpeedY, Stretch = b.Stretch,
            TiledHorizontally = b.TiledHorizontally, TiledVertically = b.TiledVertically,
        });
    }

    var effectProperties = new Func<IEnumerable<UndertaleRoom.EffectProperty>, IEnumerable<UndertaleRoom.EffectProperty>>(
        props => props.Select(p => new UndertaleRoom.EffectProperty { Kind = p.Kind, Name = p.Name, Value = p.Value }));

    foreach (var sl in source.Layers)
    {
        var layer = new UndertaleRoom.Layer
        {
            ParentRoom = room,
            LayerName = sl.LayerName,
            LayerId = sl.LayerId,
            LayerType = sl.LayerType,
            LayerDepth = sl.LayerDepth,
            XOffset = sl.XOffset,
            YOffset = sl.YOffset,
            HSpeed = sl.HSpeed,
            VSpeed = sl.VSpeed,
            IsVisible = sl.IsVisible,
        };

        switch (sl.LayerType)
        {
            case UndertaleRoom.LayerType.Instances:
                layer.Data = new UndertaleRoom.Layer.LayerInstancesData();
                foreach (var si in sl.InstancesData.Instances.Where(i => keepObjects.Contains(i.ObjectDefinition.Name.Content)))
                {
                    var instance = new UndertaleRoom.GameObject
                    {
                        X = si.X, Y = si.Y, ObjectDefinition = si.ObjectDefinition,
                        InstanceID = ++Data.GeneralInfo.LastObj,
                        ScaleX = si.ScaleX, ScaleY = si.ScaleY, Color = si.Color, Rotation = si.Rotation,
                        ImageSpeed = si.ImageSpeed, ImageIndex = si.ImageIndex,
                    };
                    room.GameObjects.Add(instance);
                    layer.InstancesData.Instances.Add(instance);
                }
                break;

            case UndertaleRoom.LayerType.Background:
                var sb = sl.BackgroundData;
                layer.Data = new UndertaleRoom.Layer.LayerBackgroundData
                {
                    ParentLayer = layer, Visible = sb.Visible, Foreground = sb.Foreground, Sprite = sb.Sprite,
                    TiledHorizontally = sb.TiledHorizontally, TiledVertically = sb.TiledVertically, Stretch = sb.Stretch,
                    Color = sb.Color, FirstFrame = sb.FirstFrame, AnimationSpeed = sb.AnimationSpeed,
                    AnimationSpeedType = sb.AnimationSpeedType,
                };
                break;

            case UndertaleRoom.LayerType.Assets:
                var sa = sl.AssetsData;
                var assets = new UndertaleRoom.Layer.LayerAssetsData
                {
                    LegacyTiles = new UndertalePointerList<UndertaleRoom.Tile>(),
                    Sprites = new UndertalePointerList<UndertaleRoom.SpriteInstance>(),
                    Sequences = new UndertalePointerList<UndertaleRoom.SequenceInstance>(),
                    NineSlices = new UndertalePointerList<UndertaleRoom.SpriteInstance>(),
                    ParticleSystems = new UndertalePointerList<UndertaleRoom.ParticleSystemInstance>(),
                    TextItems = new UndertalePointerList<UndertaleRoom.TextItemInstance>(),
                };
                foreach (var s in sa.Sprites ?? new UndertalePointerList<UndertaleRoom.SpriteInstance>())
                    assets.Sprites.Add(new UndertaleRoom.SpriteInstance
                    {
                        Name = s.Name, Sprite = s.Sprite, X = s.X, Y = s.Y, ScaleX = s.ScaleX, ScaleY = s.ScaleY,
                        Color = s.Color, AnimationSpeed = s.AnimationSpeed, AnimationSpeedType = s.AnimationSpeedType,
                        FrameIndex = s.FrameIndex, Rotation = s.Rotation,
                    });
                if ((sa.LegacyTiles?.Count ?? 0) + (sa.Sequences?.Count ?? 0) + (sa.NineSlices?.Count ?? 0)
                    + (sa.ParticleSystems?.Count ?? 0) + (sa.TextItems?.Count ?? 0) > 0)
                {
                    ScriptError("Layer " + sl.LayerName.Content + " of " + sourceName + " holds assets other than sprites; extend add_rooms.csx to copy them.");
                    return;
                }
                layer.Data = assets;
                break;

            case UndertaleRoom.LayerType.Effect:
                layer.Data = new UndertaleRoom.Layer.LayerEffectData
                {
                    EffectType = sl.EffectData.EffectType,
                    Properties = new UndertaleSimpleList<UndertaleRoom.EffectProperty>(),
                };
                foreach (var p in effectProperties(sl.EffectData.Properties))
                    ((UndertaleRoom.Layer.LayerEffectData)layer.Data).Properties.Add(p);
                break;

            default:
                ScriptError("Layer type " + sl.LayerType + " of " + sourceName + " is not supported by add_rooms.csx.");
                return;
        }

        room.Layers.Add(layer);
    }

    Data.Rooms.Add(room);
    Data.GeneralInfo.RoomOrder.Add(new UndertaleResourceById<UndertaleRoom, UndertaleChunkROOM> { Resource = room });
    Console.WriteLine($"added room {name}: {room.Layers.Count} layers, {room.GameObjects.Count} instances, cloned from {sourceName}");
}
