package net.wg.gui.lobby.settings
{
   import flash.events.IEventDispatcher;
   
   public interface ISettingsAimForm extends IEventDispatcher
   {
       
      
      function setData(param1:String, param2:Object) : void;
      
      function get formId() : String;
   }
}
