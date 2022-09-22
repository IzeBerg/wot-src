package net.wg.gui.lobby.personalMissions.components
{
   import fl.motion.easing.Linear;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.PERSONAL_MISSIONS_ALIASES;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.personalMissions.data.OperationVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class OperationRenderer extends UIComponentEx
   {
      
      private static const FADE_IN_DURATION:Number = 500;
      
      private static const ICON_ALPHA_LOCKED:Number = 0.6;
      
      private static const ICON_ALPHA_UNLOCKED:Number = 1;
      
      private static const ICON_SCALE_DEF:Number = 0.75;
      
      private static const ICON_SCALE_CURRENT:Number = 1;
      
      private static const ICON_WIDTH:Number = 150;
      
      private static const ICON_HEIGHT:Number = 100;
       
      
      public var icon:UILoaderAlt;
      
      public var titleBigTF:TextField;
      
      public var titleSmallTF:TextField;
      
      public var statusTF:TextField;
      
      public var lock:Sprite;
      
      public var arrow:Sprite;
      
      private var _data:OperationVO;
      
      private var _fadeTween:Tween;
      
      public function OperationRenderer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.icon.removeEventListener(MouseEvent.CLICK,this.onIconClickHandler);
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         this.icon.dispose();
         this.icon = null;
         this._data = null;
         this.lock = null;
         this.titleBigTF = null;
         this.titleSmallTF = null;
         this.statusTF = null;
         this.arrow = null;
         if(this._fadeTween)
         {
            this._fadeTween.dispose();
            this._fadeTween = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.icon.source = this._data.iconSource;
            _loc1_ = this._data.state == PERSONAL_MISSIONS_ALIASES.OPERATION_CURRENT_STATE;
            _loc2_ = this._data.state == PERSONAL_MISSIONS_ALIASES.OPERATION_LOCKED_STATE;
            this.icon.alpha = !!_loc2_ ? Number(ICON_ALPHA_LOCKED) : Number(ICON_ALPHA_UNLOCKED);
            this.lock.visible = _loc2_;
            if(_loc1_)
            {
               this.titleBigTF.htmlText = this._data.title;
            }
            else
            {
               this.titleSmallTF.htmlText = this._data.title;
            }
            this.icon.useHandCursor = this.icon.buttonMode = _loc1_;
            if(this._data.state != PERSONAL_MISSIONS_ALIASES.OPERATION_LOCKED_STATE)
            {
               this.statusTF.htmlText = this._data.desc;
            }
            this._fadeTween = new Tween(FADE_IN_DURATION,this,{"alpha":1},{
               "paused":false,
               "ease":Linear.easeOut,
               "delay":this._data.showDelay
            });
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.icon.x = ICON_WIDTH - this.icon.width >> 1;
            this.icon.y = ICON_HEIGHT - this.icon.height >> 1;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         alpha = 0;
         this.icon.mouseChildren = false;
         this.icon.autoSize = false;
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         this.icon.addEventListener(MouseEvent.CLICK,this.onIconClickHandler);
      }
      
      public function setArrowVisible(param1:Boolean) : void
      {
         this.arrow.visible = param1;
      }
      
      public function setData(param1:OperationVO) : void
      {
         this._data = OperationVO(param1);
         invalidateData();
      }
      
      private function onIconClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new Event(Event.SELECT,true));
      }
      
      private function onIconCompleteHandler(param1:UILoaderEvent) : void
      {
         this.icon.scaleX = this.icon.scaleY = this._data.state == PERSONAL_MISSIONS_ALIASES.OPERATION_CURRENT_STATE ? Number(ICON_SCALE_CURRENT) : Number(ICON_SCALE_DEF);
         invalidateSize();
      }
   }
}
