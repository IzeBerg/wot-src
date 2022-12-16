package net.wg.gui.components.carousels
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.carousels.data.FilterCarouseInitVO;
   import net.wg.gui.components.carousels.data.FiltersStateVO;
   import net.wg.gui.components.carousels.events.FiltersTileListEvent;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.components.controls.events.RendererEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IClassFactory;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class VehiclesFilterPopoverContent extends UIComponentEx
   {
      
      public static const TOGGLE_TILE_WIDTH:uint = 45;
      
      public static const TOGGLE_TILE_HEIGHT:uint = 34;
      
      protected static const LIST_OFFSET:int = 2;
      
      protected static const LABEL_OFFSET:uint = 7;
      
      private static const CHECKBOX_TILE_WIDTH:uint = 110;
      
      private static const CHECKBOX_TILE_HEIGHT:uint = 25;
      
      private static const LINKAGE_TOGGLE_RENDERER_IMG_ALPHA:String = "ToggleRendererImageAlphaUI";
      
      private static const LINKAGE_CHECKBOX_RENDERER:String = "CheckBoxRendererUI";
       
      
      public var lblNationType:TextField = null;
      
      public var lblVehicleType:TextField = null;
      
      public var lblVehicleLevel:TextField = null;
      
      public var lblHidden:TextField = null;
      
      public var lblSpecials:TextField = null;
      
      public var lblProgressions:TextField = null;
      
      public var listNationType:SimpleTileList = null;
      
      public var listVehicleType:SimpleTileList = null;
      
      public var listVehicleLevels:SimpleTileList = null;
      
      public var listSpecials:SimpleTileList = null;
      
      public var listHidden:SimpleTileList = null;
      
      public var listProgressions:SimpleTileList = null;
      
      public var lblAdditionalInfo:TextField = null;
      
      protected var initData:FilterCarouseInitVO = null;
      
      protected var stateData:FiltersStateVO = null;
      
      public function VehiclesFilterPopoverContent()
      {
         super();
      }
      
      protected static function listSetState(param1:SimpleTileList, param2:Vector.<Boolean>) : void
      {
         var _loc4_:IListItemRenderer = null;
         var _loc3_:int = param2.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = param1.getRendererAt(_loc5_);
            if(_loc4_)
            {
               param1.getRendererAt(_loc5_).selectable = param2[_loc5_];
            }
            _loc5_++;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:IClassFactory = App.utils.classFactory;
         this.listNationType.itemRenderer = _loc1_.getClass(LINKAGE_TOGGLE_RENDERER_IMG_ALPHA);
         this.listVehicleType.itemRenderer = this.listVehicleLevels.itemRenderer = this.listSpecials.itemRenderer = this.listProgressions.itemRenderer = _loc1_.getClass(Linkages.TOGGLE_RENDERER_UI);
         this.listHidden.itemRenderer = _loc1_.getClass(LINKAGE_CHECKBOX_RENDERER);
         this.listNationType.tileWidth = this.listVehicleType.tileWidth = this.listVehicleLevels.tileWidth = this.listSpecials.tileWidth = this.listProgressions.tileWidth = TOGGLE_TILE_WIDTH;
         this.listNationType.tileHeight = this.listVehicleType.tileHeight = this.listVehicleLevels.tileHeight = this.listSpecials.tileHeight = this.listProgressions.tileHeight = TOGGLE_TILE_HEIGHT;
         this.listHidden.tileWidth = CHECKBOX_TILE_WIDTH;
         this.listHidden.tileHeight = CHECKBOX_TILE_HEIGHT;
         this.listSpecials.directionMode = this.listHidden.directionMode = this.listNationType.directionMode = this.listVehicleType.directionMode = this.listVehicleLevels.directionMode = this.listProgressions.directionMode = DirectionMode.HORIZONTAL;
         this.listNationType.addEventListener(RendererEvent.ITEM_CLICK,this.onNationTypeItemClickHandler);
         this.listVehicleType.addEventListener(RendererEvent.ITEM_CLICK,this.onVehicleTypeItemClickHandler);
         this.listVehicleLevels.addEventListener(RendererEvent.ITEM_CLICK,this.onLevelsTypeItemClickHandler);
         this.listSpecials.addEventListener(RendererEvent.ITEM_CLICK,this.onSpecialItemClickHandler);
         this.listHidden.addEventListener(RendererEvent.ITEM_CLICK,this.onHiddenItemClickHandler);
         this.listProgressions.addEventListener(RendererEvent.ITEM_CLICK,this.onProgressionsItemClickHandler);
         this.listNationType.addEventListener(Event.RESIZE,this.onListsResizeHandler);
         this.listVehicleType.addEventListener(Event.RESIZE,this.onListsResizeHandler);
         this.listVehicleLevels.addEventListener(Event.RESIZE,this.onListsResizeHandler);
         this.listSpecials.addEventListener(Event.RESIZE,this.onListsResizeHandler);
         this.listHidden.addEventListener(Event.RESIZE,this.onListsResizeHandler);
         if(this.lblAdditionalInfo)
         {
            this.lblAdditionalInfo.visible = false;
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.stateData && isInvalid(InvalidationType.STATE))
         {
            this.updateState();
         }
         if(this.initData && isInvalid(InvalidationType.DATA))
         {
            this.updateData();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateSize();
         }
      }
      
      override protected function onDispose() : void
      {
         this.listNationType.removeEventListener(RendererEvent.ITEM_CLICK,this.onNationTypeItemClickHandler);
         this.listVehicleType.removeEventListener(RendererEvent.ITEM_CLICK,this.onVehicleTypeItemClickHandler);
         this.listSpecials.removeEventListener(RendererEvent.ITEM_CLICK,this.onSpecialItemClickHandler);
         this.listHidden.removeEventListener(RendererEvent.ITEM_CLICK,this.onHiddenItemClickHandler);
         this.listVehicleLevels.removeEventListener(RendererEvent.ITEM_CLICK,this.onLevelsTypeItemClickHandler);
         this.listProgressions.removeEventListener(RendererEvent.ITEM_CLICK,this.onProgressionsItemClickHandler);
         this.listNationType.removeEventListener(Event.RESIZE,this.onListsResizeHandler);
         this.listVehicleType.removeEventListener(Event.RESIZE,this.onListsResizeHandler);
         this.listVehicleLevels.removeEventListener(Event.RESIZE,this.onListsResizeHandler);
         this.listSpecials.removeEventListener(Event.RESIZE,this.onListsResizeHandler);
         this.listHidden.removeEventListener(Event.RESIZE,this.onListsResizeHandler);
         this.lblNationType = null;
         this.lblVehicleType = null;
         this.lblVehicleLevel = null;
         this.lblSpecials = null;
         this.lblHidden = null;
         this.lblProgressions = null;
         this.lblAdditionalInfo = null;
         this.listNationType.dispose();
         this.listNationType = null;
         this.listVehicleType.dispose();
         this.listVehicleType = null;
         this.listSpecials.dispose();
         this.listSpecials = null;
         this.listHidden.dispose();
         this.listHidden = null;
         this.listVehicleLevels.dispose();
         this.listVehicleLevels = null;
         this.listProgressions.dispose();
         this.listProgressions = null;
         this.initData = null;
         this.stateData = null;
         super.onDispose();
      }
      
      public function setInitData(param1:FilterCarouseInitVO) : void
      {
         if(this.initData != param1)
         {
            this.initData = param1;
            invalidateData();
         }
      }
      
      public function setStateData(param1:FiltersStateVO) : void
      {
         if(this.stateData != param1)
         {
            this.stateData = param1;
            invalidateState();
         }
      }
      
      protected function updateSize() : void
      {
         setSize(width,this.getNewHeight(this.listVehicleType.y + this.listVehicleType.height + LIST_OFFSET));
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      protected function getNewHeight(param1:int) : int
      {
         var _loc2_:Boolean = false;
         this.lblNationType.y = param1;
         this.listNationType.y = this.lblNationType.y + this.lblNationType.height + LABEL_OFFSET | 0;
         param1 = this.listNationType.y + this.listNationType.height + LIST_OFFSET;
         if(this.initData.tankTierSectionVisible)
         {
            this.lblVehicleLevel.y = param1;
            this.listVehicleLevels.y = this.lblVehicleLevel.y + this.lblVehicleLevel.height + LABEL_OFFSET | 0;
            param1 = this.listVehicleLevels.y + this.listVehicleLevels.height + LIST_OFFSET;
         }
         if(this.initData.specialSectionVisible)
         {
            this.lblSpecials.y = param1;
            this.listSpecials.y = this.lblSpecials.y + this.lblSpecials.height + LABEL_OFFSET | 0;
            param1 = this.listSpecials.y + this.listSpecials.height + LIST_OFFSET;
         }
         if(this.initData.hiddenSectionVisible)
         {
            this.lblHidden.y = param1;
            this.listHidden.y = this.lblHidden.y + this.lblHidden.height + LABEL_OFFSET | 0;
            param1 = this.listHidden.y + this.listHidden.height + LIST_OFFSET;
         }
         if(this.initData.progressionsSectionVisible)
         {
            this.lblProgressions.y = param1;
            this.listProgressions.y = this.lblProgressions.y + this.lblProgressions.height + LABEL_OFFSET | 0;
            param1 = this.listProgressions.y + this.listProgressions.height + LIST_OFFSET;
         }
         if(this.lblAdditionalInfo)
         {
            _loc2_ = StringUtils.isNotEmpty(this.initData.additionalInfo);
            this.lblAdditionalInfo.visible = _loc2_;
            if(_loc2_)
            {
               this.lblAdditionalInfo.y = param1;
               param1 = this.lblAdditionalInfo.y + this.lblAdditionalInfo.height + LIST_OFFSET | 0;
            }
         }
         return param1;
      }
      
      protected function updateState() : void
      {
         listSetState(this.listNationType,this.stateData.nationsSelected);
         listSetState(this.listVehicleType,this.stateData.vehicleTypesSelected);
         listSetState(this.listSpecials,this.stateData.specialsSelected);
         listSetState(this.listHidden,this.stateData.hiddenSelected);
         listSetState(this.listVehicleLevels,this.stateData.levelsSelected);
         listSetState(this.listProgressions,this.stateData.progressionsSelected);
      }
      
      protected function updateData() : void
      {
         var _loc1_:String = null;
         this.lblHidden.visible = this.listHidden.visible = this.initData.hiddenSectionVisible;
         if(this.initData.hiddenSectionVisible)
         {
            this.lblHidden.htmlText = this.initData.hiddenLabel;
            this.listHidden.dataProvider = this.initData.hidden;
         }
         this.lblSpecials.visible = this.listSpecials.visible = this.initData.specialSectionVisible;
         if(this.initData.specialSectionVisible)
         {
            this.lblSpecials.htmlText = this.initData.specialsLabel;
            this.listSpecials.dataProvider = this.initData.specials;
         }
         this.lblVehicleLevel.visible = this.listVehicleLevels.visible = this.initData.tankTierSectionVisible;
         if(this.initData.tankTierSectionVisible)
         {
            this.lblVehicleLevel.htmlText = this.initData.levelsLabel;
            this.listVehicleLevels.dataProvider = this.initData.levels;
         }
         this.lblProgressions.visible = this.listProgressions.visible = this.initData.progressionsSectionVisible;
         if(this.initData.progressionsSectionVisible)
         {
            this.lblProgressions.htmlText = this.initData.progressionsLabel;
            this.listProgressions.dataProvider = this.initData.progressions;
         }
         this.lblNationType.htmlText = this.initData.nationsLabel;
         this.listNationType.dataProvider = this.initData.nations;
         this.lblVehicleType.htmlText = this.initData.vehicleTypesLabel;
         this.listVehicleType.dataProvider = this.initData.vehicleTypes;
         if(this.lblAdditionalInfo)
         {
            _loc1_ = this.initData.additionalInfo;
            if(StringUtils.isNotEmpty(_loc1_))
            {
               this.lblAdditionalInfo.htmlText = _loc1_;
               App.utils.commons.updateTextFieldSize(this.lblAdditionalInfo,false,true);
            }
         }
      }
      
      private function onNationTypeItemClickHandler(param1:RendererEvent) : void
      {
         dispatchEvent(new FiltersTileListEvent(FiltersTileListEvent.ITEM_CLICK,this.initData.nationsSectionId,param1.index));
      }
      
      private function onLevelsTypeItemClickHandler(param1:RendererEvent) : void
      {
         dispatchEvent(new FiltersTileListEvent(FiltersTileListEvent.ITEM_CLICK,this.initData.levelsSectionId,param1.index));
      }
      
      private function onSpecialItemClickHandler(param1:RendererEvent) : void
      {
         dispatchEvent(new FiltersTileListEvent(FiltersTileListEvent.ITEM_CLICK,this.initData.specialSectionId,param1.index));
      }
      
      private function onHiddenItemClickHandler(param1:RendererEvent) : void
      {
         dispatchEvent(new FiltersTileListEvent(FiltersTileListEvent.ITEM_CLICK,this.initData.hiddenSectionId,param1.index));
      }
      
      private function onVehicleTypeItemClickHandler(param1:RendererEvent) : void
      {
         dispatchEvent(new FiltersTileListEvent(FiltersTileListEvent.ITEM_CLICK,this.initData.vehicleTypesSectionId,param1.index));
      }
      
      private function onProgressionsItemClickHandler(param1:RendererEvent) : void
      {
         dispatchEvent(new FiltersTileListEvent(FiltersTileListEvent.ITEM_CLICK,this.initData.progressionsSectionId,param1.index));
      }
      
      private function onListsResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
