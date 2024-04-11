package net.wg.gui.battle.historicalBattles.playersPanel.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class HBLiveCounter extends BattleUIComponent
   {
      
      private static const LIVES_ICON_AVAILABLE:Number = 1;
      
      private static const CROSS_ICON_AVAILABLE:Number = 0.5;
      
      private static const TEXT_AVAILABLE:Number = 0.7;
      
      private static const LIVES_ICON_DISABLE:Number = 0.35;
      
      private static const CROSS_ICON_DISABLE:Number = 0.35;
      
      private static const TEXT_DISABLE:Number = 0.35;
       
      
      public var livesTF:TextField = null;
      
      public var livesIconMc:MovieClip = null;
      
      public var crossIconMc:MovieClip = null;
      
      private var _lives:int = 0;
      
      private var _isAvailable:Boolean = false;
      
      public function HBLiveCounter()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.livesTF.text = this._lives.toString();
         }
         if(isInvalid(InvalidationType.COLOR_SCHEME))
         {
            this.livesIconMc.alpha = !!this._isAvailable ? Number(LIVES_ICON_AVAILABLE) : Number(LIVES_ICON_DISABLE);
            this.crossIconMc.alpha = !!this._isAvailable ? Number(CROSS_ICON_AVAILABLE) : Number(CROSS_ICON_DISABLE);
            this.livesTF.alpha = !!this._isAvailable ? Number(TEXT_AVAILABLE) : Number(TEXT_DISABLE);
         }
      }
      
      override protected function onDispose() : void
      {
         this.livesTF = null;
         this.livesIconMc = null;
         this.crossIconMc = null;
         super.onDispose();
      }
      
      public function set lives(param1:int) : void
      {
         if(this._lives == param1)
         {
            return;
         }
         this._lives = param1;
         invalidateData();
      }
      
      public function set isAvailable(param1:Boolean) : void
      {
         if(this._isAvailable == param1)
         {
            return;
         }
         this._isAvailable = param1;
         invalidate(InvalidationType.COLOR_SCHEME);
      }
   }
}
