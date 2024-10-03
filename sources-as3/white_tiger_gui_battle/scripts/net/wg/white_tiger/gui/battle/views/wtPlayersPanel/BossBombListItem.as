package net.wg.white_tiger.gui.battle.views.wtPlayersPanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.white_tiger.gui.battle.views.shared.TimerAnimHelper;
   import net.wg.white_tiger.gui.battle.views.shared.interfaces.ITimerAnimation;
   
   public class BossBombListItem extends BattleUIComponent implements ITimerAnimation
   {
       
      
      public var timerBar:MovieClip = null;
      
      public var titleTF:TextField = null;
      
      public var timerTF:TextField = null;
      
      public var indexTF:TextField = null;
      
      private var _id:int = -1;
      
      private var _animHelper:TimerAnimHelper = null;
      
      public function BossBombListItem()
      {
         super();
         this._animHelper = new TimerAnimHelper(this);
      }
      
      override protected function onDispose() : void
      {
         this._animHelper.dispose();
         this._animHelper = null;
         this.timerBar = null;
         this.timerTF = null;
         this.indexTF = null;
         this.titleTF = null;
         super.onDispose();
      }
      
      public function updateProgress(param1:Number, param2:int) : void
      {
         var _loc3_:int = param1 * this.timerBar.totalFrames >> 0;
         this.timerBar.gotoAndStop(_loc3_);
         this.timerTF.text = this._animHelper.getTimeFormatted(param2);
      }
      
      public function updateTime(param1:Number, param2:Number, param3:Number) : void
      {
         this._animHelper.setTime(param1,param2,param3);
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
         var _loc2_:String = String(param1);
         this.titleTF.text = App.utils.locale.makeString(EVENT.PLAYERSPANEL_BOMBLABEL,{"id":_loc2_});
         this.indexTF.text = _loc2_;
      }
   }
}
