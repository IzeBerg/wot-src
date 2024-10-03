package net.wg.white_tiger.gui.battle.views.staticMarkers
{
   import flash.display.CapsStyle;
   import flash.display.LineScaleMode;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.utils.GraphicsUtilities;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.white_tiger.gui.battle.views.shared.TimerAnimHelper;
   import net.wg.white_tiger.gui.battle.views.shared.interfaces.ITimerAnimation;
   
   public class BombActionMarkerTimer extends MovieClip implements ITimerAnimation, IDisposable
   {
      
      private static const LINE_THICKNESS:Number = 4;
      
      private static const LINE_COLOR:uint = 9753343;
      
      private static const CIRCLE_RADIUS:uint = 36;
      
      private static const ARC_START_ANGLE:Number = Math.PI / 2;
      
      private static const CIRCLE_RAD_LENGTH:Number = 2 * Math.PI;
       
      
      public var timerTF:TextField = null;
      
      public var circleAnimMC:MovieClip = null;
      
      private var _animHelper:TimerAnimHelper = null;
      
      private var _disposed:Boolean = false;
      
      public function BombActionMarkerTimer()
      {
         super();
         this._animHelper = new TimerAnimHelper(this);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function updateProgress(param1:Number, param2:int) : void
      {
         this.timerTF.text = this._animHelper.getTimeFormatted(param2);
         this.circleAnimMC.graphics.clear();
         this.circleAnimMC.graphics.lineStyle(LINE_THICKNESS,LINE_COLOR,1,false,LineScaleMode.NONE,CapsStyle.NONE);
         var _loc3_:Number = (1 - param1) * CIRCLE_RAD_LENGTH;
         GraphicsUtilities.drawArc(this.circleAnimMC.graphics,0,0,ARC_START_ANGLE,_loc3_,CIRCLE_RADIUS);
      }
      
      public function updateTime(param1:Number, param2:Number, param3:Number) : void
      {
         this._animHelper.setTime(param1,param2,param3);
      }
      
      protected function onDispose() : void
      {
         this._disposed = true;
         if(this._animHelper)
         {
            this._animHelper.dispose();
         }
         this._animHelper = null;
         this.circleAnimMC = null;
         this.timerTF = null;
      }
   }
}
