package net.wg.gui.lobby.vehiclePreview.additionalInfo
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.lobby.vehiclePreview.data.VPAdditionalInfoVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   
   public class VPAdditionalInfoPanel extends UIComponentEx implements IStageSizeDependComponent
   {
      
      private static const DISPLAY_OBJECT_NAME_CONTAINER:String = "container";
      
      private static const OBJECT_DESC_OFFSET:int = 10;
      
      private static const VEH_INFO_DESC_OFFSET:int = 32;
      
      private static const DESC_TITLE_TEXT_OFFSET:int = 3;
      
      private static const PAGE_SCROLL_SIZE:int = 10;
      
      private static const TITLE_SCALE_SMALL:Number = 0.64;
      
      private static const TITLE_SCALE_NORMAL:Number = 1;
      
      private static const SCROLL_BAR_PADDING:Number = 10;
      
      private static const CONTAINER_BG_COLOR:int = 16777215;
       
      
      public var objectSubtitle:TextField;
      
      public var objectTitle:TextField;
      
      public var vehicleInfoDesc:VehicleInfoDesc;
      
      public var descriptionTitle:TextField;
      
      public var descriptionText:TextField;
      
      public var scrollBar:ScrollBar;
      
      private var _data:VPAdditionalInfoVO;
      
      private var _container:Sprite;
      
      private var _containerBg:Sprite;
      
      public function VPAdditionalInfoPanel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         this.objectSubtitle.mouseEnabled = this.objectSubtitle.mouseWheelEnabled = false;
         this.objectSubtitle.wordWrap = false;
         this.objectTitle.mouseEnabled = this.objectTitle.mouseWheelEnabled = false;
         this.objectTitle.wordWrap = false;
         this.descriptionTitle.mouseEnabled = this.descriptionTitle.mouseWheelEnabled = false;
         this.descriptionTitle.wordWrap = false;
         this.descriptionText.mouseEnabled = this.descriptionText.mouseWheelEnabled = false;
         this.descriptionText.wordWrap = true;
         this.vehicleInfoDesc.visible = false;
         this._containerBg = new Sprite();
         this._containerBg.graphics.lineStyle(0,CONTAINER_BG_COLOR,0);
         this._containerBg.graphics.beginFill(CONTAINER_BG_COLOR,0);
         this._containerBg.graphics.drawRect(0,0,1,1);
         this._containerBg.graphics.endFill();
         this._container = new Sprite();
         this._container.name = DISPLAY_OBJECT_NAME_CONTAINER;
         this._container.addChild(this.descriptionTitle);
         this._container.addChild(this.descriptionText);
         this._container.addEventListener(MouseEvent.MOUSE_WHEEL,this.onContainerMouseWheelHandler);
         addChild(this._container);
         this.scrollBar.addEventListener(Event.SCROLL,this.onScrollBarScrollHandler);
         App.stageSizeMgr.register(this);
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         this.objectSubtitle = null;
         this.objectTitle = null;
         this.vehicleInfoDesc.dispose();
         this.vehicleInfoDesc = null;
         this.descriptionTitle = null;
         this.descriptionText = null;
         this.scrollBar.removeEventListener(Event.SCROLL,this.onScrollBarScrollHandler);
         this.scrollBar.dispose();
         this.scrollBar = null;
         this._container.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onContainerMouseWheelHandler);
         this._container = null;
         this._containerBg = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            if(this._data.vehicleInfoDesc)
            {
               this.vehicleInfoDesc.visible = true;
               this.vehicleInfoDesc.setData(this._data.vehicleInfoDesc);
            }
            this.objectSubtitle.htmlText = this._data.objectSubtitle;
            this.objectTitle.htmlText = this._data.objectTitle;
            this.descriptionTitle.htmlText = this._data.descriptionTitle;
            this.descriptionText.htmlText = this._data.descriptionText;
            App.utils.commons.updateTextFieldSize(this.descriptionText,false,true);
            App.utils.commons.updateTextFieldSize(this.objectTitle,true,true);
         }
         if(this._data && isInvalid(InvalidationType.SIZE))
         {
            this._container.y = this.objectTitle.y + this.objectTitle.height + OBJECT_DESC_OFFSET | 0;
            this.descriptionTitle.y = 0;
            this.descriptionText.y = this.descriptionTitle.y + this.descriptionTitle.height + DESC_TITLE_TEXT_OFFSET | 0;
            this._container.removeChild(this._containerBg);
            this.resetContainerSize();
            this.updateScrollBar();
            this._containerBg.width = this._container.width;
            this._containerBg.height = this._container.height;
            this._container.addChildAt(this._containerBg,0);
            if(this._data.vehicleInfoDesc)
            {
               this.vehicleInfoDesc.y = this.objectTitle.y + this.objectTitle.height;
               this._container.y = this.vehicleInfoDesc.y + VEH_INFO_DESC_OFFSET;
            }
         }
      }
      
      public function setData(param1:VPAdditionalInfoVO) : void
      {
         this._data = param1;
         invalidateData();
         invalidateSize();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         if(param2 == StageSizeBoundaries.HEIGHT_768)
         {
            this.objectTitle.scaleX = this.objectTitle.scaleY = TITLE_SCALE_SMALL;
         }
         else
         {
            this.objectTitle.scaleX = this.objectTitle.scaleY = TITLE_SCALE_NORMAL;
         }
         invalidateSize();
      }
      
      private function updateScrollBar() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this._container.y + this._container.height - height | 0;
         if(_loc1_ > 0)
         {
            this.scrollBar.visible = true;
            this.scrollBar.x = this._container.x + this._container.width + SCROLL_BAR_PADDING | 0;
            this.scrollBar.y = this._container.y;
            this.scrollBar.height = height - this._container.y | 0;
            this.scrollBar.setScrollProperties(this._container.height,0,_loc1_,PAGE_SCROLL_SIZE);
            this.updateContainerPosByScroll();
         }
         else
         {
            this.scrollBar.visible = false;
         }
      }
      
      private function resetContainerSize() : void
      {
         this.scrollBar.position = 0;
         this._container.scrollRect = null;
      }
      
      private function updateContainerPosByScroll() : void
      {
         var _loc1_:int = height - this._container.y | 0;
         this._container.scrollRect = new Rectangle(0,this.scrollBar.position,this._container.width,_loc1_);
      }
      
      private function onScrollBarScrollHandler(param1:Event) : void
      {
         this.updateContainerPosByScroll();
      }
      
      private function onContainerMouseWheelHandler(param1:MouseEvent) : void
      {
         if(this.scrollBar.visible)
         {
            this.scrollBar.position -= param1.delta * PAGE_SCROLL_SIZE | 0;
            this.updateContainerPosByScroll();
         }
      }
   }
}
