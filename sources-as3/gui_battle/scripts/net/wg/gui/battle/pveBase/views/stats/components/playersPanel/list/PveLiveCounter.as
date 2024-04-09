package net.wg.gui.battle.pveBase.views.stats.components.playersPanel.list
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class PveLiveCounter extends BattleUIComponent
   {
      
      private static const AVAILABLE_FRAME:int = 1;
      
      private static const DISABLE_FRAME:int = 2;
       
      
      public var livesTF:TextField = null;
      
      public var livesIconMc:MovieClip = null;
      
      private var _lives:int = 0;
      
      private var _isAvailable:Boolean = false;
      
      public function PveLiveCounter()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.livesTF.text = App.utils.locale.makeString(COMMON.MULTIPLIER) + this._lives.toString();
            this.livesTF.visible = this._isAvailable;
            this.livesIconMc.gotoAndStop(!!this._isAvailable ? AVAILABLE_FRAME : DISABLE_FRAME);
         }
      }
      
      override protected function onDispose() : void
      {
         this.livesTF = null;
         this.livesIconMc = null;
         super.onDispose();
      }
      
      public function set lives(param1:int) : void
      {
         if(this._lives == param1)
         {
            return;
         }
         this._lives = param1;
         this._isAvailable = param1 > Values.ZERO;
         invalidateData();
      }
   }
}
