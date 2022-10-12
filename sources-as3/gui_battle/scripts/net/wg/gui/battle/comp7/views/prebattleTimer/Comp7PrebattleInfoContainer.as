package net.wg.gui.battle.comp7.views.prebattleTimer
{
   import net.wg.gui.battle.views.prebattleInfo.PrebattleInfoContainer;
   
   public class Comp7PrebattleInfoContainer extends PrebattleInfoContainer
   {
       
      
      private var _isInfoVisible:Boolean = false;
      
      public function Comp7PrebattleInfoContainer()
      {
         super();
      }
      
      override public function hideByTimer() : void
      {
         if(this._isInfoVisible)
         {
            this._isInfoVisible = false;
            super.hideByTimer();
         }
      }
      
      override public function hideInfo() : void
      {
         if(this._isInfoVisible)
         {
            this._isInfoVisible = false;
            super.hideInfo();
         }
      }
      
      override public function resetByTimer() : void
      {
         this._isInfoVisible = true;
         super.resetByTimer();
      }
      
      override public function showInfo() : Boolean
      {
         this._isInfoVisible = super.showInfo();
         return this._isInfoVisible;
      }
   }
}
