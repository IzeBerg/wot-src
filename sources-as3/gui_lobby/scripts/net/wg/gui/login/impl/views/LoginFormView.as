package net.wg.gui.login.impl.views
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.common.serverStats.ServerDropDown;
   import net.wg.gui.components.common.serverStats.ServerVO;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.components.controls.events.DropdownMenuEvent;
   import net.wg.gui.components.controls.helpers.ServerCsisState;
   import net.wg.gui.login.IFormBaseVo;
   import net.wg.gui.login.ILoginFormView;
   import net.wg.gui.login.impl.ev.LoginEvent;
   import net.wg.gui.login.impl.ev.LoginEventTextLink;
   import net.wg.gui.login.impl.ev.LoginServerDDEvent;
   import net.wg.gui.login.impl.vo.SubmitDataVo;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class LoginFormView extends UIComponentEx implements ILoginFormView
   {
      
      private static const MAX_SERVER_ROW_COUNT:Number = 12;
      
      public static const INV_ALL_DATA:String = "inv_allData";
      
      public static const INVALID_INIT_FOCUS:String = "invalidInitFocus";
      
      public static const PASSWORD_RECOVERY:String = "passwordRecovery";
       
      
      public var submit:SoundButton = null;
      
      private var _message:TextField = null;
      
      private var _server:ServerDropDown = null;
      
      private var _data:IFormBaseVo = null;
      
      private var _isTFClickedByMBR:Boolean = false;
      
      public function LoginFormView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.utils.styleSheetManager.setLinkStyle(this._message);
         this.submit.soundType = SoundTypes.RED_BTN;
         this.submit.addEventListener(ButtonEvent.CLICK,this.onSubmitClickHandler);
         this._server.checkItemDisabledFunction = this.checkListItemDisabledFunction;
         this._server.addEventListener(DropdownMenuEvent.SHOW_DROP_DOWN,this.onServerShowDropDownHandler);
         this._server.addEventListener(DropdownMenuEvent.CLOSE_DROP_DOWN,this.onServerCloseDropDownHandler);
         this._server.addEventListener(ListEvent.INDEX_CHANGE,this.onServerIndexChangeHandler);
         this._message.addEventListener(TextEvent.LINK,this.onMessageLinkHandler);
         this._message.addEventListener(MouseEvent.CLICK,this.onMessageClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         this.submit.removeEventListener(ButtonEvent.CLICK,this.onSubmitClickHandler);
         this.submit.dispose();
         this.submit = null;
         this._message.removeEventListener(TextEvent.LINK,this.onMessageLinkHandler);
         this._message.removeEventListener(MouseEvent.CLICK,this.onMessageClickHandler);
         this._message.styleSheet = null;
         this._message = null;
         this._server.removeEventListener(DropdownMenuEvent.SHOW_DROP_DOWN,this.onServerShowDropDownHandler);
         this._server.removeEventListener(DropdownMenuEvent.CLOSE_DROP_DOWN,this.onServerCloseDropDownHandler);
         this._server.removeEventListener(ListEvent.INDEX_CHANGE,this.onServerIndexChangeHandler);
         this._server.dispose();
         this._server = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(!this._data)
         {
            return;
         }
         if(isInvalid(INV_ALL_DATA))
         {
            this.redrawAll();
         }
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function getSubmitData() : SubmitDataVo
      {
         var _loc1_:SubmitDataVo = new SubmitDataVo();
         _loc1_.login = Values.EMPTY_STR;
         _loc1_.pwd = Values.EMPTY_STR;
         _loc1_.host = this.getSelectedServerName();
         _loc1_.isSocial = false;
         return _loc1_;
      }
      
      public function initFocus() : void
      {
         invalidate(INVALID_INIT_FOCUS);
      }
      
      public function setErrorMessage(param1:String, param2:int) : void
      {
         this.message.htmlText = param1;
      }
      
      public function setSelectedServerIndex(param1:int) : void
      {
         if(this._server.dataProvider != null && this._server.dataProvider.length == 0)
         {
            return;
         }
         if(this._server.dataProvider.length > param1)
         {
            this._server.selectedIndex = param1;
         }
         else
         {
            DebugUtils.LOG_WARNING("Selected server index " + param1 + " not found in provided list!");
         }
      }
      
      public function setServersDP(param1:IDataProvider) : void
      {
         this._server.dataProvider = param1;
         this._server.scrollBar = param1.length > this._server.menuRowCount ? Linkages.SCROLL_BAR : Values.EMPTY_STR;
         this._server.menuRowCount = Math.min(param1.length,MAX_SERVER_ROW_COUNT);
      }
      
      public function update(param1:Object) : void
      {
      }
      
      public function updateVo(param1:IFormBaseVo) : void
      {
         this._data = param1;
         invalidate(this._data.invalidType);
      }
      
      protected function dispatchFocus() : void
      {
      }
      
      protected function getSelectedServerName() : String
      {
         var _loc1_:Number = this.server.selectedIndex;
         var _loc2_:ServerVO = ServerVO(this.server.dataProvider.requestItemAt(_loc1_));
         if(_loc2_ != null)
         {
            return _loc2_.data;
         }
         return Values.EMPTY_STR;
      }
      
      protected function redrawAll() : void
      {
      }
      
      protected function dispatchInputChange(param1:InteractiveObject) : void
      {
         dispatchEvent(new LoginEvent(LoginEvent.ON_INPUT_CHANGE,true,false,param1));
      }
      
      protected function submitDispatch() : void
      {
         dispatchEvent(new LoginEvent(LoginEvent.SUBMIT,true,false));
      }
      
      private function checkListItemDisabledFunction(param1:ServerVO) : Boolean
      {
         return param1.csisStatus == ServerCsisState.NOT_AVAILABLE;
      }
      
      private function dispatchServerEvent(param1:Boolean) : void
      {
         dispatchEvent(new LoginServerDDEvent(LoginServerDDEvent.ON_CHANGE_LISTEN_CSIS,true,false,null,param1,this.server.selectedIndex));
      }
      
      public function get message() : TextField
      {
         return this._message;
      }
      
      public function set message(param1:TextField) : void
      {
         this._message = param1;
      }
      
      public function get server() : ServerDropDown
      {
         return this._server;
      }
      
      public function set server(param1:ServerDropDown) : void
      {
         this._server = param1;
      }
      
      private function onServerCloseDropDownHandler(param1:DropdownMenuEvent) : void
      {
         this.dispatchServerEvent(false);
      }
      
      private function onServerShowDropDownHandler(param1:DropdownMenuEvent) : void
      {
         this.dispatchServerEvent(true);
      }
      
      private function onMessageClickHandler(param1:MouseEvent) : void
      {
         this._isTFClickedByMBR = App.utils.commons.isRightButton(param1);
      }
      
      private function onMessageLinkHandler(param1:TextEvent) : void
      {
         var _loc2_:Event = null;
         if(this._isTFClickedByMBR)
         {
            return;
         }
         if(param1.text == PASSWORD_RECOVERY)
         {
            _loc2_ = new LoginEvent(LoginEvent.ON_RECOVERY_LINK_CLICK,true,false);
         }
         else
         {
            _loc2_ = new LoginEventTextLink(LoginEventTextLink.ON_TEXT_LINK_CLICK,true,false,param1.text);
         }
         dispatchEvent(_loc2_);
      }
      
      private function onServerIndexChangeHandler(param1:ListEvent) : void
      {
         this.dispatchInputChange(InteractiveObject(param1.target));
         if(param1.itemData)
         {
            dispatchEvent(new LoginServerDDEvent(LoginServerDDEvent.ON_SERVER_CHANGE,true,false,ServerVO(param1.itemData),false,this.server.selectedIndex));
         }
      }
      
      private function onSubmitClickHandler(param1:ButtonEvent) : void
      {
         this.submitDispatch();
      }
   }
}
