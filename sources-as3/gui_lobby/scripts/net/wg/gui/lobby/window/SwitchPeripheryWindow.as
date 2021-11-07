package net.wg.gui.lobby.window
{
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.daapi.LoadViewVO;
   import net.wg.gui.components.common.serverStats.ServerDropDown;
   import net.wg.gui.components.common.serverStats.ServerVO;
   import net.wg.gui.components.controls.events.DropdownMenuEvent;
   import net.wg.infrastructure.base.meta.ISwitchPeripheryWindowMeta;
   import net.wg.infrastructure.base.meta.impl.SwitchPeripheryWindowMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class SwitchPeripheryWindow extends SwitchPeripheryWindowMeta implements ISwitchPeripheryWindowMeta
   {
      
      private static const BOTTOM_MARGIN:int = 130;
      
      private static const MENU_GAP:int = 1;
      
      private static const LINES_GAP:int = 10;
      
      private static const BTN_ACTION_SWITCH:String = "switchAction";
      
      private static const INV_CSIS_LISTENING:String = "invCsisListening";
       
      
      public var labelTF:TextField = null;
      
      public var serverDropdownMenu:ServerDropDown = null;
      
      private var _dataProvider:IDataProvider;
      
      private var _label:String;
      
      private var _showDropDown:Boolean = false;
      
      private var _startListenCSIS:Boolean = false;
      
      public function SwitchPeripheryWindow()
      {
         super();
         this._dataProvider = new ListDAAPIDataProvider(ServerVO);
         contentBottomMargin = BOTTOM_MARGIN;
      }
      
      override public function set as_config(param1:LoadViewVO) : void
      {
         super.as_config = param1;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.serverDropdownMenu.dataProvider = this._dataProvider;
         this.serverDropdownMenu.x = DESCRIPTION_HORIZONTAL_MARGIN;
         this.serverDropdownMenu.addEventListener(DropdownMenuEvent.SHOW_DROP_DOWN,this.onRegionShowDropDownHandler);
         this.serverDropdownMenu.addEventListener(DropdownMenuEvent.CLOSE_DROP_DOWN,this.onRegionCloseDropDownHandler);
      }
      
      override protected function onDispose() : void
      {
         this._dataProvider.cleanUp();
         this._dataProvider = null;
         this.serverDropdownMenu.removeEventListener(DropdownMenuEvent.SHOW_DROP_DOWN,this.onRegionShowDropDownHandler);
         this.serverDropdownMenu.removeEventListener(DropdownMenuEvent.CLOSE_DROP_DOWN,this.onRegionCloseDropDownHandler);
         this.serverDropdownMenu.dispose();
         this.serverDropdownMenu = null;
         this.labelTF = null;
         super.onDispose();
      }
      
      override protected function updateCustomLayout(param1:Number, param2:Number) : Rectangle
      {
         var _loc3_:int = param1 - (DESCRIPTION_HORIZONTAL_MARGIN << 1) >> 0;
         descriptionTF.width = _loc3_;
         this.labelTF.width = _loc3_;
         return new Rectangle(0,0,param1,param2);
      }
      
      override protected function initTexts() : void
      {
         super.initTexts();
         this.labelTF.multiline = true;
         this.labelTF.wordWrap = true;
         this.labelTF.autoSize = TextFieldAutoSize.LEFT;
         this.labelTF.x = DESCRIPTION_HORIZONTAL_MARGIN;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.labelTF.htmlText = this._label;
            this.serverDropdownMenu.visible = this._showDropDown;
            App.utils.commons.updateTextFieldSize(descriptionTF,false,true);
            App.utils.commons.updateTextFieldSize(this.labelTF,false,true);
            this.labelTF.y = descriptionTF.y + descriptionTF.height + LINES_GAP >> 0;
            this.serverDropdownMenu.y = this.labelTF.y + this.labelTF.height + MENU_GAP >> 0;
         }
         if(isInvalid(INV_CSIS_LISTENING))
         {
            onDropDownOpenedS(this._startListenCSIS);
         }
      }
      
      override protected function isBtnHasCustomAction(param1:String) : Boolean
      {
         var _loc2_:ServerVO = null;
         if(param1 == BTN_ACTION_SWITCH)
         {
            _loc2_ = ServerVO(this.serverDropdownMenu.dataProvider.requestItemAt(this.serverDropdownMenu.selectedIndex));
            requestForChangeS(_loc2_.id);
            return true;
         }
         return super.isBtnHasCustomAction(param1);
      }
      
      public function as_getServersDP() : Object
      {
         return this._dataProvider;
      }
      
      public function as_setSelectedIndex(param1:int) : void
      {
         this.serverDropdownMenu.selectedIndex = param1;
      }
      
      public function as_setServerParams(param1:String, param2:Boolean) : void
      {
         this._label = param1;
         this._showDropDown = param2;
         invalidateData();
      }
      
      private function onRegionCloseDropDownHandler(param1:DropdownMenuEvent) : void
      {
         this._startListenCSIS = false;
         invalidate(INV_CSIS_LISTENING);
      }
      
      private function onRegionShowDropDownHandler(param1:DropdownMenuEvent) : void
      {
         this._startListenCSIS = true;
         invalidate(INV_CSIS_LISTENING);
      }
   }
}
