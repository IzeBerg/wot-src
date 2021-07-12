package net.wg.gui.battle.views.prebattleInfo.questInfo
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class QuestInfoFlagBg extends Sprite implements IDisposable
   {
       
      
      public var scaledFlag:Sprite = null;
      
      private var _bgHeight:int;
      
      private const MIN_FLAG_BG_HEIGHT:int = 166;
      
      public function QuestInfoFlagBg()
      {
         this._bgHeight = this.MIN_FLAG_BG_HEIGHT;
         super();
      }
      
      public final function dispose() : void
      {
         this.scaledFlag = null;
      }
      
      public function setDeltaHeight(param1:int) : void
      {
         if(this._bgHeight == param1)
         {
            return;
         }
         this._bgHeight = param1;
         this.scaledFlag.height = this._bgHeight + this.MIN_FLAG_BG_HEIGHT;
      }
   }
}
