package net.wg.gui.components.advanced.interfaces
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface ISearchInput extends IUIComponentEx
   {
       
      
      function get promptTextColor() : uint;
      
      function set promptTextColor(param1:uint) : void;
      
      function get normalTextColor() : uint;
      
      function set normalTextColor(param1:uint) : void;
      
      function get isPromptShow() : Boolean;
      
      function get defaultText() : String;
      
      function set defaultText(param1:String) : void;
      
      function get text() : String;
      
      function set text(param1:String) : void;
      
      function get maxChars() : uint;
      
      function set maxChars(param1:uint) : void;
      
      function get selectionBgColor() : uint;
      
      function set selectionBgColor(param1:uint) : void;
      
      function get actAsButton() : Boolean;
      
      function set actAsButton(param1:Boolean) : void;
      
      function get displayAsPassword() : Boolean;
      
      function set displayAsPassword(param1:Boolean) : void;
      
      function get selectionTextColor() : uint;
      
      function set selectionTextColor(param1:uint) : void;
      
      function get editable() : Boolean;
      
      function set editable(param1:Boolean) : void;
      
      function get focusable() : Boolean;
      
      function set focusable(param1:Boolean) : void;
      
      function get isSearchIconVisible() : Boolean;
      
      function set isSearchIconVisible(param1:Boolean) : void;
      
      function get highlight() : Boolean;
      
      function set highlight(param1:Boolean) : void;
   }
}
