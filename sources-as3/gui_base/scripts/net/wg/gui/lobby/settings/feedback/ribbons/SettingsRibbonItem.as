package net.wg.gui.lobby.settings.feedback.ribbons
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.components.ribbon.RibbonIcons;
   import net.wg.gui.components.ribbon.RibbonTexts;
   import net.wg.gui.components.ribbon.data.RibbonSettingsLobby;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IClassFactory;
   
   public class SettingsRibbonItem extends Sprite implements IDisposable
   {
      
      private static const PADDING:int = -88;
       
      
      private var _icons:RibbonIcons;
      
      private var _texts:RibbonTexts;
      
      private var _disposed:Boolean = false;
      
      private var _ribbonType:String;
      
      public function SettingsRibbonItem(param1:RibbonSettingsLobby)
      {
         super();
         this._ribbonType = param1.getRibbonType();
         var _loc2_:IClassFactory = App.utils.classFactory;
         this._icons = _loc2_.getComponent(Linkages.RIBBON_ICONS,RibbonIcons);
         this._texts = _loc2_.getComponent(Linkages.RIBBON_TEXT,RibbonTexts);
         this._texts.init(param1);
         var _loc3_:TextField = this._texts.ribbonNameTF;
         this._icons.init(ATLAS_CONSTANTS.COMMON_BATTLE_LOBBY,param1,_loc3_.x + _loc3_.textWidth);
         addChild(this._icons);
         addChild(this._texts);
         x = PADDING;
         this.updateSettings(true,true);
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function setData(param1:String, param2:String, param3:String) : void
      {
         this._texts.setData(param2,param3,Values.EMPTY_STR,param1);
         this._icons.setDamageSourceIcon(param1);
      }
      
      public function update() : void
      {
         this._icons.updateIcons();
         this._texts.updateTextFields();
      }
      
      public function updateSettings(param1:Boolean, param2:Boolean) : void
      {
         this._texts.setSettings(false,param1,param2);
         this._icons.setSettings(param1,param2);
      }
      
      protected function onDispose() : void
      {
         this._disposed = true;
         this._icons.dispose();
         removeChild(this._icons);
         this._icons = null;
         this._texts.dispose();
         removeChild(this._texts);
         this._texts = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
