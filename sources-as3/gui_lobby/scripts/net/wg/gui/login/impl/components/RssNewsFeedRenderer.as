package net.wg.gui.login.impl.components
{
   import fl.transitions.easing.Strong;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.AlertIco;
   import net.wg.gui.components.controls.HyperLink;
   import net.wg.gui.login.IRssNewsFeedRenderer;
   import net.wg.gui.login.impl.vo.RssItemVo;
   import net.wg.gui.utils.ExcludeTweenManager;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   import scaleform.gfx.TextFieldEx;
   
   public class RssNewsFeedRenderer extends UIComponentEx implements IRssNewsFeedRenderer
   {
      
      public static const MOOVING_ANIMATION_SPEED:Number = 1000;
      
      public static const HIDED:String = "hided";
      
      private static var SELECTION_TEXT_COLOR:Number = 4280163867;
      
      private static var SELECTION_TEXT_BG_COLOR:Number = 4288059015;
      
      private static var ANIM_DISTANCE:Number = 30;
       
      
      public var alertIco:AlertIco = null;
      
      public var description:TextField = null;
      
      public var hyperLink:HyperLink = null;
      
      private var tweenManager:ExcludeTweenManager;
      
      private var moveTween:Tween = null;
      
      private var _hideAnimationSpeed:Number = 350;
      
      private var _isUsed:Boolean = false;
      
      private var _dataVo:RssItemVo = null;
      
      public function RssNewsFeedRenderer()
      {
         this.tweenManager = new ExcludeTweenManager();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hyperLink.addEventListener(ButtonEvent.CLICK,this.onReedMoreClick);
         TextFieldEx.setSelectionTextColor(this.description,SELECTION_TEXT_COLOR);
         TextFieldEx.setInactiveSelectionTextColor(this.description,SELECTION_TEXT_COLOR);
         TextFieldEx.setSelectionBkgColor(this.description,SELECTION_TEXT_BG_COLOR);
         TextFieldEx.setInactiveSelectionBkgColor(this.description,SELECTION_TEXT_BG_COLOR);
      }
      
      private function onReedMoreClick(param1:ButtonEvent) : void
      {
         dispatchEvent(new RssItemEvent(RssItemEvent.TO_REED_MORE,false,false,this._dataVo));
      }
      
      override protected function onDispose() : void
      {
         this.hyperLink.removeEventListener(ButtonEvent.CLICK,this.onReedMoreClick);
         this._dataVo = null;
         if(this.tweenManager)
         {
            this.tweenManager.dispose();
            this.tweenManager = null;
         }
         if(this.moveTween)
         {
            this.moveTween = null;
         }
         super.onDispose();
      }
      
      public function setData(param1:RssItemVo) : void
      {
         this._isUsed = true;
         this.itemDataVo = param1;
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA))
         {
            this.alertIco.icoType = AlertIco.ALERT_ICO_SMALL;
            this.alertIco.validateNow();
            if(this._dataVo)
            {
               this.description.text = this._dataVo.description;
               this.description.height = this.description.textHeight + 4;
               this.hyperLink.label = MENU.LOGIN_RSS_READMORE;
               this.hyperLink.validateNow();
               this.hyperLink.visible = this._dataVo.link != Values.EMPTY_STR;
               this.updatePosition();
            }
         }
         super.draw();
      }
      
      private function updatePosition() : void
      {
         if(this.hyperLink.visible)
         {
            this.hyperLink.x = this.description.x + this.description.width - this.hyperLink.width;
            this.hyperLink.y = this.description.y + this.description.height - 5;
         }
         else
         {
            this.hyperLink.x = this.hyperLink.y = 0;
         }
         dispatchEvent(new RssItemEvent(RssItemEvent.ITEM_SIZE_INVALID));
      }
      
      public function get itemId() : String
      {
         return Boolean(this._dataVo) ? this._dataVo.id : Values.EMPTY_STR;
      }
      
      public function get itemHeight() : Number
      {
         return Math.round(this.actualHeight);
      }
      
      public function get itemWidth() : Number
      {
         return Math.round(this.actualWidth);
      }
      
      public function set itemDataVo(param1:RssItemVo) : void
      {
         this._dataVo = param1;
         invalidateData();
      }
      
      public function get itemDataVo() : RssItemVo
      {
         return this._dataVo;
      }
      
      public function moveToY(param1:Number) : void
      {
         if(alpha == 0)
         {
            this.y = param1 + ANIM_DISTANCE;
         }
         this.moveTween = this.tweenManager.registerAndLaunch(MOOVING_ANIMATION_SPEED,this,{
            "y":param1,
            "alpha":1
         },{
            "ease":Strong.easeInOut,
            "onComplete":this.onMoveTweenComplete
         });
         this.moveTween.fastTransform = false;
      }
      
      private function onMoveTweenComplete(param1:Tween) : void
      {
         this.unregisterTweeen(param1);
      }
      
      private function unregisterTweeen(param1:Tween) : void
      {
         this.tweenManager.unregister(param1);
      }
      
      public function hide() : void
      {
         this._isUsed = false;
         this.moveTween = this.tweenManager.registerAndLaunch(this._hideAnimationSpeed,this,{"alpha":0},{
            "ease":Strong.easeIn,
            "onComplete":this.onHideTweenComplete
         });
         this.moveTween.fastTransform = false;
      }
      
      private function onHideTweenComplete(param1:Tween) : void
      {
         this.unregisterTweeen(param1);
         dispatchEvent(new RssItemEvent(RssItemEvent.ON_HIDED));
      }
      
      public function get isUsed() : Boolean
      {
         return this._isUsed;
      }
   }
}
