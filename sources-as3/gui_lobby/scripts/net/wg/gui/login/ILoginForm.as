package net.wg.gui.login
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.HyperLink;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface ILoginForm extends IUIComponentEx
   {
       
      
      function update(param1:Object, param2:Boolean) : void;
      
      function addChangeHandler(param1:Function) : void;
      
      function removeChangeHandler(param1:Function) : void;
      
      function setDefaultValues(param1:String, param2:String, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean) : void;
      
      function setServersList(param1:Array, param2:int) : void;
      
      function setErrorMessage(param1:String, param2:int) : void;
      
      function setCapsLockState(param1:Boolean) : void;
      
      function setKeyboardLang(param1:String) : void;
      
      function getSelectedServerName() : String;
      
      function get submit() : SoundButton;
      
      function set submit(param1:SoundButton) : void;
      
      function get rememberPwdCheckbox() : CheckBox;
      
      function set rememberPwdCheckbox(param1:CheckBox) : void;
      
      function get registerLink() : HyperLink;
      
      function set registerLink(param1:HyperLink) : void;
      
      function get recoveryLink() : HyperLink;
      
      function set recoveryLink(param1:HyperLink) : void;
      
      function get login() : TextInput;
      
      function set login(param1:TextInput) : void;
      
      function get pass() : TextInput;
      
      function set pass(param1:TextInput) : void;
      
      function get message() : TextField;
      
      function set message(param1:TextField) : void;
      
      function get server() : DropdownMenu;
      
      function set server(param1:DropdownMenu) : void;
   }
}
