package net.wg.gui.lobby.epicBattles.components.afterBattle
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EpicBattlesAfterBattleMaxLevelInfo extends Sprite implements IDisposable
   {
      
      private static const ICON_TEXT_GAP:int = 0;
       
      
      public var icon:Sprite = null;
      
      public var titleTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      private var _baseDisposed:Boolean = false;
      
      public function EpicBattlesAfterBattleMaxLevelInfo()
      {
         super();
         this.titleTF.text = EPIC_BATTLE.EPIC_BATTLES_AFTER_BATTLE_MAX_LEVEL_INFO_TITLE;
         App.utils.commons.updateTextFieldSize(this.titleTF,true,false);
         this.descriptionTF.text = EPIC_BATTLE.EPIC_BATTLES_AFTER_BATTLE_MAX_LEVEL_INFO_DESCRIPTION;
         App.utils.commons.updateTextFieldSize(this.descriptionTF,true,false);
         var _loc1_:Number = this.icon.width + ICON_TEXT_GAP + Math.max(this.titleTF.width,this.descriptionTF.width);
         this.icon.x = -_loc1_ >> 1;
         this.titleTF.x = this.descriptionTF.x = this.icon.x + this.icon.width + ICON_TEXT_GAP | 0;
      }
      
      protected function onDispose() : void
      {
         this.descriptionTF = null;
         this.titleTF = null;
         this.icon = null;
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
   }
}
