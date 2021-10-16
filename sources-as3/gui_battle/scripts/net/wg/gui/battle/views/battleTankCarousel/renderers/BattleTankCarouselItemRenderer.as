package net.wg.gui.battle.views.battleTankCarousel.renderers
{
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.SoundManagerStatesLobby;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.battle.views.battleTankCarousel.data.BattleVehicleCarouselVO;
   import net.wg.gui.components.carousels.controls.levelInfo.LevelInfoItem;
   import net.wg.gui.components.carousels.events.TankItemEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   import net.wg.gui.components.controls.scroller.ListRendererEvent;
   import net.wg.gui.components.controls.scroller.data.ScrollerItemRendererSize;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.gfx.MouseEventEx;
   
   public class BattleTankCarouselItemRenderer extends SoundButtonEx implements IScrollerItemRenderer
   {
      
      private static const DEFAULT_WIDTH:uint = 162;
      
      private static const DEFAULT_HEIGHT:uint = 102;
      
      private static const INFO_LEVEL_ITEM_NAME:String = "infoLevelContent";
      
      private static const LEVEL_INFO_ITEM_LINKAGE:String = "InfoLevelItemUI";
      
      private static const LEVEL_INFO_OFFSET:int = -10;
      
      private static const INFO_LEVEL_MASK_NAME:String = "infoLevelMask";
       
      
      public var content:BaseBattleTankIcon = null;
      
      public var border:Sprite = null;
      
      public var selectedMc:Sprite = null;
      
      public var hoverBg:Sprite = null;
      
      private var _index:uint = 0;
      
      private var _vehicleData:BattleVehicleCarouselVO = null;
      
      private var _isClickEnabled:Boolean = false;
      
      private var _isViewPortEnabled:Boolean = true;
      
      private var _isInteractive:Boolean = false;
      
      private var _rowCount:int = 0;
      
      private var _infoLevelContent:LevelInfoItem = null;
      
      private var _infoLevelContentMask:Shape = null;
      
      private var _hasLevelInfo:Boolean = false;
      
      public function BattleTankCarouselItemRenderer()
      {
         super();
         preventAutosizing = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.content.cacheAsBitmap = true;
         this.border.mouseEnabled = false;
         this.border.mouseChildren = false;
         this.selectedMc.mouseEnabled = false;
         this.selectedMc.mouseChildren = false;
         soundType = SoundTypes.CAROUSEL_BTN;
         soundId = SoundManagerStatesLobby.CAROUSEL_CELL_BTN;
         this.addListeners();
      }
      
      override protected function onDispose() : void
      {
         this.removeListeners();
         this.content.dispose();
         this.content = null;
         this._vehicleData = null;
         _owner = null;
         this.border = null;
         this.selectedMc = null;
         this.hoverBg = null;
         this.clearInfoLevelContent();
         super.onDispose();
      }
      
      public function measureSize(param1:Point = null) : Point
      {
         return null;
      }
      
      protected function updateData() : void
      {
         var _loc1_:Boolean = this._vehicleData != null;
         if(_loc1_)
         {
            mouseEnabledOnDisabled = true;
            this._isClickEnabled = this._vehicleData.enabled;
         }
         else
         {
            this._isClickEnabled = false;
            mouseEnabledOnDisabled = false;
         }
         this.updateInteractiveState();
         this._hasLevelInfo = _loc1_ && this._vehicleData.hasExtendedInfo;
         this.updateInfoLevelContent();
         if(!this._hasLevelInfo)
         {
            this.content.setData(this._vehicleData);
         }
         else
         {
            this.content.resetData();
         }
      }
      
      private function updateInteractiveState() : void
      {
         this._isInteractive = this._isViewPortEnabled && this._isClickEnabled && !this._hasLevelInfo;
         this.enabled = this._isInteractive;
         this.content.enabled = this._isInteractive;
      }
      
      private function addListeners() : void
      {
         addEventListener(MouseEvent.CLICK,this.onSlotMouseClickHandler);
      }
      
      private function removeListeners() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onSlotMouseClickHandler);
      }
      
      private function clearInfoLevelContent() : void
      {
         if(this._infoLevelContent)
         {
            this._infoLevelContent.removeEventListener(ListRendererEvent.CHANGE_SIZE,this.onInfoLevelChangeSizeHandler);
            removeChild(this._infoLevelContent);
            this._infoLevelContent.dispose();
            this._infoLevelContent = null;
         }
         if(this._infoLevelContentMask)
         {
            mask = null;
            removeChild(this._infoLevelContentMask);
            this._infoLevelContentMask = null;
         }
      }
      
      private function addInfoLevelContent() : void
      {
         this._infoLevelContent = App.utils.classFactory.getComponent(LEVEL_INFO_ITEM_LINKAGE,LevelInfoItem);
         this._infoLevelContent.name = INFO_LEVEL_ITEM_NAME;
         this._infoLevelContent.addEventListener(ListRendererEvent.CHANGE_SIZE,this.onInfoLevelChangeSizeHandler);
         this._infoLevelContent.y = LEVEL_INFO_OFFSET;
         addChildAt(this._infoLevelContent,getChildIndex(this.content));
         this._infoLevelContentMask = new Shape();
         this._infoLevelContentMask.name = INFO_LEVEL_MASK_NAME;
         var _loc1_:Graphics = this._infoLevelContentMask.graphics;
         _loc1_.beginFill(4095,1);
         _loc1_.drawRect(0,0,32,102);
         _loc1_.endFill();
         addChild(this._infoLevelContentMask);
         mask = this._infoLevelContentMask;
      }
      
      private function updateInfoLevelContent() : void
      {
         if(this._hasLevelInfo)
         {
            if(!this._infoLevelContent)
            {
               this.addInfoLevelContent();
            }
            this._infoLevelContent.setData(this._vehicleData.levelInfo);
            this._infoLevelContent.small = this.adaptiveSize == ScrollerItemRendererSize.SMALL_SIZE;
            this._infoLevelContent.doubled = this._rowCount > 1;
            this._infoLevelContent.visible = true;
            this.content.visible = false;
            this.border.visible = false;
            this.selectedMc.visible = false;
            this.hoverBg.visible = false;
            hitMc.width = hitMc.height = 0;
         }
         else
         {
            if(this._infoLevelContent)
            {
               this.resetLayout();
            }
            this.clearInfoLevelContent();
         }
      }
      
      private function resetLayout() : void
      {
         this.border.visible = this.selectedMc.visible = this.hoverBg.visible = true;
         hitMc.width = DEFAULT_WIDTH;
         hitMc.height = DEFAULT_HEIGHT;
      }
      
      [Inspectable(defaultValue="",type="string")]
      override public function get data() : Object
      {
         return this._vehicleData;
      }
      
      override public function set data(param1:Object) : void
      {
         if(this._vehicleData != null)
         {
            this._vehicleData.removeEventListener(Event.CHANGE,this.onDataVOChangeHandler);
            this._vehicleData = null;
         }
         if(param1 != null)
         {
            this._vehicleData = BattleVehicleCarouselVO(param1);
            this._vehicleData.addEventListener(Event.CHANGE,this.onDataVOChangeHandler);
         }
         this.updateData();
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function set tooltipDecorator(param1:ITooltipMgr) : void
      {
      }
      
      public function set isViewPortEnabled(param1:Boolean) : void
      {
         if(this._isViewPortEnabled == param1)
         {
            return;
         }
         this._isViewPortEnabled = param1;
         this.updateInteractiveState();
      }
      
      public function get rowsCount() : int
      {
         return this._rowCount;
      }
      
      public function set rowsCount(param1:int) : void
      {
         this._rowCount = param1;
      }
      
      public function get adaptiveSize() : String
      {
         return ScrollerItemRendererSize.NORMAL_SIZE;
      }
      
      private function onSlotMouseClickHandler(param1:Event) : void
      {
         var _loc2_:MouseEventEx = null;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         if(!this._isInteractive)
         {
            return;
         }
         if(this._vehicleData != null)
         {
            _loc2_ = param1 as MouseEventEx;
            _loc3_ = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
            if(!selected && _loc3_ == MouseEventEx.LEFT_BUTTON)
            {
               if(this._isClickEnabled && !this._hasLevelInfo)
               {
                  _loc4_ = TankItemEvent.SELECT_ITEM;
                  dispatchEvent(new ListRendererEvent(ListRendererEvent.SELECT));
               }
               if(_loc4_ != null)
               {
                  dispatchEvent(new TankItemEvent(_loc4_,this._index));
               }
            }
         }
      }
      
      private function onDataVOChangeHandler(param1:Event) : void
      {
         this.updateData();
      }
      
      private function onInfoLevelChangeSizeHandler(param1:ListRendererEvent) : void
      {
         dispatchEvent(param1);
      }
   }
}
