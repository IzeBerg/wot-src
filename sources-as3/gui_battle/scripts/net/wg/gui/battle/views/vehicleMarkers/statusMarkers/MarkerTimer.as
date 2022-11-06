package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class MarkerTimer extends BattleUIComponent implements IDisposable
   {
       
      
      public var timerTf:TextField = null;
      
      private var _timeLeft:int = -1;
      
      private var _timeUnits:String = "";
      
      private var _color:uint = 0;
      
      public function MarkerTimer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         TextFieldEx.setNoTranslate(this.timerTf,true);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._timeLeft >= 0)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.timerTf.text = this._timeLeft + this._timeUnits;
            }
            if(isInvalid(InvalidationType.STATE))
            {
               this.timerTf.textColor = this._color;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.timerTf = null;
         super.onDispose();
      }
      
      public function set timeLeft(param1:int) : void
      {
         if(param1 >= 0 && this._timeLeft != param1)
         {
            this._timeLeft = param1;
            invalidateData();
         }
      }
      
      public function set timeUnits(param1:String) : void
      {
         if(this._timeUnits != param1)
         {
            this._timeUnits = param1;
            invalidateData();
         }
      }
      
      public function set color(param1:uint) : void
      {
         if(this._color != param1)
         {
            this._color = param1;
            invalidateState();
         }
      }
   }
}
