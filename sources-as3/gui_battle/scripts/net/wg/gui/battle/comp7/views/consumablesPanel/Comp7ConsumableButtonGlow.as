package net.wg.gui.battle.comp7.views.consumablesPanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.CONSUMABLES_PANEL_SETTINGS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleEquipmentButtonGlow;
   import net.wg.infrastructure.interfaces.IImage;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.TextFieldEx;
   
   public class Comp7ConsumableButtonGlow extends BattleUIComponent implements IBattleEquipmentButtonGlow
   {
      
      private static const INV_ICON:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const SHOW_GLOW_GREEN_STATE:String = "green";
      
      private static const SHOW_GLOW_ORANGE_STATE:String = "orange";
      
      private static const SHOW_GLOW_ORANGE_SPECIAL_STATE:String = "orangeSpecial";
      
      private static const SHOW_GLOW_ORANGE_UPGRADE_STATE:String = "orangeUpgrade";
      
      private static const NORMAL_TEXT_COLOR:uint = 0;
       
      
      public var tfContainer:MovieClip = null;
      
      public var iconMc:MovieClip = null;
      
      private var _textField:TextField = null;
      
      private var _sourceIcon:String = null;
      
      private var _icon:IImage = null;
      
      public function Comp7ConsumableButtonGlow()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._textField = this.tfContainer.bindKeyField;
         this._textField.textColor = NORMAL_TEXT_COLOR;
         TextFieldEx.setNoTranslate(this._textField,true);
         this._icon = this.iconMc.icon;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(StringUtils.isNotEmpty(this._sourceIcon) && isInvalid(INV_ICON))
         {
            this._icon.source = this._sourceIcon;
         }
      }
      
      override protected function onDispose() : void
      {
         this._textField = null;
         this.tfContainer = null;
         this._icon.dispose();
         this._icon = null;
         this.iconMc = null;
         super.onDispose();
      }
      
      public function hideGlow(param1:Boolean = true) : void
      {
      }
      
      public function setBindKeyText(param1:String) : void
      {
         this._textField.text = param1;
      }
      
      public function setIcon(param1:String) : void
      {
         this._sourceIcon = param1;
         invalidate(INV_ICON);
      }
      
      public function showGlow(param1:int, param2:Boolean = true) : void
      {
         if(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_ORANGE)
         {
            gotoAndPlay(SHOW_GLOW_ORANGE_STATE);
         }
         else if(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_ORANGE_UPGRADE)
         {
            gotoAndPlay(SHOW_GLOW_ORANGE_UPGRADE_STATE);
         }
         else if(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_ORANGE_SPECIAL)
         {
            gotoAndPlay(SHOW_GLOW_ORANGE_SPECIAL_STATE);
         }
         else if(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_GREEN || param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_GREEN_SPECIAL)
         {
            gotoAndPlay(SHOW_GLOW_GREEN_STATE);
         }
      }
   }
}
