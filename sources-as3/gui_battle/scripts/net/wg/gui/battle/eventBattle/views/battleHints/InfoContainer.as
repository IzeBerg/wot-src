package net.wg.gui.battle.eventBattle.views.battleHints
{
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import net.wg.gui.battle.eventBattle.views.helpers.IAnimateAlpha;
   import net.wg.gui.battle.views.battleHint.vo.BattleHintVO;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.motion.Tween;
   
   public class InfoContainer extends MovieClip implements IDisposable, IAnimateAlpha
   {
      
      private static const TWEEN_TIME:uint = 500;
      
      private static const TIMER_Y_OFFSET:uint = 10;
      
      private static const WT_LABEL:String = "wt";
       
      
      public var txtMessage:TextContainer = null;
      
      public var icon:Image = null;
      
      public var bg:MovieClip = null;
      
      public var hintTimer:TimerContainer = null;
      
      private var _disposed:Boolean = false;
      
      private var _alphaTween:Tween = null;
      
      private var _data:BattleHintVO = null;
      
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
         this.bg.visible = this._data != null;
         this.icon.visible = this._data != null && StringUtils.isNotEmpty(this._data.iconSource);
         this.bg.y = !!this.icon.visible ? Number(this._initialBgY) : Number(this._initialBgY - this._initialMessageY);
         this.txtMessage.y = !!this.icon.visible ? Number(this._initialMessageY) : Number(0);
         this.hintTimer.y = this.txtMessage.y + this.txtMessage.height + TIMER_Y_OFFSET | 0;
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.updateLayout();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.clearTweens();
         this._data = null;
         this.bg = null;
         this.hintTimer.dispose();
         this.hintTimer = null;
         this.txtMessage.dispose();
         this.txtMessage = null;
         this.icon.dispose();
         this.icon = null;
      }
      
      public function animateAlpha(param1:Number, param2:Number, param3:uint) : void
      {
         this.clearTweens();
         this.alpha = param1;
         this._alphaTween = new Tween(param3,this,{"alpha":param2},{
            "ease":Strong.easeInOut,
            "onComplete":this.onAlphaTweenComplete
         });
      }
      
      public function onAlphaTweenComplete(param1:Tween) : void
      {
         this.clearTweens();
      }
      
      public function clearTweens() : void
      {
         if(this._alphaTween)
         {
            this._alphaTween.dispose();
            this._alphaTween = null;
         }
      }
      
      public function showHint(param1:BattleHintVO) : void
      {
         this._data = param1;
         if(StringUtils.isNotEmpty(param1.iconSource))
         {
            this.icon.source = RES_ICONS.getEventHintIcon(param1.iconSource);
         }
         this.bg.gotoAndStop(WT_LABEL);
         this.txtMessage.setText(param1.message);
         this.hintTimer.visible = true;
         this.hintTimer.startTimer(param1.timer);
         this.updateLayout();
         this.animateAlpha(0,1,TWEEN_TIME);
      }
      
      public function hideHint() : void
      {
         this.hintTimer.stopTimer();
         this.clearTweens();
         this.animateAlpha(1,0,TWEEN_TIME);
      }
      
      public function hideHintImmediately() : void
      {
         this.hintTimer.stopTimer();
         this.clearTweens();
         this.alpha = 0;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
