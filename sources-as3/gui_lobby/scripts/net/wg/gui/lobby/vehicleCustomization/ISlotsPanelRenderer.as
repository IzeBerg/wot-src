package net.wg.gui.lobby.vehicleCustomization
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public interface ISlotsPanelRenderer extends IUIComponentEx, IUpdatable, IListItemRenderer
   {
       
      
      function show() : void;
      
      function hide() : void;
      
      function showPartly() : void;
      
      function setState(param1:String) : void;
      
      function get id() : int;
      
      function set id(param1:int) : void;
      
      function get ownerId() : int;
      
      function set ownerId(param1:int) : void;
      
      function get selectId() : int;
      
      function set selectId(param1:int) : void;
   }
}
