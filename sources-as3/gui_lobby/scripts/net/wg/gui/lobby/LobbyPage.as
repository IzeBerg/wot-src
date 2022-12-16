package net.wg.gui.lobby
{
   import fl.motion.easing.Quadratic;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.DragType;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.LAYER_NAMES;
   import net.wg.gui.components.common.waiting.Waiting;
   import net.wg.gui.components.containers.MainViewContainer;
   import net.wg.gui.components.containers.ManagedContainer;
   import net.wg.gui.components.vehicleHitArea.VehicleHitAreaComponent;
   import net.wg.gui.events.LobbyEvent;
   import net.wg.gui.lobby.header.LobbyHeader;
   import net.wg.gui.lobby.header.headerButtonBar.HBC_Settings;
   import net.wg.gui.lobby.header.headerButtonBar.HeaderButton;
   import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonsHelper;
   import net.wg.gui.lobby.interfaces.ILobbyPage;
   import net.wg.gui.lobby.messengerBar.MessengerBar;
   import net.wg.gui.lobby.post.TeaserEvent;
   import net.wg.gui.lobby.settings.config.ControlsFactory;
   import net.wg.gui.notification.NotificationPopUpViewer;
   import net.wg.infrastructure.base.meta.impl.LobbyPageMeta;
   import net.wg.infrastructure.interfaces.IManagedContainer;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.utils.Constraints;
   
   public class LobbyPage extends LobbyPageMeta implements ILobbyPage
   {
      
      private static const TEASER_ANIMATION_SCALE:Number = 0.05;
      
      private static const TEASER_ANIMATION_ALPHA:Number = 0.5;
      
      private static const TEASER_ANIM_SPEED_TIME:int = 600;
      
      private static const TOP_SUB_VIEW_POSITION:Number = 53;
      
      private static const WARNING_EMPTY_HIT_AREA:String = "vehicleHitArea is null!";
       
      
      public var vehicleHitArea:VehicleHitAreaComponent = null;
      
      public var subTopContainer:IManagedContainer = null;
      
      public var subViewContainer:IManagedContainer = null;
      
      public var header:LobbyHeader;
      
      public var notificationPopupViewer:NotificationPopUpViewer;
      
      public var messengerBar:MessengerBar;
      
      public var waiting:Waiting = null;
      
      private var _dragOffsetX:Number = 0;
      
      private var _dragOffsetY:Number = 0;
      
      private var _resetDragParams:Boolean;
      
      private var _teaserOverlay:Sprite = null;
      
      private var _teaserTween:Tween;
      
      private var _teaser:Bitmap;
      
      public function LobbyPage()
      {
         super();
      }
      
      override public function getSubContainers() : Array
      {
         return [this.subViewContainer,this.subTopContainer];
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         var _loc5_:IManagedContainer = null;
         _originalWidth = param1;
         _originalHeight = param2;
         setSize(param1,param2);
         this.vehicleHitArea.width = param1;
         this.vehicleHitArea.height = param2 - this.vehicleHitArea.y;
         this.messengerBar.updateStage(param1,param2);
         var _loc3_:Array = this.getSubContainers();
         var _loc4_:Number = param2 - TOP_SUB_VIEW_POSITION;
         if(this.messengerBar.visible)
         {
            _loc4_ -= MessengerBar.BAR_VISIBLE_HEIGHT;
         }
         for each(_loc5_ in _loc3_)
         {
            if(_loc5_)
            {
               _loc5_.y = TOP_SUB_VIEW_POSITION;
               _loc5_.updateStage(param1,_loc4_);
            }
         }
         this.header.width = param1;
         if(this.notificationPopupViewer)
         {
            this.notificationPopupViewer.updateStage(param1,param2);
         }
         this.waiting.setSize(param1,param2);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.stage.addEventListener(LobbyEvent.REGISTER_DRAGGING,this.onRegisterDraggingHandler);
         App.stage.addEventListener(LobbyEvent.UNREGISTER_DRAGGING,this.onUnregisterDraggingHandler);
         addEventListener(TeaserEvent.HIDE,this.onTeaserHideHandler,true);
         constraints = new Constraints(this,ConstrainMode.COUNTER_SCALE);
         this.updateStage(App.appWidth,App.appHeight);
         this.vehicleHitArea.addEventListener(MouseEvent.ROLL_OVER,this.onVehicleHitAreaRollOverHandler);
         this.vehicleHitArea.addEventListener(MouseEvent.ROLL_OUT,this.onVehicleHitAreaRollOutHandler);
      }
      
      override protected function allowHandleInput() : Boolean
      {
         return false;
      }
      
      override protected function onSetModalFocus(param1:InteractiveObject) : void
      {
         if(param1 == null)
         {
            setFocus(this.header.mainMenuButtonBar);
         }
         super.onSetModalFocus(param1);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            constraints.update(width,height);
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.header,Aliases.LOBBY_HEADER);
         if(!this.notificationPopupViewer)
         {
            this.notificationPopupViewer = new NotificationPopUpViewer(App.utils.classFactory.getClass(Linkages.SERVICE_MESSAGES_POPUP));
            addChild(this.notificationPopupViewer);
            registerFlashComponentS(this.notificationPopupViewer,Aliases.SYSTEM_MESSAGES);
         }
         registerFlashComponentS(this.messengerBar,Aliases.MESSENGER_BAR);
         var _loc1_:uint = this.getChildIndex(this.waiting) + 1;
         this.subViewContainer = this.addSubContainer(LAYER_NAMES.SUBVIEW,_loc1_);
         this.subTopContainer = this.addSubContainer(LAYER_NAMES.TOP_SUB_VIEW,_loc1_ + 1);
         this.subViewContainer.manageSize = false;
         this.subTopContainer.manageSize = false;
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(LobbyEvent.REGISTER_DRAGGING,this.onRegisterDraggingHandler);
         App.stage.removeEventListener(LobbyEvent.UNREGISTER_DRAGGING,this.onUnregisterDraggingHandler);
         removeEventListener(TeaserEvent.HIDE,this.onTeaserHideHandler,true);
         removeChild(this.notificationPopupViewer);
         this.vehicleHitArea.hit.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onHitAreaMouseWheelHandler);
         this.vehicleHitArea.removeEventListener(MouseEvent.ROLL_OVER,this.onVehicleHitAreaRollOverHandler);
         this.vehicleHitArea.removeEventListener(MouseEvent.ROLL_OUT,this.onVehicleHitAreaRollOutHandler);
         this.vehicleHitArea.dispose();
         this.vehicleHitArea = null;
         this.subViewContainer = null;
         this.subTopContainer = null;
         this.waiting.dispose();
         this.waiting = null;
         if(this._teaserTween)
         {
            this._teaserTween.paused = true;
            this._teaserTween.dispose();
            this._teaserTween = null;
         }
         if(this._teaser)
         {
            this._teaserOverlay.removeChild(this._teaser);
            this._teaser.bitmapData.dispose();
            this._teaser = null;
         }
         this.header = null;
         this.notificationPopupViewer = null;
         this.messengerBar = null;
         this._teaserOverlay = null;
         ControlsFactory.instance.dispose();
         super.onDispose();
      }
      
      public function as_closeHelpLayout() : void
      {
         var _loc1_:InteractiveObject = InteractiveObject(this.subViewContainer.getTopmostView());
         if(_loc1_)
         {
            setFocus(_loc1_);
         }
      }
      
      public function as_hideWaiting() : void
      {
         this.waiting.hide();
      }
      
      public function as_showHelpLayout() : void
      {
      }
      
      public function as_showWaiting(param1:String) : void
      {
         this.waiting.setMessage(param1);
         this.waiting.setSize(_width,_height);
         this.waiting.show();
      }
      
      public function as_setSubContainerItemsVisibility(param1:Boolean) : void
      {
         var _loc3_:IManagedContainer = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:DisplayObject = null;
         var _loc2_:InteractiveObject = null;
         for each(_loc3_ in this.getSubContainers())
         {
            _loc4_ = _loc3_.numChildren;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = _loc3_.getChildAt(_loc5_);
               _loc6_.visible = param1;
               _loc2_ = _loc6_ as InteractiveObject;
               _loc5_++;
            }
         }
         if(param1 && _loc2_)
         {
            setFocus(_loc2_);
         }
      }
      
      public function getDragType() : String
      {
         return DragType.SOFT;
      }
      
      public function getHitArea() : InteractiveObject
      {
         if(this.vehicleHitArea == null)
         {
            DebugUtils.LOG_WARNING(WARNING_EMPTY_HIT_AREA);
            return this;
         }
         return this.vehicleHitArea.hit;
      }
      
      public function onDragging(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = !!this._resetDragParams ? Number(0) : Number(-(this._dragOffsetX - stage.mouseX));
         var _loc4_:Number = !!this._resetDragParams ? Number(0) : Number(-(this._dragOffsetY - stage.mouseY));
         this._resetDragParams = false;
         this._dragOffsetX = stage.mouseX;
         this._dragOffsetY = stage.mouseY;
         dispatchEvent(new LobbyEvent(LobbyEvent.DRAGGING));
         moveSpaceS(_loc3_,_loc4_,0);
      }
      
      public function onEndDrag() : void
      {
         dispatchEvent(new LobbyEvent(LobbyEvent.DRAGGING_END));
         notifyCursorDraggingS(false);
      }
      
      public function onStartDrag() : void
      {
         dispatchEvent(new LobbyEvent(LobbyEvent.DRAGGING_START));
         notifyCursorDraggingS(true);
         this._dragOffsetX = stage.mouseX;
         this._dragOffsetY = stage.mouseY;
      }
      
      private function createHintTween(param1:Point, param2:DisplayObject) : Tween
      {
         return new Tween(TEASER_ANIM_SPEED_TIME,param2,{
            "x":param1.x,
            "y":param1.y,
            "scaleX":TEASER_ANIMATION_SCALE,
            "scaleY":TEASER_ANIMATION_SCALE,
            "alpha":TEASER_ANIMATION_ALPHA
         },{
            "paused":false,
            "onComplete":this.animationFinished,
            "ease":Quadratic.easeInOut
         });
      }
      
      private function animationFinished() : void
      {
         this._teaserOverlay.removeChild(this._teaser);
         this._teaser.bitmapData.dispose();
         this._teaser = null;
         this._teaserTween = null;
         this._teaserOverlay = null;
         var _loc1_:HeaderButton = this.header.getTabRenderer(HeaderButtonsHelper.ITEM_ID_SETTINGS);
         HBC_Settings(_loc1_.content).showBlink();
      }
      
      private function addSubContainer(param1:String, param2:int) : IManagedContainer
      {
         var _loc3_:ManagedContainer = new MainViewContainer(param1);
         addChildAt(_loc3_,param2);
         return _loc3_;
      }
      
      private function registerDraging() : void
      {
         this.vehicleHitArea.hit.addEventListener(MouseEvent.MOUSE_WHEEL,this.onHitAreaMouseWheelHandler);
         App.cursor.registerDragging(this,Cursors.ROTATE);
      }
      
      private function unregisterDragging() : void
      {
         this.vehicleHitArea.hit.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onHitAreaMouseWheelHandler);
         App.cursor.unRegisterDragging(this);
      }
      
      private function onTeaserHideHandler(param1:TeaserEvent) : void
      {
         var _loc2_:Point = null;
         addChildAt(this._teaserOverlay = new Sprite(),getChildIndex(this.header) + 1);
         this._teaser = param1.teaser.drawToBitmap();
         _loc2_ = new Point(this._teaser.x,this._teaser.y);
         _loc2_ = this._teaserOverlay.globalToLocal(_loc2_);
         this._teaser.x = _loc2_.x;
         this._teaser.y = _loc2_.y;
         this._teaserOverlay.addChild(this._teaser);
         var _loc3_:HeaderButton = this.header.getTabRenderer(HeaderButtonsHelper.ITEM_ID_SETTINGS);
         _loc2_.x = _loc3_.x + _loc3_.content.width >> 1;
         _loc2_.y = _loc3_.y + _loc3_.content.height >> 1;
         _loc2_ = _loc3_.parent.localToGlobal(_loc2_);
         _loc2_.offset(this._teaser.width * -TEASER_ANIMATION_SCALE >> 1,this._teaser.height * -TEASER_ANIMATION_SCALE >> 1);
         if(!this._teaserTween)
         {
            this._teaserTween = this.createHintTween(_loc2_,this._teaser);
         }
      }
      
      private function onVehicleHitAreaRollOverHandler(param1:MouseEvent) : void
      {
         notifyCursorOver3dSceneS(true);
      }
      
      private function onVehicleHitAreaRollOutHandler(param1:MouseEvent) : void
      {
         this._resetDragParams = true;
         notifyCursorOver3dSceneS(false);
      }
      
      private function onHitAreaMouseWheelHandler(param1:MouseEvent) : void
      {
         moveSpaceS(0,0,param1.delta * 200);
      }
      
      private function onRegisterDraggingHandler(param1:LobbyEvent) : void
      {
         this.registerDraging();
      }
      
      private function onUnregisterDraggingHandler(param1:LobbyEvent) : void
      {
         this.unregisterDragging();
      }
   }
}
