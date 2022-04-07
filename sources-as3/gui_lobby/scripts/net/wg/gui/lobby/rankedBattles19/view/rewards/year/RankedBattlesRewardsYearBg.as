package net.wg.gui.lobby.rankedBattles19.view.rewards.year
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RankedBattlesRewardsYearBg extends MovieClip implements IDisposable
   {
      
      private static const LABEL_SHOW:String = "show";
      
      private static const LABEL_HIDE:String = "hide";
       
      
      private var _currentState:String = "hide";
      
      private var _isPermanentShow:Boolean;
      
      private var _disposed:Boolean = false;
      
      public function RankedBattlesRewardsYearBg()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         stop();
      }
      
      public function hide(param1:Boolean = false) : void
      {
         this.animate(LABEL_HIDE,param1);
      }
      
      public function show(param1:Boolean = false) : void
      {
         this.animate(LABEL_SHOW,param1);
      }
      
      private function animate(param1:String, param2:Boolean) : void
      {
         if((!this._isPermanentShow || param2) && this._currentState != param1)
         {
            this._currentState = param1;
            gotoAndPlay(param1);
         }
      }
      
      public function set isPermanentShow(param1:Boolean) : void
      {
         if(this._isPermanentShow != param1)
         {
            if(param1)
            {
               this.show(true);
            }
            else
            {
               this.hide(true);
            }
            this._isPermanentShow = param1;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
