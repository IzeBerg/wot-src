package net.wg.gui.lobby.missions.components.detailedView
{
   import fl.motion.easing.Cubic;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.missions.data.MissionAccountRequirementsVO;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.motion.Tween;
   
   public class MissionDetailsAccountRequirementsPanel extends AbstractPopoverWithScrollableGroupPanel
   {
      
      private static const CONDITIONS_OFFSET_X:int = 10;
      
      private static const LAYOUT_GAP:int = 8;
      
      private static const TWEEN_CONTENT_TIME:int = 200;
      
      private static const TWEEN_CONTENT_DELAY:int = 100;
      
      private static const TWEEN_SHOW_TIME:int = 300;
      
      private static const TWEEN_HIDE_TIME:int = 200;
      
      private static const SCROLL_PANE_WIDTH:int = 420;
      
      private static const HEADER_HEIGHT:int = 42;
      
      private static const CONDITIONS_ROLL_UP_MIN:int = 1;
       
      
      public var shadow:Sprite;
      
      public var hitMC:Sprite;
      
      public var bodyMask:Sprite;
      
      public var buttonDown:ISoundButtonEx;
      
      public var buttonUp:ISoundButtonEx;
      
      private var _data:MissionAccountRequirementsVO;
      
      private var _tweenShow:Tween;
      
      private var _tweenHide:Tween;
      
      private var _tweenContent:Tween;
      
      private var _isShown:Boolean = false;
      
      private var _contentOpacity:Number = 1;
      
      private var _isHeaderTruncated:Boolean = false;
      
      public function MissionDetailsAccountRequirementsPanel()
      {
         super();
      }
      
      override public function setData(param1:IDAAPIDataClass) : void
      {
         super.setData(param1);
         this._data = MissionAccountRequirementsVO(param1);
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         scrollpane.setSize(param1,param2 - scrollpane.y);
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         this.shadow = null;
         this.hitMC.removeEventListener(MouseEvent.CLICK,this.onBgClickHandler);
         this.buttonDown.removeEventListener(MouseEvent.CLICK,this.onBgClickHandler);
         this.buttonUp.removeEventListener(MouseEvent.CLICK,this.onBgClickHandler);
         this.buttonDown.dispose();
         this.buttonDown = null;
         this.buttonUp.dispose();
         this.buttonUp = null;
         this._tweenShow.dispose();
         this._tweenShow = null;
         this._tweenHide.dispose();
         this._tweenHide = null;
         this._tweenContent.dispose();
         this._tweenContent = null;
         this.bodyMask = null;
         this.hitMC.removeEventListener(MouseEvent.ROLL_OVER,this.onBgRollOverHandler);
         this.hitMC.removeEventListener(MouseEvent.ROLL_OUT,this.onBgRollOutHandler);
         this.hitMC = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.shadow.mouseEnabled = false;
         this.buttonUp.visible = this.buttonDown.visible = false;
         this.hitMC.buttonMode = false;
         this.bodyMask.width = body.width;
         this.bodyMask.height = body.height;
         this.bodyMask.x = body.x;
         this.bodyMask.y = body.y;
         this.bodyMask.visible = false;
         var _loc1_:int = -body.height + HEADER_HEIGHT;
         body.mask = this.bodyMask;
         body.y = _loc1_;
         this.contentOpacity = 0;
         this._tweenContent = new Tween(TWEEN_CONTENT_TIME,this,{"contentOpacity":1},{
            "paused":true,
            "ease":Cubic.easeIn,
            "delay":TWEEN_CONTENT_DELAY
         });
         this._tweenShow = new Tween(TWEEN_SHOW_TIME,body,{"y":HEADER_HEIGHT},{
            "paused":true,
            "ease":Cubic.easeOut
         });
         this._tweenHide = new Tween(TWEEN_HIDE_TIME,body,{"y":_loc1_},{
            "paused":true,
            "ease":Cubic.easeOut
         });
         body.mouseEnabled = false;
         separator.mouseEnabled = false;
         mouseEnabled = false;
         this.buttonDown.addEventListener(MouseEvent.CLICK,this.onBgClickHandler);
         this.buttonUp.addEventListener(MouseEvent.CLICK,this.onBgClickHandler);
         this.hitMC.addEventListener(MouseEvent.CLICK,this.onBgClickHandler);
         this.hitMC.addEventListener(MouseEvent.ROLL_OVER,this.onBgRollOverHandler);
         this.hitMC.addEventListener(MouseEvent.ROLL_OUT,this.onBgRollOutHandler);
      }
      
      override protected function getScrollPaneWidth() : int
      {
         return SCROLL_PANE_WIDTH;
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            renderersGroup.x = CONDITIONS_OFFSET_X;
            _loc1_ = App.utils.commons.truncateTextFieldText(labelTf,this.header,true,true);
            this._isHeaderTruncated = _loc1_.length < this.header.length;
            if(this.groupData.length > CONDITIONS_ROLL_UP_MIN)
            {
               this.buttonDown.visible = !this._isShown;
               this.buttonUp.visible = this._isShown;
               this.hitMC.buttonMode = !this._isShown;
               this.hitMC.visible = !this._isShown;
               body.visible = true;
               this.contentOpacity = !!this._isShown ? Number(1) : Number(0);
            }
            else
            {
               this.buttonDown.visible = this.buttonUp.visible = false;
               body.visible = false;
               this.hitMC.buttonMode = false;
               this.hitMC.visible = this._isHeaderTruncated;
               this.contentOpacity = 0;
            }
         }
      }
      
      private function playShowTween() : void
      {
         this._tweenHide.reset();
         this._tweenHide.paused = true;
         this._tweenContent.reset();
         this._tweenContent.paused = false;
         this._tweenShow.reset();
         this._tweenShow.paused = false;
      }
      
      private function playHideTween() : void
      {
         this.contentOpacity = 0;
         this._tweenShow.reset();
         this._tweenShow.paused = true;
         this._tweenContent.reset();
         this._tweenContent.paused = true;
         this._tweenHide.reset();
         this._tweenHide.paused = false;
      }
      
      override protected function get groupData() : IDataProvider
      {
         return this._data.requirements;
      }
      
      override protected function get header() : String
      {
         return this._data.header;
      }
      
      override protected function get layoutGap() : int
      {
         return LAYOUT_GAP;
      }
      
      override protected function get groupRendererLinkage() : String
      {
         return Linkages.MISSION_ACCOUNT_REQUIREMENT_RENDERER;
      }
      
      public function get contentOpacity() : Number
      {
         return this._contentOpacity;
      }
      
      public function set contentOpacity(param1:Number) : void
      {
         this._contentOpacity = param1;
         scrollpane.alpha = this._contentOpacity;
         this.shadow.alpha = this._contentOpacity;
         separator.alpha = this._contentOpacity;
         separator.visible = this.shadow.visible = scrollpane.visible = this._contentOpacity > 0;
      }
      
      private function onBgRollOutHandler(param1:MouseEvent) : void
      {
         if(this._isHeaderTruncated)
         {
            App.toolTipMgr.hide();
         }
      }
      
      private function onBgRollOverHandler(param1:MouseEvent) : void
      {
         if(this._isHeaderTruncated)
         {
            App.toolTipMgr.show(this.header);
         }
      }
      
      private function onBgClickHandler(param1:MouseEvent) : void
      {
         if(this.groupData.length <= CONDITIONS_ROLL_UP_MIN)
         {
            return;
         }
         if(this._isShown)
         {
            this.playHideTween();
         }
         else
         {
            this.playShowTween();
         }
         this._isShown = !this._isShown;
         this.buttonDown.visible = !this._isShown;
         this.buttonUp.visible = this._isShown;
      }
   }
}
