package net.wg.gui.battle.eventBattle.views.battleHints
{
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import net.wg.gui.battle.eventBattle.views.battleHints.data.HintInfoVO;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.motion.Tween;
   
   public class InfoContainer extends MovieClip implements IDisposable
   {
      
      private static const TWEEN_TIME:uint = 500;
      
      private static const TIMER_Y_OFFSET:uint = 10;
       
      
      public var txtMessage:TextContainer = null;
      
      public var icon:Image = null;
      
      public var timer:TimerContainer = null;
      
      public var bg:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      private var _alphaTween:Tween = null;
      
      private var _data:HintInfoVO = null;
      
      private var _stageHeight:int = 0;
      
      private var _initialBgY:int = 0;
      
      private var _initialMessageY:int = 0;
      
      public function InfoContainer()
      {
         super();
         this._initialBgY = this.bg.y;
         this._initialMessageY = this.txtMessage.y;
         this.alpha = 0;
      }
      
      private function updateLayout() : void
      {
         this.bg.visible = this._data != null && StringUtils.isNotEmpty(this._data.backgroundColor);
         this.icon.visible = this._data != null && StringUtils.isNotEmpty(this._data.iconSource) && this._stageHeight > StageSizeBoundaries.HEIGHT_900;
         this.bg.y = !!this.icon.visible ? Number(this._initialBgY) : Number(this._initialBgY - this._initialMessageY);
         this.txtMessage.y = !!this.icon.visible ? Number(this._initialMessageY) : Number(0);
         this.timer.y = this.txtMessage.y + this.txtMessage.height + TIMER_Y_OFFSET | 0;
      }
      
      private function animateAlpha(param1:Number, param2:Number, param3:uint) : void
      {
         this.clearTweens();
         this.alpha = param1;
         this._alphaTween = new Tween(param3,this,{"alpha":param2},{
            "ease":Strong.easeInOut,
            "onComplete":this.onAlphaTweenComplete
         });
      }
      
      private function onAlphaTweenComplete(param1:Tween) : void
      {
         this.clearTweens();
      }
      
      private function clearTweens() : void
      {
         if(this._alphaTween)
         {
            this._alphaTween.dispose();
            this._alphaTween = null;
         }
      }
      
      public function showHint(param1:HintInfoVO) : void
      {
         this._data = param1;
         if(StringUtils.isNotEmpty(param1.iconSource))
         {
            this.icon.source = param1.iconSource;
         }
         if(StringUtils.isNotEmpty(param1.backgroundColor))
         {
            this.bg.gotoAndStop(param1.backgroundColor);
         }
         this.txtMessage.setText(param1.message);
         this.timer.startTimer(param1.timer);
         this.updateLayout();
         this.animateAlpha(0,1,TWEEN_TIME);
      }
      
      public function hideHint() : void
      {
         this.timer.stopTimer();
         this.clearTweens();
         this.animateAlpha(1,0,TWEEN_TIME);
      }
      
      public function closeHint() : void
      {
         this.timer.stopTimer();
         this.clearTweens();
         this.alpha = 0;
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._stageHeight = param2;
         this.updateLayout();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.clearTweens();
         this._data = null;
         this.bg = null;
         this.timer.dispose();
         this.timer = null;
         this.txtMessage.dispose();
         this.txtMessage = null;
         this.icon.dispose();
         this.icon = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
