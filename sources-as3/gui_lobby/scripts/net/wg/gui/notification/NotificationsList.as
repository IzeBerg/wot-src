package net.wg.gui.notification
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.VerticalListViewPort;
   import net.wg.gui.components.controls.events.VerticalListViewportEvent;
   import net.wg.gui.components.controls.scroller.ScrollerBase;
   import net.wg.gui.components.controls.scroller.data.ScrollConfig;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   import net.wg.gui.notification.vo.NotificationMessagesListVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class NotificationsList extends ScrollerBase
   {
      
      private static const INV_UPDATE_DATA:String = "invalidateUpdateData";
       
      
      private var _viewPort:VerticalListViewPort = null;
      
      private var _data:NotificationMessagesListVO = null;
      
      private var _dataToUpdate:Vector.<NotificationInfoVO> = null;
      
      private var _itemRendererClassName:String = null;
      
      public function NotificationsList()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:ScrollConfig = new ScrollConfig();
         _loc1_.normalizeWheelScrollDelta = false;
         _loc1_.mouseWheelScrollDuration = 0;
         this.scrollConfig = _loc1_;
         cropContent = true;
         useTimer = true;
         touchScrollEnabled = false;
         var _loc2_:Sprite = new Sprite();
         hitArea = _loc2_;
         addChild(_loc2_);
         this._viewPort = new VerticalListViewPort();
         this._viewPort.addEventListener(VerticalListViewportEvent.RESIZE_TOP,this.onViewPortResizeTopHandler);
         viewPort = this._viewPort;
         this._dataToUpdate = new Vector.<NotificationInfoVO>();
      }
      
      override protected function roundToNearest(param1:Number, param2:Number) : Number
      {
         return param1;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.RENDERERS))
         {
            this._viewPort.itemRendererClassName = this._itemRendererClassName;
         }
         if(isInvalid(InvalidationType.DATA) && this._data != null)
         {
            this._viewPort.dataProvider = this._data.messages;
            App.utils.scheduler.scheduleOnNextFrame(this.scrollToMaxPosition);
         }
         if(isInvalid(INV_UPDATE_DATA))
         {
            while(this._dataToUpdate.length)
            {
               this.doUpdateData(this._dataToUpdate.pop());
            }
         }
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.scrollToMaxPosition);
         this._viewPort.removeEventListener(VerticalListViewportEvent.RESIZE_TOP,this.onViewPortResizeTopHandler);
         var _loc1_:int = this._dataToUpdate.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._dataToUpdate[_loc2_].dispose();
            _loc2_++;
         }
         this._dataToUpdate.splice(0,this._dataToUpdate.length);
         this._dataToUpdate = null;
         this._viewPort.dispose();
         this._viewPort = null;
         this._data = null;
         super.onDispose();
      }
      
      public function appendData(param1:NotificationInfoVO) : void
      {
         var _loc2_:IDataProvider = this.dataProvider;
         if(_loc2_ != null)
         {
            DataProvider(_loc2_).push(param1);
            _loc2_.invalidate();
         }
      }
      
      public function invalidateRenderers() : void
      {
         if(this._viewPort != null)
         {
            this._viewPort.invalidateRenderers();
         }
      }
      
      public function scrollTo(param1:Number, param2:Number = 0.0) : void
      {
         verticalScrollPosition = param1;
         startScroll();
         throwToVerticalPosition(param1,param2);
      }
      
      public function setData(param1:NotificationMessagesListVO) : void
      {
         if(this._data != param1)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      public function updateData(param1:NotificationInfoVO) : void
      {
         this._dataToUpdate.push(param1);
         invalidate(INV_UPDATE_DATA);
      }
      
      private function doUpdateData(param1:NotificationInfoVO) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc2_:IDataProvider = this.dataProvider;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(param1.isEquals(_loc2_[_loc4_]))
               {
                  _loc2_[_loc4_] = param1;
                  this._viewPort.updateData(_loc4_);
                  break;
               }
               _loc4_++;
            }
         }
      }
      
      private function scrollToMaxPosition() : void
      {
         do
         {
            this._viewPort.verticalScrollPosition = maxVerticalScrollPosition;
            this._viewPort.validateNow();
            refreshMinAndMaxScrollValues();
         }
         while(this._viewPort.verticalScrollPosition != maxVerticalScrollPosition);
         
         this.scrollTo(this._viewPort.verticalScrollPosition);
      }
      
      public function get itemRendererClassName() : String
      {
         return this._itemRendererClassName;
      }
      
      public function set itemRendererClassName(param1:String) : void
      {
         if(this._itemRendererClassName != param1)
         {
            this._itemRendererClassName = param1;
            invalidate(InvalidationType.RENDERERS);
         }
      }
      
      public function get dataProvider() : IDataProvider
      {
         return this._viewPort != null ? this._viewPort.dataProvider : null;
      }
      
      private function onViewPortResizeTopHandler(param1:VerticalListViewportEvent) : void
      {
         var _loc2_:int = param1.change;
         this.scrollTo(verticalScrollPosition + _loc2_);
         this._viewPort.y -= _loc2_;
      }
   }
}
