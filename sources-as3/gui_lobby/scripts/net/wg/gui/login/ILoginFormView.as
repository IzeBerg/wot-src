package net.wg.gui.login
{
   import flash.text.TextField;
   import net.wg.gui.components.common.serverStats.ServerDropDown;
   import net.wg.gui.login.impl.vo.SubmitDataVo;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public interface ILoginFormView extends IUIComponentEx, IViewStackContent
   {
       
      
      function setServersDP(param1:IDataProvider) : void;
      
      function setSelectedServerIndex(param1:int) : void;
      
      function setErrorMessage(param1:String, param2:int) : void;
      
      function updateVo(param1:IFormBaseVo) : void;
      
      function initFocus() : void;
      
      function getSubmitData() : SubmitDataVo;
      
      function get message() : TextField;
      
      function set message(param1:TextField) : void;
      
      function get server() : ServerDropDown;
   }
}
