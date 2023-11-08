package net.wg.gui.lobby.vehicleCompare.nodes
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.ModuleTypesUIWithFill;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ModuleItemNode extends ModuleRenderer
   {
      
      private static const EXTRA_ICON_ALPHA:int = 