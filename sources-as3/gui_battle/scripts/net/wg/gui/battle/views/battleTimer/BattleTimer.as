package net.wg.gui.battle.views.battleTimer
{
   import flash.text.TextField;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import scaleform.gfx.TextFieldEx;
   
   public class BattleTimer extends BaseBattleTimer
   {
      
      private static const TIMER_COLOR_WHITE:String = "timerNormal";
      
      private static const TIMER_COLOR_RED:String = "timerRed";
       
      
      public var minutesTF:TextField;
      
      public var secondsTF:TextField;
      
      public var dotsTF:TextField;
      
      private var _minutes:String;
      
      private var _criticalColorStr:String = "timerNormal";
      
      private var _colorSchemeMgr:IColorSchemeManager = null;
      
      public function BattleTimer()
      {
         super();
         TextFieldEx.setNoTranslate(this.minutesTF,true);
         TextFieldEx.setNoTranslate(this.secondsTF,true);
         TextFieldEx.setNoTranslate(this.dotsTF,true);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this.dotsTF.text = COMMON.COMMON_COLON;
      }
      
      override protected function onPopulate() : void
      {
         this._colorSchemeMgr = App.colorSchemeMgr;
         this._colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeChangeHandler);
         super.onPopulate();
      }
      
      override protected function onDispose() : void
      {
         this.minutesTF = null;
         this.secondsTF = null;
         this.dotsTF = null;
         this._colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeChangeHandler);
         this._colorSchemeMgr = null;
         super.onDispose();
      }
      
      override public function as_setColor(param1:Boolean) : void
      {
         if(param1)
         {
            this._criticalColorStr = TIMER_COLOR_RED;
         }
         else
         {
            this._criticalColorStr = TIMER_COLOR_WHITE;
         }
         this.updateColors();
      }
      
      override public function as_setTotalTime(param1:String, param2:String) : void
      {
         if(this._minutes != param1)
         {
            this._minutes = param1;
            this.minutesTF.text = param1;
         }
         this.secondsTF.text = param2;
      }
      
      private function updateColors() : void
      {
         var _loc1_:uint = this._colorSchemeMgr.getRGB(this._criticalColorStr);
         this.minutesTF.textColor = _loc1_;
         this.secondsTF.textColor = _loc1_;
         this.dotsTF.textColor = _loc1_;
      }
      
      private function onColorSchemeChangeHandler(param1:ColorSchemeEvent) : void
      {
         this.updateColors();
      }
   }
}
