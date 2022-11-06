package scaleform.clik.interfaces
{
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   
   public interface IListItemRenderer extends IUIComponent
   {
       
      
      function get index() : uint;
      
      function set index(param1:uint) : void;
      
      function get owner() : UIComponent;
      
      function set owner(param1:UIComponent) : void;
      
      function get selectable() : Boolean;
      
      function set selectable(param1:Boolean) : void;
      
      function get selected() : Boolean;
      
      function set selected(param1:Boolean) : void;
      
      function get displayFocus() : Boolean;
      
      function set displayFocus(param1:Boolean) : void;
      
      function setListData(param1:ListData) : void;
      
      function setData(param1:Object) : void;
      
      function getData() : Object;
   }
}
