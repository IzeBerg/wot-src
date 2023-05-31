package net.wg.gui.lobby.profile.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.dogtag.DogtagComponent;
   import net.wg.gui.lobby.profile.ProfileOpenInfoEvent;
   import net.wg.gui.lobby.profile.data.ProfileGroupBlockVO;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.events.ButtonEvent;
   
   public class ProfileWindowFooter extends ProfileFooter
   {
      
      private static const BACKGROUND_HIT_AREA_WIDTH_MULT:Number = 