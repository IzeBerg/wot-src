package net.wg.gui.lobby.rankedBattles19.view.rewards.league
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RewardsLeagueStyleReward extends MovieClip implements IDisposable
   {
      
      public static const SIZE_NORMAL:String = "small";
      
      public static const SIZE_WIDE:String = "big";
      
      private static const LABEL_REWARD:String = "reward";
      
      private static const LABEL_OVER:String = "over";
      
      private static const LABEL_OUT:String = "out";
       
      
      public var smallIcon:FrameStateCmpnt = null;
      
      public var bigIcon:FrameStateCmpnt = null;
      
      public var selectSmallIcon:Sprite = null;
      
      public var selectBigIcon:Sprite = null;
      
      private var _curSize:String = "";
      
      private var _curLeagueId:uint = 0;
      
      private var _selected:Boolean = false;
      
      public function RewardsLeagueStyleReward()
      {
         super();
         this.smallIcon.visible = false;
         this.bigIcon.visible = false;
         this.selectSmallIcon.visible = false;
         this.selectBigIcon.visible = false;
      }
      
      public final function dispose() : void
      {
         stop();
         this.smallIcon.dispose();
         this.smallIcon = null;
         this.selectSmallIcon = null;
         this.bigIcon.dispose();
         this.bigIcon = null;
         this.selectBigIcon = null;
      }
      
      public function out() : void
      {
         gotoAndPlay(LABEL_OUT);
      }
      
      public function over() : void
      {
         gotoAndPlay(LABEL_OVER);
      }
      
      public function setData(param1:String, param2:int) : void
      {
         if(this._curSize != param1 || this._curLeagueId != param2)
         {
            this._curSize = param1;
            this._curLeagueId = param2;
            this.smallIcon.frameLabel = LABEL_REWARD + this._curLeagueId;
            this.bigIcon.frameLabel = LABEL_REWARD + this._curLeagueId;
            this.updateVisibility();
         }
      }
      
      public function updateVisibility() : void
      {
         this.smallIcon.visible = this._curSize == SIZE_NORMAL;
         this.selectSmallIcon.visible = this._curSize == SIZE_NORMAL && this._selected;
         this.bigIcon.visible = this._curSize == SIZE_WIDE;
         this.selectBigIcon.visible = this._curSize == SIZE_WIDE && this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
         this.updateVisibility();
      }
   }
}
