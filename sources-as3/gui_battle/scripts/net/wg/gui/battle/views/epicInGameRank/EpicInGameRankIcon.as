package net.wg.gui.battle.views.epicInGameRank
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class EpicInGameRankIcon extends BattleUIComponent
   {
      
      private static const NORMAL_STATE:String = "normal";
      
      private static const RANKUP_STATE:String = "rankup";
      
      private static const END_FRAME:int = 28;
       
      
      public var glow:MovieClip = null;
      
      public var icon:MovieClip = null;
      
      private var _currentRank:int = -1;
      
      private var _previousRank:int = -1;
      
      public function EpicInGameRankIcon()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addFrameScript(END_FRAME,this.onTweenComplete);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._currentRank != this._previousRank)
            {
               this.icon.gotoAndStop(this._currentRank);
               gotoAndPlay(RANKUP_STATE);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         addFrameScript(END_FRAME,null);
         stop();
         this.glow = null;
         this.icon = null;
         super.onDispose();
      }
      
      public function setRankProgressData(param1:int) : void
      {
         if(param1 != this._currentRank)
         {
            this._previousRank = this._currentRank;
            this._currentRank = param1;
            invalidateData();
         }
      }
      
      private function onTweenComplete() : void
      {
         gotoAndStop(NORMAL_STATE);
      }
   }
}
