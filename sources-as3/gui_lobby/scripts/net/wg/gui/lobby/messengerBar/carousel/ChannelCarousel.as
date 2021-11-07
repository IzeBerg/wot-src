package net.wg.gui.lobby.messengerBar.carousel
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventPhase;
   import flash.geom.Point;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.daapi.base.DAAPIDataProvider;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.components.containers.IGroupEx;
   import net.wg.gui.components.windows.Window;
   import net.wg.gui.events.MessengerBarEvent;
   import net.wg.gui.lobby.messengerBar.WindowOffsetsInBar;
   import net.wg.gui.lobby.messengerBar.carousel.data.ChannelListItemVO;
   import net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent;
   import net.wg.gui.lobby.messengerBar.carousel.events.MessengerBarChannelCarouselEvent;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.base.meta.IChannelCarouselMeta;
   import net.wg.infrastructure.base.meta.impl.ChannelCarouselMeta;
   import net.wg.infrastructure.interfaces.IAbstractWindowView;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class ChannelCarousel extends ChannelCarouselMeta implements IChannelCarouselMeta
   {
      
      private static const HORIZONTAL_OFFSET_NO_SCROLL:Number = 5;
      
      private static const HORIZONTAL_OFFSET_SCROLL:Number = 24;
      
      private static const OFFSET_BETWEEN_LISTS:Number = 5;
      
      private static const OFFSET_PRE_BATTLES_GROUP:Number = 5;
       
      
      public var list:ChannelList = null;
      
      public var scrollBar:ChannelCarouselScrollBar = null;
      
      public var background:Sprite = null;
      
      private var _dataProvider:DAAPIDataProvider = null;
      
      private var _battlesDataProvider:DAAPIDataProvider = null;
      
      private var _preBattlesGroup:IGroupEx = null;
      
      private var _appStage:Stage;
      
      public function ChannelCarousel()
      {
         this._appStage = App.stage;
         super();
         this._dataProvider = new DAAPIDataProvider();
         this._battlesDataProvider = new DAAPIDataProvider();
      }
      
      private static function findIndexByClientID(param1:Number, param2:DAAPIDataProvider) : int
      {
         var _loc5_:ChannelListItemVO = null;
         var _loc3_:Number = -1;
         var _loc4_:Number = param2.length;
         var _loc6_:Number = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = new ChannelListItemVO(param2.requestItemAt(_loc6_));
            if(_loc5_.clientID == param1)
            {
               _loc3_ = _loc6_;
               _loc5_.dispose();
               break;
            }
            _loc5_.dispose();
            _loc6_++;
         }
         return _loc3_;
      }
      
      private static function updateWindowVisibleProperty(param1:IAbstractWindowView, param2:Boolean = false) : void
      {
         var _loc3_:Window = Window(param1.window);
         if(_loc3_.visible != param2)
         {
            _loc3_.visible = param2;
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = this._preBattlesGroup.width;
            _loc2_ = this._preBattlesGroup.x;
            _loc3_ = _loc1_ > 0 ? uint(OFFSET_BETWEEN_LISTS) : uint(0);
            _loc4_ = _width - _loc1_;
            _loc5_ = this.isScrollNeeded(_loc4_ - (HORIZONTAL_OFFSET_NO_SCROLL << 1));
            this.scrollBar.visible = _loc5_;
            if(_loc5_)
            {
               _loc6_ = _loc1_ + HORIZONTAL_OFFSET_SCROLL;
               _loc7_ = _loc4_ - (HORIZONTAL_OFFSET_SCROLL << 1);
            }
            else
            {
               _loc6_ = _loc1_ + HORIZONTAL_OFFSET_NO_SCROLL;
               _loc7_ = _loc4_ - (HORIZONTAL_OFFSET_NO_SCROLL << 1);
            }
            this.list.x = _loc6_ + _loc3_ | 0;
            this.list.width = _loc7_ - _loc3_;
            this.scrollBar.width = _loc4_ - (_loc2_ << 1) - _loc3_;
            this.scrollBar.x = _loc2_ + _loc1_ + _loc3_ | 0;
            this.background.width = this.scrollBar.width + (HORIZONTAL_OFFSET_NO_SCROLL << 1);
            this.background.x = this.scrollBar.x - HORIZONTAL_OFFSET_NO_SCROLL;
         }
      }
      
      override protected function configUI() : void
      {
         this._preBattlesGroup = new GroupEx();
         this._preBattlesGroup.layout = new HorizontalGroupLayout();
         this._preBattlesGroup.itemRendererLinkage = Linkages.PRE_BATTLE_CHANNEL_RENDERER;
         this._preBattlesGroup.y = this.list.y + this.list.padding.top;
         this._preBattlesGroup.x = OFFSET_PRE_BATTLES_GROUP;
         addChild(DisplayObject(this._preBattlesGroup));
         super.configUI();
         this.scrollBar.upArrow.preventAutosizing = true;
         this.scrollBar.downArrow.preventAutosizing = true;
         addEventListener(ChannelListEvent.OPEN_CHANNEL,this.onChannelOpenChannelHandler,false,0,true);
         addEventListener(ChannelListEvent.CLOSE_CHANNEL,this.onChannelCloseChannelHandler,false,0,true);
         this._dataProvider.addEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
         this._preBattlesGroup.addEventListener(Event.RESIZE,this.onPreBattlesGroupResizeHandler,false,0,true);
         this.list.dataProvider = this._dataProvider;
         this._preBattlesGroup.dataProvider = this._battlesDataProvider;
         this._appStage.addEventListener(MessengerBarEvent.PIN_CAROUSEL_WINDOW,this.onAppStagePinCarouselWindowHandler);
         this._appStage.addEventListener(MessengerBarChannelCarouselEvent.CHANNEL_WINDOW_FOCUS_IN,this.onAppStageChannelWindowFocusInHandler);
         this._appStage.addEventListener(MessengerBarChannelCarouselEvent.CHANNEL_WINDOW_FOCUS_OUT,this.onAppStageChannelWindowFocusOutHandler);
         this._appStage.addEventListener(MessengerBarChannelCarouselEvent.CHANNEL_WINDOW_SHOW,this.onAppStageChannelWindowShowHandler);
         this._appStage.addEventListener(MessengerBarChannelCarouselEvent.CHANNEL_WINDOW_HIDE,this.onAppStageChannelWindowHideHandler);
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.onAppStagePinCarouselWindowHandler);
         this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
         this._preBattlesGroup.removeEventListener(Event.RESIZE,this.onPreBattlesGroupResizeHandler,false);
         removeEventListener(ChannelListEvent.OPEN_CHANNEL,this.onChannelOpenChannelHandler);
         removeEventListener(ChannelListEvent.CLOSE_CHANNEL,this.onChannelCloseChannelHandler);
         this._appStage.removeEventListener(MessengerBarEvent.PIN_CAROUSEL_WINDOW,this.onAppStagePinCarouselWindowHandler);
         this._appStage.removeEventListener(MessengerBarChannelCarouselEvent.CHANNEL_WINDOW_FOCUS_IN,this.onAppStageChannelWindowFocusInHandler);
         this._appStage.removeEventListener(MessengerBarChannelCarouselEvent.CHANNEL_WINDOW_FOCUS_OUT,this.onAppStageChannelWindowFocusOutHandler);
         this._appStage.removeEventListener(MessengerBarChannelCarouselEvent.CHANNEL_WINDOW_SHOW,this.onAppStageChannelWindowShowHandler);
         this._appStage.removeEventListener(MessengerBarChannelCarouselEvent.CHANNEL_WINDOW_HIDE,this.onAppStageChannelWindowHideHandler);
         removeChild(DisplayObject(this._preBattlesGroup));
         this._preBattlesGroup.dispose();
         this._preBattlesGroup = null;
         this._battlesDataProvider.cleanUp();
         this._battlesDataProvider = null;
         this._dataProvider.cleanUp();
         this._dataProvider = null;
         this.list.dispose();
         this.list = null;
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.background = null;
         this._appStage = null;
         super.onDispose();
      }
      
      public function as_getBattlesDataProvider() : Object
      {
         return this._battlesDataProvider;
      }
      
      public function as_getDataProvider() : Object
      {
         return this._dataProvider;
      }
      
      private function isScrollNeeded(param1:int) : Boolean
      {
         var _loc2_:IDataProvider = this.list.dataProvider;
         var _loc3_:uint = Boolean(_loc2_) ? uint(_loc2_.length) : uint(0);
         var _loc4_:int = FlexibleTileList.getAvailableItemWidth(_loc3_,this.list.minRendererWidth,this.list.maxRendererWidth,param1 - (HORIZONTAL_OFFSET_NO_SCROLL << 1));
         var _loc5_:Number = param1 / _loc4_ >> 0;
         return _loc5_ < _loc3_;
      }
      
      private function setChannelsListItemCoordinates(param1:int, param2:MessengerBarEvent) : void
      {
         var _loc3_:IListItemRenderer = null;
         var _loc4_:IAbstractWindowView = null;
         if(param1 > -1)
         {
            _loc3_ = this.list.getRendererAt(param1 - this.list.scrollPosition);
            _loc4_ = param2.target as AbstractWindowView;
            App.utils.asserter.assertNotNull(_loc4_,"view" + Errors.CANT_NULL);
            if(_loc3_ == null)
            {
               updateWindowVisibleProperty(_loc4_,false);
               this.list.scrollToIndex(param1);
               App.utils.scheduler.scheduleOnNextFrame(this.onAppStagePinCarouselWindowHandler,param2);
            }
            else
            {
               updateWindowVisibleProperty(_loc4_,true);
               this.applyWindowPosition(_loc4_,DisplayObject(_loc3_));
            }
         }
      }
      
      private function applyWindowPosition(param1:IAbstractWindowView, param2:DisplayObject) : void
      {
         var _loc3_:IWindow = IWindow(param1.window);
         var _loc4_:Number = _loc3_.width;
         var _loc5_:uint = App.appHeight - height;
         var _loc6_:Point = new Point(0,-_loc3_.height);
         if(_loc5_ < _loc3_.height)
         {
            _loc6_.y = this.height - App.appHeight - WindowOffsetsInBar.WINDOW_TOP_OFFSET;
         }
         var _loc7_:Number = param2.parent.localToGlobal(new Point(param2.x,param2.y)).x;
         var _loc8_:Number = _loc7_ + param2.width - _loc4_;
         if(_loc7_ + _loc4_ < App.appWidth)
         {
            _loc6_.x = _loc7_ - WindowOffsetsInBar.CHANNEL_WINDOW_LEFT_OFFSET;
         }
         else if(_loc8_ > 0)
         {
            _loc6_.x = _loc8_ + WindowOffsetsInBar.CHANNEL_WINDOW_RIGHT_OFFSET;
         }
         else
         {
            _loc6_.x = App.appWidth - _loc4_ >> 1;
         }
         _loc3_.x = Math.round(_loc6_.x);
         _loc3_.y = localToGlobal(_loc6_).y;
      }
      
      private function updateChannelListItemRendererFocusState(param1:Number, param2:String, param3:Boolean) : void
      {
         updateItemDataFocusS(param1,param2,param3);
      }
      
      private function updateChannelWindowWindowOpenState(param1:Number, param2:String, param3:Boolean) : void
      {
         updateItemDataOpenedS(param1,param2,param3);
      }
      
      private function onPreBattlesGroupResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onDataProviderChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onChannelOpenChannelHandler(param1:ChannelListEvent) : void
      {
         param1.stopImmediatePropagation();
         channelOpenClickS(param1.clientID);
      }
      
      private function onChannelCloseChannelHandler(param1:ChannelListEvent) : void
      {
         param1.stopImmediatePropagation();
         channelCloseClickS(param1.clientID);
      }
      
      private function onAppStagePinCarouselWindowHandler(param1:MessengerBarEvent) : void
      {
         if(param1.eventPhase != EventPhase.BUBBLING_PHASE)
         {
            return;
         }
         this.setChannelsListItemCoordinates(findIndexByClientID(param1.clientID,this._dataProvider),param1);
      }
      
      private function onAppStageChannelWindowFocusInHandler(param1:MessengerBarChannelCarouselEvent) : void
      {
         if(param1.eventPhase != EventPhase.BUBBLING_PHASE)
         {
            return;
         }
         this.updateChannelListItemRendererFocusState(param1.clientID,param1.itemType,true);
      }
      
      private function onAppStageChannelWindowFocusOutHandler(param1:MessengerBarChannelCarouselEvent) : void
      {
         if(param1.eventPhase != EventPhase.BUBBLING_PHASE)
         {
            return;
         }
         this.updateChannelListItemRendererFocusState(param1.clientID,param1.itemType,false);
      }
      
      private function onAppStageChannelWindowShowHandler(param1:MessengerBarChannelCarouselEvent) : void
      {
         if(param1.eventPhase != EventPhase.BUBBLING_PHASE)
         {
            return;
         }
         this.updateChannelWindowWindowOpenState(param1.clientID,param1.itemType,true);
      }
      
      private function onAppStageChannelWindowHideHandler(param1:MessengerBarChannelCarouselEvent) : void
      {
         if(param1.eventPhase != EventPhase.BUBBLING_PHASE)
         {
            return;
         }
         this.updateChannelWindowWindowOpenState(param1.clientID,param1.itemType,false);
      }
   }
}
