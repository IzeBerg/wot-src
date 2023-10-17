package net.wg.gui.battle.battleRoyale.views.components.respawnMessages
{
   import fl.motion.easing.Cubic;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.battleRoyale.data.RespawnMessageVO;
   import net.wg.gui.battle.components.BattleUIComponent;
   import scaleform.clik.motion.Tween;
   
   public class BaseRespawnMessage extends BattleUIComponent implements IRespawnMessage
   {
      
      private static const SHOW_TWEEN_DELAY:int = 500;
      
      private static const SHOW_TWEEN_TIME:int = 250;
      
      private static const HIDE_TWEEN_TIME:int = 300;
       
      
      public var bg:Sprite = null;
      
      private var _data:RespawnMessageVO = null;
      
      private var _curTime:int = 0;
      
      private var _showWithDelay:Boolean = true;
      
      private var _showTween:Tween = null;
      
      private var _hideTween:Tween = null;
      
      public function BaseRespawnMessage()
      {
         super();
         alpha = 0;
         scaleX = 0;
         scaleY = 0;
      }
      
      override protected function onDispose() : void
      {
         this.bg = null;
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         this.clearTweens();
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this._curTime = this._data.time;
         }
      }
      
      public function hide() : void
      {
         this.clearTweens();
         if(this._data.quickHide)
         {
            visible = false;
            this.onHideCompleteHandler();
         }
         else
         {
            this._hideTween = new Tween(HIDE_TWEEN_TIME,this,{
               "alpha":1,
               "scaleX":0,
               "scaleY":0
            },{
               "fastTransform":false,
               "ease":Cubic.easeIn,
               "onComplete":this.onHideCompleteHandler
            });
         }
      }
      
      public function setData(param1:RespawnMessageVO, param2:Boolean) : void
      {
         this._data = param1;
         this._showWithDelay = param2;
         invalidateData();
      }
      
      public function show(param1:Boolean) : void
      {
         this.clearTweens();
         if(param1)
         {
            this._showTween = new Tween(SHOW_TWEEN_TIME,this,{
               "alpha":1,
               "scaleX":1,
               "scaleY":1
            },{
               "fastTransform":false,
               "delay":(!!this._showWithDelay ? SHOW_TWEEN_DELAY : 0),
               "ease":Cubic.easeOut
            });
         }
         else
         {
            alpha = 1;
            scaleX = 1;
            scaleY = 1;
         }
      }
      
      private function clearTweens() : void
      {
         if(this._showTween)
         {
            this._showTween.paused = true;
            this._showTween.dispose();
            this._showTween = null;
         }
         if(this._hideTween)
         {
            this._hideTween.paused = true;
            this._hideTween.dispose();
            this._hideTween = null;
         }
      }
      
      private function onHideCompleteHandler() : void
      {
         dispatchEvent(new Event(Event.DEACTIVATE));
      }
      
      override public function get height() : Number
      {
         return this.bg.height;
      }
      
      override public function get width() : Number
      {
         return this.bg.width;
      }
      
      public function get currentTime() : Number
      {
         return this._curTime;
      }
      
      public function get data() : RespawnMessageVO
      {
         return this._data;
      }
      
      protected function get curTime() : int
      {
         return this._curTime;
      }
   }
}
