package net.wg.gui.lobby.vehicleCompare
{
   import flash.text.TextField;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.VO.ButtonPropertiesVO;
   import net.wg.gui.components.controls.IconTextButton;
   import net.wg.gui.components.controls.interfaces.ISortableTable;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareCartItemVO;
   import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareCartPopoverInitDataVO;
   import net.wg.gui.lobby.vehicleCompare.events.VehicleCompareCartEvent;
   import net.wg.infrastructure.base.meta.IVehicleCompareCartPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.VehicleCompareCartPopoverMeta;
   import net.wg.infrastructure.interfaces.IWrapper;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class VehicleCompareCartPopover extends VehicleCompareCartPopoverMeta implements IVehicleCompareCartPopoverMeta
   {
      
      private static const WIDTH:int = 362;
      
      private static const HEIGHT:int = 328;
      
      private static const INV_TOCMPBTN_PROPS:String = "InvToCmpBtnProps";
      
      private static const INV_CLEARBTN_PROPS:String = "InvClearBtnProps";
       
      
      public var titleTF:TextField;
      
      public var toCmpBtn:ISoundButtonEx;
      
      public var toCmpWarnBtn:IconTextButton;
      
      public var clearBtn:ISoundButtonEx;
      
      public var table:ISortableTable;
      
      private var _initData:VehicleCompareCartPopoverInitDataVO;
      
      private var _dataProvider:IDataProvider;
      
      private var _toCmpBtnProps:ButtonPropertiesVO;
      
      private var _clearBtnProps:ButtonPropertiesVO;
      
      public function VehicleCompareCartPopover()
      {
         super();
      }
      
      private static function updateButtonParams(param1:ISoundButtonEx, param2:ButtonPropertiesVO) : void
      {
         param1.label = param2.btnLabel;
         param1.tooltip = param2.btnTooltip;
         param1.enabled = param2.btnEnabled;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(this._initData && isInvalid(InvalidationType.DATA))
         {
            this.titleTF.htmlText = this._initData.title;
         }
         if(this._toCmpBtnProps && isInvalid(INV_TOCMPBTN_PROPS))
         {
            _loc1_ = this._toCmpBtnProps.btnIcon != null;
            this.toCmpBtn.visible = !_loc1_;
            this.toCmpWarnBtn.visible = _loc1_;
            if(_loc1_)
            {
               updateButtonParams(this.toCmpWarnBtn,this._toCmpBtnProps);
               this.toCmpWarnBtn.iconSource = this._toCmpBtnProps.btnIcon;
            }
            else
            {
               updateButtonParams(this.toCmpBtn,this._toCmpBtnProps);
            }
         }
         if(this._clearBtnProps && isInvalid(INV_CLEARBTN_PROPS))
         {
            updateButtonParams(this.clearBtn,this._clearBtnProps);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.table.isSortable = true;
         this.table.isListSelectable = false;
         this.table.addEventListener(VehicleCompareCartEvent.DELETE_ITEM,this.onTableDeleteItemHandler);
         this.clearBtn.addEventListener(ButtonEvent.CLICK,this.onClearBtnClickHandler);
         this.toCmpBtn.addEventListener(ButtonEvent.CLICK,this.onToCmpBtnClickHandler);
         this.toCmpWarnBtn.addEventListener(ButtonEvent.CLICK,this.onToCmpBtnClickHandler);
         this.toCmpWarnBtn.mouseEnabledOnDisabled = true;
         this.toCmpWarnBtn.caps = false;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this._dataProvider = new ListDAAPIDataProvider(VehicleCompareCartItemVO);
         this.table.listDP = this._dataProvider;
      }
      
      override protected function onDispose() : void
      {
         this.table.removeEventListener(VehicleCompareCartEvent.DELETE_ITEM,this.onTableDeleteItemHandler);
         this.table.dispose();
         this.table = null;
         this.toCmpBtn.removeEventListener(ButtonEvent.CLICK,this.onToCmpBtnClickHandler);
         this.toCmpBtn.dispose();
         this.toCmpBtn = null;
         this.toCmpWarnBtn.removeEventListener(ButtonEvent.CLICK,this.onToCmpBtnClickHandler);
         this.toCmpWarnBtn.dispose();
         this.toCmpWarnBtn = null;
         this.clearBtn.removeEventListener(ButtonEvent.CLICK,this.onClearBtnClickHandler);
         this.clearBtn.dispose();
         this.clearBtn = null;
         this.titleTF = null;
         this._dataProvider.cleanUp();
         this._dataProvider = null;
         this._initData = null;
         this._toCmpBtnProps = null;
         this._clearBtnProps = null;
         super.onDispose();
      }
      
      override protected function setInitData(param1:VehicleCompareCartPopoverInitDataVO) : void
      {
         this._initData = param1;
         this.table.headerDP = this._initData.tableHeaders;
         invalidateData();
      }
      
      override protected function updateToCmpBtnProps(param1:ButtonPropertiesVO) : void
      {
         this._toCmpBtnProps = param1;
         invalidate(INV_TOCMPBTN_PROPS);
      }
      
      override protected function updateClearBtnProps(param1:ButtonPropertiesVO) : void
      {
         this._clearBtnProps = param1;
         invalidate(INV_CLEARBTN_PROPS);
      }
      
      public function as_getDP() : Object
      {
         return this._dataProvider;
      }
      
      override public function set wrapper(param1:IWrapper) : void
      {
         super.wrapper = param1;
         PopOver(param1).isCloseBtnVisible = true;
      }
      
      override public function get width() : Number
      {
         return WIDTH;
      }
      
      override public function get height() : Number
      {
         return HEIGHT;
      }
      
      private function onToCmpBtnClickHandler(param1:ButtonEvent) : void
      {
         gotoCompareViewS();
      }
      
      private function onClearBtnClickHandler(param1:ButtonEvent) : void
      {
         removeAllS();
      }
      
      private function onTableDeleteItemHandler(param1:VehicleCompareCartEvent) : void
      {
         removeS(param1.id);
      }
   }
}
