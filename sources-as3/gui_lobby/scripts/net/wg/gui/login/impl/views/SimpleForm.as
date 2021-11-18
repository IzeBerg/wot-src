package net.wg.gui.login.impl.views
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.common.serverStats.ServerVO;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.HyperLink;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.gui.login.IFormBaseVo;
   import net.wg.gui.login.impl.ErrorStates;
   import net.wg.gui.login.impl.components.CapsLockIndicator;
   import net.wg.gui.login.impl.components.LoginIgrWarning;
   import net.wg.gui.login.impl.components.SocialGroup;
   import net.wg.gui.login.impl.components.SocialItemRenderer;
   import net.wg.gui.login.impl.ev.LoginEvent;
   import net.wg.gui.login.impl.vo.SimpleFormVo;
   import net.wg.gui.login.impl.vo.SubmitDataVo;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class SimpleForm extends LoginFormView
   {
      
      public static const INV_CAPS_LOCK:String = "inv_capsLock";
      
      public static const INV_KEYBOARD_LANG:String = "inv_keyboardLang";
      
      public static const INV_AUTO_LOGIN_KEY:String = "inv_autoLoginKey";
      
      public static const INV_DEFAULT_DATA:String = "inv_defData";
      
      public static const INV_PASSWORD:String = "inv_password";
      
      private static const INV_SOCIAL_LIST:String = "inv_socialList";
      
      private static const MULTI_SYMBOL:String = "*";
      
      private static const REMEMBER_PWD_CHECK_BOX_WIDTH:Number = 500;
      
      private static const REMEMBER_PWD_CHECK_BOX_INVISIBLE_TOP_OFFSET:uint = 20;
      
      private static const SUBMIT_Y:uint = 98;
      
      private static const SOCIAL_Y:uint = 157;
      
      private static const MESSAGE_Y:uint = 208;
       
      
      public var serverTF:TextField;
      
      public var capsLockIndicator:CapsLockIndicator = null;
      
      public var loginTF:TextField = null;
      
      public var passwordTF:TextField = null;
      
      public var igrWarning:LoginIgrWarning = null;
      
      public var keyboardLang:TextField = null;
      
      public var socialGroup:SocialGroup = null;
      
      public var rememberPwdCheckbox:CheckBox = null;
      
      public var registerLink:HyperLink = null;
      
      public var recoveryLink:HyperLink = null;
      
      public var login:TextInput = null;
      
      public var pass:TextInput = null;
      
      private var _hasCtrlVDown:Boolean = false;
      
      private var _lastDownKeyCode:Number = -1;
      
      private var _isIgrCredentialsReset:Boolean = false;
      
      private var _dataVo:SimpleFormVo = null;
      
      public function SimpleForm()
      {
         super();
      }
      
      override public function getSubmitData() : SubmitDataVo
      {
         var _loc1_:SubmitDataVo = new SubmitDataVo();
         _loc1_.login = this.login.text;
         _loc1_.pwd = this.pass.text;
         _loc1_.host = getSelectedServerName();
         _loc1_.isSocial = false;
         return _loc1_;
      }
      
      override public function setErrorMessage(param1:String, param2:int) : void
      {
         super.setErrorMessage(param1,param2);
         this.login.highlight = (param2 & ErrorStates.LOGIN_INVALID) == ErrorStates.LOGIN_INVALID;
         this.pass.highlight = (param2 & ErrorStates.PASSWORD_INVALID) == ErrorStates.PASSWORD_INVALID;
      }
      
      override public function setServersDP(param1:IDataProvider) : void
      {
         super.setServersDP(param1);
         this.updateSubmitEnabled();
      }
      
      override public function updateVo(param1:IFormBaseVo) : void
      {
         this._dataVo = param1 as SimpleFormVo;
         App.utils.asserter.assertNotNull(this._dataVo,Errors.CANT_NULL);
         super.updateVo(param1);
      }
      
      override protected function dispatchFocus() : void
      {
         if(this.login.text.length == 0 || this.login.highlight)
         {
            dispatchEvent(new LoginEvent(LoginEvent.FOCUS_INIT,true,false,this.login));
         }
         else
         {
            dispatchEvent(new LoginEvent(LoginEvent.FOCUS_INIT,true,false,this.pass));
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.socialGroup != null)
         {
            this.socialGroup.socialList.removeEventListener(ListEvent.ITEM_CLICK,this.onSocialListItemClickHandler);
            this.socialGroup.dispose();
            this.socialGroup = null;
         }
         removeEventListener(InputEvent.INPUT,this.onInputHandler);
         this.login.removeEventListener(Event.CHANGE,this.onInputChangeHandler);
         this.pass.removeEventListener(Event.CHANGE,this.onInputChangeHandler);
         this.rememberPwdCheckbox.removeEventListener(Event.SELECT,this.onRememberPwdCheckboxSelectHandler);
         this.rememberPwdCheckbox.removeEventListener(MouseEvent.MOUSE_OVER,this.onRememberPwdCheckboxMouseOverHandler);
         this.rememberPwdCheckbox.removeEventListener(MouseEvent.ROLL_OUT,this.onRememberPwdCheckboxRollOutHandler);
         this.rememberPwdCheckbox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onRememberPwdCheckboxMouseDownHandler);
         this.registerLink.removeEventListener(ButtonEvent.CLICK,this.onRegisterLinkClickHandler);
         this.recoveryLink.removeEventListener(ButtonEvent.CLICK,this.onRecoveryLinkClickHandler);
         this.serverTF = null;
         this.loginTF = null;
         this.passwordTF = null;
         this.rememberPwdCheckbox.dispose();
         this.rememberPwdCheckbox = null;
         this.registerLink.dispose();
         this.registerLink = null;
         this.recoveryLink.dispose();
         this.recoveryLink = null;
         this.login.dispose();
         this.login = null;
         this.pass.dispose();
         this.pass = null;
         this.igrWarning.dispose();
         this.igrWarning = null;
         this.keyboardLang = null;
         this.capsLockIndicator.dispose();
         this.capsLockIndicator = null;
         this._dataVo = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:IDataProvider = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:ServerVO = null;
         var _loc5_:int = 0;
         super.draw();
         if(!this._dataVo)
         {
            return;
         }
         if(isInvalid(INV_CAPS_LOCK))
         {
            this.capsLockIndicator.visible = this._dataVo.capsLockState;
         }
         if(isInvalid(INV_KEYBOARD_LANG))
         {
            this.keyboardLang.text = this._dataVo.keyboardLang;
         }
         if(isInvalid(INV_AUTO_LOGIN_KEY))
         {
            _loc1_ = server.dataProvider;
            _loc2_ = -1;
            _loc3_ = _loc1_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_ = ServerVO(_loc1_.requestItemAt(_loc5_));
               if(_loc4_.data == this._dataVo.autoLoginKey)
               {
                  _loc2_ = _loc5_;
                  break;
               }
               _loc5_++;
            }
            if(_loc2_ > -1)
            {
               server.selectedIndex = _loc2_;
               server.validateNow();
               submitDispatch();
            }
         }
         if(isInvalid(INV_DEFAULT_DATA))
         {
            if(this._dataVo.isIgrCredentialsReset)
            {
               this.igrWarning.visible = this._dataVo.memberMe;
               this.rememberPwdCheckbox.width = REMEMBER_PWD_CHECK_BOX_WIDTH;
               this.rememberPwdCheckbox.label = MENU.LOGIN_REMEMBERPASSWORDIGR;
            }
            else
            {
               this.igrWarning.visible = false;
               this.rememberPwdCheckbox.label = MENU.LOGIN_REMEMBERPASSWORD;
            }
            this.login.text = this._dataVo.loginName;
            this.pass.text = this._dataVo.pwd;
            this._isIgrCredentialsReset = this._dataVo.isIgrCredentialsReset;
            this.rememberPwdCheckbox.selected = this._dataVo.memberMe;
            this.rememberPwdCheckbox.visible = this._dataVo.memberMeVisible;
            this.recoveryLink.visible = this._dataVo.showRecoveryLink;
            this.registerLink.visible = this._dataVo.showRegisterLink;
            this.updateSubmitEnabled();
            this.updatePosition();
         }
         if(isInvalid(INV_PASSWORD))
         {
            this.pass.text = this._dataVo.pwd;
         }
         if(isInvalid(INV_SOCIAL_LIST))
         {
            this.socialGroup.visible = this._dataVo.isShowSocial;
            this.socialGroup.updateList(this._dataVo.socialList);
            this.socialGroup.socialList.removeEventListener(ListEvent.ITEM_CLICK,this.onSocialListItemClickHandler);
            this.socialGroup.socialList.addEventListener(ListEvent.ITEM_CLICK,this.onSocialListItemClickHandler);
         }
         if(isInvalid(LoginFormView.INVALID_INIT_FOCUS))
         {
            this.dispatchFocus();
         }
      }
      
      private function updatePosition() : void
      {
         if(!this.rememberPwdCheckbox.visible)
         {
            submit.y = SUBMIT_Y - REMEMBER_PWD_CHECK_BOX_INVISIBLE_TOP_OFFSET;
            this.socialGroup.y = SOCIAL_Y - REMEMBER_PWD_CHECK_BOX_INVISIBLE_TOP_OFFSET;
            message.y = MESSAGE_Y - REMEMBER_PWD_CHECK_BOX_INVISIBLE_TOP_OFFSET;
         }
         else
         {
            submit.y = SUBMIT_Y;
            this.socialGroup.y = SOCIAL_Y;
            message.y = MESSAGE_Y;
         }
      }
      
      override protected function redrawAll() : void
      {
         invalidate(INV_DEFAULT_DATA,INV_AUTO_LOGIN_KEY,INV_KEYBOARD_LANG,INV_CAPS_LOCK,INV_SOCIAL_LIST);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.serverTF.text = MENU.LOGIN_SERVER;
         this.loginTF.text = MENU.LOGIN_LOGIN;
         this.passwordTF.text = MENU.LOGIN_PASSWORD;
         this.socialGroup.visible = false;
         submit.enabled = false;
         this.capsLockIndicator.visible = false;
         this.capsLockIndicator.alpha = 1;
         App.utils.commons.initTabIndex(new <InteractiveObject>[this.login.textField,this.pass.textField,submit,this.registerLink,this.recoveryLink,this.rememberPwdCheckbox,server]);
         addEventListener(InputEvent.INPUT,this.onInputHandler);
         this.login.addEventListener(Event.CHANGE,this.onInputChangeHandler);
         this.pass.addEventListener(Event.CHANGE,this.onInputChangeHandler);
         this.rememberPwdCheckbox.addEventListener(Event.SELECT,this.onRememberPwdCheckboxSelectHandler);
         this.rememberPwdCheckbox.addEventListener(MouseEvent.MOUSE_OVER,this.onRememberPwdCheckboxMouseOverHandler);
         this.rememberPwdCheckbox.addEventListener(MouseEvent.ROLL_OUT,this.onRememberPwdCheckboxRollOutHandler);
         this.rememberPwdCheckbox.addEventListener(MouseEvent.MOUSE_DOWN,this.onRememberPwdCheckboxMouseDownHandler);
         this.registerLink.addEventListener(ButtonEvent.CLICK,this.onRegisterLinkClickHandler);
         this.recoveryLink.addEventListener(ButtonEvent.CLICK,this.onRecoveryLinkClickHandler);
      }
      
      public function updateInputForm(param1:InteractiveObject, param2:Boolean) : void
      {
         var _loc3_:String = null;
         if((param1 == this.login || param1 == this.pass) && param2)
         {
            _loc3_ = Values.EMPTY_STR;
            if(param1 == this.login)
            {
               this.pass.text = _loc3_;
            }
            else if(param1 == this.pass && !this._hasCtrlVDown)
            {
               _loc3_ = this.pass.text.slice(-1);
               if(_loc3_ == MULTI_SYMBOL && this._lastDownKeyCode != MULTI_SYMBOL.charCodeAt())
               {
                  _loc3_ = Values.EMPTY_STR;
               }
               this.pass.text = _loc3_;
            }
            this._hasCtrlVDown = false;
            dispatchEvent(new LoginEvent(LoginEvent.TOKEN_RESET,true,false));
         }
         this.setErrorMessage(MENU.LOGIN_STATUS_CONNECTING,ErrorStates.NONE);
         this.updateSubmitEnabled();
      }
      
      private function updateSubmitEnabled() : void
      {
         submit.enabled = this.login.text.length > 1 && server.dataProvider.length > 0;
      }
      
      private function onInputHandler(param1:InputEvent) : void
      {
         if(param1.details.value == InputValue.KEY_DOWN)
         {
            this._lastDownKeyCode = param1.details.code;
            this._hasCtrlVDown = this._lastDownKeyCode == Keyboard.V && param1.details.ctrlKey;
         }
      }
      
      private function onSocialListItemClickHandler(param1:ListEvent) : void
      {
         dispatchEvent(new LoginEvent(LoginEvent.LOGIN_BY_SOCIAL,true,false,null,false,SocialItemRenderer(param1.itemRenderer).socialId));
      }
      
      private function onInputChangeHandler(param1:Event) : void
      {
         var _loc2_:InteractiveObject = param1.target as InteractiveObject;
         App.utils.asserter.assertNotNull(_loc2_,Errors.CANT_NULL);
         dispatchInputChange(_loc2_);
      }
      
      private function onRecoveryLinkClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new LoginEvent(LoginEvent.ON_RECOVERY_LINK_CLICK,true,false));
      }
      
      private function onRegisterLinkClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new LoginEvent(LoginEvent.ON_REGISTER_LINK_CLICK,true,false));
      }
      
      private function onRememberPwdCheckboxSelectHandler(param1:Event) : void
      {
         if(this._isIgrCredentialsReset)
         {
            this.igrWarning.visible = this.rememberPwdCheckbox.selected;
         }
         dispatchEvent(new LoginEvent(LoginEvent.ON_REMEMBER_CHANGE,true,false,null,this.rememberPwdCheckbox.selected));
      }
      
      private function onRememberPwdCheckboxMouseDownHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onRememberPwdCheckboxRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onRememberPwdCheckboxMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = this._dataVo && this._dataVo.isShowSocial ? TOOLTIPS.LOGIN_REMEMBERPASSWORD_SIMPLE : TOOLTIPS.LOGIN_REMEMBERPASSWORD_SOCIAL;
         App.toolTipMgr.showComplex(_loc2_);
      }
   }
}
