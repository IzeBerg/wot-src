package net.wg.gui.lobby.profile.components
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class BattlesTypeDropdown extends UIComponentEx
   {
       
      
      public var txtLabel:TextField = null;
      
      public var dropdownMenu:DropdownMenu = null;
      
      private var _selectedItem:String = "";
      
      private var _tooltip:String = null;
      
      private var _isToolTipShowing:Boolean = false;
      
      public function BattlesTypeDropdown()
      {
         super();
      }
      
      private static function hideToolTip() : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(App.utils)
         {
            this.txtLabel.autoSize = TextFieldAutoSize.RIGHT;
            this.txtLabel.htmlText = App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.MAIN_TEXT,App.utils.locale.makeString(PROFILE.PROFILE_DROPDOWN_BATTLESTYPE));
         }
         this.tooltip = PROFILE.TOOLTIP_DROPDOWN_BATTLETYPE;
      }
      
      override protected function draw() : void
      {
         var _loc1_:IDataProvider = null;
         var _loc2_:uint = 0;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._selectedItem)
            {
               _loc1_ = this.dropdownMenu.dataProvider;
               _loc2_ = _loc1_.length;
               _loc4_ = -1;
               _loc5_ = 0;
               while(_loc5_ < _loc2_)
               {
                  _loc3_ = _loc1_[_loc5_];
                  if(_loc3_.key == this._selectedItem)
                  {
                     _loc4_ = _loc5_;
                     break;
                  }
                  _loc5_++;
               }
               this.dropdownMenu.selectedIndex = _loc4_;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.disposeHandlers();
         this.dropdownMenu.removeEventListener(ListEvent.INDEX_CHANGE,this.onMenuIndexChangeHandler);
         this.dropdownMenu.dispose();
         this.dropdownMenu = null;
         this.txtLabel = null;
         super.onDispose();
      }
      
      private function disposeHandlers() : void
      {
         this.dropdownMenu.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.dropdownMenu.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      private function showToolTip() : void
      {
         if(this._tooltip)
         {
            App.toolTipMgr.showComplex(this._tooltip);
         }
      }
      
      public function set dataProvider(param1:IDataProvider) : void
      {
         this.dropdownMenu.addEventListener(ListEvent.INDEX_CHANGE,this.onMenuIndexChangeHandler,false,0,true);
         this.dropdownMenu.dataProvider = param1;
         this.dropdownMenu.validateNow();
      }
      
      public function get tooltip() : String
      {
         return this._tooltip;
      }
      
      public function set tooltip(param1:String) : void
      {
         this._tooltip = param1;
         this.disposeHandlers();
         if(this._isToolTipShowing)
         {
            hideToolTip();
            this.showToolTip();
         }
         if(this._tooltip)
         {
            this.dropdownMenu.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler,false,0,true);
            this.dropdownMenu.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler,false,0,true);
         }
      }
      
      public function get selectedItem() : String
      {
         return this._selectedItem;
      }
      
      public function set selectedItem(param1:String) : void
      {
         if(this._selectedItem == param1)
         {
            return;
         }
         this._selectedItem = param1;
         invalidateData();
      }
      
      protected function onRollOverHandler(param1:MouseEvent) : void
      {
         this._isToolTipShowing = true;
         this.showToolTip();
      }
      
      protected function onRollOutHandler(param1:MouseEvent) : void
      {
         this._isToolTipShowing = false;
         hideToolTip();
      }
      
      private function onMenuIndexChangeHandler(param1:ListEvent) : void
      {
         param1.stopImmediatePropagation();
         this._selectedItem = param1.itemData.key;
         dispatchEvent(new Event(Event.CHANGE));
      }
   }
}
