package net.wg.gui.battle.eventBattle.views.timersPanel
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class WtBombCarryIconContent extends Sprite implements ITimerIconContent, IDisposable
   {
      
      private static const GAP:int = 4;
      
      private static const KEYLABELTF_OFFSET_X:int = 2;
       
      
      public var bombIndexTF:TextField = null;
      
      public var tipLabelTF:TextField = null;
      
      public var keyLabelTF:TextField = null;
      
      public var hintBg:Sprite = null;
      
      private var _disposed:Boolean = false;
      
      public function WtBombCarryIconContent()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.bombIndexTF = null;
         this.tipLabelTF = null;
         this.keyLabelTF = null;
         this.hintBg = null;
      }
      
      public function setSettings(param1:NotificationTimerSettingVO) : void
      {
         this.tipLabelTF.text = "";
         this.keyLabelTF.text = App.utils.commons.keyToString(param1.tipKeyCode).keyName;
         App.utils.commons.updateTextFieldSize(this.tipLabelTF);
         App.utils.commons.updateTextFieldSize(this.keyLabelTF);
         var _loc2_:int = this.hintBg.width + this.tipLabelTF.textWidth + GAP;
         this.hintBg.x = -(_loc2_ >> 1);
         this.keyLabelTF.x = this.hintBg.x + (this.hintBg.width - this.keyLabelTF.textWidth >> 1) - KEYLABELTF_OFFSET_X | 0;
         this.tipLabelTF.x = this.hintBg.x + this.hintBg.width + GAP | 0;
      }
      
      public function updateData(param1:StatusNotificationVO) : void
      {
         this.bombIndexTF.text = String(param1.additionalInfo);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
