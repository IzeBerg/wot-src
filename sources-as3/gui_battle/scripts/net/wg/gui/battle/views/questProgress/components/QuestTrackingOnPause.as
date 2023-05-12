package net.wg.gui.battle.views.questProgress.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class QuestTrackingOnPause extends Sprite implements IDisposable
   {
      
      private static const ICON_SHIFT_X:int = -2;
       
      
      public var textField:TextField = null;
      
      public var ico:Sprite = null;
      
      public var bg:Sprite = null;
      
      private var _disposed:Boolean = false;
      
      public function QuestTrackingOnPause()
      {
         super();
         var _loc1_:String = App.utils.locale.makeString(PERSONAL_MISSIONS.QUESTPROGRESSTRACKING_STATUS_ONPAUSE);
         App.utils.commons.truncateTextFieldText(this.textField,_loc1_);
         App.utils.commons.updateTextFieldSize(this.textField,true,false);
         var _loc2_:int = this.ico.width + this.textField.width;
         this.ico.x = ICON_SHIFT_X + (this.bg.width - _loc2_ >> 1);
         this.textField.x = this.ico.x + this.ico.width;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.bg = null;
         this.textField = null;
         this.ico = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
